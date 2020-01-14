Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70512C33CAE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AA62084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YIQ1uJSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgANH10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:27:26 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:35238
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728877AbgANH1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:27:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8ySUvudvXwcIDO6UPC7vY9AGhAydOxAEuBbNzkennfDgK/Yhb5pDdvoS3YNi/8UHcOWvgNoaR3ft1bYeVyEFBeIS3CPABO8rLLpSG3gJKnqLrD0OO0YRNRw9prj9juiZifLt/UC+TrM/SX0L1h/Fjmdd0k6Ecdtpd4Lcxy6Et1QdOE3RqDMZZ2B5sqrRs2oii1997PBhOCTQau2bg6v13AwSNdT9MAWHtRcjwS4UYN8+Ma0hICYxbXct/h1xyf/+zZ98jronnzfaO/F0Wi05Vo3Gyx38gfZmKVNllyzEYhtyGc7wrwZPQq4+ttr6+dG5xhlWKnNwASXKcfswV5BeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A20Xl+PTW4KlQYSpQ5Kx0Mu9QL0bg+HUF+jbGVQYkk0=;
 b=ig92TyuGiaReh68mVt0h+EcSTNzBXuiTNBH9TWIM6fx449IR5HmgCU/Yai/OuyUkXVo3iluMsGyOIc9CiKoZkxNyJizAIujNi9pkZLcVbe7py673GnEzggSCS2Z7YnhXTeJMnBiBU2jdujiYUAH2T7ihzu+NrYZJwZM8VcVag9qLTfWcvL0xnr/dCqvIhEhJvU8sK1LgWHpuDu43Bk1PV/2mw+cFqj4iUHjYLn+ZbZ3JNZ6b7zpoBuZQ9CLI1NEdwmMP4C9MEK9yojVHjAlYDEGSGIVhTuPRUuALpoovL/IRfFu8DzSqfWbq/g2QWp4YdgByOe7VpZSfZJJdYukvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A20Xl+PTW4KlQYSpQ5Kx0Mu9QL0bg+HUF+jbGVQYkk0=;
 b=YIQ1uJSV6duD0xMzbjtZYCjLXU+Je4DH38vTyd8KjE79av/MWRcohA2aIF2OyiqwGSRZNhggpd9kQ+e2hI6ReBQV0liqG2HW0YZ9XHICrSExobttbAt3l0zqBdvsbSF7L2N4QqkvQjJ1typ86hmXoXFXj3YGnR4yLAlkT+vtUj8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5490.eurprd04.prod.outlook.com (20.178.115.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 07:27:21 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 07:27:21 +0000
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 07:27:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] clk: imx: imx8mm: fix a53 cpu clock
Thread-Topic: [PATCH V2 2/4] clk: imx: imx8mm: fix a53 cpu clock
Thread-Index: AQHVyqwOq4fuxmFDc0W4slntRANDBQ==
Date:   Tue, 14 Jan 2020 07:27:21 +0000
Message-ID: <1578986576-6168-3-git-send-email-peng.fan@nxp.com>
References: <1578986576-6168-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1578986576-6168-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0149c7a8-b3af-4115-8a57-08d798c33146
x-ms-traffictypediagnostic: AM0PR04MB5490:|AM0PR04MB5490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB549077731E7A3496AE9677E888340@AM0PR04MB5490.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(66476007)(478600001)(66946007)(2906002)(66446008)(66556008)(6506007)(64756008)(52116002)(186003)(2616005)(26005)(44832011)(16526019)(8936002)(71200400001)(69590400006)(956004)(81166006)(8676002)(36756003)(81156014)(86362001)(6666004)(5660300002)(4326008)(6486002)(6636002)(110136005)(6512007)(316002)(54906003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5490;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLoF/zVohCBARVE4ISiqSsXyei9lZaft3Wu9jOuwmApMvPMpCdS1PqZlJ+RHSG4CxhBRiaXpGLZzk44VV/eg6ho1Rm/b4QPSf/t9nqQ98eWC0PRNAOQIUNxkoix21y3veUziTYxAPTl71dOtdYvAgheaW3fVB+VEvvbQ/s7+wzTgZU3nG1nHkVuvUB6ivexgOicwYyJmD9Rjmnx0YCQfb1Culatu4gF2cQiD8f9tS7ITxXZydwfbL+Wj34Q2+VAQbwPXC+pKwjhHWAGBTNMI6xdOM1nMIkNsXwXkpGfvC+Obv1LyLn2FVI9SOerfhUAU4vIwMN8426WaXW5pCSiZusrpVq1UpTQueyWUAsc7B0gdgI+NytVvYCNopHCViFqLrWYl/2pUJT1LcxD4/Bi13w5cMINY5A6sTF7HdIF1jgy3Ff0crROAISZGEOv5WpF01x0/C96GQsdjMy5wQoMd9wSCuH/VrICBv1ZQOmwO+OmV//cBM46CQcXO1Lwqn7py/B8Nx/FALrFB4gr3FCbNbw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0149c7a8-b3af-4115-8a57-08d798c33146
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 07:27:21.1923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UsT9DTYxOqZ/xWIZm+wUtEFoKGyW96W7TIahE/oK4lEFsddB+cchqCAlnDXBLvLTpEQJ5ohl9IOf1P9kQvmFjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5490
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

V2:
 None

 drivers/clk/imx/clk-imx8mm.c             | 16 ++++++++++++----
 include/dt-bindings/clock/imx8mm-clock.h |  4 +++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 197ba2cdab7d..ad7a77e3276c 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -41,6 +41,8 @@ static const char *sys_pll3_bypass_sels[] =3D {"sys_pll3"=
, "sys_pll3_ref_sel", };
 static const char *imx8mm_a53_sels[] =3D {"osc_24m", "arm_pll_out", "sys_p=
ll2_500m", "sys_pll2_1000m",
 					"sys_pll1_800m", "sys_pll1_400m", "audio_pll1_out", "sys_pll3_out", }=
;
=20
+static const char * const imx8mm_a53_core_sels[] =3D {"arm_a53_div", "arm_=
pll_out", };
+
 static const char *imx8mm_m4_sels[] =3D {"osc_24m", "sys_pll2_200m", "sys_=
pll2_250m", "sys_pll1_266m",
 				       "sys_pll1_800m", "audio_pll1_out", "video_pll1_out", "sys_pll3_=
out", };
=20
@@ -422,6 +424,9 @@ static int imx8mm_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MM_CLK_GPU3D_DIV] =3D imx8m_clk_hw_composite_core("gpu3d_div", im=
x8mm_gpu3d_sels, base + 0x8180);
 	hws[IMX8MM_CLK_GPU2D_DIV] =3D imx8m_clk_hw_composite_core("gpu2d_div", im=
x8mm_gpu2d_sels, base + 0x8200);
=20
+	/* CORE SEL */
+	hws[IMX8MM_CLK_A53_CORE] =3D imx_clk_hw_mux2_flags("arm_a53_core", base +=
 0x9880, 24, 1, imx8mm_a53_core_sels, ARRAY_SIZE(imx8mm_a53_core_sels), CLK=
_IS_CRITICAL);
+
 	/* BUS */
 	hws[IMX8MM_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
 imx8mm_main_axi_sels, base + 0x8800);
 	hws[IMX8MM_CLK_ENET_AXI] =3D imx8m_clk_hw_composite("enet_axi", imx8mm_en=
et_axi_sels, base + 0x8880);
@@ -587,11 +592,14 @@ static int imx8mm_clocks_probe(struct platform_device=
 *pdev)
 	hws[IMX8MM_CLK_DRAM_ALT_ROOT] =3D imx_clk_hw_fixed_factor("dram_alt_root"=
, "dram_alt", 1, 4);
 	hws[IMX8MM_CLK_DRAM_CORE] =3D imx_clk_hw_mux2_flags("dram_core_clk", base=
 + 0x9800, 24, 1, imx8mm_dram_core_sels, ARRAY_SIZE(imx8mm_dram_core_sels),=
 CLK_IS_CRITICAL);
=20
-	hws[IMX8MM_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_div",
-					   hws[IMX8MM_CLK_A53_DIV]->clk,
-					   hws[IMX8MM_CLK_A53_SRC]->clk,
+	clk_hw_set_parent(hws[IMX8MM_CLK_A53_SRC], hws[IMX8MM_SYS_PLL1_800M]);
+	clk_hw_set_parent(hws[IMX8MM_CLK_A53_CORE], hws[IMX8MM_ARM_PLL_OUT]);
+
+	hws[IMX8MM_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_core",
+					   hws[IMX8MM_CLK_A53_CORE]->clk,
+					   hws[IMX8MM_CLK_A53_CORE]->clk,
 					   hws[IMX8MM_ARM_PLL_OUT]->clk,
-					   hws[IMX8MM_SYS_PLL1_800M]->clk);
+					   hws[IMX8MM_CLK_A53_DIV]->clk);
=20
 	imx_check_clk_hws(hws, IMX8MM_CLK_END);
=20
diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings=
/clock/imx8mm-clock.h
index edeece2289f0..8b585a910ddb 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -265,6 +265,8 @@
 #define IMX8MM_SYS_PLL2_333M_CG			244
 #define IMX8MM_SYS_PLL2_500M_CG			245
=20
-#define IMX8MM_CLK_END				246
+#define IMX8MM_CLK_A53_CORE			246
+
+#define IMX8MM_CLK_END				247
=20
 #endif
--=20
2.16.4

