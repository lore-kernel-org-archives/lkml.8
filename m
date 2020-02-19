Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CD9C34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4742464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="neCIwgLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBSKXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:23:32 -0500
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:39555
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbgBSKXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:23:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT38mFXrbmuXwBiuci/VpW8vptR+JzlNxXSojekoWKXq3irBc/vcAO1K679EY9ypwVU6zeRTFusnwlqXqPOGEJeuhQW2amD+XuuCmz+RJnRFMwoBuCN+Dq34R3NBuTVWNV+H3lBmNUDkLZEVJct7ILHQaXfeYnruW9qNWvs73ExifjJ7TV2IAc3g/KrBFxVQ3t6OB4R9nEqoSenPQ2KPIWA1pPlbh+TdXlDe6z0lo8d7FPUntyhM0orwObsrpu3aHd6oh0nv2zSDSJD4OIFyrLadmBwjzEvuYbc9oIm/z+aCeggIfXq8j5QXhfiuLO+LfTIVhvyv/Ox120Y8vGdzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Oy1dR0aG8YGDdnOFrIOVj6WElHxZlH/iIKD9NQQQI=;
 b=lXjFjmdsvksJuRCvEi560UalC4c8To+CsDhkR9v74A5/b50WiBVKfKgrRmGWODpiFByhSx5X6whw+VUPdUm5PgFSqHTDOy0fzdQwd0kUo46+lYhR8kcUZvik0VgjbqrEri6HyLpbwoq8evdY5cXxAA/jy6kJj2X7Xqr2hLMsDIlUba/f3dR0b+YVF4ij5xWsgA/hGlu8zm6yF4R5PLsCHYabK3PtVUyRJX6uA5yNGf55L28xkZn/s4llFC6ouUsii+1vdcJWlKYdQLQkN52CNRftvcxk8x5aB1NZZTx/bvqQ5icc2w6rOn4AU+rG/gddcl5nbiNdNTg7tYBUVcOGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Oy1dR0aG8YGDdnOFrIOVj6WElHxZlH/iIKD9NQQQI=;
 b=neCIwgLr7uhD7wGkRGj4B+V2CNkn2S/copGrO2MbmDm0T4rNRHdpJ/qC9QVNDvQuUpx6qqMmNNSDrGlP9bemwvo1QhK5KQvJ0WvmqTRMXsorCSCVYjugH79hqmLAJvKz9z0WFK2w6w4e7ccM0j+3KeD8pN/bfkqw0r+jaHAQuYg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4099.eurprd04.prod.outlook.com (52.134.93.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 10:23:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:23:27 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH RESEND v3 4/4] clk: imx: imx8mp: fix a53 cpu clock
Date:   Wed, 19 Feb 2020 18:17:09 +0800
Message-Id: <1582107429-21123-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
References: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0014.apcprd04.prod.outlook.com (2603:1096:203:d0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 10:23:22 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac9e80ff-57c6-415f-c4ac-08d7b525c215
X-MS-TrafficTypeDiagnostic: AM0PR04MB4099:|AM0PR04MB4099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB40999926E2B0A2866AFDA15C88100@AM0PR04MB4099.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(189003)(5660300002)(2616005)(956004)(66946007)(6666004)(52116002)(26005)(6506007)(16526019)(186003)(66556008)(66476007)(69590400006)(316002)(6512007)(8936002)(81166006)(81156014)(2906002)(8676002)(4326008)(6486002)(36756003)(86362001)(9686003)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4099;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORkldbyN//IaZ1W4U4z8Edn7GJCFCPMA3mVaUbyu6I95ok+5NXDDpFcu65XF53TLJ7+B6u2VLQqm+iHQmUqOpSetLnVzhc0FxDn/N0KN/xKRKOkEHlDQPahnipsLP9wpGE5nLmxhQNL7fbDM0n9cLTVktiZN7w3gg+CUSzl4GSFIXjG8ndSfC66SSU8xLfnkAbiUfQivNkyshNmU6wGZ6zMbQFUiFKeHbp2CTFaaPIedLHE+x7r2M3dkLEbB/5dW4SFVYOjplikhGt+/AuCC8QrC2S2S2xXaHMLTEwjbhaGPF6DflJ8UPi7u4khuFuQ9pfKiPeUISGBpFyxoP9T2XPvW5tNRQqgUj2LK0B2E00dz07D5wMPfSZ9WfrdHjz1qQsQb2lRuXwrjTd0j9jMV3wcVsZtzG6wVf8XcfAnuzxkyohc5pP+3a+FpIDfWQrfMg43w4pnvn31Yx6o2utBZbbYlspM/SjI0IIZM6XX5KUMO4aPbhA0v+b1GBrzTTA3p1rLjBPdjaFtjIPvhk7//NyiVsMUwIDimgbyGG3qkn2sMbngxaezKeRaEyPuxm2Fp
X-MS-Exchange-AntiSpam-MessageData: Vs9vlzLMpPyM+ToExa5Il+G4W5tVCXQef5/RBc6nRh+PrvpRBTVgou+4MobYh3pP8KsjEfSHwIR5Vvv0JV39DNBPzF/yA4wc7Wy4LCqKaOvX51WMfl8I7P7JngwoHfGrjDnoax2XDQ72JYb51wYG/g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9e80ff-57c6-415f-c4ac-08d7b525c215
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 10:23:27.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zir+Mbtt/Uz3vFj/Q5A7vpK7ZYszUq68/ZyxreQe+kn4rUYIYd3tOnUvsEB9zzyytxOZxrWnOc5vjdI1NK/8Q==
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

