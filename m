Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC69C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1A02464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PcoLuQUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgBSJ7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:59:53 -0500
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:29280
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbgBSJ7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:59:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkjvLk3bPl3jdQBiAQ63KBkyqpa+WW8Cjyr2bIuG0pFr7f7ARNhXExl44RhemLTk+9pFjJBn3GCgZAyaPa7i7ljW1LNz5PeUDHPGDEEw0xYJk8TWdMBTiEfFxq9AYOXrcYHekspWv4NEVhmOJVjx34nQEsQZ7ogTVmye48qqZvFocdQylgx9C/m65Z4hwn0lvjABJfplsFKx6DjNaD8RFBwuDbg8RRzKlXeqJpJ8DURmpw6bjAdcsDlnLXQQArNjsO8Bq3BDrfl19x4lNk8rcvf+9z1Eg6qiz6Rao1YvbvAMfLCdwcvW10FLTp2b4qBFYRxF4Fr1u0qmp+Dsgx3bLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+kgdvhsTrvidDFzKYrZZvTKpU6ws6tP+RaUjd3/80U=;
 b=aGTjdTeEmZeDyJo4GLoKMT1aKKxY4TfyvTSx4rks2bfnzIpOLMcBGstutmZq11e4dOHHtjKBiEf/cdovHjx1SpuIWgT2XCqOv0LPDNYhtQr/5moUhHlflROlB7dXmLEQ4fKnSX290t3e5RKl8NTdcUHgW45kb5Ad96sH3l2wxgvEfuyzQlxrm01bHxvg0vIh33ZAZOlnzXkZ/bjGL7mwAUHEKIycMt/2AtWJquq/0LKZjJ2f5Psr/OIxQ8QnVa+29oIC7C9hx62puMR/36hZASeKpLCvNZcvK/+KZe8rAOkiGMdopN6Jo3H2hQN++ZJyIgMfEOu5LEsqzxkMAJAYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+kgdvhsTrvidDFzKYrZZvTKpU6ws6tP+RaUjd3/80U=;
 b=PcoLuQUSPs84gAkfCIucaCdEEMSjbPDkyaf7231fG37ifxEtZ9tdZgRPeG5UEtJx74JP8zR9vqMz5YiUs4CEsqMxxHaljD5oBxSbMQdzIQmc0FanAMTXRbpIYjYKkgc7Y+ls2SCFwRScWs7aI/DSrb+O4031yRabpBoyJo210UI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6514.eurprd04.prod.outlook.com (20.179.254.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 09:59:49 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 09:59:48 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 1/4] clk: imx: imx8mq: fix a53 cpu clock
Date:   Wed, 19 Feb 2020 17:53:36 +0800
Message-Id: <1582106022-20926-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
References: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.8 via Frontend Transport; Wed, 19 Feb 2020 09:59:44 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7cec1c1-41da-4d7b-1dce-08d7b52274ae
X-MS-TrafficTypeDiagnostic: AM0PR04MB6514:|AM0PR04MB6514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6514EEB075DB798032B4563388100@AM0PR04MB6514.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(4326008)(2616005)(956004)(6512007)(5660300002)(8936002)(9686003)(16526019)(186003)(478600001)(81166006)(81156014)(8676002)(36756003)(2906002)(6486002)(6506007)(86362001)(66946007)(52116002)(69590400006)(66556008)(66476007)(316002)(6666004)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6514;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbpeBS0ae3AbgN9jhrHaSih++DLfgWDcwNi1SWMGfDIdi6n/gi3KWVcacIfolDcMIOHLTYSoJoSwLUK8hQnLBrVeA9tVAOrcICDpUzsmuRKwaggAak4rJJr2soz3fzFiQ/UDiEedu5m474w3MUlZ2eSFL+WBNPDnrQFscJ1hN2VwKJIwmEeZv/AVojNHkw7zoWHcuAPsAoadwczHeP7rTN4BoKzFnt9K5FU3PW4EKb+Mtaf6sHJlIcwYcgvvnV/1p7wAF58Ck6x2rwvKSH/v+oRMAJ5eEslG8pHraBkozyktZi+qGjwWdeC2K1HUy+g9T/Pw+8MeHZWlLk8chRjUHsSOv06yvt1S9wtzGa/BTWNsl4cm3sys/5cw7gGsWuvpt1G0eTrqzAV53aS01UE1wVJFUI2ECxmjn54Y3JKMgx25nIAacnfQhdVkgAlSTBx9DzVSKJc2+yaBSErTENKdWWrDy3mqiuH4fyKIJP1MkKB98d1nnJmBmXp8DMO3PCsaK3TtlFV4uYFJAhGZ01YcaYsi91J3Ol/IWo34eRzDAKwq5ToCWaT+qe891G5t+2B9
X-MS-Exchange-AntiSpam-MessageData: P52/r3jlLvwyqdw556lLNwukV5/DOuCD+TCwqEmTehZ5iQ3VnM9d0Uf5AeLQzD9su52LUMUWNJhk1mqH+AOm+fxzIqGeiexBUjyDj3eoV+nRGMzLZxmkNU1mkDHPYcKyo1Y7WqCw1hCii1m9j80pgQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cec1c1-41da-4d7b-1dce-08d7b52274ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 09:59:48.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKKJmR6nP4X50/l+nH1pA4IJ0rVrVUdPk47C/dJ9Sy9prRLU35WDMR5+g/LhH0ThOHhYqDVK5LYYUd/OkF4nNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root
signoff timing is 1Ghz, however the A53 core which sources from CCM
root could run above 1GHz which violates the CCM.

There is a CORE_SEL slice before A53 core, we need to configure the
CORE_SEL slice source from ARM PLL, not A53 CCM clk root.

The A53 CCM clk root should only be used when need to change ARM PLL
frequency.

Add arm_a53_core clk that could source from arm_a53_div and arm_pll_out.
Configure a53 ccm root sources from 800MHz sys pll
Configure a53 core sources from arm_pll_out
Mark arm_a53_core as critical clock

Fixes: db27e40b27f1 ("clk: imx8mq: Add the missing ARM clock")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c             | 16 ++++++++++++----
 include/dt-bindings/clock/imx8mq-clock.h |  4 +++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 1f5ea1eaad65..b81f02ab7eb1 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -41,6 +41,8 @@ static const char * const video2_pll_out_sels[] = {"video2_pll1_ref_sel", };
 static const char * const imx8mq_a53_sels[] = {"osc_25m", "arm_pll_out", "sys2_pll_500m", "sys2_pll_1000m",
 					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "sys3_pll_out", };
 
+static const char * const imx8mq_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
+
 static const char * const imx8mq_arm_m4_sels[] = {"osc_25m", "sys2_pll_200m", "sys2_pll_250m", "sys1_pll_266m",
 					"sys1_pll_800m", "audio_pll1_out", "video_pll1_out", "sys3_pll_out", };
 
@@ -425,6 +427,9 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MQ_CLK_GPU_SHADER_CG] = hws[IMX8MQ_CLK_GPU_SHADER];
 	hws[IMX8MQ_CLK_GPU_SHADER_DIV] = hws[IMX8MQ_CLK_GPU_SHADER];
 
+	/* CORE SEL */
+	hws[IMX8MQ_CLK_A53_CORE] = imx_clk_hw_mux2_flags("arm_a53_core", base + 0x9880, 24, 1, imx8mq_a53_core_sels, ARRAY_SIZE(imx8mq_a53_core_sels), CLK_IS_CRITICAL);
+
 	/* BUS */
 	hws[IMX8MQ_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mq_main_axi_sels, base + 0x8800);
 	hws[IMX8MQ_CLK_ENET_AXI] = imx8m_clk_hw_composite("enet_axi", imx8mq_enet_axi_sels, base + 0x8880);
@@ -588,11 +593,14 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MQ_GPT_3M_CLK] = imx_clk_hw_fixed_factor("gpt_3m", "osc_25m", 1, 8);
 	hws[IMX8MQ_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
 
-	hws[IMX8MQ_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_div",
-					   hws[IMX8MQ_CLK_A53_DIV]->clk,
-					   hws[IMX8MQ_CLK_A53_SRC]->clk,
+	clk_hw_set_parent(hws[IMX8MQ_CLK_A53_SRC], hws[IMX8MQ_SYS1_PLL_800M]);
+	clk_hw_set_parent(hws[IMX8MQ_CLK_A53_CORE], hws[IMX8MQ_ARM_PLL_OUT]);
+
+	hws[IMX8MQ_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
+					   hws[IMX8MQ_CLK_A53_CORE]->clk,
+					   hws[IMX8MQ_CLK_A53_CORE]->clk,
 					   hws[IMX8MQ_ARM_PLL_OUT]->clk,
-					   hws[IMX8MQ_SYS1_PLL_800M]->clk);
+					   hws[IMX8MQ_CLK_A53_DIV]->clk);
 
 	imx_check_clk_hws(hws, IMX8MQ_CLK_END);
 
diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings/clock/imx8mq-clock.h
index 2b88723310bd..9b8045d75b8b 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -429,6 +429,8 @@
 #define IMX8MQ_CLK_M4_CORE			287
 #define IMX8MQ_CLK_VPU_CORE			288
 
-#define IMX8MQ_CLK_END				289
+#define IMX8MQ_CLK_A53_CORE			289
+
+#define IMX8MQ_CLK_END				290
 
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
-- 
2.16.4

