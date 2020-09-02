Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC7DC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FAF20829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ap5wipzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgIBRAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:00:00 -0400
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:24096
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728505AbgIBQ6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:58:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbH15QQ0QY/QxtNpWOwRjS+szNko/N8soPnWgdYkNjSKu4M4BJpuslRgOb985elCXqoziTu61b3ersEBjp8w4J+7IAi9aMZIk002JRz8XAu/H0yeELnoxoSBAL5i4nvhacs1AVnXqFnhFMhs/1QjNxLUR4yVs2+9vg6ZyIg5o8VhZi6ZaWG+wpKEiLS4DxA+N9NWHoGbgkUntLhJhrGlcGrvg/n2d6JThlxM3tguiy9Sk/cHsNkf8mQd2Oqy2c11I04YRAD2t65zbu1z+R57L4Ns7ujMux9REOxvM+tiMnHDne4jnjy+mCZpdVa7MjoPBt0OtWX9qL/HYmAn/mOl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwFVZeoZwiXl8ndkCyyjOAwNIPyMDdnbgovzZTgi0rw=;
 b=UX0YwGr3ZivCqPO/7xxFo4N8J6oG+ySHJWkLDIQeicgVLbeK9q/ELr6KaHhjbWaWqTASCRUZP0GIFOhRWhgIb/PSJmPWbIMSJIxWNMla0Ml+f/zLT/4NuptxF8YGlsDwTALrwSz/y6o3mDqg77+H/TfMyJjxtAPDbNsyHmVlFCxYobdHx4Tqv/X61f65AiTeu3x7HiULfwAllw4SQZJpBIemedld8XEA5NeNnyKIUwKtuXnUA9m/FVqWLFP3mqaDv/KHHfYm5Pnh8y0UWVRd0FkfLxYGO77Rh0Ti0Q1eT3WH9EWiUXWXxjtVmx4gZ5Y41CwqeyJYBsOejHsHme5pxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwFVZeoZwiXl8ndkCyyjOAwNIPyMDdnbgovzZTgi0rw=;
 b=ap5wipzHAC6n8URCPw2+b1LN8F34MEC/+S0ZlBKF2fnGuoU4++6HZk3ZNaK5TD2OBUbNlWNT1ZXMSz5Qb/qzW+XkYqORj5EULx2JsPexLa1FsN/w8f9lJOmZOlaNdPXWrz6kA/16QjbNEqkabVTjSUu1ifqNKc9KWx07GiddmeI=
Received: from MN2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:208:134::44)
 by DM6PR02MB5596.namprd02.prod.outlook.com (2603:10b6:5:7b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 16:58:51 +0000
Received: from BL2NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:134:cafe::db) by MN2PR16CA0031.outlook.office365.com
 (2603:10b6:208:134::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Wed, 2 Sep 2020 16:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT005.mail.protection.outlook.com (10.152.76.252) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 16:58:50
 +0000
Received: from [149.199.38.66] (port=52901 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5t-0004kW-RE; Wed, 02 Sep 2020 09:58:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5y-0004Hg-Dr; Wed, 02 Sep 2020 09:58:50 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 082Gwk5n032480;
        Wed, 2 Sep 2020 09:58:46 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5u-0004H9-F9; Wed, 02 Sep 2020 09:58:46 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefanos@xilinx.com, michals@xilinx.com, michael.auchter@ni.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v11 4/5] dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc bindings
Date:   Wed,  2 Sep 2020 09:58:45 -0700
Message-Id: <20200902165846.3366-5-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902165846.3366-1-ben.levinsky@xilinx.com>
References: <20200902165846.3366-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 21792167-4a55-4078-c2e5-08d84f61777a
X-MS-TrafficTypeDiagnostic: DM6PR02MB5596:
X-Microsoft-Antispam-PRVS: <DM6PR02MB55968E4C71540EE954FF22E6B52F0@DM6PR02MB5596.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22erLZDBheqHKdkQbmD7RudyZc4/E12GusBHjY8KRZu96ogQ2GuZnsAs5GZu1mZHwVBHv/Aa0y6o+q5J6A80WDZSLd86YqE2cd7i6HH8CX+VB5BGi+fQ3O35andf5K6++MnXbYsppkr23EhYjQWKYBjg8R0s4vDMZhYdrcLBEZ4BxVhyD9OgXpHjiEvC/CWH94ijiTue96Zjlr6j+L1Ov9WpmX7R3pDSooDHLq0pukuOv4U/Ch9cGgGbAUdTEsMZHfHhNDsd3PrN86UgHTJoXemtgL0R/YY7XknSxPznmzg0D7Kjsu4EKMOsZlWhsMsKPoXmc8PkaMBtLVfI+WJTfH3gTG4JbMpOpY6sH60Z/jl8eV2+3bt2+/jareLXsU2h2a3oCwMwl9oJUxA+k0L87Oo8Os02/jRTvEGOCd80s5xPH/qqlGZJHi6hn9ozM4oiAvHgQZ1VKC9+o1uXhXuyRRrd9yoaPHHQ+xNZ1O2ZbglV3Lw/IpAQINhNoqgcSZAl
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(39860400002)(396003)(346002)(376002)(46966005)(426003)(70586007)(5660300002)(70206006)(4326008)(8936002)(186003)(26005)(9786002)(8676002)(44832011)(336012)(7696005)(81166007)(47076004)(83380400001)(316002)(2616005)(36756003)(478600001)(82310400003)(2906002)(1076003)(82740400003)(356005)(42866002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 16:58:50.7781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21792167-4a55-4078-c2e5-08d84f61777a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5596
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

