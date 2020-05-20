Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A27CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD232081A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lpOkURkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgETCOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:14:46 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:31950
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgETCOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:14:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWermGJgaqOxOtSpEb5Yfkx3jIBVOF2gGjMaXK11/NtgoNTH8PTfJPUECU0K0Gne8DopR+sUTIbBJThYUwsYYRBktOS4xwTeIT2Gv8IiPTd0M3ntjVZSEN3FDeBbsRPQDS4fMc52r7u0F5jSDvUgFtKMPpe4RMA+lAEyCme3Z2Gtqif5FxMLDeUe3IJaWcwoilI399ncmLkZLpEVR12yovvHL9gy6Mkfg/IsIIg3bGL3/S/MnMgtu4P/VjCS/Cr4FzvJQ6SwB6PpHgm2+eOgf8Fz/j0EJCo+UkVgVC2h+frCwZh78/rpGhxQQG+FW8a7xw7pv6I17zPbk9KVuSQcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cmrbQVG6ViVNlF/jcMtlUa0o8PALw4xj+WQBTrBxTc=;
 b=eYaRUPwK8MWN0i61o1UylaO+rWg5OTYARgHOqacQHCWRo+6+fHvSqpOpRZ+Gtpgb7b3MLGR636Sm6Ocyb8giz5jgS5/cg3JzsadVt5ioXGlWMHpW+VD6JL1NaNu8sTsuoFa99b2wrcub7MmpV7YNXPdz8up+eRrgJQFMmVN82v9sHIqL+10O7JNz9ksSdanlv3l27tnew7GZHHnpvZo29ad2DtALg3BNPEbJzKgEFmDBxcQFWLUSvg0gVhOIv89lmcqiDbetsOr1UJJGOKTl7AwtUCbV/3Qtp8mqE5m0JDT6shEC9hqkd3NY1XnNcIKHaPACXhrIV8krlqDVDDq4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cmrbQVG6ViVNlF/jcMtlUa0o8PALw4xj+WQBTrBxTc=;
 b=lpOkURkCTh/AwMUJfhn0fWQk8AuLLVqn5EXW+bQoaAz8KF5y5v21MMcgrNpNSrZI3GmssZFH2jduL0F2MQubCsUgr5gfVcnY7EV9FGvFgMsCT9ADJg1MYYfZ2U01Ly16GssS6W1BhCKR0D3GC2Ef32+a9kGYHhO4358pIOypGZA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2741.eurprd04.prod.outlook.com (2603:10a6:4:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 02:14:42 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 02:14:42 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] arm64: dts: imx8m: add mu node
Date:   Wed, 20 May 2020 10:04:36 +0800
Message-Id: <1589940278-3680-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589940278-3680-1-git-send-email-peng.fan@nxp.com>
References: <1589940278-3680-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0011.apcprd06.prod.outlook.com (2603:1096:3::21)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0601CA0011.apcprd06.prod.outlook.com (2603:1096:3::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.25 via Frontend Transport; Wed, 20 May 2020 02:14:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 775ae183-b537-4b98-f328-08d7fc638ea7
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB274160D2DE844BDF1D45A21488B60@DB6PR0402MB2741.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PKa94PP1B7pAuj36TBRbt6t7ztbDY1syDvpG+qd5Nxh8te49w1R3bY0D4nEHuNn0wYjrBK79cYBbPCrQwgrySchFObRFmrinhnR4hX7IL0aB4X3A+DYNsgb81eKzyNSNSPlpe2fI7d0+h++SS9xANng7cJheIHjsJPF4q6VhaP9ip+JIQ4GYSt6Yr8aO0fA5jm5tw2WRQwR7SmdB3nBcCj1LslbXgtLHvRRQvWf2muLBh42+fGY+Os7TWAN8I2qPi7VxX8XSQvLmVn+TMUCZY7/+xsNIs/jwAELhvvkE1JLo+EI7Zts7Wwuyw014VLQB4B9WJwziTpo7vo6MVampiZuqG0HjhD2GYMI0GME24RW1JaFG+QmpYmA3DxpsKmzC8hbB59Iztj//vpZLaTFTcfiyaz/eGwasnbtyhAgsi+8iBBQ4S21wHJo3WRAA6+fVDndAhPeryMMEpQdyUWtq9xSeQTqy/0vr6pYBP0DilfRTXenB+TjHHUk0VZlHSh6xw70LMdcIlIWAKvgjZm6aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(36756003)(8676002)(6512007)(86362001)(52116002)(9686003)(66946007)(66556008)(66476007)(8936002)(478600001)(316002)(5660300002)(26005)(6486002)(69590400007)(6506007)(4326008)(2616005)(956004)(2906002)(186003)(16526019)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aTnrSpKiczfl6HcuusdmL0vxiGpVq+CYmo8VTut6psJXpVMqBS9QTSSmjq+yWwD7/e+5qGDFo++uoZrQPQvuM4vQzzTIiuChvxZpSHIO4M1P/IAH+4A8gHqHL+2y+Li/49r0sfAOkFIKJw6lYBUfubaI+VbQ+dS51i9Xz8254p/FBYVGzpPX4ZUFlbmszrads4V6CLuW+6IkDRWA35PN5qgpfSrD9LNaw3/FNyv+zooqtiMIrlEQ2SdQBcZ7611ceb4I2DbFhWgHmyV/HdPhuIsQ2TaXmNqyKRQGHs59bXSw6Xb1TGUo+y1eDup4F20mMltXa5uC82o+fh5ZP0iw9/7fHSuoDMGEXsyng5+n0BLLSLk9WW04qcyipjpIxe7091U3NqbtKQE3lsQJBprzUB9ZchhCZ/SvXfwCrBAEMOMn+hDLHJXBVvwhinQSHRd2PuL4lCGtJfBPPj7vy/g4mnnesv6P5rXeBW41ipRSSyTcA+ybXvfQy9S/YMjv5J7q
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775ae183-b537-4b98-f328-08d7fc638ea7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 02:14:42.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tM0e2chP4nr18BtWD2UTH2r8tWbtUp3/WBRS0QWZnmfOa2NnTcsxx5qP0F2ZhhOKeqn2knRAUI55j2MWOInjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mu node to let A53 could communicate with M Core.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index f3bbefe3e59f..9722f76d8c3f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -771,6 +771,15 @@
 				status = "disabled";
 			};
 
+			mu: mailbox@30aa0000 {
+				compatible = "fsl,imx6sx-mu";
+				reg = <0x30aa0000 0x10000>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_MU_ROOT>;
+				clock-names = "mu";
+				#mbox-cells = <2>;
+			};
+
 			usdhc1: mmc@30b40000 {
 				compatible = "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b40000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index fb63a98fdff5..5f30f1d50460 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -671,6 +671,15 @@
 				status = "disabled";
 			};
 
+			mu: mailbox@30aa0000 {
+				compatible = "fsl,imx6sx-mu";
+				reg = <0x30aa0000 0x10000>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MN_CLK_MU_ROOT>;
+				clock-names = "mu";
+				#mbox-cells = <2>;
+			};
+
 			usdhc1: mmc@30b40000 {
 				compatible = "fsl,imx8mn-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b40000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 1d15680a4962..e969fcbbd15f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -956,6 +956,15 @@
 				status = "disabled";
 			};
 
+			mu: mailbox@30aa0000 {
+				compatible = "fsl,imx6sx-mu";
+				reg = <0x30aa0000 0x10000>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_MU_ROOT>;
+				clock-names = "mu";
+				#mbox-cells = <2>;
+			};
+
 			usdhc1: mmc@30b40000 {
 				compatible = "fsl,imx8mq-usdhc",
 				             "fsl,imx7d-usdhc";
-- 
2.16.4

