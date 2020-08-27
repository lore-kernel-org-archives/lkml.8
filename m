Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5630A2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h42zhaSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgH0B61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:58:27 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:20704
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbgH0B6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:58:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoagsjhYX7fR+0in6ksMshQ+w6yNVvABFs2A5ut+YdDJIOPqCdXW2fEAfVReO4LhQByF89Zc7/bIoX8RfKiRKFV91Fkb6dst9uzfmxpQ0LJNUrUa2hEOg/Tc7nYiTAYs54yqxQTPXC+2plNJnZ0JvA7A2sAzZmbOvbg/7Nq/qW0TYfJ+a8S6Gbut3qpvhzhMsj1IRmwcM0SEHzJvl9Y9cBEhBYPbXzU4j3udzQxX3xQ9/EpZghDHtaa1OT/fRTaukwDRt+Yd4FSaFvv+3Cvqc+aAMIT7rzb1cAJ0zwTRUjubsYxEGa9K5/UxAE/t82QsARmGhe/1XEoyAfIBfuJVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MjQ7Hl/NKOY4hkjvlL6c0AoBoaWrBzf0OHRiOxcYIM=;
 b=c1NDdrglBBg2OwfYq8oiT+IlYc696ue7nXDwcpfw+r7h08Cbn9f/tOu8dcML6D4Gl5x7XtCEj5kT4YevJBPsfyxMHhhyNr1J9dQ080zHHGDctm/lMaqmGqHq+UbQmx5IiPM3Mz6cp8LWM9U8WgjZZ75GImyv8AASsIikPNcfj7kvid1kIzGomKjUCsiK6oOK5mWNchyMUKcbjGwK5n3sJU0Isd7uQW92tVGSnh6GOCX0OuVpaAiocUe10+OriYcZMOPrWZIkyenCyPJ3rdY+n4rjDSWo/2KhR0WZmrh5kTXV0au2Eb8wbs0tBUHkGKPn+R+yWQjdeD0Une1S3h/p2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MjQ7Hl/NKOY4hkjvlL6c0AoBoaWrBzf0OHRiOxcYIM=;
 b=h42zhaSAaHj/YywptwzOgwOjOxRDbjHOhJ1EiOSZaM9WnEGpw13UABz63chJ1CxXfknvrGwWwzL5JfoT7AVGOLo48AiNroyDDduHjoLcN33afr2OYGAAB3j8zmYwJTfGGF1EhjkBwLxh53zErmolXu+U4rWTpFw8HIFVpDeB2cI=
Received: from CY4PR14CA0027.namprd14.prod.outlook.com (2603:10b6:903:101::13)
 by BN6PR02MB2451.namprd02.prod.outlook.com (2603:10b6:404:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 01:58:16 +0000
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:101:cafe::7b) by CY4PR14CA0027.outlook.office365.com
 (2603:10b6:903:101::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Thu, 27 Aug 2020 01:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT032.mail.protection.outlook.com (10.152.75.184) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 01:58:15
 +0000
Received: from [149.199.38.66] (port=58716 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7Ad-0002AP-LO; Wed, 26 Aug 2020 18:57:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7B9-000183-8U; Wed, 26 Aug 2020 18:58:15 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07R1wAnt007544;
        Wed, 26 Aug 2020 18:58:11 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7B4-000155-SY; Wed, 26 Aug 2020 18:58:10 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michals@xilinx.com,
        michael.auchter@ni.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 4/5] dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc bindings
Date:   Wed, 26 Aug 2020 18:58:09 -0700
Message-Id: <20200827015810.11157-5-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827015810.11157-1-ben.levinsky@xilinx.com>
References: <20200827015810.11157-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 05e512b7-5fda-4c62-1078-08d84a2ca97f
X-MS-TrafficTypeDiagnostic: BN6PR02MB2451:
X-Microsoft-Antispam-PRVS: <BN6PR02MB245151D47884A6CE639A1DE4B5550@BN6PR02MB2451.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMcGxccyWCmd+B4YysWobF81oti9EOjKhEWOsYBLEhio7lq3T3QR+gQJMqZEWBIo6O0+IX3gbVid/wP+TWGs1s7aUGi5xSxFM59NooZzBqRaFCNBzjMpxHL/zS9PzJTaisfSUoxlaUuLO8qihq0j9YXu5Jjs1uSNXOG5rEoa+NvDZg8NQW5OjLyA0jUjw7migaZJa5LGck0TaPEcJdKKU2BeW66fMIzrp3/DT/Tttb8nWnNDk3LSoIbyUMLB7xMXEsHdiFDNKljEWQjBuciZPicp8pq4ENBaJilnTR5ONZ4ewef1bk6YCGIzrkEqWEy1POiZn7TFbFnsyIvMaPJ9RLXuasYDDwCZghjw3PjH86/7DIM5S5mhrDIwnSbi7WywYAxlebF8Ku8d+DGqpafavF745oAEak4/XeEbBvXTfJ6Zye4Knwv+/6hN0g91ZJQcrQM1/iSqcbz+2xzB9hrNyex8U6PslcSsil9EnIVjaig=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(346002)(46966005)(4326008)(5660300002)(426003)(81166007)(70586007)(70206006)(478600001)(82740400003)(336012)(186003)(26005)(83380400001)(356005)(82310400002)(47076004)(7696005)(9786002)(36756003)(44832011)(2616005)(1076003)(8936002)(2906002)(8676002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 01:58:15.5318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e512b7-5fda-4c62-1078-08d84a2ca97f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2451
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
v7:
- change lockstep-mode to xlnx,cluster-mode
v9:
- show example IPC nodes and tcm bank nodes
---
 .../xilinx,zynqmp-r5-remoteproc.yaml          | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
new file mode 100644
index 000000000000..f4a28831af6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
@@ -0,0 +1,113 @@
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
+     /*
+      * Below nodes are required if using TCM to load R5 firmware
+      * if not, then either do not provide nodes are label as disabled in
+      * status property
+      */
+     tcm_0a@0 {
+         reg = <0x0 0xffe00000 0x0 0x10000>;
+         pnode-id = <0xf>;
+         no-map;
+         status = "okay";
+     };
+     tcm_1a@0 {
+         reg = <0x0 0xffe20000 0x0 0x10000>;
+         pnode-id = <0x10>;
+         no-map;
+         status = "okay";
+     };
+
+     /*
+      * Below nodes are required for IPC, as Xilinx Kernel
+      * can potentially have other applications that use CMA
+      * and conflict from hardware design. With that in mind,
+      * explicitly state the address spaces for the IPC remoteproc
+      * mechanisms.
+      *
+      * If IPC not required and only elf-loading then these are not needed.
+      */
+     rpu0vdev0vring0: rpu0vdev0vring0@3ed40000 {
+         no-map;
+         reg = <0x0 0x3ed40000 0x0 0x4000>;
+     };
+     rpu0vdev0vring1: rpu0vdev0vring1@3ed44000 {
+         no-map;
+         reg = <0x0 0x3ed44000 0x0 0x4000>;
+     };
+     rpu0vdev0buffer: rpu0vdev0buffer@3ed48000 {
+         no-map;
+         reg = <0x0 0x3ed48000 0x0 0x100000>;
+     };
+
+...
-- 
2.17.1

