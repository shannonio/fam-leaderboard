import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";

const Home = () => {
  const [scores, setScores] = useState([])
    useEffect(() => {
      const url = "/api/v1/scores";
      fetch(url)
        .then((res) => {
          if (res.ok) {
            return res.json();
          }
          throw new Error("Network response was not ok.");
        })
        .then((res) => setScores(res))
        .catch(() => navigate("/"));
    }, []);

    return (
      <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
        <div className="jumbotron jumbotron-fluid bg-transparent">
          <div className="container secondary-color">
            <h1 className="display-4">Family Game Leaderboard</h1>
            <hr className="my-4" />
            {scores.map(score => (
              <div key={score.userId}>{score.userName} | {score.totalScore}</div>
            ))}
          </div>
        </div>
      </div>
    );
}


export default Home