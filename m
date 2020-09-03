Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45337C07548
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BA0206E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YIkcOBwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgICVX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:23:26 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:2912
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726323AbgICVXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWYwWV1NKj2fb6ETynVYYUoV2lQox4G0f9Se/Lr5cVMhp3yM/FHTBbLUX+sDIzM23E4ro1bm1asyRUgGkiIN9knRmxRBNHr4ThmKb5i0MNZ0rTVtjTfAIQNcdOSiLx+uuoSstqHMD3MjDssYVdNu+hEraG34saleyIeEiu22o0T/sAtlN2XAhKgwzRgV01f30u7WT9ZKW4kpSyNnXCSUL8cZ28mpPJ/KvVQcxeDFctgkLX5reUYTmt4B++YJciHMWsORad1mToJgllXs4T1y2TAqbYQWlBprkZQF6BTbWsGr5k4a7U3iCGQjjI9OouEeVDH5zIbkkzPZXRm7Ii80zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBhzK6/+3qzl2TIEmlP/0lBGAMg4z3Yvf69FMHri2gI=;
 b=MH9chjd3YQbqbytmvC06cI+gVjlBoJdo47Usaqd7vqZJkYcL4bV/mKA8mgt7PIqE1ik9tP8zlfzlWSRiLiyGVJq9xTb8N8ltzn1EevqfSyIChppXZFoyzjlMY2S6qp7PoIHtIOFI7Px5fY5V+fKK8hrHQHixqJcUciRGyV7NbRmf/ZBr/5AgmFn+S0TA08utr1VL9GiJby4u64XF2abCMY+hVGqLbt8EahMGQtZ9QEEugbrveZwCYIRr0OLWXM3zfuNS7T7VR/Yyuy1fx/FyC/+QCqaPuWpYLhBdV00YftcT531kXce3TTNczPdApYX4Cpy4PxS/4x3vI1ZPMbaObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBhzK6/+3qzl2TIEmlP/0lBGAMg4z3Yvf69FMHri2gI=;
 b=YIkcOBwqdeTu01WHVugUuRQNWDsZtGrprIvES/uIAjBUePkPcMvY87jCHBQ53FJ51njraOSoFkz0Oz0cd7KlL/7gQVXVGsR0hDnQcIAPyjkCcqkS4TvfDA3TpzrTuchYWthcRxXyNwH95adwq/HkzteHiZBqSvuUmMKOdtfGaoI=
Received: from CY4PR03CA0006.namprd03.prod.outlook.com (2603:10b6:903:33::16)
 by BL0PR02MB4707.namprd02.prod.outlook.com (2603:10b6:208:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 3 Sep
 2020 21:23:16 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:33:cafe::eb) by CY4PR03CA0006.outlook.office365.com
 (2603:10b6:903:33::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Thu, 3 Sep 2020 21:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 21:23:15
 +0000
Received: from [149.199.38.66] (port=37580 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDwhJ-0006tf-8t; Thu, 03 Sep 2020 14:23:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDwhP-0000OF-JK; Thu, 03 Sep 2020 14:23:15 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 083LNAeD023395;
        Thu, 3 Sep 2020 14:23:10 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDwhK-0000M3-B4; Thu, 03 Sep 2020 14:23:10 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     punit1.agrawal@toshiba.co.jp, stefanos@xilinx.com,
        michals@xilinx.com
Cc:     michael.auchter@ni.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, emooring@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jliang@xilinx.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, Jason Wu <j.wu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v12 4/5] dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc bindings
Date:   Thu,  3 Sep 2020 14:23:09 -0700
Message-Id: <20200903212310.17990-5-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903212310.17990-1-ben.levinsky@xilinx.com>
References: <20200903212310.17990-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b69e53d9-bb46-4954-ac1a-08d8504f9233
X-MS-TrafficTypeDiagnostic: BL0PR02MB4707:
X-Microsoft-Antispam-PRVS: <BL0PR02MB47078E492D103F5819D894B5B52C0@BL0PR02MB4707.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5rXSQ3iAMmPvSBOqgcT0iP3tgwnpu768A1sAIsw/JBvG6K8jq7R6wQQJYJJXM0hz5CinuqpE3BBWigGT+Ekb+FKxHc9JYSSNRjrchntnEuWMWWKmAgJ82pZNc1AsPZfDzr6BD9W2gEGqpU/HUZxIcCmtEG0SkzT4K5CIdEzLHTqd2oTzltwHAUj5c4DHG/nc7HHPzarjW/UtCzakvX1D2wznumihsaVHdVerPo++TrdEu+v15guZJ29kPi/8F6IlLqVsdH991A3Ah2qme88QhQ+XJG8cAOAJqmgplai1Q0yaY5h4q0KkbRr9Zoo+GiW+v66yXr0JWDbSqVXEcMMeE2mgRqKHoZqA2y1vTbqNmW0L1aJX68z6w5xjacvq7QuYXLHbVpEQxIF9ZFUCbw2f8jZwt0mQyu3kDJgPlytmpJVwxZu0bW7r9ND1rK6zeDZ4s7TKoCsN95TZk0npuWxuaXcGnIbN5lnvUL7yMHI23k=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(39860400002)(376002)(346002)(396003)(46966005)(44832011)(5660300002)(426003)(26005)(6636002)(336012)(82310400003)(356005)(54906003)(81166007)(316002)(7696005)(47076004)(1076003)(4326008)(8936002)(478600001)(186003)(70206006)(9786002)(83380400001)(36756003)(8676002)(82740400003)(2616005)(70586007)(107886003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 21:23:15.8323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b69e53d9-bb46-4954-ac1a-08d8504f9233
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for ZynqMP R5 OpenAMP.

Represent the RPU domain resources in one device node. Each RPU
processor is a subnode of the top RPU domain node.

Signed-off-by: Jason Wu <j.wu@xilinx.com>
Signed-off-by: Wendy Liang <jliang@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
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
v11:
- add property meta-memory-regions to illustrate link
  between r5 and TCM banks
- update so no warnings from 'make dt_binding_check'
---
 .../xilinx,zynqmp-r5-remoteproc.yaml          | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
new file mode 100644
index 000000000000..148374c61908
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
@@ -0,0 +1,123 @@
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
+  meta-memory-regions:
+    description:
+      collection of memories that are not present in the top level memory
+      nodes' mapping. For example, R5s' TCM banks. These banks are needed
+      for R5 firmware meta data such as the R5 firmware's heap and stack
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
+               meta-memory-regions = <0x40 0x41>;
+               pnode-id = <0x7>;
+          };
+     };
+
+     /*
+      * Below nodes are required if using TCM to load R5 firmware
+      * if not, then either do not provide nodes are label as disabled in
+      * status property
+      */
+     tcm_0a@ffe00000 {
+         reg = <0xffe00000 0x10000>;
+         pnode-id = <0xf>;
+         no-map;
+         status = "okay";
+         phandle = <0x40>;
+         compatible = "xlnx,tcm";
+     };
+     tcm_1a@ffe20000 {
+         reg = <0xffe20000 0x10000>;
+         pnode-id = <0x10>;
+         no-map;
+         status = "okay";
+         compatible = "xlnx,tcm";
+         phandle = <0x41>;
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
+         reg = <0x3ed40000 0x4000>;
+     };
+     rpu0vdev0vring1: rpu0vdev0vring1@3ed44000 {
+         no-map;
+         reg = <0x3ed44000 0x4000>;
+     };
+     rpu0vdev0buffer: rpu0vdev0buffer@3ed48000 {
+         no-map;
+         reg = <0x3ed48000 0x100000>;
+     };
+
+...
-- 
2.17.1

