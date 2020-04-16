Vue.component("playlist-item", {
	props: ["name", "link", "image"],
	template: '<div class="card">' +
  					'<img v-bind:src="image"/>' +
            '<div class="container">' +
            '<a v-bind:href="link"><div class="card-text">{{ name }}</div></a>' +
            '</div>' +
            '</div>'
});

function getPlaylist() {
	var theUrl = "https://raw.githubusercontent.com/bcpmax/BidenPlaylist/master/playlist.json";
  var xmlHttp = new XMLHttpRequest();
  xmlHttp.open( "GET", theUrl, false );
  xmlHttp.send(null);
  var response = xmlHttp.responseText;
  return JSON.parse(response);
}

var playlist = getPlaylist();

console.log(playlist);

var app = new Vue({
	el: "#main",
  data: {
    playlist: playlist["playlist"]
  },
  methods: {
  	getVideoURL: function (videoid) {
      var url = "https://youtu.be/" + videoid;
      return url;
    },
    getThumbnailURL: function (videoid) {
      var url = "https://img.youtube.com/vi/" + videoid + "/0.jpg";
      return url;
    }
  }
})