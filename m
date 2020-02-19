Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B27AC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C5E24658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QRiRYp22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBSKX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:23:27 -0500
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:25853
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbgBSKX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:23:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSOquqItYHGyAqVQkIOODCkH6Og+Kjoihsnu+8tY+qYJwfI/Tsu+Tgv+Fdg4XoUfPrlcWkFsKGH+gI78rlI00coQDSe2SoI0tAyu4VHl+Ez2trT13/YDMjZbrNZzGgbwlJoDv4V52oGZOxtgpESsQg+MaJOmhx+ET7G6GExJFljSBqrf+EhTnV6wGQD6mGTms87Am5O4lzAi3IEmsz/q0JbCPCSEC09Jn86UdK2ihK+WkdqyHYLDScnx5nfehvDu8RCLmjxFCgzjAr+38UNRziJaGsTQ2rfffeqO8UYvdQB7xlxiq8+HispwVAqwr9lvmYiJ5VtpYQ+ehzZ+FEcZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZj/tQFK+TG9SaEptTiSGlv7Los740ea3CD53lknP2Y=;
 b=Gl7dJA2PIgbge5c422uOUZ/EenwpUte4FnoQlxIKipqRQyf1Qmg9JXAoBrKH82MngXRJXMFaeTm+IscSq/g82EsaIc6nAPzxGiQt+1mO7We2y8VRSryJfVMN9XsVHagRyZYlKmsnVfMuQLZqzoCMffCMJRH7yLB6QOR6tyEDZkOP6sTWyVC7OjeKbTEylbFC2RM9v2LiBg44FpjTyddZ0/hadhuzdeswjMiPfPN74mr8i6Cjh777AxEWI+IdvAmFClAWHUN/yJy4b2ZsBX9ubOUxjKu1+9TA/sQhzgoAUQOFQjuVKbvNOSojMvKm0PnszPkJ8KRXTOm6U+uvVFlBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZj/tQFK+TG9SaEptTiSGlv7Los740ea3CD53lknP2Y=;
 b=QRiRYp22w8AzofJunGpu8KVBazoGr9QJCAoaEWJscshjRl1+4O7qCAURMB1f4iUbGzHn3niWFExCKimk89iIuJMVgrBiWAaMLn3RzbbvNEMBT6g3sBduPava3FVoxzi8jA8qzc8Yvl68cF6laGH86EOSI4KpdoqW5NEvKOFIHjQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4099.eurprd04.prod.outlook.com (52.134.93.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 10:23:22 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:23:22 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH RESEND v3 3/4] clk: imx: imx8mn: fix a53 cpu clock
Date:   Wed, 19 Feb 2020 18:17:08 +0800
Message-Id: <1582107429-21123-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
References: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0014.apcprd04.prod.outlook.com (2603:1096:203:d0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 10:23:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35b55e28-dc7a-4d1c-33ef-08d7b525bf53
X-MS-TrafficTypeDiagnostic: AM0PR04MB4099:|AM0PR04MB4099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB409975110A724360B1002B7C88100@AM0PR04MB4099.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(189003)(5660300002)(2616005)(956004)(66946007)(6666004)(52116002)(26005)(6506007)(16526019)(186003)(66556008)(66476007)(69590400006)(316002)(6512007)(8936002)(81166006)(81156014)(2906002)(8676002)(4326008)(6486002)(36756003)(86362001)(9686003)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4099;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRObZyePopUz3igkJF2BcilonlKOlqpUlHEXu9s9vkyA7Pp061E8APFz4x9sObTu5BG5w3b3+EOyLS2m2TnJE+9Ej4NCej+XxyhbwLfu0JkgD5mNT04KgqfSOEB3Krp0PKo6xllykF7HCEn6SuUCDcVuGjv8uJHpRV5pmCdOC2I7s2Fp9alpseeeiGZhmyOb1Nl4UJMLvpFzlFkeYUCXRiMnMB+B0/rdyMVabdoMsNDTBUJXMqZEBZjXd6H87rS9R/aKtEhsNFM1ymD5NbVRLzWth8dbzPZiQvUmoI8+SOtil6MHcdZ9CZlD511hLDQ5selVOTpnImlUntCfFipafH86ASfD/4Ormu/eKoxDSSqpTrlSfMCyCj8Jtv6LNoFnHWfpKDqHUwqbpuuzzOKPrisZHFqVwdXJix2fgXpKqYLPF/lRcp0+CUi+Csd2KuchQKaViK4K9ykWov6kUbbBfY3mZ9HXpqIg3U1LGRv2vXZbEq6yyR9FLXIoH1YLmhKvHu4XLvGz8gjybWKhoPL/VGN+yI5PomsDXV+cUDXJiZ5PyLcBBpmPjUm89TISnVLS
X-MS-Exchange-AntiSpam-MessageData: qwzoEH2dzlI7nx7oKF/gaiJNhFNpsosk6EvG4pX8usiMnoFsU3xFPilXcicbrKJnoerZIoWZq48Fs8w9/uAT2s81owAQjiX0jI/fBNLVkUPwPOt0cIF+rPgkjBcdfZ8WV50X4fe/bY+Ce+LPBsyJ0w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b55e28-dc7a-4d1c-33ef-08d7b525bf53
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 10:23:22.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSAJEDaqDdqsOvhgPEj8WrjH912fa7P56bVMQi9gFQJRDcr+d3SnFMwgJynK5OxkPfF/IgJaRpu2yjv1kXxKiw==
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

