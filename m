Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED10C33CAD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5532187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oWUZ0yx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgANH1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:27:38 -0500
Received: from mail-eopbgr20048.outbound.protection.outlook.com ([40.107.2.48]:38189
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728877AbgANH1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:27:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkQJEKBOf60BxppePpUtPzMDhzD8/HBmeAveVwpgBXeiKLwMzvMoT3gMgQo0bJVp9bmxkzj0JceJ7xp+igUKJiRZmPWTVShMQac9V6PdtOLb2pShIvE6eHA9nrytIKAl+u/1RJnO+2Duobbt5pNmbBrmgT9L7hJYOxWjWFjxxyi8D/Z6zL8mGGkaL6VSt6kRnCc36RKDWQzyFqXlVPezMUeaxEouAP3WbseHQPqNiVDKOjm6Lxx3zDEAHbtQqTkxR7nFSabHPdtzWf2bl8xI16m3C9Gs/gLrh4RHQNX9NqFsrL2L33g8wzGZIJMBsG7x5bOZDersWR4971EqhZzfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjg/P8ZE54mEmXQrCAZ3IcfFh6AgOTtACWGF/NSzCBg=;
 b=lSBIBafpoqmqBy5e+h8Dd+uResb5h0GZniuNp6sRLMsxB2GfM2U531YGppBkReWrLP3K4JptB8HeRmz/HCrrt2sj22wMtX4wNED5J5+ex13lotBiQ0uCpbVGrMbuHmY02ktefg9LAOWaETc7d3U8rP47nhZihT840TMmhZW0Ss0+0bL7ksVQCfXQVZrDVwBZjxgvbA2sxTxep/J4KcRO+/4r6uj2a9UqEeV3XL6EGALZrFI8Wd7qf9FaheY2Il0RxR7OhAtSwuGzNZo/eXk4PATSUZuf9NX8t3QaqcuOi57sf1je9RcisPEA1/+XRRYL6N+0wlVBYLsBn5Uw5zkEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjg/P8ZE54mEmXQrCAZ3IcfFh6AgOTtACWGF/NSzCBg=;
 b=oWUZ0yx/ehYGBr5zLt/zI1gSAIuXlrLCIjCk/0+/Qxy1D1WEIyv6rZe/HyROXAlAPy+CsOfdXkQC7pKKXCRS/+0UNb6RMTYbgt1enYijK515TmVQvsBf8hc+AZ/SFrKZmysBap4dRJCo8jy18JtgYe6Vn61utV5XSAhW3JTz7a8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6211.eurprd04.prod.outlook.com (20.179.34.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 14 Jan 2020 07:27:33 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 07:27:33 +0000
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 07:27:27 +0000
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
Subject: [PATCH V2 4/4] clk: imx: imx8mp: fix a53 cpu clock
Thread-Topic: [PATCH V2 4/4] clk: imx: imx8mp: fix a53 cpu clock
Thread-Index: AQHVyqwVgLXhQDIHI0mgOwyl4endfg==
Date:   Tue, 14 Jan 2020 07:27:32 +0000
Message-ID: <1578986576-6168-5-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 4087361c-97ac-4e23-5005-08d798c33813
x-ms-traffictypediagnostic: AM0PR04MB6211:|AM0PR04MB6211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6211FEBBE9B5C4493D409CD588340@AM0PR04MB6211.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(64756008)(66446008)(6512007)(26005)(66946007)(6486002)(956004)(2616005)(66556008)(52116002)(66476007)(6506007)(86362001)(110136005)(316002)(54906003)(2906002)(36756003)(44832011)(5660300002)(4326008)(6666004)(478600001)(6636002)(186003)(16526019)(8676002)(81156014)(71200400001)(8936002)(69590400006)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6211;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XDpLXpM4hTxecuYDsrNdgTeMaEMg82KjuMD83wt8fEuMekRzWtTwWTEVAAi+0gmdU9kz5WHqWS7PsnQAjm8YTCQrqZzhwM7NTWjtViPz6DNehxs7KtMO4Vv2PCMARdTXxN6twxIC82/a10dVVNByP4qlbo4JsE1abvd3gVCvH43XDVKOuqX+117xYt0KvUwHrplQY5K2oewjCDMssucWR8jPe23CSi7wrQs01+wVWfJUxy54G/crOUKU3UKOZAsoNLMudn5ifDExM43o9jCX1BUmJxQB5ErwvOMImWYEncVd02hEs2EeKXN0DxzKDB+7Y1n4XWbancufDuz7cZ5Sh7yX1o/XcG77dijPfEzRHB6HknvyXGRT1Ejkf2rR+eZSMlYyKTlGXiIbPeTLYD3+EuhkuGdkgooO2wIOsWWoTRP2QVfbvwfphj2pMIpE7bum6sfeeAemEfiIBriAaGYGqBMmnEP86n19Nu6wKlWVENXEh1Daq08/9xLpYYsksAO1u1QrTmJemGaxU3lQBWxnuw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4087361c-97ac-4e23-5005-08d798c33813
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 07:27:33.0284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uY0LVuvijDwofxcY/4f1gWjVQq8Oc93gK95xyr0Kgb+iqohsssfm521OdonDhDjcpNgdWg0L5w7GV7GAIMSVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6211
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

V2:
 Fix build

 drivers/clk/imx/clk-imx8mp.c             | 16 ++++++++++++----
 include/dt-bindings/clock/imx8mp-clock.h |  3 ++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index f6c120cca0d4..6ac4746898cb 100644
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
+	hws[IMX8MP_CLK_A53_CORE] =3D imx_clk_hw_mux2_flags("arm_a53_core", ccm_ba=
se + 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels),=
 CLK_IS_CRITICAL);
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
+	clk_hw_set_parent(hws[IMX8MP_CLK_A53_SRC], hws[IMX8MP_SYS_PLL1_800M]);
+	clk_hw_set_parent(hws[IMX8MP_CLK_A53_CORE], hws[IMX8MP_ARM_PLL_OUT]);
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

