Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C9C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0D124671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bWOPgk1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBSKXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:23:23 -0500
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]:63363
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbgBSKXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:23:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXvua4OwqV9RoRHy2vZNkOUvMfNLJWIvoYlohfigTU4CrItxetr2rH3uG4YO67frMtjwJD5z3CdUqU9vk1OvWfB+RQJcBIZMCG6Bw9sMWB6zxEilyqP9AcwMF9kt44dupcO7D2bI8JdVWYejh5AupLCAtUPA+7V/WXLBxIwOr3Gm1xE+P9/GMxAeTFA4otTETgDnIfYcmepqG9c3CniAx9CFp6izamS2agf2y9i7A94IDy6gZTSf/AkqBofQHymk1NTqWJUOnUn0t3UZFf2t8+AMuwT2YR0SGAl/acrxRLnbrIOIGHxFrPhI6WVaoruO52Wq7bs4Q4LF+yXDFQ8mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f43JoIc+8YLyGY0c4NvlXlO4/YEjkBxXnXJBlMKE35E=;
 b=GtyS2VR7pVXLNQKSDnsf5H2OxL4tj07M5eQl9wj7/aqtORApdpNM9EK/8xhiQTtsj9ZMjeC2kscvasF5PrevAVfeFiEvIC+xRfnqd9s1T5sokJRfE6YuzfvzVw82CNqXPvSrmkpg2k6wrDp6vQyX5alaIJnskIPOave5PnnGlRyMEjqGEHIpJ4XmIxaetJuw4O5DW+rsTICwOu89vcO2GpGemMxgksKujmHPb9LGZDzwQOfFstdIFoFkq+zOM9Vw39Yy6EgPAAfz9hBlBy0xWdxzOLeGZr4Y1JGDJfxXBCdswCAbY/J9O/zlekVqHtOrPp6fOoeiqM90un58VyvsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f43JoIc+8YLyGY0c4NvlXlO4/YEjkBxXnXJBlMKE35E=;
 b=bWOPgk1m+VU3w0rv4iK9uicUAsdZUAVsy7K/3dlh4VvdtmWmN7pfEB91sCgDuF+q/NONC6FGYZVrJK6iIDZkyBQ6TaAax3n0DlpTATEbkFrdcSQqGPq55GSxeUeWD21SalHEr8rKlD3NbEqKbmLnze/VJHkr74z1U/f6donEUZw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4099.eurprd04.prod.outlook.com (52.134.93.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 10:23:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:23:18 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH RESEND v3 2/4] clk: imx: imx8mm: fix a53 cpu clock
Date:   Wed, 19 Feb 2020 18:17:07 +0800
Message-Id: <1582107429-21123-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
References: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0014.apcprd04.prod.outlook.com (2603:1096:203:d0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 10:23:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06a79a44-f7d2-42ae-02f3-08d7b525bc89
X-MS-TrafficTypeDiagnostic: AM0PR04MB4099:|AM0PR04MB4099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB40994C52B6049A551764741088100@AM0PR04MB4099.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(189003)(5660300002)(2616005)(956004)(66946007)(6666004)(52116002)(26005)(6506007)(16526019)(186003)(66556008)(66476007)(69590400006)(316002)(6512007)(8936002)(81166006)(81156014)(2906002)(8676002)(4326008)(6486002)(36756003)(86362001)(9686003)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4099;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCMUAEG3OLb7AsJiD0EQoXyEnAaKXvpFlrriXqANFt30mHLdz1R2HAdlrjqYKmjKCx2ZxIcC0XLmZchOV2whhrng60inn5pJrI0O//Du8pBRQnr+h4AuPQ4RfoVWidF9z1ZOrp8GCSCUmscCtsoBmiXzB+GTMdfEk5As3K5o8ttyggIXKEbu0H0XzSXaIYuYn2vhl82CcRRZK22N73xbXIoYSjmiZX4FKe3bOsWFHaLaYTq6d2NIDgarB01OvRINIEftdpgUzpPpE6TDo1OwXuN9BhyTKfqTSZNUGoZF7V2EScPy8DoeNTYQhQ5JHpszmeOIEWL/pEaNwjLzG9/RZ8VilSOIAP+U0CcdTVgupWBjEnGD4NJYpeGPglchxk1Qz+LSTAUXQmwriGAVw2fcSfje2VVbUNGLEbiJNHyQ7YNP6nqHNPQW1fn3d0HNpThZewN1LileRsJRipjo1iTWrYQhLgXgo//Gc2/XlpVwOecbTf2MN/p6bLLntSs6kjdsdrrw0n67L+puzPMU8GSgYZlmpp04d6RedJmCvb0nJ5TCdzw5qK+1TsLa8XsnXVWp
X-MS-Exchange-AntiSpam-MessageData: u9XZIs+C0WTodMDgzVdKq3y3iHgrv7G+I3anBcN6RJb+XfRXNGTyTn5yWk77b+0fHa+o61tIRUE+3lVlW67EPRzIpw3EBnamyo1/63Yox/kWMp3MVMjF6K85pXLDaKReGGhqhQTl9fNJB4S3Z8bh0Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a79a44-f7d2-42ae-02f3-08d7b525bc89
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 10:23:17.9306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpU95WZz34RnGuf2QeFqCFYDJnhDlyuc9jy/xBht1Fsf/Tn3nPDffdybyDbDbnEE7Q+sHUZxI0JpCGzWv7B9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4099
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
Mark arm_a53_core as critical clock

Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c             | 16 ++++++++++++----
 include/dt-bindings/clock/imx8mm-clock.h |  4 +++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 2f2c240a86e2..f851cd447e7c 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -41,6 +41,8 @@ static const char *sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
 static const char *imx8mm_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pll2_500m", "sys_pll2_1000m",
 					"sys_pll1_800m", "sys_pll1_400m", "audio_pll1_out", "sys_pll3_out", };
 
+static const char * const imx8mm_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
+
 static const char *imx8mm_m4_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "sys_pll1_266m",
 				       "sys_pll1_800m", "audio_pll1_out", "video_pll1_out", "sys_pll3_out", };
 
@@ -439,6 +441,9 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MM_CLK_GPU2D_CG] = hws[IMX8MM_CLK_GPU2D_CORE];
 	hws[IMX8MM_CLK_GPU2D_DIV] = hws[IMX8MM_CLK_GPU2D_CORE];
 
+	/* CORE SEL */
+	hws[IMX8MM_CLK_A53_CORE] = imx_clk_hw_mux2_flags("arm_a53_core", base + 0x9880, 24, 1, imx8mm_a53_core_sels, ARRAY_SIZE(imx8mm_a53_core_sels), CLK_IS_CRITICAL);
+
 	/* BUS */
 	hws[IMX8MM_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi",  imx8mm_main_axi_sels, base + 0x8800);
 	hws[IMX8MM_CLK_ENET_AXI] = imx8m_clk_hw_composite("enet_axi", imx8mm_enet_axi_sels, base + 0x8880);
@@ -605,11 +610,14 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MM_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
 	hws[IMX8MM_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mm_dram_core_sels, ARRAY_SIZE(imx8mm_dram_core_sels), CLK_IS_CRITICAL);
 
-	hws[IMX8MM_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_div",
-					   hws[IMX8MM_CLK_A53_DIV]->clk,
-					   hws[IMX8MM_CLK_A53_SRC]->clk,
+	clk_hw_set_parent(hws[IMX8MM_CLK_A53_SRC], hws[IMX8MM_SYS_PLL1_800M]);
+	clk_hw_set_parent(hws[IMX8MM_CLK_A53_CORE], hws[IMX8MM_ARM_PLL_OUT]);
+
+	hws[IMX8MM_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
+					   hws[IMX8MM_CLK_A53_CORE]->clk,
+					   hws[IMX8MM_CLK_A53_CORE]->clk,
 					   hws[IMX8MM_ARM_PLL_OUT]->clk,
-					   hws[IMX8MM_SYS_PLL1_800M]->clk);
+					   hws[IMX8MM_CLK_A53_DIV]->clk);
 
 	imx_check_clk_hws(hws, IMX8MM_CLK_END);
 
diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings/clock/imx8mm-clock.h
index dbfee6579d6c..e63a5530aed7 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -272,6 +272,8 @@
 
 #define IMX8MM_CLK_CLKO2			250
 
-#define IMX8MM_CLK_END				251
+#define IMX8MM_CLK_A53_CORE			251
+
+#define IMX8MM_CLK_END				252
 
 #endif
-- 
2.16.4

