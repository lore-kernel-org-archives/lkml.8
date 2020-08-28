Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E3FC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC322086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Eq5j5GPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgH1OBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:01:35 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:64737
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbgH1N74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaxXSNSIrAaJDfeUcJPLJOoBkPVaZBz8vBrL1DHb7lcF8+o4uNn8yodOUk/WyQTDMnvUJ4hn+WEIE7WeuSsyNWd3rcSAtl4hWwHTenUo6YXvtq3DJbCqEZrqxLApgMgJYTUTNkuMfpmts/T8M0Ux9SSeB/pbPP4UJdCBND8WkXLokGbSA+pN3oKQtdM/fZjINKkezOPj8VHImVeR0/lA2dcKhzFzblTcr3C8tyG/nCDrf+uwwDY5bhikGO7ymkX6eDKtYRupunIk15s0mg6ztbHXorYlDSVAnVgOthftWRiS1JuzNU9SErRXBLYJ+1/b6C7qI35IAGIcvUp4aHIXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODr807QNJv9l/eM4eFpjvTeYc+chEjWpdMZeqwpfWk8=;
 b=B9pFxAjKF4R2GzIlxMt3qmiziJkW6ApqzA/WEmVMTGu86pu6ZAZe1LB1r1cGJehF5byjxmEV6eaS25RM41V2CfoIru07HCK0Kpe7eb0jxFhMDPUGESuQ2jl1l0ui8Pe7JMJ3XXdRzvSuWEsLdAbmJdnOvz80RLphGT8kyhhlX5Uozp0YAvtYzZcsnL+ZPk5aOAkeCgDPAUk7eptuT3YJqcTb6r6o4GNo+f36/LHdyAAeARVi5gsaWjv5vHo/fECZnjm+mQPROTSu6cZaQ11KaIFP8BGeDiqrLPim6y1ab7zMiwRZpQrjWwhCPx2h84BY8vaVtWSunBfNu7SePVTpig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODr807QNJv9l/eM4eFpjvTeYc+chEjWpdMZeqwpfWk8=;
 b=Eq5j5GPItKh92gSmybwYRW//BQDC2AToSFzo+cZyynmJg4AyzvDeTU3GKPt23kUamoO7vYmAC2TQxUnCTJVs8cn+icDb2nuJWG58D/CblnvjZH0mDUsK0RXKJmzOYBrLvOddHDxFo+Dr7/bS2gTLbokIZThY6JJAQNw11PbM85E=
Received: from SN4PR0401CA0036.namprd04.prod.outlook.com
 (2603:10b6:803:2a::22) by MW2PR02MB3884.namprd02.prod.outlook.com
 (2603:10b6:907:4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 28 Aug
 2020 13:40:13 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2a:cafe::3e) by SN4PR0401CA0036.outlook.office365.com
 (2603:10b6:803:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 13:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 13:40:13
 +0000
Received: from [149.199.38.66] (port=58589 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBebS-0004sL-MZ; Fri, 28 Aug 2020 06:39:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBec0-00065Q-NY; Fri, 28 Aug 2020 06:40:12 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07SDe89C024460;
        Fri, 28 Aug 2020 06:40:08 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBebw-0005it-0j; Fri, 28 Aug 2020 06:40:08 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, sboyd@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v6 1/8] dt-bindings: add documentation of xilinx clocking wizard
Date:   Fri, 28 Aug 2020 19:09:49 +0530
Message-Id: <1598621996-31040-2-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 37c71119-db78-48e2-2d8a-08d84b57e3e1
X-MS-TrafficTypeDiagnostic: MW2PR02MB3884:
X-Microsoft-Antispam-PRVS: <MW2PR02MB38842C7DCA8D344FDE83D546AA520@MW2PR02MB3884.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILXO4mLqjAfciJLcxEPnqBxULbDnIEsL2v/HPVfJCHCR6iNs8A1u0CXK31W5DpQhoQa6AYxpxQ2CLAvBlaYc3ezmiKqCzJahfAyKpzrFCzsnIjNJ47qCO93YC79D8Djj0S0UgIvhwEx6lYYpEarmPtszRLXFFoP9LFw6b89N/PmIKlAASqrhXBlKp54U//LzUdoFnuhsybw8ex3KgeSvunrPgZY51JMNACHxfmq2juip1MdDeANxu2d2dS2/JSIhSQMuSB//AgqayrmMwT3rdQ4/TvrHaGD5u7DYXomxwLwZRw+yrFFC3BjHCAA3SvSeZm8yMceDo2rgxa2zSodaqfzYL+98IBEltNONW8cQSRS/eMhOaITXLOUUHkNwzKdP+lCC44PSZQzciZvMg4Rcpom7bSS06dqyHU5DJjdUZ+vxXGRQSGZdOdNNoNrY9Xb/Od67dePGHgP/Na98LyGDFlCx/ckZFnCL+ZRlEK9Q+vg=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(346002)(39860400002)(136003)(396003)(46966005)(26005)(81166007)(186003)(7696005)(9786002)(6666004)(47076004)(82740400003)(966005)(336012)(426003)(4326008)(44832011)(478600001)(70206006)(8936002)(2616005)(70586007)(82310400002)(83380400001)(6916009)(5660300002)(107886003)(36756003)(8676002)(356005)(316002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 13:40:13.0248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c71119-db78-48e2-2d8a-08d84b57e3e1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devicetree binding for the xilinx clocking wizard.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v6:
Fix a yaml warning

 .../bindings/clock/xlnx,clocking-wizard.yaml       | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
new file mode 100644
index 0000000..ca63593
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/xlnx,clocking-wizard.yaml#
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

