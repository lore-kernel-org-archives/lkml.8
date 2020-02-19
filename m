Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5963EC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A11521D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gn2oQ9cJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBSKAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:00:23 -0500
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:34030
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbgBSKAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:00:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtlFd/FcrFOm+R75J4krxxW6kHY4bCj+Ekw7JTOPoRJB2HUjWQRtnPidhN6DTXZWNMqXXg0iXe5moMU5Vo6KIi22V55ozfBpvhS6RhNVWmYoqWQ8pDjyBO2LH5FLh2H3mSLhBiIVkWC5l8EYFuAqOqrcKuxQ9GHrQNBIJPTuVDEqPCFUpGAvZ+pj/rfHiY+XR5X0OzMpWaIB8YafM3tr0NZA6T6Cwde1yNeCCQEbl20ZDeSkgLcA7VRKi4tLjB5iKqpe2N1ngQgf/jE17HsjFN1RznsNe6PXVEeEj4w8tS9xRvabaRBb1sd6SR2+SNKJak8e/X0Jqjn1PXxKAUHmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Oy1dR0aG8YGDdnOFrIOVj6WElHxZlH/iIKD9NQQQI=;
 b=hsJxz0Py/6bFc+mf/pU5CguHmpiqQdvV7/2g469fkyfqmfmPnMH3ZttJf4oxsxmkvVmdusmi9Pav7fAkV84aydw3Gpf9rCLZ0ty7YjmWaVl53wTzZM05ifKyf24397G86RW0X3RnS3Mm9EFoOw65MC9otEaqfYSeMb+0+uUEeWIfa68CUXRpKkzKIdIjJF5yLQRFzsVCHtVYjMzEs138L5521gkwSbjc6re+jVa4+6fNn8xTZh8Ho2ytCK8iC/pEnvuR7Kzli+O4Q2a8gC/XuISKCtxLrdKLTWwpfrNqv0DyhrAdU8ta3sa01pVPiFR3WtPbc8pDXoipHyrudETtIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Oy1dR0aG8YGDdnOFrIOVj6WElHxZlH/iIKD9NQQQI=;
 b=gn2oQ9cJGP19prF0B5sXhGtoO+inScnQyrGtVlU99Kgj+UYglOg36GhIme/BbQ8Vg0W8EIciOjcuokr0VBPMcFO1YoZu+ALrARPlBnsvf3PFfWfTPImnDY178g2yuZtbxHv2pGkoA9Ec6xuphZ+GHuJD3Tykbce65bbp98dIm/U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6770.eurprd04.prod.outlook.com (52.132.214.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Wed, 19 Feb 2020 10:00:17 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:00:17 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 4/4] clk: imx: imx8mp: fix a53 cpu clock
Date:   Wed, 19 Feb 2020 17:53:42 +0800
Message-Id: <1582106022-20926-9-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
References: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.8 via Frontend Transport; Wed, 19 Feb 2020 10:00:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f308db0a-d74f-490b-3b62-08d7b52285ea
X-MS-TrafficTypeDiagnostic: AM0PR04MB6770:|AM0PR04MB6770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6770815FD086C1B433A0028C88100@AM0PR04MB6770.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(66476007)(66946007)(4326008)(66556008)(6666004)(5660300002)(86362001)(69590400006)(16526019)(8936002)(2906002)(316002)(956004)(6486002)(36756003)(52116002)(26005)(6506007)(186003)(478600001)(81166006)(8676002)(9686003)(2616005)(6512007)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6770;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WnmOIZbeQ+hG3haYvRxAlTZZKJHYJVP3i3AFEom+yBzBkoA7gGztxopA/apTQjJaAkg001ZaecYnrs3kiBERYzgyhuxzSggT90pHCXXbQa4DwZY3Jsdsri7b/KzTFDidEIamf9b2LRHNolWr5xEsasPoS40RnLjLRAW0msPsoK4yhRbq+BQsFj6U4GKC9KlkF1qCVzVCJjILYcNFgN/WVdcnLJgiN+/b4MKqo2Aed+JrfPRY3VPiKcMihBSLyCk3hOrCDn6HEvLzYcFUcR7zuz3A3ojJQfswA8diNgAo66ar+Kk2lvyucnnkNCOA58ry2vF+RSpwo4Sixo5dZO8YSt6gQUbWrhBUzkRM7T4/Ig6IK1BN5CEuEk2cAlbGZcOrGxNbDgRLmgAectcDVMftD1KGxYS0scuipawgk9qkfXJ6FYiBYAxZrDnygNO8Kq7cUlfGKeWwxT7H+sVxqW9+abpNPtP+1eEsm/0v8jBg0TF9mXq8imtLvSaCTg+gWKRUBt6fkesz58M6wV9FeOMQdUVrOReiD8Ddy+VkTFKxugAbfovdNSOb84JySJXFmCr
X-MS-Exchange-AntiSpam-MessageData: BYrnBWBoAo169dcoJH7e0i8szaYkKrlxk+MiQBpo7H9PY5AeC4HoVPUwyHuUa/1RpnTDpv0xTQIjpctB5cfA2E+G1HWwlX0MGTeyk8slpTkNkE4xhqgSAYJiCJPybBI9mfiEIraEbiRYfpAUWI8fKA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f308db0a-d74f-490b-3b62-08d7b52285ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 10:00:17.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EP9Nntow6ExhkMXPb4tWSGU38SwmbOFPd2dOwgJ3imgEj6x5aNcKPC1naxQbqLCPgqqx+3x6MwD2G9YtQ9Ra6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6770
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
Mark arm_a53_core as critical clk

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c             | 16 ++++++++++++----
 include/dt-bindings/clock/imx8mp-clock.h |  3 ++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index a16af4fce044..d67ee36b84de 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -34,6 +34,8 @@ static const char * const imx8mp_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pl
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
 
+static const char * const imx8mp_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
+
 static const char * const imx8mp_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m",
 					      "vpu_pll_out", "sys_pll1_800m", "audio_pll1_out",
 					      "video_pll1_out", "sys_pll3_out", };
@@ -554,6 +556,9 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_HSIO_AXI_DIV] = imx_clk_hw_divider2("hsio_axi_div", "hsio_axi_cg", ccm_base + 0x8380, 0, 3);
 	hws[IMX8MP_CLK_MEDIA_ISP_DIV] = imx_clk_hw_divider2("media_isp_div", "media_isp_cg", ccm_base + 0x8400, 0, 3);
 
+	/* CORE SEL */
+	hws[IMX8MP_CLK_A53_CORE] = imx_clk_hw_mux2_flags("arm_a53_core", ccm_base + 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels), CLK_IS_CRITICAL);
+
 	hws[IMX8MP_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mp_main_axi_sels, ccm_base + 0x8800);
 	hws[IMX8MP_CLK_ENET_AXI] = imx8m_clk_hw_composite("enet_axi", imx8mp_enet_axi_sels, ccm_base + 0x8880);
 	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_critical("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
@@ -724,11 +729,14 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_VPU_ROOT] = imx_clk_hw_gate4("vpu_root_clk", "vpu_bus", ccm_base + 0x4630, 0);
 	hws[IMX8MP_CLK_AUDIO_ROOT] = imx_clk_hw_gate4("audio_root_clk", "ipg_root", ccm_base + 0x4650, 0);
 
-	hws[IMX8MP_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_div",
-					     hws[IMX8MP_CLK_A53_DIV]->clk,
-					     hws[IMX8MP_CLK_A53_SRC]->clk,
+	clk_hw_set_parent(hws[IMX8MP_CLK_A53_SRC], hws[IMX8MP_SYS_PLL1_800M]);
+	clk_hw_set_parent(hws[IMX8MP_CLK_A53_CORE], hws[IMX8MP_ARM_PLL_OUT]);
+
+	hws[IMX8MP_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
+					     hws[IMX8MP_CLK_A53_CORE]->clk,
+					     hws[IMX8MP_CLK_A53_CORE]->clk,
 					     hws[IMX8MP_ARM_PLL_OUT]->clk,
-					     hws[IMX8MP_SYS_PLL1_800M]->clk);
+					     hws[IMX8MP_CLK_A53_DIV]->clk);
 
 	imx_check_clk_hws(hws, IMX8MP_CLK_END);
 
diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 2fab63186bca..c92d1f4117eb 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -294,7 +294,8 @@
 #define IMX8MP_CLK_DRAM_ALT_ROOT		285
 #define IMX8MP_CLK_DRAM_CORE			286
 #define IMX8MP_CLK_ARM				287
+#define IMX8MP_CLK_A53_CORE			288
 
-#define IMX8MP_CLK_END				288
+#define IMX8MP_CLK_END				289
 
 #endif
-- 
2.16.4

