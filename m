Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984ABC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0AA2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pT+VVNhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgEGGFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:05:46 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:22990
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbgEGGFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:05:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV+q/Ac+n6asiq6CfpD0g8u5xLWvfJajusWEua3G076Alz3ao9a0TqXwiQQKeKFDpw6kRnOFQQsWTnwDu5pjkhwhHOFLWPFfABEUJvAU/CK1o3Icu+ecLh9/pizkr6CftRTQvjYSD08OcUn2T9bmfZgcCOxq3HCfIXlkOVbMCyV2N81MNK2Gr08MUIJxm9EBaH7A8SW+Tk2C+XxN+OKT1pDbG7KXJoBtRl4w6YZveG5i2WP+QOsw2SIui4OFvyO++2OzYN4wHXyxA9gRpld1F35HHnU6jjAKvX7rBifAgwnoR3RkOCniHrutziMHKiaAH5zj6cMPlbZsAlIu4TwYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbqSHfoVQ2BeBf+O+6BaFn8kZrjzGekqOC890+tzGCs=;
 b=e+bFhNchaYWVH8dbmd4/0FxuQOTtxU8BqWUz0UODnwEqQvNZRRzOAS9axxPZ/Nt0cP5S3kHLvQ968vfSAdbO9+hfKAM70Wia/xVj73osmKjNqz78vw5gZpDAnsYZMlLzzn1gMEYKh+yMd4NaSKy3wGhOpYRWDbUkZx4GUyY7rLHnEOMWYFvR29EHh14f7/baef+lttWIIwSyPQKDXQ0O2XZK557cBfdT0CxgEbdVsnOJ0IB0GJ1wr8ulydc5S5K9eoZUjWA0/sm6Cdm4QDk5+Yk+gK3HCSyYA8OulvuNIZ6NYaIGbKKn+cXqSYhv3MA1vSOIgv/hHo9cvqbe7Iam5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbqSHfoVQ2BeBf+O+6BaFn8kZrjzGekqOC890+tzGCs=;
 b=pT+VVNhSTdey2FYcbGjQ3FNCayVKhaBO/RwIPHjQ0+UUVH50qno1k61xYF/AJAkDnLKfVtHp03MmOJIPLdjsVOwQu9Nh+65itAKclxFdHuQ7LVjW7GS4ZDREE3m7S3TWqU9JTR7R2qZQXepGieWlZA6PRGrR5iYSZ5uvDG5pIdE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2710.eurprd04.prod.outlook.com (2603:10a6:4:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 7 May
 2020 06:05:39 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 06:05:39 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 01/10] arm64: dts: imx8m: assign clocks for A53
Date:   Thu,  7 May 2020 13:56:10 +0800
Message-Id: <1588830979-11586-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588830979-11586-1-git-send-email-peng.fan@nxp.com>
References: <1588830979-11586-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0147.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 06:05:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4637ea3c-c25c-4328-8cb5-08d7f24caaa5
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2710:|DB6PR0402MB2710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2710E558EE711496F42AABF088A50@DB6PR0402MB2710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AM/O3xxhvcwaxB7l5LJdMAFqC8GnIoErki1kvNfz8pVz0GMcB0+v5KSMdmo7d04GjvSCP8ouqhDp6Kx+dlMGleJtnHJr2QbWmbn2vuXhDQYuFc8B8DrHo658S1QTnDxAiTi2P10ZL1B06QzlwgMAutZ1rY8eZTBqhlCtyStb76zzDNxyYZap+wf4yqrkdQxxWAovApEig6XVo5mLOGiIILC4el+jHhDjGyorUh5t9FaRxBS0v55CcWteT+0ErhxHjrw7WNoY3984E8rzU2dl+Xhk/JnWINPC0oHj3ITK0dfeUv704yDjGEVnGtJWt6/j84ag9/Pb2RZ7F/9p6jisO/D2wBtg5rpY3aDxw7MhIBXeTPFqyliOpkZ+zcjs530HUx7mrV7QNl82ZKWV+BRBy31h5urGq0o2OCW77edQ42DDbICZCPc+cqVjPDULRp/dlFc/65K8sORi7BD/J/RTHsCqEHGgI5dxkSvUTBZUsXo+9lzdK/ybYFRw7wd+5sI/Blva7xkX2RHpm3zpDq9YAii/nAPhAXQzLgQiNCteupSnrQnOqYrawbN+kD8ipns4ia5H6MYdAJq3LnFHNtCxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(33430700001)(316002)(33440700001)(478600001)(2616005)(16526019)(69590400007)(6666004)(4326008)(66476007)(66946007)(86362001)(2906002)(66556008)(956004)(6486002)(52116002)(36756003)(8676002)(26005)(6506007)(8936002)(5660300002)(186003)(6512007)(9686003)(83320400001)(83280400001)(83300400001)(83310400001)(83290400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RAG7b5zQC5yFA9LYzERw2pzYmHFRdfWpcmhsFAhE+itBXNM/M8t/DY9V55YoYcB98N5vwdg8tajOnBzXUjZjkxtBheIBpKsS5WCokPWfxJRMgSaAvqx1xHOMEMJB4jegtdmLOkfQesxUIHnrIddih5Hiq+Sk56ZEPgedU6MbNy9aQI2b8LOW6q042GfXGQP+ehpXYo6lnI8mOBtzg1M7gZcdWKfHDWaabtnpzyhxhCiOFx33+zVYhQ54NPeYlmu7rUmBxwVaKl1l+B4YdHCpbyFxrymBNJpML7Ztuy2G7LibzkKVjMivxq1jVRG9fIEV1pRSyGnd0tF5f5LTSN52d33J5du8RU1x1o8/KEEvtAjiR2/O4YOWtD/Afhaez+8pIw6EQwYYpvyhzCuGRYu7ge8rcso3nSeP9uNUZKyE8omCm6fmqNerKA7zaTqV2sNiK/p/WAcicE82QwRl5O6Yxo7bW+evXQbyVXBveskNUPd8twRNs4slR9sMcIfPReD4Npk0eqQWcC2ZDZFKJc/krMZ49VHGUL+TW3JVtjQ3z/UsJQS65+6rC7dDcNqMmoRw49cOraMcG7oWouU9pdyx7UAUOSMVNaoGMsVxWrPnqeDlxEICty4ndi0F/UWiMQ3Y9CTI/2Cgfv80iDMBlyJESAz9n1gsl95Akrc6Y+ZBjVtPnzwT3b12DB9XhbYywmSW4WwMRjs5uWE1wQEQXvHtT+3EvmXXG9fH/fKZM6fLrYd8p+OClcYyfX6OyLu+7AVIJBgx3b4dGZxb+aLraLqjzv68RCT5VlYiT4F4W7VvrNg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4637ea3c-c25c-4328-8cb5-08d7f24caaa5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 06:05:39.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhLm6TaIH+BRCralT4nIB1rwU0y2ZVfr1rKBnh8eleNLURvaCqabnb1tyMask5ovpd9ZdWileMAI8A3+hwvYTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2710
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
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 10 +++++++---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 10 +++++++---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 11 ++++++++---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi |  9 +++++++--
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c63685ae80ee..aaf6e71101a1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -519,16 +519,20 @@
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
index fb63a98fdff5..9a4b65a267d4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -426,13 +426,17 @@
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
index 014205fc24f6..6d30208b6aee 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -360,7 +360,9 @@
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
@@ -368,12 +370,15 @@
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
index bab88369be1b..a6189460ed89 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -595,8 +595,13 @@
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

