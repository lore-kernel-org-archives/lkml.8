Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF413C33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E64E2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MLBMqcHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbgAPCQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:16:03 -0500
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:56288
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730202AbgAPCQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:16:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W48CSH7+yxg8ne0W6+HuRb72Zgg5YUVVMIJ5RhgnrRv+cgfKU/rI6SK2th4uIdLJmkhqoDa/Yrygi/IXcZVdENfWP0jYe01nMdU3RvM+VbGVoKdw1JiI1SFZsraOPQUMWf239jZw1+o6U3ZATuMXA6KXxixIaHHrsGsxXM6Ooi1FgcT4+ZG87SeQHvdxs6gT3kYG6orVpNUFv/Yq49gGXOZoPnmsPkINPhj/exiOznXtVt531mTfx65fGFP/Nv/o90ejri4xnfViVdgmVG7EIRP6NjQxEs0vKmrkD69NIETddLBdmgqQPwg0UwR4FL6gV9qOpsDIGttl0r6Eg/8kTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNQA4pBlWfvS3JwJ/HKUKXzz2K1IdLwTO++PCDTph6A=;
 b=KNY8f/WbKeAgueaRepK+oSGFu4cz+cHOb4uGEUF1Q3S3JUexNaEfojmGzqp9rzL57K6jln18SQtFdCvMb6gAKrQna1kibn509gDOiZEMqeeARNEREuwhFapy9UoW+db6m/qPpTYnYuybENnI6WJjg7qR5eT5yBj3aC5+CdikR0HglH8rsJr2R8k/t0WM9kAtZ1VfXxB5h1CYF20hcfyWgkxHLYFHCZneJ0J+IC3i6uHOaPX8xfGCNnimnlzc0UCX+AMWITQE0Rjf3C46TjDKjP8fEYcfoCJ9aTKgjbifQSp7gtDzVauMhD3o541okUTtmm9rDyM9+Z4waTyq4RGWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNQA4pBlWfvS3JwJ/HKUKXzz2K1IdLwTO++PCDTph6A=;
 b=MLBMqcHvT/JHIeQ0igKR3KthDqA/j4OOpJZw5uf/kd0J2wc7jO9VsAr35eM6xjYohE1Wusb3cNwiuHmSjDg4vJ4ZXfuPHGaJpNFabr5U2xARfEJphDVUD5mQSKRqLf7mcEzz501NaT73FtZgYP7Rjwqso5r7/DIShcwOLePZhNo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6289.eurprd04.prod.outlook.com (20.179.35.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 02:16:00 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 02:16:00 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Thu, 16 Jan 2020 02:15:54 +0000
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
Subject: [PATCH V3 3/4] clk: imx: imx8mm: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V3 3/4] clk: imx: imx8mm: use imx8m_clk_hw_composite_core
Thread-Index: AQHVzBLki5blCLQd2ku196asnlKIfQ==
Date:   Thu, 16 Jan 2020 02:15:59 +0000
Message-ID: <1579140562-8060-4-git-send-email-peng.fan@nxp.com>
References: <1579140562-8060-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1579140562-8060-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6ad995c-0698-4172-bf05-08d79a2a0736
x-ms-traffictypediagnostic: AM0PR04MB6289:|AM0PR04MB6289:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB62894DD9B36232BEF5EC5F5588360@AM0PR04MB6289.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(478600001)(4326008)(5660300002)(316002)(54906003)(110136005)(8936002)(81166006)(81156014)(8676002)(36756003)(6512007)(71200400001)(69590400006)(16526019)(6636002)(26005)(6506007)(186003)(86362001)(52116002)(64756008)(956004)(66946007)(66476007)(6486002)(66556008)(44832011)(66446008)(2616005)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6289;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t7W81Tb8jVYfdHmaN7APTgjhggCScbO/er2fM5H9a4NGD00Z0UdJbRiV1Yu0yWGFvzmMaMoaJBDfDWYRSyED8ibXLA1b6Xx20K1Ip5HWThdGiqzlvpGehzizAVRBcOO/+D/NsuMrdFSrpO2L4f2duH6Nzo3Oi2J87UrYSPlK7/tMGFvfCbfryPkZpQDRX60mD0MXDV7CTnQM7i7hjc+XtLfvsY02L0/brfpDRRh35SKJqpFuBt63OtmM+K727krXiyr1vnF/nFEBfwQR0VLZEE9ga6N/KaMquf9JK/mlHRSZ3Iihm/8t3BqKpwoCipD7/feVyIGaN3k3Xc4bnR0nEnev6yLtEjXR7zVraYH3V7906kwLgcOaOzUNEpy1Zv72/Xv94/zWyE3snqjDZ9u9VXz1BpwEcbccJ5NZb6UFi64KsZmFW4FJsJd6WWquKbBjaw4Mv7w0UIAPokEy2HisaAQNMFLhkH0aVba9/QDMAWygR6dSU+AFBCXwN1kWt3AZYHYsMh1Ttljkg1w7Vu4BCw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ad995c-0698-4172-bf05-08d79a2a0736
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 02:15:59.8385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjY4Hw8I92bP32KBV3UMbs/FL35mUVsozMSNyxTYMkZnv2fBX6YYNPoVAP5zDtjt9KYetXgwBAbJnCz85s+1bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6289
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

