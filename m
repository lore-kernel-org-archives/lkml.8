Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55714206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rAetCOA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgHKDca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:32:30 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:36015
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728030AbgHKDc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:32:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFOr6h4Jw0t6Vqog77k9fE4V09U3xIM3haRZO/5st/RjHk/Ho22VjICJicXeHEHHffvdksS6eblrO7ZzY2K7kH2SRq5NPxL1lw9+pDfqYqmEBj2HGsuLaYIUXVw/sMT35Wlk5U+OdBNFa+N/JYLvd2x5tvrtVBsfqe70zSn6GiIXRyagjWGN5YzVhfA53PRlinLj7aFMX1pBjU5vfTe2UF4qTkcsU1xErKYvrfg4s25hySlGSq+E3LX8fRmGynQLytCgsfVVqI0AwrHZEg36R9niA+EITORqGViXr4Wum2/6UgPhBD13F2pv0eYDaYONBS+wucQlWzwapsLOjZNXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMLYYk1qe+9AcIay1ZsWUGOoEnqLvJKC7DYYvsREHPU=;
 b=aWINK5kWnQMjyLOY2J0+B1n/D94gmBn8RzZbgZsdYkNv0PLbM+Ez61bKIHBbdGlksm5uzI85eclnrxTvRRLqgdvzdWxAHvCfCWBRBueBlaby0jWDa+dKux3zHiA0n/kSNJlQk6/gWl/vLrKGdWl5Vbuo6K+CPPzzYinrifu7r6/b2Tlnq/YI1Sc7UD7jhEGmVRybVZKkaOFt/2/1Gv8zzI66WBt1cjLrqRJoiwHunP/aXGMDsP2v9cE4oyGXALQq6JXNCHS0z7XZEJbuxZwLKT9jGInQqyUOtdhzyKicEayPefTQTfsfZk+M9sjKwPny3hvtOd33JE8QkBBB3k6YyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMLYYk1qe+9AcIay1ZsWUGOoEnqLvJKC7DYYvsREHPU=;
 b=rAetCOA6HdoS/2U1vzcbcPhSZZohCIzlQ5C6raTTBw9FAUgmrH8Cc3bzB/2+xAmKABgV8FsLhA8ZPJztq5k6zWOzomeCpkGWzZgCwZsi7XTpBhOh8kXFyn0VpzVp+KCOZK/ayl4IGb6SiaXgmEScbMrg719n8H/4oQ73M59twTY=
Received: from MN2PR15CA0044.namprd15.prod.outlook.com (2603:10b6:208:237::13)
 by BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 03:32:21 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:237:cafe::57) by MN2PR15CA0044.outlook.office365.com
 (2603:10b6:208:237::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Tue, 11 Aug 2020 03:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server id 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 03:32:21
 +0000
Received: from [149.199.38.66] (port=60901 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1K-0000iB-Rl; Mon, 10 Aug 2020 20:32:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1R-0004hE-EE; Mon, 10 Aug 2020 20:32:21 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1J-0004gc-9d; Mon, 10 Aug 2020 20:32:13 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefanos@xilinx.com, michals@xilinx.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        ed.mooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wendy.liang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Wu <j.wu@xilinx.com>, Wendy Liang <jliang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v8 4/5] dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc bindings
Date:   Mon, 10 Aug 2020 20:32:12 -0700
Message-Id: <20200811033213.20088-5-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811033213.20088-1-ben.levinsky@xilinx.com>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eca04453-661a-4dff-cfe9-08d83da7284c
X-MS-TrafficTypeDiagnostic: BN7PR02MB4148:
X-Microsoft-Antispam-PRVS: <BN7PR02MB414805E393097C43198A9D7AB5450@BN7PR02MB4148.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxqcvaKSHVV5MAPpqU5wXZ1pWnJElKpz+ELDefha7B/HnsdNGLtddXQt9w3RWYOa2tIKnrKA0+QFffHSuQERHnHDyggsx6+oq1o2PgN1UbRqQff+XGzAA9Id7H0FLc9SgvQQJ03WCtvzmYtB5JsSkmvGy0b+7fS0x/NoaXqVIJym6c9kbK5XCWlulKzWi2/d9Z4a62k69EXM//PgBKqHvVJEo0Z8//NR10sDzFvTlrW89JAQ+cxOthD+0CAbY9CtzYR6rnn3FBlzkA5PCZjraGSf2jpYH6SU5CDKzGqscqrrcr+uOk4IcAeTVktS87ClqGwSosXj1nB4KvemhQd1a8+T7593R4BWCJVgWqTx6zJlMVkCe1CynKlq/7ssa9zrb2FRVJbHIKAd+SVBbdSWrh6zIGvagMu+FV+0lfCSQdP0uMwe+dYS4u1JSbwaHMj3KJmjKhrFSRHJqTTcBo0qMLktf4F7AN2iIkd4nnp78zM=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(39860400002)(376002)(46966005)(5660300002)(83380400001)(9786002)(8936002)(36756003)(82740400003)(8676002)(7696005)(4326008)(47076004)(82310400002)(6636002)(1076003)(70586007)(316002)(70206006)(356005)(81166007)(2616005)(54906003)(2906002)(478600001)(426003)(26005)(44832011)(107886003)(186003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 03:32:21.7800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca04453-661a-4dff-cfe9-08d83da7284c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4148
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

