Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF43C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAAF2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AYCJSxIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgAJHSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:18:05 -0500
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:55266
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbgAJHSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:18:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9rYht/VkfRka3nKAVFF49rIHOaNGsNavEd8GeDuWcNtX9waf6UfK7piIDxZxiwdQpwSXwKSMF8FcQRTvPUbLV/r+SjeuxcnREDQrCe35z2xdNqVNeH/H0WaEeqSTbZCF0YetNol/WQHELewPpJWaKXPTIlid6dmBTOgGXFalBBcMAxv3ZMwGSC2d680IoUZ6ziGsX4ZeyvZTsJF20NwoKhUWT3qxy+H+KJzpgx2RdkeMNOo/OEqxlRi3OcTLbjjFrhM/af/59DQX4Cnh9ib3Od6vbwMEv2Kj04Q7JUmH9gOBtnxUWfyL8cVcVOcJOzGXP2osl0D97LM5B4nrnuzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNQA4pBlWfvS3JwJ/HKUKXzz2K1IdLwTO++PCDTph6A=;
 b=j5pNf+v8mi5zRmmAtfKyfybVLA+2I0OxmiKZqwnMwjoBlPTXGcC53gSdMoN/u7ntyVUXVUjpbiLkArg08FMxavDNynLi9rG3Hu787DpOhSUkXiIkLJ2QXA1yTzBipFAAAOWPpDcyslAB5F/5yo6Ops9VaYp2Q6OPoz3ylnosq0q2xNgz0mmg5f9hXYJmXFjU0cjXLpkQy268FSvIHUsSmolFRYylL3gltiY9gWx9pyjr5JUasvscppcU+v7WiG+3xsaHO8EAvKnvZW/Lq5pAsYv7w+M9Hbf14zXf7jTlEtqor+9E6UIdgNFHW3mpC2ZwGb64P6fahB2yb+6lZ3J04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNQA4pBlWfvS3JwJ/HKUKXzz2K1IdLwTO++PCDTph6A=;
 b=AYCJSxITgegcA5KNW8boVsXUpc27fktU6CgJuZh1XokXP/uYpKU0qZnzeeWSGat7dnsGJ2i5DwEYKCcbTq13Sa/yZBDyAmqNzOY0O4o9j4eyDr9K/6oF9cdUl2vz89e77or9gd4goWlUJBY5B+t37/wBOuEbh251DA9cUh0Zit4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7172.eurprd04.prod.outlook.com (10.186.128.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 07:18:01 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 07:18:01 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.10 via Frontend Transport; Fri, 10 Jan 2020 07:17:56 +0000
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
Subject: [PATCH V2 3/4] clk: imx: imx8mm: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V2 3/4] clk: imx: imx8mm: use imx8m_clk_hw_composite_core
Thread-Index: AQHVx4YXMxTL9tvflUGSFPY8FST0Gg==
Date:   Fri, 10 Jan 2020 07:18:01 +0000
Message-ID: <1578640411-16991-4-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: d95df21f-3d07-40bb-1737-08d7959d39d5
x-ms-traffictypediagnostic: AM0PR04MB7172:|AM0PR04MB7172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB717238452FB249E91BE0BC1688380@AM0PR04MB7172.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(2906002)(478600001)(81156014)(81166006)(69590400006)(956004)(8936002)(4326008)(2616005)(44832011)(71200400001)(8676002)(6666004)(86362001)(6512007)(5660300002)(6486002)(186003)(16526019)(66476007)(66446008)(36756003)(66556008)(64756008)(66946007)(26005)(6506007)(6636002)(54906003)(316002)(52116002)(110136005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7172;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ilf3yK6WbfyaotCONMB5cXQ3pHNxKQVAiSkcbljKjmWB8m9jvJEAMATUi6+fdjL6Xs+nCMsKYL6FDlekrXuWfTt+3WOq1/5F9lCXj2Avc/KPK33TMUEvTmmozZ79mBFzirRDQ+2X6WGdj0rHYHCP1Wj6B/c4nyH6RKhFyjetQqwWGyHerhqDeV/RUWPKYSkI5blfTpKcJl1+7UfhJEzoY9t/fW85Xq/PU41MGzyjQnurZMVnvxB/Op+fdsJrcj24Q8mMbkqVB2kUeGJftlRXwNxjUTVMQcNlwXsYBwb/VUytGiwyy7J2inC+xHhrFK7eM2+Ie18EJrPNCNwEBJ5dmdxweRKa8xogmRBYTgssxX0L1X3A5qwgZbDqpV5GZu+u17xm3yguHusS4qXvAlcxWmiDviFDOz48AviOujyhaDlMU1QAbZeJmpm/Js3sRH723ldpjEOI0N8vzQuYnvd+pwy/vkuXOPTqbW/EvwWOZIplNma1Um8po6gX/WdF3Ur++szE3mOj3t1v8ud8Qlzi2w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95df21f-3d07-40bb-1737-08d7959d39d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 07:18:01.1533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGRPau8gKp6atl+PtkwXsQbFSBjVrkdyFHA644za3kyMwUrX4eqJ++lGl8iSOOd22Nykn+Dx7mzndnDMxGymvQ==
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
 drivers/clk/imx/clk-imx8mm.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 2ed93fc25087..197ba2cdab7d 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -414,20 +414,13 @@ static int imx8mm_clocks_probe(struct platform_device=
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
+	hws[IMX8MM_CLK_M4_DIV] =3D imx8m_clk_hw_composite_core("arm_m4_div", imx8=
mm_m4_sels, base + 0x8080);
+	hws[IMX8MM_CLK_VPU_DIV] =3D imx8m_clk_hw_composite_core("vpu_div", imx8mm=
_vpu_sels, base + 0x8100);
+	hws[IMX8MM_CLK_GPU3D_DIV] =3D imx8m_clk_hw_composite_core("gpu3d_div", im=
x8mm_gpu3d_sels, base + 0x8180);
+	hws[IMX8MM_CLK_GPU2D_DIV] =3D imx8m_clk_hw_composite_core("gpu2d_div", im=
x8mm_gpu2d_sels, base + 0x8200);
=20
 	/* BUS */
 	hws[IMX8MM_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
 imx8mm_main_axi_sels, base + 0x8800);
--=20
2.16.4

