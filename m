Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82F2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950852080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RaeWOASS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgHZQN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:13:29 -0400
Received: from mail-eopbgr760071.outbound.protection.outlook.com ([40.107.76.71]:21838
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbgHZQNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH5U9guYDf/hwuMDVkm6RJHkzkz8dmmZfD6gBVeJJkD8iaO17CVwe2lpjlLVHG32zmZFdevVPNZLaELg+LpB3az7edOofabqIcwvJIaNKZ8bRu59DTMOKGdR6WSij4PBilNbguEXQIiC034ZOz5NH2Ugojbmpxu7IT5FbD3sYmuT0TrczOBWLdW73vdh4Oh2YLVcT35gyf0yhDSHIhyKvQw/UKQRk0F/k7f2/u3qxTqIZUPbMZ2VlIYrodk/YB9yswYrUt26r8exjfZcIPJ64qd1tHGORIs4K3j+6p+JcXB2cpnv0D/42/36mLwBtIQ1UCj3Np1JHcQ+jTacibbWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MjQ7Hl/NKOY4hkjvlL6c0AoBoaWrBzf0OHRiOxcYIM=;
 b=L0glli7dmiBSslria/7CLneSON6HXEKKdMPDw2PoGWQyGSf777kR6ZEP0hgHRjQWzyLa4li3gd1zJB1eTAmu/YPfFng+aQmE6POYs4SZ0SGUdVyTyUyZb/mR6BX1CTppFFHdOP1l4QD6Bto9tSe+tD/VNZY6D3kNVKIFOs0sf4TwxM03v71k4W5ozV6nPtnnilAtH4Tx0jiwEnZFEp4pWiCLeoMElemYDA7XLJ314pY3nhKXmcyvah3z3wEpMi4smBPti+TsB26/mQs6nx49XF5TZOiQjtzChcPpOaY0klbg1h0EsWv65nHjqXyvJGQerEq9kcFahOjaN6U5h0xQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MjQ7Hl/NKOY4hkjvlL6c0AoBoaWrBzf0OHRiOxcYIM=;
 b=RaeWOASSOY950w73QaOHqkIe1enrI9ePfMmarLpKq/IAtgSchohzVq0hhnwJX5YhZJaHUdBMwPO+cL2go8Pl2mpHY4krrciw1Xx0Pp5xvEN/JIrw8W9Yfeev9crtn4fOh8K9P55I8wEVOcFTQcVUSpXLQ5BvMpK+Yh6X4GOGCJo=
Received: from BL0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:91::28)
 by SN6PR02MB4909.namprd02.prod.outlook.com (2603:10b6:805:9a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 16:13:09 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::22) by BL0PR05CA0018.outlook.office365.com
 (2603:10b6:208:91::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Wed, 26 Aug 2020 16:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 16:13:09
 +0000
Received: from [149.199.38.66] (port=58602 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2Q-0006Zz-9R; Wed, 26 Aug 2020 09:12:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2v-0008BQ-83; Wed, 26 Aug 2020 09:13:09 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2t-0008B0-RR; Wed, 26 Aug 2020 09:13:07 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michals@xilinx.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        michael.auchter@ni.com
Subject: [PATCH v9 4/5] dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc bindings
Date:   Wed, 26 Aug 2020 09:13:06 -0700
Message-Id: <20200826161307.1064-5-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826161307.1064-1-ben.levinsky@xilinx.com>
References: <20200826161307.1064-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 496428ec-4b4c-4b0a-6afd-08d849daecb6
X-MS-TrafficTypeDiagnostic: SN6PR02MB4909:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4909829FC365B5596C7AAF33B5540@SN6PR02MB4909.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+jFcBx2h22jv9R1RG4NR6l6bk8KKg55JrDAvP45PT4FUAzAJCnKchPEOj7Nt7XvZWRyTZcVXVLkZsD5w+o4xhDoc+34Ff3eJjcj48iXTu9FOiuge0/2EVbsGsTGiPpO9vdCvqbW9YKEE1inm+3I7OIwAsvSCheQmCoA5TBMGzQBrUaogabUMcU4R8BDYIDE0IZVnXKAuXjqZn41MT0zip+N/uRDlB5iOykkngP/UrrFLKY3v8U6Y4yznX9zvLxCL1yY9zeA96keHX7AhG50syIlBLMpxc2KB5uO5rzIqPLNRcnOpAS0MV0Bv+QJJBrwu73Np5gkC0LTIH1SIMeKmZLPled5dh6pTo8wBNeBCAtFuVgs/FvzMw/oYWpcOeNIDsjK92eTnluETz8KTYldJvZ1zSrI1obVCHm8bl10sElf0J3HhBP4UjkQlv6bhnRLWPTVRD+sDsxF+GvlAL1W18Yq8C2cg8OzKPFmcxfGVeI=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(136003)(46966005)(83380400001)(1076003)(2906002)(5660300002)(36756003)(44832011)(478600001)(4326008)(426003)(47076004)(6636002)(70586007)(356005)(81166007)(70206006)(82740400003)(2616005)(82310400002)(8936002)(26005)(316002)(336012)(9786002)(8676002)(186003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 16:13:09.5911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496428ec-4b4c-4b0a-6afd-08d849daecb6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4909
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

