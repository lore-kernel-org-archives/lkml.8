Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014FCC33CAE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35B2217BA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W5SKmtR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgANDSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 22:18:13 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:12766
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729668AbgANDSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 22:18:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT4cHfcPb41nh65Ghk1dVgQBI2hVcsCXEe4KI5/rMYIjZt8RvTsRzNdl/VYdVesnvF/+2ajj3QOF/8QbhVRXtiAUJmnwEimiN6uHCu4G4lCIQX1K8JNwlKcImTJiU+8QkLzZ5y3/4O5JhpHYrGRdCM38bpNmoxRT49mO/3Wlh1Cn0VNsx7iwfDKl38cegeOCkQr84AnciBb93JO3I0sCedYKgOsOXA/90A5HdG4mIjFAFkTONmXYeD5JdR17O0kbt4kmcXgKRupJVrR/6Vlhw9C0HOzvWdv86Xuo4HAKSIeIqgPhv7W8rKLwT+JPXoFzb+Y3V5Y9GXXvPQJDRpZu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGJGx+bmaGvG1Urcf+/E89Cw7MIFdmWGSxHNkDBuCs4=;
 b=JP9we2CykDzoN8Swz8CazCMGgMaDiIpXgpjk8CUkSsO6EbC6xHA3UjVK4AwI9Pb6XT02RMrhakTd6VJ5qFUui+G1hVUdya1o0rylKenKLjlxN0RHBMOoL2pt/LtXkEuwfh8hCZYRF3xtp3yYnqMFceoi6GrbSE76O9LrIGQPyBvD+Yg9W96isLmn4wct5T+RlbMa208Xf2jL1IDzrqEaeaO6GomTdNKaV2LjWhYzhLiPYKSqONM4EjDbNUJ2wxUgPe/7Dc282eLmy/tmj+LZ8ZHncRv3juJP4l9H9t+oskIs93D+U337dLqeXx6bf1SX+sNfb8IbLi8GBGcznirkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGJGx+bmaGvG1Urcf+/E89Cw7MIFdmWGSxHNkDBuCs4=;
 b=W5SKmtR5XsVZiy1ly1jSuEMn6m5WHlYPGnUzfZtq4ORYUc4mBCwNSnEIbjFuDVv7mELYObUM9EfKkZjcuSDXe6x72GCLl2iJ6G3ttn4jFIHbQr7VWf0TQXKuwC13bVTXzJCTZMs7eS987Ean8wi9ymKdtLuMzv/c7P9Xb8QGqcs=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 03:18:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 03:18:07 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0002.apcprd03.prod.outlook.com (2603:1096:202::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Tue, 14 Jan 2020 03:18:02 +0000
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
Subject: [PATCH 4/4] clk: imx: imx8mp: fix a53 cpu clock
Thread-Topic: [PATCH 4/4] clk: imx: imx8mp: fix a53 cpu clock
Thread-Index: AQHVyok9IoaFwrOhrEqVCCN442+qiA==
Date:   Tue, 14 Jan 2020 03:18:07 +0000
Message-ID: <1578971599-4277-5-git-send-email-peng.fan@nxp.com>
References: <1578971599-4277-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1578971599-4277-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b76f586-45dd-47c4-1ed5-08d798a06005
x-ms-traffictypediagnostic: AM0PR04MB4402:|AM0PR04MB4402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4402896662E2CE36BB0DA89B88340@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(54906003)(316002)(6512007)(5660300002)(36756003)(86362001)(26005)(8676002)(956004)(71200400001)(110136005)(2616005)(44832011)(2906002)(69590400006)(186003)(4326008)(52116002)(6486002)(16526019)(81166006)(81156014)(8936002)(66476007)(66446008)(478600001)(6506007)(64756008)(6636002)(66556008)(66946007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1oiiEx4ZE0C60d2XVURyXMLquF4wCtdhcgGM7GdeTrvVUJEnDIawvNSlKhsvg/PKEozbNutlY2TyX81Vr7F7twfZMusx/aly6ZWTnkrg75MOeL3TomgtQJFxq+goyqCCEw3LmYgENUPEfwVAMc0I3tNgWqQKq8P+uy7xwRMIK6kCav4b3mYmavY11nnIzoMAp6lJVcrc946IB8osXjj0Klc9FLxF+TMu4X4XtFi77VmRHvVuN1X4FrjCCp/bw8ST14Vjw2mXjgbKGy5eMeGIYgxnOq/YxP1vIoOCg+KVI6U69UALNyZIrV9pjKOlEEJakeoeefvYUbpTB0hB8MKZ1xq7TpUJRzD36HQXIDrM7wWuisfi9QSYVB9Q7aLHAPa/O3mdAu3c9PpPG5OHkgaBeMaZEUkreQGCwFBQIPc/FAY59IeA3FPlhYLZue2Ag1JJPVL8OSs5sl2S7Uh7hMb7EWf36uApM1UiaQGA8JDxirm5NqcVMPU9RpCInLaHG72klzBIvxNxAqSS7yAs34tEOQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b76f586-45dd-47c4-1ed5-08d798a06005
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 03:18:07.1940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQabR/ShQja2PVMRw/hagyBD9lheEiBYpBSt0wczbPqNoWizP58Tw5oFuMy+Y4yt7shvJaMTfQyasX6LX61Xzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
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
index f6c120cca0d4..8a73aef845bb 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -34,6 +34,8 @@ static const char * const imx8mp_a53_sels[] =3D {"osc_24m=
", "arm_pll_out", "sys_pl
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
=20
+static const char * const imx8mp_a53_core_sels[] =3D {"arm_a53_div", "arm_=
pll_out", };
+
 static const char * const imx8mp_m7_sels[] =3D {"osc_24m", "sys_pll2_200m"=
, "sys_pll2_250m",
 					      "vpu_pll_out", "sys_pll1_800m", "audio_pll1_out",
 					      "video_pll1_out", "sys_pll3_out", };
@@ -553,6 +555,9 @@ static int imx8mp_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MP_CLK_HSIO_AXI_DIV] =3D imx_clk_hw_divider2("hsio_axi_div", "hsi=
o_axi_cg", ccm_base + 0x8380, 0, 3);
 	hws[IMX8MP_CLK_MEDIA_ISP_DIV] =3D imx_clk_hw_divider2("media_isp_div", "m=
edia_isp_cg", ccm_base + 0x8400, 0, 3);
=20
+	/* CORE SEL */
+	hws[IMX8MP_CLK_A53_CORE] =3D imx_clk_hw_mux2_flags("arm_a53_core", base +=
 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels), CLK=
_IS_CRITICAL);
+
 	hws[IMX8MP_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
imx8mp_main_axi_sels, ccm_base + 0x8800);
 	hws[IMX8MP_CLK_ENET_AXI] =3D imx8m_clk_hw_composite("enet_axi", imx8mp_en=
et_axi_sels, ccm_base + 0x8880);
 	hws[IMX8MP_CLK_NAND_USDHC_BUS] =3D imx8m_clk_hw_composite_critical("nand_=
usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
@@ -722,11 +727,14 @@ static int imx8mp_clocks_probe(struct platform_device=
 *pdev)
 	hws[IMX8MP_CLK_VPU_ROOT] =3D imx_clk_hw_gate4("vpu_root_clk", "vpu_bus", =
ccm_base + 0x4630, 0);
 	hws[IMX8MP_CLK_AUDIO_ROOT] =3D imx_clk_hw_gate4("audio_root_clk", "ipg_ro=
ot", ccm_base + 0x4650, 0);
=20
-	hws[IMX8MP_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_div",
-					     hws[IMX8MP_CLK_A53_DIV]->clk,
-					     hws[IMX8MP_CLK_A53_SRC]->clk,
+	clk_hw_set_parent(hws[IMX8MP_CLK_A53_SRC], clks[IMX8MP_SYS_PLL1_800M]);
+	clk_hw_set_parent(hws[IMX8MP_CLK_A53_CORE], clks[IMX8MP_ARM_PLL_OUT]);
+
+	hws[IMX8MP_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_core",
+					     hws[IMX8MP_CLK_A53_CORE]->clk,
+					     hws[IMX8MP_CLK_A53_CORE]->clk,
 					     hws[IMX8MP_ARM_PLL_OUT]->clk,
-					     hws[IMX8MP_SYS_PLL1_800M]->clk);
+					     hws[IMX8MP_CLK_A53_DIV]->clk);
=20
 	imx_check_clk_hws(hws, IMX8MP_CLK_END);
=20
diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings=
/clock/imx8mp-clock.h
index 2fab63186bca..c92d1f4117eb 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -294,7 +294,8 @@
 #define IMX8MP_CLK_DRAM_ALT_ROOT		285
 #define IMX8MP_CLK_DRAM_CORE			286
 #define IMX8MP_CLK_ARM				287
+#define IMX8MP_CLK_A53_CORE			288
=20
-#define IMX8MP_CLK_END				288
+#define IMX8MP_CLK_END				289
=20
 #endif
--=20
2.16.4

