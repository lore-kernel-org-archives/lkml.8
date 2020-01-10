Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE4AC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792C42073A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZLUYJc5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgAJHSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:18:00 -0500
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:30435
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgAJHSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:18:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQnPSqsxJJhoZykO2/ZDAF9CCh28KOVO0hGcLW60FbC7DcFd0dA0DG1w8KWaY5SKABo8x/PMA1YrHOzaMQedHwmBMBalnXgTV4JB9Dyp7qIYHBQ/6tGLepLnBgBneyDe8OmBvJSVCr0bilUw82P+hJCScr5YIJD+/d1G9VWhA5W5u+zxgU93Aeo1mqPG8DsKQ3imy4ntYYOMVXrsS5KTfHP92ZPQRxm1CueUR5xM2+tzlnf3E8ZySeR/l6/6Mf2dGkcJ3uHc4E1MHSYJTy6jNGHS1fpsomjnn/0TQser6+clcwfu3+znf4d8w7gMIu+RkBCpcVDUHWeXJyS0ExAM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH/VPj5bal6rKEmyI75MYlu4G6yrXSLlKRtLJWPefFo=;
 b=eOzMAa1E7Ks53gQF9serL7u0aEgDlzFDUZXbd+zT7NxkrfzRMJ6SAvwBzZcByYBmJR/HyWKpnshGOid8oiEEAVefoTell0cbQtMQr2akmEP8tH55Rk1zTa2tawDEAW47X9r3Cy9so7MQ72yAGVJmm3EzpTof114m7QTBFxJGwTR0FuefYvEBLaeuwClCORA+MDgZQH6zWioFsFl1AfmLdrc06ZQ7mlNnjoc9PFICOK7t4BSuNdm3MvgoWEZepFK9xiOarkVp2yi/AKmpnMflYXkkYa5sgJg9y8Xbrd0LBtGTl/vah5wS8Q6syr+2XF3cKchPodkdAEKKgX0B+DeGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH/VPj5bal6rKEmyI75MYlu4G6yrXSLlKRtLJWPefFo=;
 b=ZLUYJc5OwFmFLqyjnjA1ocaf5/FbdFBvNiATc+SJAHXsQKiF48JHpX+uVe7n6c34B7doK7z9LQ1+3+VXNxc4PVcdpmAuSWC/UAgCLmjU7BICxyvNuGR8fslE3Oo0VQuwLrrWDEgqoqG2J3a1pEGWkV0AxWZxWxNr2h16THxZBJ0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7172.eurprd04.prod.outlook.com (10.186.128.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 07:17:56 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 07:17:56 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.10 via Frontend Transport; Fri, 10 Jan 2020 07:17:51 +0000
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
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V2 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Index: AQHVx4YUjgdbWY8cjkmCWC9mUDXV2g==
Date:   Fri, 10 Jan 2020 07:17:56 +0000
Message-ID: <1578640411-16991-3-git-send-email-peng.fan@nxp.com>
References: <1578640411-16991-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1578640411-16991-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bfcb13d-e159-4a4d-18f1-08d7959d36e7
x-ms-traffictypediagnostic: AM0PR04MB7172:|AM0PR04MB7172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7172E9D9BA4775B61AAD5AD088380@AM0PR04MB7172.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:239;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(2906002)(478600001)(81156014)(81166006)(69590400006)(956004)(8936002)(4326008)(2616005)(44832011)(71200400001)(8676002)(86362001)(6512007)(5660300002)(6486002)(186003)(16526019)(66476007)(66446008)(36756003)(66556008)(64756008)(66946007)(26005)(6506007)(6636002)(54906003)(316002)(52116002)(110136005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7172;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7u+KGRblaKjcvurZvxJy9CZb4bpCUvIEH1MSRRqgKGeRFM9pGvPxoZg+fQMhSEltMMnBiNI2rrU0pcRN2X1Jrgs6HCIa1pyFAfTqnZsCSJE0EqkG1sU54I1GvkFcilFhFtWFspjrHIre7kazrzKlRVaLCi/Cgo4wLIpOziIJvc/WxY5HBxM9XJFoMcH8HqyosPzMaVH8/jGewCiEOIrQmQpiNE657l8Hs2SSFgMQTlhC4ny8xmGFHhPsa5g08KYj+N2qNNjYRRPKi4N/okjUhrZLQgN+rbvRu05mkHtzr7uR9jkAeLSzRvF8bb/jQY6p67uI87iYRb8DEH5GScwqyzKja+ZMQyTIKbAZQwLh+CW/OYvtJeIhpn5h+EyysR/+63vhJ/cJRiJJQnosHJA81fTBHa6zF4Ua+UerQGX0Wk0fa22nA9rerPYe9AnRgA1H7829F0FvQvhnGfFYOwW+++rPl8dFQ07NIGhfMAW7MrCoV0N1jWpTlXDFZB8FlF2T1lvQ76Q9b2fwyj0cUVh/1g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfcb13d-e159-4a4d-18f1-08d7959d36e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 07:17:56.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpEq9Mwkhtqnp2ExvXqm9HD+H1Mo7NclDIhhVyLjfSN1oTqrTI3bVHy+cUVhzlks4b8fGH5shmoSTJz+QwGB5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use imx8m_clk_hw_composite_core to simplify code.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 4c0edca1a6d0..b031183ff427 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -403,22 +403,13 @@ static int imx8mq_clocks_probe(struct platform_device=
 *pdev)
=20
 	/* CORE */
 	hws[IMX8MQ_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src", base + 0x8000,=
 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));
-	hws[IMX8MQ_CLK_M4_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base + 0x8080, 2=
4, 3, imx8mq_arm_m4_sels, ARRAY_SIZE(imx8mq_arm_m4_sels));
-	hws[IMX8MQ_CLK_VPU_SRC] =3D imx_clk_hw_mux2("vpu_src", base + 0x8100, 24,=
 3, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));
-	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D imx_clk_hw_mux2("gpu_core_src", base + 0=
x8180, 24, 3,  imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels));
-	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D imx_clk_hw_mux2("gpu_shader_src", base=
 + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sel=
s));
-
 	hws[IMX8MQ_CLK_A53_CG] =3D imx_clk_hw_gate3_flags("arm_a53_cg", "arm_a53_=
src", base + 0x8000, 28, CLK_IS_CRITICAL);
-	hws[IMX8MQ_CLK_M4_CG] =3D imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src", bas=
e + 0x8080, 28);
-	hws[IMX8MQ_CLK_VPU_CG] =3D imx_clk_hw_gate3("vpu_cg", "vpu_src", base + 0=
x8100, 28);
-	hws[IMX8MQ_CLK_GPU_CORE_CG] =3D imx_clk_hw_gate3("gpu_core_cg", "gpu_core=
_src", base + 0x8180, 28);
-	hws[IMX8MQ_CLK_GPU_SHADER_CG] =3D imx_clk_hw_gate3("gpu_shader_cg", "gpu_=
shader_src", base + 0x8200, 28);
-
 	hws[IMX8MQ_CLK_A53_DIV] =3D imx_clk_hw_divider2("arm_a53_div", "arm_a53_c=
g", base + 0x8000, 0, 3);
-	hws[IMX8MQ_CLK_M4_DIV] =3D imx_clk_hw_divider2("arm_m4_div", "arm_m4_cg",=
 base + 0x8080, 0, 3);
-	hws[IMX8MQ_CLK_VPU_DIV] =3D imx_clk_hw_divider2("vpu_div", "vpu_cg", base=
 + 0x8100, 0, 3);
-	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D imx_clk_hw_divider2("gpu_core_div", "gpu=
_core_cg", base + 0x8180, 0, 3);
-	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D imx_clk_hw_divider2("gpu_shader_div", =
"gpu_shader_cg", base + 0x8200, 0, 3);
+
+	hws[IMX8MQ_CLK_M4_DIV] =3D imx8m_clk_hw_composite_core("arm_m4_div", imx8=
mq_arm_m4_sels, base + 0x8080);
+	hws[IMX8MQ_CLK_VPU_DIV] =3D imx8m_clk_hw_composite_core("vpu_div", imx8mq=
_vpu_sels, base + 0x8100);
+	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D imx8m_clk_hw_composite_core("gpu_core_di=
v", imx8mq_gpu_core_sels, base + 0x8180);
+	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D imx8m_clk_hw_composite("gpu_shader_div=
", imx8mq_gpu_shader_sels, base + 0x8200);
=20
 	/* BUS */
 	hws[IMX8MQ_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
imx8mq_main_axi_sels, base + 0x8800);
--=20
2.16.4

