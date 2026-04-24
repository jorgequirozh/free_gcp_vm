/*
# Allow http
resource "google_compute_firewall" "allow-http" {
  name    = "socat-fw-allow-http"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

# allow https
resource "google_compute_firewall" "allow-https" {
  name    = "socat-fw-allow-https"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}
*/

# allow ssh
resource "google_compute_firewall" "allow-ssh" {
  name    = "socat-fw-allow-http-fw-allow-ssh"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
  depends_on = [
    google_compute_network.vpc
  ]
}

/*
resource "google_compute_firewall" "allow-51820" {
  name    = "wireguard-fw-allow-http-fw-allow-51820"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["51820"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["wireguard"]
  depends_on = [
    google_compute_network.vpc
  ]
}
*/

resource "google_compute_firewall" "portainer" {
  name    = "wireguard-fw-allow-http-fw-allow-9001"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["9001"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["portainer"]
  depends_on = [
    google_compute_network.vpc
  ]
}
resource "google_compute_firewall" "allow-ovpn" {
  name    = "socat-fw-allow-ovpn"
  network = google_compute_network.vpc.name
  allow {
    protocol = "udp"
    ports    = ["1194"]
  }
 
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ovpn"]
  depends_on = [ 
    google_compute_network.vpc
  ]
}
