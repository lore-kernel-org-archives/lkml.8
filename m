Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534F1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D3620738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FyY6LHG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgFCOvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:51:35 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:6177
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbgFCOtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILrjO8DerIvxOmv+TTnnJMT5EAMIbX3yMVEaDZISWzUHj/AufnpwvhBhX1Vv7VFp1S7dPhfffzbHkmcMQ2ExjnfN9xYYzmkPiXiczXiG96KkNZ7CdW8QYpXnCJ5nC8qIt5kc/AANHVhmsxZYHo5Q93bY9BK7VkW2YDCcgxw7vqagLycqiAAlfMGX0kaRF88DHKd4t7nUTzRaWZzzzIVcr5D6KoHlCpi7urvWOAgMXUkTZBsGB2uHj89I3TXbOQ1KhmhJi3reQUTQz76WK5/+C5uRwdJGt0w4Wir+A8h6W75ypw/Zn2xZD22ozRYb5U0oXRKqthoymVCQCWQgmSAuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4x/CRxL8w+JvJdADGbcXIOuiE/HEnbKrtYJiAs2Njg=;
 b=Yyfys6cJ4IKm4YTIjJDqAFBYHKkLCxzCxbnipjXdusNOSdIwVObUIpWs+1Ei2Hwt1avCJ7Uo7iplKRao3/f1vtM7z+4/n7c/5LrHzta0i6MmKwbmocKzeHIa3EQE29Ylm2wbbhL5g4gmzmBNfMLEhFA29rPPYJafEayBAGRsy3pIXyRvN6asdDBHrSGkU7wsIk3gFKuPNvgRJqpSoNzwDuy1JZXwrCqtv4YcPVbS0xBBOJoglGLFYgITFEWW9KNEH/vK2py5XoiLRsC708fpkJt/xUGNfAES9JBVn7eZijYkMwN6xLi1K5O1sIrzOATrZ2O9He5G8rOXNcbx2zw00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4x/CRxL8w+JvJdADGbcXIOuiE/HEnbKrtYJiAs2Njg=;
 b=FyY6LHG+YwBCFQGLMLANYXgNd6RCXJ0rXX6etVHce0Pl+FFl0fgHl2iUzOA4qrlzAdSUHkzDtnFl4mSmbYvZ5Wgskz2XquZkrBPqpsEs0V5VE1cmqZHTlIc7e7vR9POBXVYqYUG3Abpx8ZCgIlkQvrCSws8Mc1G5hGXsJH2hobw=
Received: from SN6PR04CA0091.namprd04.prod.outlook.com (2603:10b6:805:f2::32)
 by CH2PR02MB6645.namprd02.prod.outlook.com (2603:10b6:610:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 14:49:48 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::c7) by SN6PR04CA0091.outlook.office365.com
 (2603:10b6:805:f2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 14:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server id 15.20.3045.17 via Frontend Transport; Wed, 3 Jun 2020 14:49:48
 +0000
Received: from [149.199.38.66] (port=60709 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUhS-0007GC-0d; Wed, 03 Jun 2020 07:49:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUiB-000515-QN; Wed, 03 Jun 2020 07:49:47 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 053EnhUi015307;
        Wed, 3 Jun 2020 07:49:43 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUi7-00050a-DW; Wed, 03 Jun 2020 07:49:43 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        jollys@xilinx.com, rajanv@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wu <j.wu@xilinx.com>,
        Wendy Liang <jliang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v5 4/5] dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc bindings
Date:   Wed,  3 Jun 2020 07:49:42 -0700
Message-Id: <1591195783-10290-5-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
References: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(376002)(136003)(346002)(46966005)(2906002)(316002)(8676002)(8936002)(7696005)(5660300002)(4326008)(70586007)(70206006)(426003)(2616005)(83380400001)(186003)(36756003)(336012)(107886003)(54906003)(47076004)(44832011)(82740400003)(26005)(478600001)(81166007)(9786002)(356005)(82310400002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 372259e1-a564-441d-d978-08d807cd5ce7
X-MS-TrafficTypeDiagnostic: CH2PR02MB6645:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6645C75D1D391F9BF606BAF7B5880@CH2PR02MB6645.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKlLF+VSJBqgHwrovexytGCRL1E6cOeLodr8zf60UF2BbkbmZkLzBpq/kXuU/OvT1CVPcvh39vCCkHejvHoDLEWcr+xCYFC4zs/InH4bD7HhWG6pZmDSPELcbYr9rHUx5dzYubHq+KH0hI8fYRGEO3upWX2r5iVr946nrJHMhxGJtyZQJa1qpCDyiIrJT2RiYkU+9sp0VF9c9atJWXNPuuMwRZwSYAdIVAqB5GQr3JiqlNcGC2wPEkejvg4awz0XD51eHOJpjoFv2ybo8dR9OXnDwVKvR7fJZPLi05+97sLDkZzSunWRFu1Sybzb5JoHlfL7d7F3GEL6QN7bOnHHfWuprepD04mpYjuTBrdIKduNwwBfbiwL/7Ik/5jTk98mPxjQAbSMrHVRM+d7CgMWh3PBIbv8B287xypzJya1h/GZPEgwvJARqf4Qr7Fc1krFPqTBINoXI8HvJE0lo8nHs6oYwf6UafSnbAbDPVuZZuo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 14:49:48.1183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372259e1-a564-441d-d978-08d807cd5ce7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6645
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

---
 .../remoteproc/xilinx,zynqmp-r5-remoteproc.yaml    | 132 +++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
new file mode 100644
index 0000000..23fbdce
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
@@ -0,0 +1,132 @@
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
+  core_conf:
+    description:
+      R5 core configuration (valid string - split or lock-step)
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
+if:
+  properties:
+    compatible:
+      enum:
+        - "xlnx,zynqmp-r5-tcm-1.0"
+
+
+examples:
+  - |
+     reserved-memory {
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+          rpu0vdev0vring0: rpu0vdev0vring0@3ed40000 {
+               no-map;
+               reg = <0x3ed40000 0x4000>;
+          };
+          rpu0vdev0vring1: rpu0vdev0vring1@3ed44000 {
+               no-map;
+               reg = <0x3ed44000 0x4000>;
+          };
+          rpu0vdev0buffer: rpu0vdev0buffer@3ed48000 {
+               no-map;
+               reg = <0x3ed48000 0x100000>;
+          };
+          rproc_0_reserved: rproc@3ed000000 {
+               no-map;
+               reg = <0x3ed00000 0x40000>;
+          };
+     };
+     rpu {
+          compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+          core_conf = "lock-step";
+          r5_0 {
+               ranges;
+               #address-cells = <1>;
+               #size-cells = <1>;
+               memory-region = <&rproc_0_reserved>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+               pnode-id = <0x7>;
+               mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+               mbox-names = "tx", "rx";
+               tcm_0_a: tcm_0@0 {
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+                    reg = <0xFFE00000 0x10000>;
+                    pnode-id = <0xf>;
+                    compatible = "zynqmp-r5-tcm-1.0";
+               };
+               tcm_0_b: tcm_0@1 {
+                    #address-cells = <2>;
+                    #size-cells = <2>;
+                    reg = <0xFFE20000 0x10000>;
+                    pnode-id = <0x10>;
+                    compatible = "zynqmp-r5-tcm-1.0";
+               };
+          };
+     };
+
+
+     zynqmp_ipi1 {
+          compatible = "xlnx,zynqmp-ipi-mailbox";
+          interrupt-parent = <&gic>;
+          interrupts = <0 29 4>;
+          xlnx,ipi-id = <7>;
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+
+          /* APU<->RPU0 IPI mailbox controller */
+          ipi_mailbox_rpu0: mailbox@ff90000 {
+               reg = <0xff990600 0x20>,
+                     <0xff990620 0x20>,
+                     <0xff9900c0 0x20>,
+                     <0xff9900e0 0x20>;
+               reg-names = "local_request_region",
+                        "local_response_region",
+                        "remote_request_region",
+                        "remote_response_region";
+               #mbox-cells = <1>;
+               xlnx,ipi-id = <1>;
+          };
+     };
+
+...
-- 
2.7.4

