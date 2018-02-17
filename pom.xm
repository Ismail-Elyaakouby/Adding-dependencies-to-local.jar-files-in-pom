If you'd like to use a .jar file in your project, but it's not available in any Maven repository, 
you can get around this by creating your own local repository. This is done as follows:

1 - To configure the local repository, add the following section to your pom.xml (inside the <project> tag):
  
  <repositories>
      <repository>
        <id>in-project</id>
        <name>In Project Repo</name>
        <url>file://${project.basedir}/libs</url>
      </repository>
    </repositories>
  
2 - Let's say we want to use the file myLibrary-1.0.jar in our project. First add a dependency to your pom.xml:
  
  <dependency>
    <groupId>be.ac.vub</groupId>
    <artifactId>myLibrary</artifactId>
    <version>1.0</version>
  </dependency>
  
  Two things to note:
    - You can pick whatever you like for groupId.
    - The name of your .jar has to follow this naming convention: artifactId-version.jar
      If needed, rename your .jar file.
  
3 - Put myLibrary-1.0.jar in the following location, relative to the root of your git repo:
  libs/be/ac/vub/myLibrary/1.0
  
  In general, your path looks like this: repository-location/groupId/artifactId/version
  (Just like Java packages.. if the groupId contains a ".", this corresponds to a "/" in the file structure..)
  
4 - In that location, also add a file myLibrary-1.0.pom , with the following contents:
  
<?xml version="1.0" encoding="UTF-8"?>
<project xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd" xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <modelVersion>4.0.0</modelVersion>
  <groupId>be.ac.vub</groupId>
  <artifactId>myLibrary</artifactId>
  <version>1.0</version>
  <description>POM was created from install:install-file</description>
</project>
  
5 - You have now created your own local Maven repository! To test if it works, compile the project via Maven:
  mvn clean install -U
  (The -U is optional; it forces Maven to re-download project dependencies)
  
6 - Finally, make sure to add the .jar and .pom files to your git repository as well, so it also works via continuous integration.
