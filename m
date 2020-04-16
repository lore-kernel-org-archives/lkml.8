Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880B8C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5684822201
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MSCbxBud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgDPVy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:54:56 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:32153
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728340AbgDPVyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:54:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfVm5Svk10RgStWRfSmNkTfqmPsH7hOUutqrCkZJNXTdFZYWyGfzkDAuJ3n/8mQk5IIAxRB5+SJYrPk/9/BwNNmQltGTRZoo58Jlxp6SU5KstQoaRYqblA9CoOKL+6krNGwpbDjpZVtOPV33IMP/NmG/oW/t0Hx+1O2C93Abtkv49XqppjrO+ZVWnl5aUTOjKmyJPTJ6AZaeI98aVO1ArHX7GUIijEDmd2iYOLRjFvAxxwOxGARhBS1o6jtPceeiMUZWiJInBORw3ig/PRNLo3tr+r3HNAK7yNvZzbSwyh/VZFfTbwvf1eUn1A7kpd25sG51k1+HSizhtJXCwMUTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azTVLFszMpSzhCnvfyJAmWasG6qEOP3q9lLEae9VxOg=;
 b=CNf+/jnpgfmBRuxscMXWHSUW7CTcLMHqxtbXWaFTZQ1gYDy5c2/fYTICrhPnznt1CjyPQ6dzUG0Qk9Cq6j2h528JMbLGXIgi+1XdpulR1zFCYcft18nFR/lkgwyWRHc6B6Y/kKjGRVi9MVQ9MXNW0eSDk5DCgmHHh9ldnSVRKTe28yB6iP/Eq5uL+kTeA6XzJbKP6We0KTC6VvEYX7DmlYpeBGI9cJvPxAU7zezQ4zB9P8cnyJjcrLBgpYwHKFVY2iyNjek/ynIP2hWE6H6aKMXshBgCE2qRrmhEPSJDD5evwt2xGodiVeZwOJN/buDzag5CJtzyWKUaSjsxwdpMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azTVLFszMpSzhCnvfyJAmWasG6qEOP3q9lLEae9VxOg=;
 b=MSCbxBudc8ceo+yZ+vhw/8+XhzJcEfh8auKHzmW8ekrl+QkTzNypRZ5vKOpADgx7yWMP77lyNPWWByj3wXoi2EOqD2oc2Wd480PAqKzfxJeK2wyA8FOyugABIPB6eObNoKQSPxzpke710KtaEpbYmT5jPbuiLWeo9p2XfUF5SaA=
Received: from SN4PR0501CA0087.namprd05.prod.outlook.com
 (2603:10b6:803:22::25) by MN2PR02MB5885.namprd02.prod.outlook.com
 (2603:10b6:208:11c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 21:54:48 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:22:cafe::1b) by SN4PR0501CA0087.outlook.office365.com
 (2603:10b6:803:22::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend
 Transport; Thu, 16 Apr 2020 21:54:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server id 15.20.2900.18 via Frontend Transport; Thu, 16 Apr 2020 21:54:47
 +0000
Received: from [149.199.38.66] (port=38403 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCSN-0004ce-Kd; Thu, 16 Apr 2020 14:53:59 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCT8-0003e3-RR; Thu, 16 Apr 2020 14:54:46 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCT4-0003cm-81; Thu, 16 Apr 2020 14:54:42 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wu <j.wu@xilinx.com>,
        Wendy Liang <jliang@xilinx.com>
Subject: [PATCH v2 4/5] dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc bindings
Date:   Thu, 16 Apr 2020 14:54:41 -0700
Message-Id: <1587074082-14836-5-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587074082-14836-1-git-send-email-ben.levinsky@xilinx.com>
References: <1587074082-14836-1-git-send-email-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966005)(44832011)(70206006)(2616005)(36756003)(336012)(7696005)(186003)(107886003)(8936002)(81156014)(9786002)(70586007)(316002)(426003)(81166007)(356005)(5660300002)(478600001)(4326008)(26005)(54906003)(2906002)(82740400003)(47076004)(8676002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5581ed08-0080-4391-28d3-08d7e250c7db
X-MS-TrafficTypeDiagnostic: MN2PR02MB5885:
X-Microsoft-Antispam-PRVS: <MN2PR02MB5885F153ABA59622390970B7B5D80@MN2PR02MB5885.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0375972289
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUrKuf1jzqkRYkh/YwmSxsOSJWpNCXtIZ95MfWxqdHKxgaHHLwCpR6M5Tu9OggaufKvWj+2etA/E74195RboR87YLYf667NkxXHlJGx8LvqV8+Se30jpioMqPZsKbZglmIGEXyniWmJ6NUNkxFOHwHccLYeBatsx/Is9ZDI8bwo1pChxcHEivUIKXCeKIxd5JaY0J2GlOk5/ooONjC5TNz5HUHmIdgToapD6xkRBMxUAVMJ13nweP7IKET56+2iAoTClnCvhfP5BorIuBvRAv9ImFxAoDk3tUy3zOlMscDqCEXBm8X7ZGU8+C6JzQoVPX9CbRR6ZzV8GEVcnBIi4C6XZh4ETgApC5UCtxRYMHo6K+4Kc1mKpxMlGc+3VjYBMSeb07KUCZrcgP7vmZO4kjvCX3foUWRdHREsUMiPOQtkmMPAunJ9tCgYPtr40hVMlZKUTTr8PP1cVkgUal4mg0iB8Kmx23qMNqYA4R2CxdwAFwdhQR6BqMZId3rVreGeX1+04GfKOFQ+xtxz4uZ5pXw6eRTj5MrUCpgW3vhjfAS+MinIfSkq7ngA6jr9mKXvgmskx/Cl9gwrWBZOn0TNhcg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 21:54:47.4374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5581ed08-0080-4391-28d3-08d7e250c7db
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5885
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
 .../remoteproc/xilinx,zynqmp-r5-remoteproc.yaml    | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
new file mode 100644
index 0000000..ed3d125d
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
@@ -0,0 +1,119 @@
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
+    maxItems: 4
+    minItems: 4
+  pnode-id:
+    maxItems: 1
+  mboxes:
+    maxItems: 2
+  mbox-names:
+    maxItems: 2
+
+additionalProperties: false
+
+examples:
+  - |
+     reserved-memory {
+          #address-cells = <2>;
+          #size-cells = <2>;
+          ranges;
+          rpu0vdev0vring0: rpu0vdev0vring0@3ed40000 {
+               no-map;
+               reg = <0x0 0x3ed40000 0x0 0x4000>;
+          };
+          rpu0vdev0vring1: rpu0vdev0vring1@3ed44000 {
+               no-map;
+               reg = <0x0 0x3ed44000 0x0 0x4000>;
+          };
+          rpu0vdev0buffer: rpu0vdev0buffer@3ed48000 {
+               no-map;
+               reg = <0x0 0x3ed48000 0x0 0x100000>;
+          };
+          rproc_0_reserved: rproc@3ed000000 {
+               no-map;
+               reg = <0x0 0x3ed00000 0x0 0x40000>;
+          };
+     };
+
+     zynqmp-rpu {
+          compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
+          #address-cells = <2>;
+          #size-cells = <2>;
+          ranges;
+          core_conf = "split";
+          reg = <0x0 0xFF9A0000 0x0 0x10000>;
+          r5_0: r5@0 {
+               #address-cells = <2>;
+               #size-cells = <2>;
+               ranges;
+               memory-region = <&rproc_0_reserved>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+               pnode-id = <0x7>;
+               mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+               mbox-names = "tx", "rx";
+               tcm_0_a: tcm_0@0 {
+                    reg = <0x0 0xFFE00000 0x0 0x10000>;
+                    pnode-id = <0xf>;
+               };
+               tcm_0_b: tcm_0@1 {
+                    reg = <0x0 0xFFE20000 0x0 0x10000>;
+                    pnode-id = <0x10>;
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

