Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3DEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD780206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SdszneBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgFZR4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:56:47 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:6049
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbgFZR4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:56:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je6ofs7XFrTvDXpBEAy1ZYaw7OLNwOhvrvtHC7stfV4Xthc1LjOG8mp5VsA6HZAJHO0NoL1ph60pPyyo2iQ7BqMCiJuUZUdE0a8yrygUwq1VIbRZVm8MTZJJ/M+XZ1ywHpGSmCNW/6qQaBzW3s+7J81nSMfIhQY40jbHJiFnjvK3B98OphTMQJATTJZNPEx9vVwj29DlveZc+ZgTtZhDJ2F4VQ/QHeixzNGiaaR0cKBxl9YITkw9UXgNruZTuchqq5sAYpTvh+MoZWPBiN2xnGgPy0nhEoennGeLJQQzmnOTFkWhe+C4b0gtjFhnbY4BsPJvVxlI2CquIGg5tTP0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbAeHvHreXUXyxkAhOFMxfX4hCvPFwE3j1A8IigJyAY=;
 b=nN90JAxKcS7ccCW3oCB6mdj1TGFyACsN3VQTfUhXAE4WXlbUza0vrSZ881qFiXCGkPMkuaFLWY5/1hYaCxMCmKVVbOFazlRtFsqjyyGpRhpKV+EAQXFKiLHkt6Oo9uM9rQaFd/1NvMb4YGLxHmBssLmqpNXFQ5eSFwTByA+IR8mHqQHS2lYhmsrA5y0iSM+ub56AppO1M6tOrp9hptX1LZoGCpj/98b+XGf9BQTPxOArpI2SBvAZJtdsdCVRAee7Ty01RJSt22XHTFnurCNywsrTfdZLUgDnUfq2/0seridxs3Nh13+zDVvHYildJpiC0S0rkAjiouoQPn8r4IMaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbAeHvHreXUXyxkAhOFMxfX4hCvPFwE3j1A8IigJyAY=;
 b=SdszneBvD3s2seNLd7+wCy9mhq8UqZUeSde/ws3jDMIdM0BfGk2z3TS+2A93Jy3pcEPchCSQ93JqbijUDwn6lIbN9yLHX0VaNC0SDcMV93+CZIP/n6EAzFoSESK01879x+Ntc522OH/VbPSngwXg1/8NFEAFQsTvqop5Lf+aP9Q=
Received: from CY1PR03CA0013.namprd03.prod.outlook.com (2603:10b6:600::23) by
 DM6PR02MB4457.namprd02.prod.outlook.com (2603:10b6:5:1f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.23; Fri, 26 Jun 2020 17:56:41 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:600:0:cafe::58) by CY1PR03CA0013.outlook.office365.com
 (2603:10b6:600::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Fri, 26 Jun 2020 17:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 17:56:41
 +0000
Received: from [149.199.38.66] (port=53173 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1josZP-0004hI-Vd; Fri, 26 Jun 2020 10:55:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1josae-0007tX-TJ; Fri, 26 Jun 2020 10:56:40 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QHuW3b000761;
        Fri, 26 Jun 2020 10:56:32 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1josaW-0007oR-Dv; Fri, 26 Jun 2020 10:56:32 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v5 1/8] dt-bindings: add documentation of xilinx clocking wizard
Date:   Fri, 26 Jun 2020 23:26:18 +0530
Message-Id: <1593194185-22394-2-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593194185-22394-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593194185-22394-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(346002)(376002)(39860400002)(136003)(46966005)(83380400001)(70206006)(6666004)(336012)(70586007)(6916009)(7696005)(26005)(44832011)(426003)(186003)(2616005)(316002)(107886003)(36756003)(8676002)(2906002)(81166007)(478600001)(966005)(9786002)(8936002)(82310400002)(82740400003)(5660300002)(47076004)(356005)(4326008);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 853f45b1-509e-493d-df55-08d819fa47fd
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4457AAA947ADC34ABBA9DF30AA930@DM6PR02MB4457.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CRWL2vM0JQ1bPr0xaevzVlztpqk/xAJvieEUO6Db4LwxMbIygz6GXonKDJT6rSybBc4kirLypondjVwmlG1WJMsMDIEt4yPhHImcc1w9DIOEMifi6Xq/c6UcfsiCnrDk7ydUaW7X4BiGqnjS2JA0IULmrYpCpAFsbWjARDl1BrWG11lJ7uipOyABz/PrEULjkjVPxmxBHorUrCQfM7u6NCu1Sp4nz8I3h4vL2EMNlkoThUwW17RNkHmfXb/jUdlpiSEwq52KzMs2I2YqxvYnNO7x/b+z1TgogsVqKA1BfMveJffxzltelgtSW4BEDbBYQ+0poqAT2JiZM6tlfEhTbCmhIfavTIz7wFdv6navEV6YQXIysDQA585JTaB+E8W9xejA2pZl6sTKwcdGwpRic/mhKNFIEr1HGhC88cvp0kupmOjv5apKEMVZCBawYsNBzWuREjwHaSvjDUvo5tO1pu934dKM8zDgJLVOUF4StQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 17:56:41.3153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853f45b1-509e-493d-df55-08d819fa47fd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devicetree binding for the xilinx clocking wizard.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v4:
change to yaml format

 .../bindings/clock/xlnx,clocking-wizard.yaml       | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
new file mode 100644
index 0000000..5a8e991
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/xlnx,clocking-wiz.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx clocking wizard
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+
+description: |
+  The clocking wizard is a soft ip clocking block of Xilinx versal. It
+  reads required input clock frequencies from the devicetree and acts as clock
+  clock output.
+
+select: false
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,clocking-wizard
+          - xlnx,clocking-wizard-6.0
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    description: List of clock specifiers which are external input
+      clocks to the given clock controller.
+    items:
+      - description: clock input
+      - description: axi clock
+
+  clock-names:
+    items:
+      - const: clk_in1
+      - const: s_axi_aclk
+
+  speed-grade:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [1, 2, 3]
+    description:
+      Speed grade of the device.
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - speed-grade
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-generator@40040000 {
+        #clock-cells = <1>;
+        reg = <0x40040000 0x1000>;
+        compatible = "xlnx,clk-wizard-1.0";
+        speed-grade = <1>;
+        clock-names = "clk_in1", "s_axi_aclk";
+        clocks = <&clkc 15>, <&clkc 15>;
+        clock-output-names = "clk_out1", "clk_out2",
+        "clk_out3", "clk_out4", "clk_out5",
+        "clk_out6", "clk_out7";
+    };
+...
-- 
2.1.1

