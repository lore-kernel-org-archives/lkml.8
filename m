Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C0DC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7A72072F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mTx31oe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgCLJI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:08:26 -0400
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:36929
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgCLJIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:08:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVOXqqRdlSxcLAtxCJKc/UMMgDAh8ntkcwsbvLPTCJZAJWOdWTOupmaP8RVTFb0YOGIPrd+4JQ+H/ZzpMWwAsZPirQHnVV4dj0ZTVaiAOvhXAy6SefJ0ULmsOUzmlqitscomtaEFtDqdJizpNMsuwRVsBxRMHfImnsnojLmfuq62Z4WjzwGOgPiW2dHZU9h+T619m/WzcBLUwiF492WMasVgIlJh499dgDEaXDFtNHNpxC3Mdoiu/TqxSt10ILcfHMwUMnMp6js1bXkRfITWzuw7HvWCjnVv5EslIc8TMYJdABszCK+cDJFyFQ06JLsxW7tPxj9dW2ZkT+WRG2cNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3zY1hA9XArfHrBjjcGidvPAQR+wMzk/fGaUOjcaGVo=;
 b=MdhJdtQFN8aHRn/GRBP2+t0JGN8ttCFu3whYIpkg96SARGJ85IFHtSrnSMI7eo2PDePY6EOZx50RMcQdguBgtj+M2IOHnDxj9L4KnXbvfaxZU8KHhGjZdIfoyVzosM9ILW96UlIPThkj59KAhe42BjLAyr/SnsHZA9BDiIikVXQZC1AySAl2DEE0M5GxV1Kyb4W/p9ztuwlXFHPDstG0iuiKptlcM/SX7vIyPXQRQnchKno1jhY2IbXemhRFUqNuN41maNQZ4cdMC/gCVEy/v0wTFabfnCbHdgIsLiz8JC1CBIgYjnat3i/4DrLQ3rhzpnX+unhcxRk2BtlXdxybVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3zY1hA9XArfHrBjjcGidvPAQR+wMzk/fGaUOjcaGVo=;
 b=mTx31oe87LTdCcSqb0o14DDVVr4NkQFrvgrwmfporFw7Xcu7KG4EuJQ0Wvc20WqhwGx1PHLs20X96UUh06/DktexO3X1OhmNrzOCyAYzaDVVTDOk7fOdR91gIa4dxt78iXugQSPr0EC0oVy/cX7PlhweHdS0s3PgP3Z0d97TpXE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5569.eurprd04.prod.outlook.com (20.178.113.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 09:08:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:08:18 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        leonard.crestez@nxp.com, sboyd@kernel.org, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anson.Huang@nxp.com, daniel.baluta@nxp.com, aford173@gmail.com,
        ping.bai@nxp.com, jun.li@nxp.com, l.stach@pengutronix.de,
        andrew.smirnov@gmail.com, agx@sigxcpu.org, angus@akkea.ca,
        heiko@sntech.de, fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org
Subject: [PATCH 01/10] arm64: dts: imx8m: assign clocks for A53
Date:   Thu, 12 Mar 2020 17:01:23 +0800
Message-Id: <1584003692-25523-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584003692-25523-1-git-send-email-peng.fan@nxp.com>
References: <1584003692-25523-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0052.apcprd02.prod.outlook.com (2603:1096:4:54::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.14 via Frontend Transport; Thu, 12 Mar 2020 09:08:12 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64931536-c59f-4bd2-0ebf-08d7c664e7e3
X-MS-TrafficTypeDiagnostic: AM0PR04MB5569:|AM0PR04MB5569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB556994618F5CD750899FEEA488FD0@AM0PR04MB5569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(69590400007)(36756003)(6666004)(26005)(52116002)(2616005)(7416002)(956004)(6506007)(186003)(5660300002)(16526019)(478600001)(86362001)(2906002)(66946007)(8676002)(81156014)(81166006)(66476007)(8936002)(66556008)(6512007)(9686003)(4326008)(316002)(6486002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5569;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcPY82xykl8JgxCnnQQMqjEbj4skpPJi3MTx/gcBSIy6qIzylpH1h293xNZ9fue9GIU+e2QilXQ36WFa0hy19o2LwdJCcklkaGUBE3CxL9C1xFBWlNqGEsV5q5Zh3EuMKsBjIvcGP79P1ozrTPANFhuBNk0n+wy3QMTGaVtYzOW1XrxYoQ9YUhCQxN8GufwquQQfxMjCRIQ2rvMTIZolYDsrLI8krkDwT7qvA1ye6iXJBSaUBHr29RutDH3ORa2VMhCMfasb+wowDrVAq718NpAO/fM0mfTk9ZeKXFYUrSgwlIjBD641TuosY+/9kudDoaE260T5VEeouLSd25+SQaF3voMc1BsfRyQBh6TI29lcQHVITYZPEg3i5KWFOnG7p5uX1EjD4qL1VxtF/epJ/9GB3Tdh0FzvxvE3g94Hi0Buk1B8Ph7HPoL5c/orc5MJa8h7VTu5k97+SD/+cWU/mkTiAzxgms+XWomyr22o6//oiZY1demIsKfXZk/M7m+wrkuT1x/o1f4nYsmH/TFnLg==
X-MS-Exchange-AntiSpam-MessageData: baVbMFO7wKhTVfuRB2HNguK0jtddBW/lEpV0NEonQ9jwsMC1Vm/jgc7eopD+gQ0tYl6WmVVRU6OhPx6NjHKWbAXvhQQWO5w54jltbnOwjOAi6EXn5IfdB+ShJ7lpWGnm4tDh0mYoIg6DmC6v9lRAtQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64931536-c59f-4bd2-0ebf-08d7c664e7e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:08:18.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6dRcNIqSaQQwTEzENlwAfXyeUduMQlZWIsQc0vMbgxEhlF+mie99yd11cgUXJiPTJT17e5L01oKaealOHxUwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Assign IMX8M*_CLK_A53_SRC's parent to system pll1 and
assign IMX8M*_CLK_A53_CORE's parent to arm pll out as what
is done in drivers/clk/imx/clk-imx8m*.c, then we could remove
the settings in driver which triggers lockdep warning.

Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 10 +++++++---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 10 +++++++---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 11 ++++++++---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi |  9 +++++++--
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 2e5e7c4457db..8d2200224db4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -471,16 +471,20 @@
 					 <&clk_ext3>, <&clk_ext4>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
 					      "clk_ext3", "clk_ext4";
-				assigned-clocks = <&clk IMX8MM_CLK_NOC>,
+				assigned-clocks = <&clk IMX8MM_CLK_A53_SRC>,
+						<&clk IMX8MM_CLK_A53_CORE>,
+						<&clk IMX8MM_CLK_NOC>,
 						<&clk IMX8MM_CLK_AUDIO_AHB>,
 						<&clk IMX8MM_CLK_IPG_AUDIO_ROOT>,
 						<&clk IMX8MM_SYS_PLL3>,
 						<&clk IMX8MM_VIDEO_PLL1>,
 						<&clk IMX8MM_AUDIO_PLL1>,
 						<&clk IMX8MM_AUDIO_PLL2>;
-				assigned-clock-parents = <&clk IMX8MM_SYS_PLL3_OUT>,
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>,
+							 <&clk IMX8MM_ARM_PLL_OUT>,
+							 <&clk IMX8MM_SYS_PLL3_OUT>,
 							 <&clk IMX8MM_SYS_PLL1_800M>;
-				assigned-clock-rates = <0>,
+				assigned-clock-rates = <0>, <0>, <0>,
 							<400000000>,
 							<400000000>,
 							<750000000>,
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index ff9c1ea38130..ad88ba3bf28c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -380,13 +380,17 @@
 					 <&clk_ext3>, <&clk_ext4>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
 					      "clk_ext3", "clk_ext4";
-				assigned-clocks = <&clk IMX8MN_CLK_NOC>,
+				assigned-clocks = <&clk IMX8MN_CLK_A53_SRC>,
+						<&clk IMX8MN_CLK_A53_CORE>,
+						<&clk IMX8MN_CLK_NOC>,
 						<&clk IMX8MN_CLK_AUDIO_AHB>,
 						<&clk IMX8MN_CLK_IPG_AUDIO_ROOT>,
 						<&clk IMX8MN_SYS_PLL3>;
-				assigned-clock-parents = <&clk IMX8MN_SYS_PLL3_OUT>,
+				assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_800M>,
+							 <&clk IMX8MN_ARM_PLL_OUT>,
+							 <&clk IMX8MN_SYS_PLL3_OUT>,
 							 <&clk IMX8MN_SYS_PLL1_800M>;
-				assigned-clock-rates = <0>,
+				assigned-clock-rates = <0>, <0>, <0>,
 							<400000000>,
 							<400000000>,
 							<600000000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index d92199bf6635..3a96082e8717 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -284,7 +284,9 @@
 					 <&clk_ext3>, <&clk_ext4>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
 					      "clk_ext3", "clk_ext4";
-				assigned-clocks = <&clk IMX8MP_CLK_NOC>,
+				assigned-clocks = <&clk IMX8MP_CLK_A53_SRC>,
+						  <&clk IMX8MP_CLK_A53_CORE>,
+						  <&clk IMX8MP_CLK_NOC>,
 						  <&clk IMX8MP_CLK_NOC_IO>,
 						  <&clk IMX8MP_CLK_GIC>,
 						  <&clk IMX8MP_CLK_AUDIO_AHB>,
@@ -292,12 +294,15 @@
 						  <&clk IMX8MP_CLK_IPG_AUDIO_ROOT>,
 						  <&clk IMX8MP_AUDIO_PLL1>,
 						  <&clk IMX8MP_AUDIO_PLL2>;
-				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
+							 <&clk IMX8MP_ARM_PLL_OUT>,
+							 <&clk IMX8MP_SYS_PLL2_1000M>,
 							 <&clk IMX8MP_SYS_PLL1_800M>,
 							 <&clk IMX8MP_SYS_PLL2_500M>,
 							 <&clk IMX8MP_SYS_PLL1_800M>,
 							 <&clk IMX8MP_SYS_PLL1_800M>;
-				assigned-clock-rates = <1000000000>,
+				assigned-clock-rates = <0>, <0>,
+						       <1000000000>,
 						       <800000000>,
 						       <500000000>,
 						       <400000000>,
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9bbdaf2d6e34..1f3ffc8c8a78 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -594,8 +594,13 @@
 				clock-names = "ckil", "osc_25m", "osc_27m",
 				              "clk_ext1", "clk_ext2",
 				              "clk_ext3", "clk_ext4";
-				assigned-clocks = <&clk IMX8MQ_CLK_NOC>;
-				assigned-clock-rates = <800000000>;
+				assigned-clocks = <&clk IMX8MQ_CLK_A53_SRC>,
+						  <&clk IMX8MQ_CLK_A53_CORE>,
+						  <&clk IMX8MQ_CLK_NOC>;
+				assigned-clock-rates = <0>, <0>,
+						       <800000000>;
+				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_ARM_PLL_OUT>;
 			};
 
 			src: reset-controller@30390000 {
-- 
2.16.4

