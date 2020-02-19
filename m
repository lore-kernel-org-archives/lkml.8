Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC782C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DCE24673
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A+bLffdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgBSKAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:00:13 -0500
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:44450
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbgBSKAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:00:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwZWGSD2Ln4bZgM/LSAAWk53EYIHqNOfCzJ2LRHvlZBtEqshlIG2iyzHZ8/64HbTIooOFvnxYuPq2WFrBZ3jzv3bYrXoux49E5C0qKt4fODIVadttl8t3lxu86iqC/STf8tSCreuRaQqOUbN8RgwWfQj2XYF/PI94lNn2DVb/j1G5vbUXpSH/EVAkqkMqdIVG7cGa3kggFWQh3sMhfzxQBtkZAJSjnr4qL9dhJ+a5bWSY03Nzfoiq7MRqhWTy51j2K5R70jUSXGZece4UF/mTyn5/uZOrvaFkfP+jVYwr0Fth5f52ORJcVuelvrMia8C8fEPWGFJVXvvIcryOAe5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZj/tQFK+TG9SaEptTiSGlv7Los740ea3CD53lknP2Y=;
 b=nFeIrP27Q08vdcL8eXNnxxn61o/ma0iVw4b6/EJCoA2zF71ZZULwCzzsU1UMyQJRncjkuXfwvamUpX4CS0rqcRXT2OkFT01qYzKymwQRpeAxXkJkfrank0NfJVvpp5T3Si4as9bEWUxQVcGhyuhMtI8/ES1ZEwU6Lv977kxO0XQKrgwhCP8GGRkO8APhDvA0a/r0ddmzewiCDlm0fM3T9bZbwT8aHJMO6V1VKEKuBkQmuBmuk3eY7iJG35aRqpKrlCsZv4n2PPLxJ4WJCSd63qH1VYOIqKo6TA7UqVSf7ssBdyZbsRlIARQhEZZoXbuwxvEKZehg3MjRY5ZI1sI+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZj/tQFK+TG9SaEptTiSGlv7Los740ea3CD53lknP2Y=;
 b=A+bLffdYAzwqxEneAe53wONHCVEtMFtKW2iwkXhS8m8nbJx6oAJxyHi0xYIYAlO6edaGVYuBW4wuNCetk9g3TL8wdNo2rlXDyN6lBdB1W2xm+sAczX03b6Ckgi/KnhSakWoZKMAJv4v3X+u3Pd0WUYm8ZIvwUnfTNImR5Cl50us=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6514.eurprd04.prod.outlook.com (20.179.254.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 10:00:08 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:00:07 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 3/4] clk: imx: imx8mn: fix a53 cpu clock
Date:   Wed, 19 Feb 2020 17:53:40 +0800
Message-Id: <1582106022-20926-7-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
References: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.8 via Frontend Transport; Wed, 19 Feb 2020 10:00:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c8f267e-5ef2-40d5-3c17-08d7b5227ffe
X-MS-TrafficTypeDiagnostic: AM0PR04MB6514:|AM0PR04MB6514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6514C02B28B18C397B9CAEC288100@AM0PR04MB6514.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(4326008)(2616005)(956004)(6512007)(5660300002)(8936002)(9686003)(16526019)(186003)(478600001)(81166006)(81156014)(8676002)(36756003)(2906002)(6486002)(6506007)(86362001)(66946007)(52116002)(69590400006)(66556008)(66476007)(316002)(6666004)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6514;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MlVbAa4gTA2gt6vCLiFRA3MKjm0XuJUSraPQzetf2HUaA3auwKA/lP5eruEziA/kMMy3qoBp2dwST4AP/8ZcL1QSA2HzLBtJ42r7nFP7hQJXSvPyN7CQCFjqYsPwL44amuVrt6kN47tsLkojEG4O4D53vke0H+ZMl77j/Gzmd9cx5iVEO7NlQW79GmUDS+djTNKF30iHJQFSB1neODu8PaEEBmMNzWuY7L3uNfWcRzv1ksdbs20S4BeQHkGzrK5quxOejT92gic1t86P2enXrwnVfP6nbCoZzhs65ZYflsSkUwJpgcDO0vqXDss49hngFAfBoznU7c53aAaHrVU4YQ2+bduxBdAz5EoP4gJQZzIM2U9le0CHu8HPilQIUUf/DXJkH3Na6Ha4a1G728U/Ukk9nmuiiGmeaWDWQFJb/SJb/je3MnJOwaF0ZZJioUP+VBa51iGEkcXzWvw1g08STVRONYiljj5fn2nmrlVLMH1fv0WlAS/QyTe5IxIhFMPRJA+AqP2+AsJ4S6gCeoUtBr8lQ+4ZArIKCU2C9VlrWDcdwikThc+DLeGhYPFemuIY
X-MS-Exchange-AntiSpam-MessageData: wiCm1y+uQT9gKMmTx5gx4hCxp3SwJpNjbsDNdKjRL9lnRG40WoIdQTjnAuyKOArxL7bkdDi6GsV6tkqiSQbhTWnbq9zwlQndQAjCFxqQzxFWton2aX1Zab7C5kQ/+ETBLQFJOkGXzsc+alPER9ddAA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8f267e-5ef2-40d5-3c17-08d7b5227ffe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 10:00:07.9416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7V02q/K074obQH6kwbcUASPLUJCIdV91Ky9F4UEuZaWd4qwtagueuCaVLtw1Eb5x3jPMJT7QA0Q7AtDvckPspg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root
signoff timing is 1Ghz, however the A53 core which sources from CCM
root could run above 1GHz which voilates the CCM.

There is a CORE_SEL slice before A53 core, we need configure the
CORE_SEL slice source from ARM PLL, not A53 CCM clk root.

The A53 CCM clk root should only be used when need to change ARM PLL
frequency.

Add arm_a53_core clk that could source from arm_a53_div and arm_pll_out.
Configure a53 ccm root sources from 800MHz sys pll
Configure a53 core sources from arm_pll_out
Mark arm_a53_core as critical clk.

Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c             | 16 ++++++++++++----
 include/dt-bindings/clock/imx8mn-clock.h |  4 +++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 67b826d7184b..f44229ca19e8 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -40,6 +40,8 @@ static const char * const imx8mn_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pl
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
 
+static const char * const imx8mn_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
+
 static const char * const imx8mn_gpu_core_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
 						    "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
 						    "video_pll1_out", "audio_pll2_out", };
@@ -427,6 +429,9 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_GPU_SHADER_CG] = hws[IMX8MN_CLK_GPU_SHADER];
 	hws[IMX8MN_CLK_GPU_SHADER_DIV] = hws[IMX8MN_CLK_GPU_SHADER];
 
+	/* CORE SEL */
+	hws[IMX8MN_CLK_A53_CORE] = imx_clk_hw_mux2_flags("arm_a53_core", base + 0x9880, 24, 1, imx8mn_a53_core_sels, ARRAY_SIZE(imx8mn_a53_core_sels), CLK_IS_CRITICAL);
+
 	/* BUS */
 	hws[IMX8MN_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mn_main_axi_sels, base + 0x8800);
 	hws[IMX8MN_CLK_ENET_AXI] = imx8m_clk_hw_composite("enet_axi", imx8mn_enet_axi_sels, base + 0x8880);
@@ -556,11 +561,14 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MN_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
 
-	hws[IMX8MN_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_div",
-					   hws[IMX8MN_CLK_A53_DIV]->clk,
-					   hws[IMX8MN_CLK_A53_SRC]->clk,
+	clk_hw_set_parent(hws[IMX8MN_CLK_A53_SRC], hws[IMX8MN_SYS_PLL1_800M]);
+	clk_hw_set_parent(hws[IMX8MN_CLK_A53_CORE], hws[IMX8MN_ARM_PLL_OUT]);
+
+	hws[IMX8MN_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
+					   hws[IMX8MN_CLK_A53_CORE]->clk,
+					   hws[IMX8MN_CLK_A53_CORE]->clk,
 					   hws[IMX8MN_ARM_PLL_OUT]->clk,
-					   hws[IMX8MN_SYS_PLL1_800M]->clk);
+					   hws[IMX8MN_CLK_A53_DIV]->clk);
 
 	imx_check_clk_hws(hws, IMX8MN_CLK_END);
 
diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings/clock/imx8mn-clock.h
index 39e088f6f195..621ea0e87c67 100644
--- a/include/dt-bindings/clock/imx8mn-clock.h
+++ b/include/dt-bindings/clock/imx8mn-clock.h
@@ -232,6 +232,8 @@
 #define IMX8MN_CLK_GPU_CORE			212
 #define IMX8MN_CLK_GPU_SHADER			213
 
-#define IMX8MN_CLK_END				214
+#define IMX8MN_CLK_A53_CORE			214
+
+#define IMX8MN_CLK_END				215
 
 #endif
-- 
2.16.4

