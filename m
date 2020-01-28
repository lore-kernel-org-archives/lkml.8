Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2199EC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E305D24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oZrJZ3kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgA1F2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:28:51 -0500
Received: from mail-am6eur05on2063.outbound.protection.outlook.com ([40.107.22.63]:25184
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbgA1F2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 00:28:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp8sfsdITjF9VzqJ+//LO/BOynh9WsoKz08ldFd3FMDJJtkc9XQXvCxW2jIC9XBLxkMnh7+8X1miQHZ7Zldlw41LL6SpayjT/8EsxuMl4xtbg0YutwdjfXs3kxT7F72Wds54HcCfn13mqPJH4srcM/Usx9rTqrbOozW9px27uRDA71pkAvXleBv2NTDBL8t3vtaXvo/elG8SeMGoaP0tJgUSAKvYGJfE1fNi2WhSi5zNm7etNF8ht/NLMsp6rq5skk8AYiJ+L9rZHO5H54SaST0FYbxu/XSyVy7iT7H4YT9Xh5cutiwE0Qax+Ly8RuzY7hfR5JT2ItiDPmO8k6MVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4c5ji5iRY/c/KIM2OC2UeIjiqJnN7GFOjzdDrVqlXw=;
 b=iyMZb4nR4+b74iIlMDNJaOWjNxrQjQj5dFaozqMGHKtRmpWw+Vp/N5VA5AUqwQyej8DWDp3y32zJ0G61h326MVd9CJ/Zm11G7mVkhvCuQrxH/YAjBpB2L6Hi8KtqaOs29ZxGW9GkVGorjQx4HNMmDjSXI/0hh7jUmwImOQRq4oSpnC3oKP+WpitUNaHgWblguZpIzJTCnfwndk34LYhZP5/NVvwaqKSccUyPgUzUC0nVllLh410imOTMaiqa7wuS8FFtIV4jSq3tUImXyjaV6oe2H3VB4XXM2yJUfKwNbrE2t0n+0Bhya5k1tpqjrwZFk96MWR0ENt9QzNVilFj5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4c5ji5iRY/c/KIM2OC2UeIjiqJnN7GFOjzdDrVqlXw=;
 b=oZrJZ3kfmXD3/hr1cqXiJEtO8dFHYjPzFiM79T6c5Md5Hx5XbWkpWgrWHgjt1KJ8F4Khl0yBWIf9yK6UOg0RK6LQ/kzyCc3UpzYAxTjTS5JYIlpULXfrwpcal3aJM56yPjNB7L3rfyRUct9awb8E4Q2RFyxM5xoOMLjrZdpalP0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5939.eurprd04.prod.outlook.com (20.178.112.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Tue, 28 Jan 2020 05:28:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 05:28:46 +0000
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0113.apcprd03.prod.outlook.com (2603:1096:203:b0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.22 via Frontend Transport; Tue, 28 Jan 2020 05:28:41 +0000
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
Subject: [PATCH V4 3/4] clk: imx: imx8mm: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V4 3/4] clk: imx: imx8mm: use imx8m_clk_hw_composite_core
Thread-Index: AQHV1ZvP2+ovD9ZmcECh6GZdFmH9Hg==
Date:   Tue, 28 Jan 2020 05:28:46 +0000
Message-ID: <1580189015-5744-4-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 3d7d86d8-8abd-45db-64d2-08d7a3b2f240
x-ms-traffictypediagnostic: AM0PR04MB5939:|AM0PR04MB5939:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5939F969432365B2230A7009880A0@AM0PR04MB5939.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(189003)(199004)(2616005)(956004)(110136005)(54906003)(44832011)(5660300002)(316002)(186003)(16526019)(71200400001)(69590400006)(26005)(478600001)(81156014)(81166006)(6486002)(52116002)(6506007)(6636002)(2906002)(8676002)(4326008)(8936002)(6512007)(86362001)(66946007)(36756003)(66476007)(66556008)(66446008)(64756008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5939;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NRh52mA7X8tGhkSRH7n4BEcQdA686NIDMqUipEcUce2a3WTtTYeSuJAyuOkTzF85ejzgAPCmXsMe6U6HtVooBAgsuAWbyuBg41zDOJz25yj3UgBQfxUKm5kLd1dXm94yBBgN1Gdspvfievq6Qdr003Pq5TURf9bzZHJRPi7q2yMGKY4EQRMCpJnpLN03GC86IuGT28zpCN8biVdPYSbFIK2tziB47XnrTpQYwcHeWCxSpQaQgJAWuM7jHJ6SW+2XhiVrY7lTyLkz9yRwzmU+sqBQBQ5VWOPEs9vggrUBsbBZ0XyHNkxphH1Zf6XHLNF+/N8+hHvCdbj4Yqafmnhg6ZyqxcR9TX6XTULqzVMpVr5vFPsYTzQVxncOd8vfe2kp4x4DmMcQxz9cdrFzgf9AGGbszw/gOSOMhLC8o2eQiX5Ezd+8DypzMc49OwsgU7kFxG18LWQWZ6JEABLx30cgCb9uSS+dXSt5xkx5F6D9gphXL04Gl8Y9R3fVGpNDF4CYFbxjm2+nRr4x4p9N6rathHxG4ochOrCwcTLPRpLPddRvR4Am4PqoDFPW6Jhcbrn1
x-ms-exchange-antispam-messagedata: Qr6Dq/VJ8lprHizCLgzfoMqW0SeKNEbd8NcoIOWAU7cqYkbc7oi5wjDteST1a3LObAksOzCuOc1op7llCfmg04WxxfbJYDYUElEwtzG0NmERhZ5HvsKOfbMsACSnX6XDG2p9FJsdoNVscxTJaZ370Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7d86d8-8abd-45db-64d2-08d7a3b2f240
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 05:28:46.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78T1rj29x4JvZXIg5DDtC5upgFerlkcut+mwdtbblpzQ9p4GZovKd6OHVDSk48aa0PbPrtvDJCiE46MJx7WqUw==
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
 drivers/clk/imx/clk-imx8mm.c             | 35 +++++++++++++++++++---------=
----
 include/dt-bindings/clock/imx8mm-clock.h |  7 ++++++-
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 2ed93fc25087..f79a5f5d9ed5 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -414,20 +414,27 @@ static int imx8mm_clocks_probe(struct platform_device=
 *pdev)
=20
 	/* Core Slice */
 	hws[IMX8MM_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src", base + 0x8000,=
 24, 3, imx8mm_a53_sels, ARRAY_SIZE(imx8mm_a53_sels));
-	hws[IMX8MM_CLK_M4_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base + 0x8080, 2=
4, 3, imx8mm_m4_sels, ARRAY_SIZE(imx8mm_m4_sels));
-	hws[IMX8MM_CLK_VPU_SRC] =3D imx_clk_hw_mux2("vpu_src", base + 0x8100, 24,=
 3, imx8mm_vpu_sels, ARRAY_SIZE(imx8mm_vpu_sels));
-	hws[IMX8MM_CLK_GPU3D_SRC] =3D imx_clk_hw_mux2("gpu3d_src", base + 0x8180,=
 24, 3,  imx8mm_gpu3d_sels, ARRAY_SIZE(imx8mm_gpu3d_sels));
-	hws[IMX8MM_CLK_GPU2D_SRC] =3D imx_clk_hw_mux2("gpu2d_src", base + 0x8200,=
 24, 3, imx8mm_gpu2d_sels,  ARRAY_SIZE(imx8mm_gpu2d_sels));
 	hws[IMX8MM_CLK_A53_CG] =3D imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src", =
base + 0x8000, 28);
-	hws[IMX8MM_CLK_M4_CG] =3D imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src", bas=
e + 0x8080, 28);
-	hws[IMX8MM_CLK_VPU_CG] =3D imx_clk_hw_gate3("vpu_cg", "vpu_src", base + 0=
x8100, 28);
-	hws[IMX8MM_CLK_GPU3D_CG] =3D imx_clk_hw_gate3("gpu3d_cg", "gpu3d_src", ba=
se + 0x8180, 28);
-	hws[IMX8MM_CLK_GPU2D_CG] =3D imx_clk_hw_gate3("gpu2d_cg", "gpu2d_src", ba=
se + 0x8200, 28);
 	hws[IMX8MM_CLK_A53_DIV] =3D imx_clk_hw_divider2("arm_a53_div", "arm_a53_c=
g", base + 0x8000, 0, 3);
-	hws[IMX8MM_CLK_M4_DIV] =3D imx_clk_hw_divider2("arm_m4_div", "arm_m4_cg",=
 base + 0x8080, 0, 3);
-	hws[IMX8MM_CLK_VPU_DIV] =3D imx_clk_hw_divider2("vpu_div", "vpu_cg", base=
 + 0x8100, 0, 3);
-	hws[IMX8MM_CLK_GPU3D_DIV] =3D imx_clk_hw_divider2("gpu3d_div", "gpu3d_cg"=
, base + 0x8180, 0, 3);
-	hws[IMX8MM_CLK_GPU2D_DIV] =3D imx_clk_hw_divider2("gpu2d_div", "gpu2d_cg"=
, base + 0x8200, 0, 3);
+
+	hws[IMX8MM_CLK_M4_CORE] =3D imx8m_clk_hw_composite_core("arm_m4_core", im=
x8mm_m4_sels, base + 0x8080);
+	hws[IMX8MM_CLK_VPU_CORE] =3D imx8m_clk_hw_composite_core("vpu_core", imx8=
mm_vpu_sels, base + 0x8100);
+	hws[IMX8MM_CLK_GPU3D_CORE] =3D imx8m_clk_hw_composite_core("gpu3d_core", =
imx8mm_gpu3d_sels, base + 0x8180);
+	hws[IMX8MM_CLK_GPU2D_CORE] =3D imx8m_clk_hw_composite_core("gpu2d_core", =
imx8mm_gpu2d_sels, base + 0x8200);
+
+	/* For backwards compatibility */
+	hws[IMX8MM_CLK_M4_SRC] =3D hws[IMX8MM_CLK_M4_CORE];
+	hws[IMX8MM_CLK_M4_CG] =3D hws[IMX8MM_CLK_M4_CORE];
+	hws[IMX8MM_CLK_M4_DIV] =3D hws[IMX8MM_CLK_M4_CORE];
+	hws[IMX8MM_CLK_VPU_SRC] =3D hws[IMX8MM_CLK_VPU_CORE];
+	hws[IMX8MM_CLK_VPU_CG] =3D hws[IMX8MM_CLK_VPU_CORE];
+	hws[IMX8MM_CLK_VPU_DIV] =3D hws[IMX8MM_CLK_VPU_CORE];
+	hws[IMX8MM_CLK_GPU3D_SRC] =3D hws[IMX8MM_CLK_GPU3D_CORE];
+	hws[IMX8MM_CLK_GPU3D_CG] =3D hws[IMX8MM_CLK_GPU3D_CORE];
+	hws[IMX8MM_CLK_GPU3D_DIV] =3D hws[IMX8MM_CLK_GPU3D_CORE];
+	hws[IMX8MM_CLK_GPU2D_SRC] =3D hws[IMX8MM_CLK_GPU2D_CORE];
+	hws[IMX8MM_CLK_GPU2D_CG] =3D hws[IMX8MM_CLK_GPU2D_CORE];
+	hws[IMX8MM_CLK_GPU2D_DIV] =3D hws[IMX8MM_CLK_GPU2D_CORE];
=20
 	/* BUS */
 	hws[IMX8MM_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
 imx8mm_main_axi_sels, base + 0x8800);
@@ -564,7 +571,7 @@ static int imx8mm_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MM_CLK_UART3_ROOT] =3D imx_clk_hw_gate4("uart3_root_clk", "uart3"=
, base + 0x44b0, 0);
 	hws[IMX8MM_CLK_UART4_ROOT] =3D imx_clk_hw_gate4("uart4_root_clk", "uart4"=
, base + 0x44c0, 0);
 	hws[IMX8MM_CLK_USB1_CTRL_ROOT] =3D imx_clk_hw_gate4("usb1_ctrl_root_clk",=
 "usb_bus", base + 0x44d0, 0);
-	hws[IMX8MM_CLK_GPU3D_ROOT] =3D imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_=
div", base + 0x44f0, 0);
+	hws[IMX8MM_CLK_GPU3D_ROOT] =3D imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_=
core", base + 0x44f0, 0);
 	hws[IMX8MM_CLK_USDHC1_ROOT] =3D imx_clk_hw_gate4("usdhc1_root_clk", "usdh=
c1", base + 0x4510, 0);
 	hws[IMX8MM_CLK_USDHC2_ROOT] =3D imx_clk_hw_gate4("usdhc2_root_clk", "usdh=
c2", base + 0x4520, 0);
 	hws[IMX8MM_CLK_WDOG1_ROOT] =3D imx_clk_hw_gate4("wdog1_root_clk", "wdog",=
 base + 0x4530, 0);
@@ -586,7 +593,7 @@ static int imx8mm_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MM_CLK_SDMA1_ROOT] =3D imx_clk_hw_gate4("sdma1_clk", "ipg_root", =
base + 0x43a0, 0);
 	hws[IMX8MM_CLK_SDMA2_ROOT] =3D imx_clk_hw_gate4("sdma2_clk", "ipg_audio_r=
oot", base + 0x43b0, 0);
 	hws[IMX8MM_CLK_SDMA3_ROOT] =3D imx_clk_hw_gate4("sdma3_clk", "ipg_audio_r=
oot", base + 0x45f0, 0);
-	hws[IMX8MM_CLK_GPU2D_ROOT] =3D imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_=
div", base + 0x4660, 0);
+	hws[IMX8MM_CLK_GPU2D_ROOT] =3D imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_=
core", base + 0x4660, 0);
 	hws[IMX8MM_CLK_CSI1_ROOT] =3D imx_clk_hw_gate4("csi1_root_clk", "csi1_cor=
e", base + 0x4650, 0);
=20
 	hws[IMX8MM_CLK_GPT_3M] =3D imx_clk_hw_fixed_factor("gpt_3m", "osc_24m", 1=
, 8);
diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings=
/clock/imx8mm-clock.h
index edeece2289f0..038c28d349e8 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -265,6 +265,11 @@
 #define IMX8MM_SYS_PLL2_333M_CG			244
 #define IMX8MM_SYS_PLL2_500M_CG			245
=20
-#define IMX8MM_CLK_END				246
+#define IMX8MM_CLK_M4_CORE			246
+#define IMX8MM_CLK_VPU_CORE			247
+#define IMX8MM_CLK_GPU3D_CORE			248
+#define IMX8MM_CLK_GPU2D_CORE			249
+
+#define IMX8MM_CLK_END				250
=20
 #endif
--=20
2.16.4

