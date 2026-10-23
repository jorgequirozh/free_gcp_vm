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

resource "google_compute_firewall" "allow-ssh" {
  name        = "default-allow-ssh"
  network     = google_compute_network.default.id
  description = "Allow SSH from anywhere"
  disabled    = true
  priority    = 65534
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

/*
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
*/
resource "google_compute_firewall" "allow-ovpn" {
  name    = "socat-fw-allow-ovpn"
  network = google_compute_network.vpc.name
  allow {
    protocol = "udp"
    ports    = ["1194"]
  }

  source_ranges = ["0.0.0.0/0"]
  depends_on = [
    google_compute_network.vpc
  ]
}

resource "google_compute_firewall" "allow-iap-ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # GCP Identity-Aware Proxy IP range
  source_ranges = ["35.235.240.0/20"]

  # Matches the 'ssh' tag defined on your VM in vm.tf
  target_tags = ["ssh"]
}
