<?php


use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Session\Session;

class ProjectManager {
    private $db;
    private $request;
    private $session;

    //CONSTRUCTOR//
    function __construct(PDO $db, Request $request, Session $session) {
        $this->db = $db;
        $this->request = $request;
        $this->session = $session;
    }

    /////////////////////////////////////////////////////////////////////////////
    /// PROJECTS
    /////////////////////////////////////////////////////////////////////////////

    public function getAllProjects() : array {
        try {
            $stmt = $this->db->prepare("SELECT * FROM Projects ORDER BY `startTime` DESC");
            $stmt->execute();
            if( $projects = $stmt->fetchAll(PDO::FETCH_CLASS, "Project")) {
                return $projects;
            }
            else {
                $this->notifyUser("Projects not found", "Kunne ikke hente prosjekter");
                //return new Project();
                return array();
            }
        } catch (Exception $e) {
            $this->NotifyUser("En feil oppstod, på getAllProjects()", $e->getMessage());
            print $e->getMessage() . PHP_EOL;
            //return new Project();
            return array();
        }
    }

    /////////////////////////////////////////////////////////////////////////////
    /// ERROR
    /////////////////////////////////////////////////////////////////////////////

    private function NotifyUser($strHeader, $strMessage) {
        $this->session->getFlashBag()->add('header', $strHeader);
        $this->session->getFlashBag()->add('message', $strMessage);
    }

    public function newProject() {}

    public function editProject() {}

    public function deleteProject() {}

    public function getProject(String $projectName) {}

    public function addGroup(Group $group) {}

    public function addEmployee(User $user) {}

    public function addCustomer(User $user) {}

    public function assignLeader(User $leader) {}

    public function changeStatus() {}

    public function addTask(Task $task) {}

    public function getTasks() {}

    public function addPhase(Phase $phase) {}

    public function getPhases(Phase $phase) {}

}