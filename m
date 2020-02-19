Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A6DC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA49C24672
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wt8mDH9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSKXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:23:18 -0500
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:54832
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbgBSKXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:23:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVZiRGv8mXzHF45xRHB6nJttga6VzShMNtxMYqDZCevjvQA3qUAVyty4h80rJuTSo5IWLPHZrTgGW2uyp0hQ9JqTdN4PcFOpZHtWY7p/IMDvm8WCMcec1ZUvQwbYacdRrt/LBGaS5H0aogT3FKIRFX9mI27oLU4i69Y4CyXSZqcvJBLrz61XqF2Dd1+IBfT9o6MCb7iU9Lf2kX3wWYWLdlHZr38AxQw2u3PxaQ7EZ4TQBmmrdA0Kj1hzJ8cZIGmJ7GxPD9aENaXrrF9EqyZPmEU6FOIBYd0cw26h6VXtbXpKCzbqnFpe/GaTVb9vQJAIRbvd+y6GFRnEa3ka6+uXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+kgdvhsTrvidDFzKYrZZvTKpU6ws6tP+RaUjd3/80U=;
 b=TnN8fRfziXfjAhvtTxgN9uE+aqGxciRpD8yI7hekuXpJGjXK7KxIIZ/TkmFCOEd7EEd6EOpL+5buXgi73fuAxUgYU0Sdk8VcVY1oRMHmPOZ9Pq0IvUg59iIZEiIfqYrApkdVEaZwmkmxdSFAe9l7M/ZqMStXg4POe6GLVXu1EJS6B//eXcKUGBjL+AiC3d+ns5gH4+eWjNb0nbYRe5gymagCKcwAX3xgocVbn9pIRfSLJLoDuXGyAeTlNE+e3qSdQX3Tvpkr+tEhyJMNHGeavmb8yB5NLdcRv6B+sngeY3rv2M5rrhHYiNzQWAyFUgrlg7SjDkHlNXvKfE1nvyddcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+kgdvhsTrvidDFzKYrZZvTKpU6ws6tP+RaUjd3/80U=;
 b=Wt8mDH9UWM/wY58AKWWOCYxKXfcc+av3Y44YIWr9HPFvJnf+GIq5nX2XvuWu/6GiKHbs4IoECUrWw8iYLZ4UH3wyLnZH7fpgDlUMs+hc9zVCK/DATpDN4Vhv8rIYRyYZLozZlE0Uv575lKa7B4mxcFpmw8FVFvY8qTH7ehSpIXc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4099.eurprd04.prod.outlook.com (52.134.93.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 10:23:13 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:23:13 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH RESEND v3 1/4] clk: imx: imx8mq: fix a53 cpu clock
Date:   Wed, 19 Feb 2020 18:17:06 +0800
Message-Id: <1582107429-21123-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
References: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0014.apcprd04.prod.outlook.com (2603:1096:203:d0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 10:23:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 128fa790-1a01-430a-3dfa-08d7b525b9c3
X-MS-TrafficTypeDiagnostic: AM0PR04MB4099:|AM0PR04MB4099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4099C990577F304E3F24004E88100@AM0PR04MB4099.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(189003)(5660300002)(2616005)(956004)(66946007)(52116002)(26005)(6506007)(16526019)(186003)(66556008)(66476007)(69590400006)(316002)(6512007)(8936002)(81166006)(81156014)(2906002)(8676002)(4326008)(6486002)(36756003)(86362001)(9686003)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4099;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7aHc6u4QIf0o3ufdX4XZ50iwEUiatsCznVy+Vw6IWi741WgvdhGo9+BhmD8r75xnXTEQQNd8vzO+GtOYYyvpnwiyUAc9XjyGwFmQoPvE9RtqSXTfG+PMzFZytwSKYH7wQnpc6mIt9q2rwrlPQNPnprN6reE7NT4kJ+EE/tgTOW2MY/NveL7QfZNlZbxXlkFL6FjNZjr+nKP06WnNxlJlKf58qfMbfOt4XgEG+AqrWNNwkE8Q/VhB5k+3ICHR9o5pp7xVYRJUjDsCM2eUyR1aYBJnt4LvCXGzZha/lbmEWt/20Gn5TVA9A7iQyLnGIFhQZxtXx0RLuWOPftFZ4CMQ5QKG+9qh6kfv56PwkSotgtIgBZYvQpXsO+g8RnWKf/EbxfHRm8ONW7gB3fEWuNJcAWnKOrGnv+pOHY+saeOISFw2Qiqlrv0fgxonen64FD9JtYF/iEUPghN3WhMwWDchk4h0ghT2JEH958fkrm7pianj++cYWK5McJjbswjfX3RvYe9R2BJk53mjhkg1SKtPxEFv6j5OzWAm+PKNDZe0N82yN6dnE6C7XUHuY4xo2zro
X-MS-Exchange-AntiSpam-MessageData: h6a5EOKHLFO+xJiRxMcH98RVor6BLi/sO4H2qrEXcfZfcFx6yvaFED4MDE8J8cXbXYM8xCUUVwB41ojRWMBxnc16Xo8oahXAHd8f5hutfWDprgsIknhEYOQuE2A6jlFBAV0jHTtaxGhOaiYPN8FT4w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128fa790-1a01-430a-3dfa-08d7b525b9c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 10:23:13.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYWIPkA3lFhmqc21c706dC4eAjN526g3S/PxhXqVJHWwK0TYNqTlROUjFuaDvRXjoikN9sYGhjyLfUInUZXbrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4099
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

