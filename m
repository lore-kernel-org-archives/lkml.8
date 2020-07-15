Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF5FC433EB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1426206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FNx49xJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGOPde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:33:34 -0400
Received: from mail-eopbgr680057.outbound.protection.outlook.com ([40.107.68.57]:45988
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbgGOPdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:33:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClJC27H7ptUJ0FSkegIan7OtaguMP/gLbkPJ6YE/IqyZiks1ekfsvUNDP+ZVq0n/OBuJNjeUsnuWAwUWygyTb8bcuLJGEWrAJ5s6juiWzaTNTJkRJ2ugORwXYEShqyNYcfBvu1Ewxil9KHyvGpgX6jusDQIRIt/DjM0U+mwsxy962go/d6vydTn5mNRfWldNh6KFc267bRiy32xru5SBDQJ2MgahJ+4Lm28lHNeaEuMWyD0SSHGKZbSM8Dd/zM+xEww5djeCYats/+JUuOanX0iRStjvL9/+CikR4G7mY4njMnjMAmDEZc6P6tusgAo/avVRn5OGcDIMCpx5nsSGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCbxp+HOokXjLS6PPmmnJzqQ674rAvhculgbV6mXZZo=;
 b=XeKEt2TL0dVOEkYTUh4jechlmYwtuS+vhOGInzEtSwK2UUwGnuR425DgFA90J2JtGW3u3WDb7CZHGghoD39TCOPOYNBCqu6i3Dsj9JXrhWevx9f+ngmBsHmLSYX2H1Hd8iSISMXxDzsaWKnnU1KrLCj1cxgNWbRFvcTG9dfplBVAHBccLdsOdjhwpP/Rk9DG08Ur2EuFpXZlIB47BNZSXLb0WN0PGTLz9wqX3OvPbdezzKZKMCHaM1hmf0+R54BL7opCnqXQ2y0D+ZQKfZFfgCKI+9VKr1WoC6kyYkNJpW3CiJraGnpvfjb0XrGEfZ5aDw8vA+ZSuvBagOgjDgPQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCbxp+HOokXjLS6PPmmnJzqQ674rAvhculgbV6mXZZo=;
 b=FNx49xJpqoxxKhVudTPBP5BSBGqs8Y/qh7X8NoyQ/m91BMv5Wz2OQGO+hpmMl5z4Y8Tj0/xPqwCyPDKlqkBPkSTZcNZiVRjS+aE3nhGQ0zmQh/Epr88QrCDLXbM3C0jYDMV1ewHf75xoi8FbxXFAjldYfPW24VAseMC2YI9usqM=
Received: from BL1PR13CA0041.namprd13.prod.outlook.com (2603:10b6:208:257::16)
 by DM6PR02MB6969.namprd02.prod.outlook.com (2603:10b6:5:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 15 Jul
 2020 15:33:20 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:257:cafe::ec) by BL1PR13CA0041.outlook.office365.com
 (2603:10b6:208:257::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.10 via Frontend
 Transport; Wed, 15 Jul 2020 15:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 15:33:20
 +0000
Received: from [149.199.38.66] (port=39345 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjNh-0005fE-02; Wed, 15 Jul 2020 08:31:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjPL-0007rZ-S1; Wed, 15 Jul 2020 08:33:19 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjPJ-0007qz-Qq; Wed, 15 Jul 2020 08:33:17 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        JOLLYS@xilinx.com, RAJANV@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        stefanos@xilinx.com, Jason Wu <j.wu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v6 4/5] dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc bindings
Date:   Wed, 15 Jul 2020 08:33:16 -0700
Message-Id: <20200715153317.25643-5-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715153317.25643-1-ben.levinsky@xilinx.com>
References: <20200715153317.25643-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(396003)(376002)(46966005)(186003)(336012)(26005)(8936002)(8676002)(47076004)(82740400003)(7696005)(44832011)(2616005)(1076003)(36756003)(5660300002)(426003)(81166007)(82310400002)(2906002)(316002)(83380400001)(9786002)(478600001)(4326008)(70206006)(70586007)(356005)(54906003)(107886003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4a7b1384-cbb5-48f2-7703-08d828d46731
X-MS-TrafficTypeDiagnostic: DM6PR02MB6969:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6969F99382E596FDF6C422A4B57E0@DM6PR02MB6969.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUZyu/Nkf0PVV39UD0gD/4MCCTUFiQWU7lCmAQGKEQaja6H2kGcqz1NMxKkjieoU8nDvSpUXnsOS2ywOvma6yFiXHnBVLV/JEfTSzJtN0B8RODsuySboqwlBlY8SHVwr99vDUn92TO20mEjXbm2uoL6C0slYGo+Uqs/CZsGf3hSMeIqBYhShai4Xy0x3ivJSVniNHMPPVR3iPMBetiSHJj2kZauGEqrFcYn0qRYDhHutaRz2qsA1TwNtHXXDe4WjiKATEFCzPOLtxyAsSy4kLVi34Y1SACSbOlmD3hCgq1Q6PW9IZb76UXMOACjHgl/icGwWAkpOgHeNM6N/p6/ZMEXQA0hrrCXoSOKFXSaGnykfg+DgSdh95VgormIVNp2Tvd8Xyhozxt8++yVT2ug9BuFRXpTQI3xgSk3cYknaqxxGFKJwd417k8BMtFueN1GNzivgGMrmUJHyDIKxSwlcWzLLkZxgxph0DMgXbqD8cKc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 15:33:20.2268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7b1384-cbb5-48f2-7703-08d828d46731
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for ZynqMP R5 OpenAMP.

Represent the RPU domain resources in one device node. Each RPU
processor is a subnode of the top RPU domain node.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Jason Wu <j.wu@xilinx.com>
Signed-off-by: Wendy Liang <jliang@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
v3:
- update zynqmp_r5 yaml parsing to not raise warnings for extra
  information in children of R5 node. The warning "node has a unit
  name, but no reg or ranges property" will still be raised though 
  as this particular node is needed to describe the
  '#address-cells' and '#size-cells' information.
v4::
- remove warning '/example-0/rpu@ff9a0000/r5@0: 
  node has a unit name, but no reg or ranges property'
  by adding reg to r5 node.
v5:
- update device tree sample and yaml parsing to not raise any warnings
- description for memory-region in yaml parsing
- compatible string in yaml parsing for TCM
v6:
- remove coupling TCM nodes with remoteproc 
- remove mailbox as it is optional not needed
---
 .../xilinx,zynqmp-r5-remoteproc.yaml          | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
new file mode 100644
index 000000000000..54f916d9b037
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Xilinx R5 remote processor controller bindings
+
+description:
+  This document defines the binding for the remoteproc component that loads and
+  boots firmwares on the Xilinx Zynqmp and Versal family chipset.
+
+  Note that the Linux has global addressing view of the R5-related memory (TCM)
+  so the absolute address ranges are provided in TCM reg's.
+maintainers:
+  - Ed Mooring <ed.mooring@xilinx.com>
+  - Ben Levinsky <ben.levinsky@xilinx.com>
+
+properties:
+  compatible:
+    const: "xlnx,zynqmp-r5-remoteproc-1.0"
+
+  lockstep-mode:
+    description:
+      R5 core configuration (split is 0 or lock-step and 1)
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt mapping for remoteproc IPI. It is required if the
+      user uses the remoteproc driver with the RPMsg kernel driver.
+    maxItems: 6
+
+  memory-region:
+    description:
+      collection of memory carveouts used for elf-loading and inter-processor
+      communication.
+    maxItems: 4
+    minItems: 4
+  pnode-id:
+    maxItems: 1
+  mboxes:
+    maxItems: 2
+  mbox-names:
+    maxItems: 2
+
+examples:
+  - |
+     reserved-memory {
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+          elf_load: rproc@3ed000000 {
+               no-map;
+               reg = <0x3ed00000 0x40000>;
+          };
+     };
+     rpu {
+          compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+          lockstep-mode = <0>;
+          r5_0 {
+               ranges;
+               #address-cells = <1>;
+               #size-cells = <1>;
+               memory-region = <&elf_load>;
+               pnode-id = <0x7>;
+          };
+     };
+
+...
-- 
2.17.1

