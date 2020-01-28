Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B9C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8B52173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MwBto7jV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgA1F2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:28:55 -0500
Received: from mail-am6eur05on2056.outbound.protection.outlook.com ([40.107.22.56]:6070
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbgA1F2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 00:28:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3NxCU/RxLvqZT6LU4YLjvy7gTFM+LZFpdAguZzbzxX4t/iG9SJxKo5BkRGRYCIhWDL/ypsHNOoRjHXEwDqAP7/NYIF51x9vOfrKGagLSRLDTvPcV824zCOl534zyRKTdRrZ2+xyUOpQuE5X/+3yKpip6FPkuahY5dxiAXss1z2YL05wgg3hXExIqKiirDz5rjQS2LdUNw0m9Rdeb0jJiFdmcsGUnkQ0Zt1pcDHAh5e9A/g/zP1Vgnx1xT5+PdCZfz0PJgzBJnRK8kRLB0Nrwq9lEMwkfUIHMdep+UuSYs+34cyw6fErWA+LfsSekaUuRuBmoaJMNq4ihR8P5PQoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aluJRYr7+ESBukTl+gMtMBFWXCBmGgbPL1P+N5fQws=;
 b=B2yjThC006Qzscl4wHDFjUZvWOGvXODuit6L81kNghbRihSfqbNZKBecldK1QosbXC5VOOd1cBfkrl3N2+WJEHtyRS8j00uHvjZDmhhpxG0N4gHOx0HPDaiB9MkVAWUq2lJMpjRB9Rm5914K9RnTMIHWJY2aNOzeMWzbnp84Ha0rYPgfeFqL3dMTJsElz8MqKAbT7lpseXpx3XG/uPbOrO6kVhHWMOcxfiLVVkBu6vSsCpSCFPPlXw8mxgHpZ33+4s7hVh3uPpD5YqFhjZp2ekbqJeA92fe/AB5Vsaz+pSxO5evfd+pMNLtxy15Wy8w2f9+lF0oIlAiCJmHmTWRe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aluJRYr7+ESBukTl+gMtMBFWXCBmGgbPL1P+N5fQws=;
 b=MwBto7jVexEQmknf/RUtGR3xfqmpkovl4vJD9s0g1t3F/sj1Y/7sJULW2uf+7j9CFj5G0LwJN3K/utgXtwOiV4YS9iBTPsM95rc/fkLBdWbw/T+d1uxE247Ita2fYXi4oPxI07Y0EKOuoxhhiqX3HFaMgG4VSKGrQRVTAPCt/SI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5939.eurprd04.prod.outlook.com (20.178.112.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Tue, 28 Jan 2020 05:28:50 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 05:28:50 +0000
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0113.apcprd03.prod.outlook.com (2603:1096:203:b0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.22 via Frontend Transport; Tue, 28 Jan 2020 05:28:46 +0000
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
Subject: [PATCH V4 4/4] clk: imx: imx8mn: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V4 4/4] clk: imx: imx8mn: use imx8m_clk_hw_composite_core
Thread-Index: AQHV1ZvSbRtVno6oAk6bZpxHDhFKdg==
Date:   Tue, 28 Jan 2020 05:28:50 +0000
Message-ID: <1580189015-5744-5-git-send-email-peng.fan@nxp.com>
References: <1580189015-5744-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1580189015-5744-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:203:b0::29) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10d818be-f5f0-44b0-7b77-08d7a3b2f509
x-ms-traffictypediagnostic: AM0PR04MB5939:|AM0PR04MB5939:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB59396CB0E53CCB3B17AC06E8880A0@AM0PR04MB5939.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(189003)(199004)(2616005)(956004)(6666004)(110136005)(54906003)(44832011)(5660300002)(316002)(186003)(16526019)(71200400001)(69590400006)(26005)(478600001)(81156014)(81166006)(6486002)(52116002)(6506007)(6636002)(2906002)(8676002)(4326008)(8936002)(6512007)(86362001)(66946007)(36756003)(66476007)(66556008)(66446008)(64756008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5939;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9F+Yy/Krm2IMh+9OxhWcdEJeKWca4k1fsUkqfx/AsFrKWwWAsVD5JOVWtzsku0cb4Gic+ANYoe7N0jrHdBcelztloubVDzBu5YQvAzsUaTUcohCNK0kv6vBUtZkWFuMH4NI7mlXlzGcEuxgI4XSCoSUOnPfyXGnbpUaxux4lZbrbf+pwdmernrgV3mSxGpWiIULJz4/EGspBvRQR4u/Q3YbpMMb1rx/WL5QOdtWJXIP221TFQrScvJBT5hxy+ghvzIOaeQ14yWxP1hThQydjmfS1umIHTPpzNElF3h2BgR6NSnGupNiskRhUJu+1ghhfU4ErygwY6dQ8HuoF9S8EU5DLSR5jJ0XZpeA3Ri7P+BSktFsbw1D1T85Znm0D/OGBkAcL/Wp/gWX/7kzM1yyznGWWbgYDH3KMKLxrJ6MNTZzFfUatQ9snOEG12raS0Tbj8LtPZoOTv2mGSL7TORfDLudUU5sgiSSRcZrF/gbcGlmpRSBjJTtogWKpnk8vpMplfZTNS8/GbeJwHz/pRgRSQseWy5GhA+Bdq6VTFZLX8g44Zr+iZ+qodMENTC+Q+EZ
x-ms-exchange-antispam-messagedata: VRLr3z8ybOFTotqW4WnaHw/AFSb4ped4+l4jD4n0upAeC/f3YMPX8JUzOjXSusbmOiIo0MGFN43P+FwOI/UrxYN6V3hSUM8FtaF1+MvyQv7VBm0wIpmQtB2mAi24FobMPwZOsJFSeElsuKzLl9G/5Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d818be-f5f0-44b0-7b77-08d7a3b2f509
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 05:28:50.8302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOcCT5SY36494rAT+6ns/A9lYri0TABCszG9l2m8f0/OKgDwccptaTaoyxtnYl5KOeY3jz/9H/7OO1eYJpktGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use imx8m_clk_hw_composite_core to simplify code.

Add new definitions, and X_SRC/CG/DIV will be alias to the new
definitions for backwards compatibility

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c             | 19 +++++++++++--------
 include/dt-bindings/clock/imx8mn-clock.h |  5 ++++-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index c5e7316b4c66..e892302f93aa 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -413,15 +413,18 @@ static int imx8mn_clocks_probe(struct platform_device=
 *pdev)
=20
 	/* CORE */
 	hws[IMX8MN_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src", base + 0x8000,=
 24, 3, imx8mn_a53_sels, ARRAY_SIZE(imx8mn_a53_sels));
-	hws[IMX8MN_CLK_GPU_CORE_SRC] =3D imx_clk_hw_mux2("gpu_core_src", base + 0=
x8180, 24, 3,  imx8mn_gpu_core_sels, ARRAY_SIZE(imx8mn_gpu_core_sels));
-	hws[IMX8MN_CLK_GPU_SHADER_SRC] =3D imx_clk_hw_mux2("gpu_shader_src", base=
 + 0x8200, 24, 3, imx8mn_gpu_shader_sels,  ARRAY_SIZE(imx8mn_gpu_shader_sel=
s));
 	hws[IMX8MN_CLK_A53_CG] =3D imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src", =
base + 0x8000, 28);
-	hws[IMX8MN_CLK_GPU_CORE_CG] =3D imx_clk_hw_gate3("gpu_core_cg", "gpu_core=
_src", base + 0x8180, 28);
-	hws[IMX8MN_CLK_GPU_SHADER_CG] =3D imx_clk_hw_gate3("gpu_shader_cg", "gpu_=
shader_src", base + 0x8200, 28);
-
 	hws[IMX8MN_CLK_A53_DIV] =3D imx_clk_hw_divider2("arm_a53_div", "arm_a53_c=
g", base + 0x8000, 0, 3);
-	hws[IMX8MN_CLK_GPU_CORE_DIV] =3D imx_clk_hw_divider2("gpu_core_div", "gpu=
_core_cg", base + 0x8180, 0, 3);
-	hws[IMX8MN_CLK_GPU_SHADER_DIV] =3D imx_clk_hw_divider2("gpu_shader_div", =
"gpu_shader_cg", base + 0x8200, 0, 3);
+
+	hws[IMX8MN_CLK_GPU_CORE] =3D imx8m_clk_hw_composite_core("gpu_core", imx8=
mn_gpu_core_sels, base + 0x8180);
+	hws[IMX8MN_CLK_GPU_SHADER] =3D imx8m_clk_hw_composite_core("gpu_shader", =
imx8mn_gpu_shader_sels, base + 0x8200);
+
+	hws[IMX8MN_CLK_GPU_CORE_SRC] =3D hws[IMX8MN_CLK_GPU_CORE];
+	hws[IMX8MN_CLK_GPU_CORE_CG] =3D hws[IMX8MN_CLK_GPU_CORE];
+	hws[IMX8MN_CLK_GPU_CORE_DIV] =3D hws[IMX8MN_CLK_GPU_CORE];
+	hws[IMX8MN_CLK_GPU_SHADER_SRC] =3D hws[IMX8MN_CLK_GPU_SHADER];
+	hws[IMX8MN_CLK_GPU_SHADER_CG] =3D hws[IMX8MN_CLK_GPU_SHADER];
+	hws[IMX8MN_CLK_GPU_SHADER_DIV] =3D hws[IMX8MN_CLK_GPU_SHADER];
=20
 	/* BUS */
 	hws[IMX8MN_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
imx8mn_main_axi_sels, base + 0x8800);
@@ -528,7 +531,7 @@ static int imx8mn_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MN_CLK_UART3_ROOT] =3D imx_clk_hw_gate4("uart3_root_clk", "uart3"=
, base + 0x44b0, 0);
 	hws[IMX8MN_CLK_UART4_ROOT] =3D imx_clk_hw_gate4("uart4_root_clk", "uart4"=
, base + 0x44c0, 0);
 	hws[IMX8MN_CLK_USB1_CTRL_ROOT] =3D imx_clk_hw_gate4("usb1_ctrl_root_clk",=
 "usb_bus", base + 0x44d0, 0);
-	hws[IMX8MN_CLK_GPU_CORE_ROOT] =3D imx_clk_hw_gate4("gpu_core_root_clk", "=
gpu_core_div", base + 0x44f0, 0);
+	hws[IMX8MN_CLK_GPU_CORE_ROOT] =3D imx_clk_hw_gate4("gpu_core_root_clk", "=
gpu_core", base + 0x44f0, 0);
 	hws[IMX8MN_CLK_USDHC1_ROOT] =3D imx_clk_hw_gate4("usdhc1_root_clk", "usdh=
c1", base + 0x4510, 0);
 	hws[IMX8MN_CLK_USDHC2_ROOT] =3D imx_clk_hw_gate4("usdhc2_root_clk", "usdh=
c2", base + 0x4520, 0);
 	hws[IMX8MN_CLK_WDOG1_ROOT] =3D imx_clk_hw_gate4("wdog1_root_clk", "wdog",=
 base + 0x4530, 0);
diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings=
/clock/imx8mn-clock.h
index 0f2b8423ce1d..95acfbe52665 100644
--- a/include/dt-bindings/clock/imx8mn-clock.h
+++ b/include/dt-bindings/clock/imx8mn-clock.h
@@ -228,6 +228,9 @@
 #define IMX8MN_SYS_PLL2_333M_CG			209
 #define IMX8MN_SYS_PLL2_500M_CG			210
=20
-#define IMX8MN_CLK_END				211
+#define IMX8MN_CLK_GPU_CORE			211
+#define IMX8MN_CLK_GPU_SHADER			212
+
+#define IMX8MN_CLK_END				213
=20
 #endif
--=20
2.16.4

