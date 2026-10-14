# Automated ISMAP Compliance & Hardening Engine / 政府情報システムのためのセキュリティ自動化エンジン

## 1. Project Overview / プロジェクト概要
This repository demonstrates a production-grade **Purple Team validation workflow** by implementing Infrastructure as Code (IaC) to model multi-tier cloud environments, automate security vulnerability identification, and execute self-healing configuration playbooks.

本リポジトリは、Infrastructure as Code (IaC) を用いてマルチレイヤのクラウド環境を構築し、セキュリティ脆弱性の自動検知および自動修復（セルフヒーリング）を実行する、実運用レベルのパープルチーム検証ワークフローを実証します。

The target environment is explicitly audited against **Japan's Information System Security Management and Assessment Program (ISMAP)** boundary controls and **CIS Benchmarks**.

本環境は、日本の「政府情報システムのためのセキュリティ評価制度（ISMAP）」の境界制御基準およびCISベンチマークに基づいて厳格に監査されています。

---

## 2. Architectural Design Matrix / アーキテクチャ設計マトリクス

[1. Infrastructure Isolation (IaC)]
Terraform (Tokyo Region)
│
▼
[2. Automated Vulnerability Scan]
Python Offensive Core Engine
│
▼
[3. Compliance Log Generation]
Continuous Telemetry Stack
│
▼
[4. Self-Healing Remediation]
Ansible Playbook Defenses

---

## 3. Regulatory Controls Mapping Matrix / セキュリティ管理要件マトリクス

| Technical Module / 技術モジュール | Code Asset / 該当コード | Targeted Vulnerability / 対象の脆弱性 | ISMAP Control / ISMAP管理基準番号 | NIST CSF / 基準項目 |
| :--- | :--- | :--- | :--- | :--- |
| **Perimeter Isolation Control** | `terraform/main.tf` | Publicly exposed SSH ingress (Port 22 open to `0.0.0.0/0`). | **Section 3.1.2** (Boundary Protection / 境界保護の不備) | **PR.AC-4** (Network Isolation) |
| **Automated Compliance Audit** | `exploits/audit_engine.py` | Configuration drifts and unauthorized perimeter adjustments. | **Section 5.4.1** (Continuous Auditing / 継続的監査) | **DE.CM-1** (Security Monitoring) |
| **System Identity Hardening** | `ansible/playbooks/hardening.yml` | Unauthorized privilege escalation paths and open root execution hooks. | **Section 4.2.8** (Host Security Settings / ホスト機密性管理) | **PR.PT-3** (Least Privilege) |

---

## 4. Technical Execution (Quickstart Guide) / 展開手順

### 1. Initialize Infrastructure Definition / インフラの初期化
Validate the structural design of the cloud-native templates using static analysis tools:
```bash
cd terraform/
terraform init -backend=false
terraform validate
```

### 2. Run the Compliance Scan / 監査エンジンの実行
Execute the Python verification script to audit local telemetry profiles for boundary flaws:
```bash
cd ..
python3 exploits/audit_engine.py
```

### 3. Deploy Self-Healing Remediation / 自動修復の実装
Trigger the active defensive baseline configuration playbooks to secure host operating systems:
```bash
ansible-playbook ansible/playbooks/hardening.yml
```
