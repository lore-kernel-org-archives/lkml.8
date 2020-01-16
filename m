Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E5DC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B742053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cGK6skKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgAPCP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:15:58 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:13285
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730202AbgAPCP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:15:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkF5C0TiIfQQOHzfF5liCZL4HZendfTOPDjthF5ked8sii0APAQDJKVeDgARp7xazCmE2vBJc0cmtINteiig/W4/55B2n49ExSWJKZ0L/A938jj1IihV7nXjN9O/dg1+VH2G0H/0xNAR9mRvvTotuVKykNgMY9JQ/NBA3wBT95ToN685jxdlp7/ScN9wPHFEq5VNsDuGxRbYERYf1ZZDDKofImmtHel4hDPrNOqsMR7nzoyx4TJfNbsmkIxAEwL4lZ6w9nfSz8J3et+uaPUz/q5oIRbFQdzMDdKGKjsWhq4FY+4uzdKpxahRDplCSXWrWRkcgOG4Vry2O2RtVlnEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m4rJXtNhslKF9USAI2uOFXyi7cYgdzd4wqwFLKb87c=;
 b=RmzMM0Koyw7+Hes03AvbrZ6VLFfQmZHPEb2gT9Q/mkOYz0V5yMQeoEuqfTeefWuSuh+LxsccFiSMIzOBBhXrUBNf3/uFY84uLXGlMNACB+aSFWZYhZBMrtSicbgAxBEhinUe7+admRrA2cjsPaxV+8+q8lH774myRU5PT9/N6X26cCKKCdXPHDNd9UwJkxw0c0VpNGJAvkO3+8axx2jPXKeJ9q33pz1PnhZ2hvh+JafM95lpOLXXXmDT5jp9MV7e32Ejxm3peF5E/80z9yg5X8KOshBE/6UBty18OuWqllhPxjFMa9/6xbFZfwh7LMgSNzq+4tBEDkU9P+6IBTUW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m4rJXtNhslKF9USAI2uOFXyi7cYgdzd4wqwFLKb87c=;
 b=cGK6skKnGjNbZ+hq9NqHOoeU0PsdtKkJ9FFJLbwcg+8vKKb1ieM+fXs9pKzZHvbt8+MyrOQ8JLeDUEp7J/9kUw1iIeSofI6wZwKBYJAuMikIN/qKvtuuPFnLeJkqaDcI2EnBLEvzf0QafU+a8cFhld7fzklmoVaNWMshzNX3Ip0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6289.eurprd04.prod.outlook.com (20.179.35.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 02:15:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 02:15:54 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Thu, 16 Jan 2020 02:15:48 +0000
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
Subject: [PATCH V3 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V3 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Index: AQHVzBLhTw2vfOWK6k2th/PMm5Catw==
Date:   Thu, 16 Jan 2020 02:15:53 +0000
Message-ID: <1579140562-8060-3-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: b27fcac7-aacf-484b-78b1-08d79a2a03a8
x-ms-traffictypediagnostic: AM0PR04MB6289:|AM0PR04MB6289:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB628967D08CE347403829DAF488360@AM0PR04MB6289.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(478600001)(4326008)(5660300002)(316002)(54906003)(110136005)(8936002)(81166006)(81156014)(8676002)(36756003)(6512007)(71200400001)(69590400006)(16526019)(6636002)(26005)(6506007)(186003)(86362001)(52116002)(64756008)(956004)(6666004)(66946007)(66476007)(6486002)(66556008)(44832011)(66446008)(2616005)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6289;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0jVkwNT2ifovsaF0fv91zRSJOVYpGiNaXTgPlL/UEFiXHsJ8rEBmnNc6sVflUMD8v0RbM2a4DdqR5Td46JPGPzg2WXFXo/XlJ+oIDK9tnneeorO8BOf1LpaKCm++g7pIzcu7Ip53uzbVh5KlPYUu51tOQIczHdTml5I7BprgcqfpqrO3Ex+swGmC5a2wlP8+BDp+3TnPzC38gW86dMJ3gmN4yZOvgV9PfRGD3sYtCGhoIJ3dZ86OIyUNuWFMSRumhcMENNPZ2elviW+eGM7TPfUx7JhjqqJxOlFYNVR0kjGe/5QQQvEWf1KvRDtX+xbgpwQTRmTVbmRYSKaTk/MHlfsR+oQYDC6ptkllLPp5fXJKYSJvO8twMGE/2V6/JS2uBkAQl+ekKhjkVxwfBB0KFVO++2qrI9RXvA7FY/ieC4Jb464F4haaQcSNW1ulNXhFqqvCyTByLB9/r60PGR1q7ofdOPvCQLc9cqHbf3PbgI93CAwES57tz1aJNRO30L3zzuxZAZfPrQcPKiwh1VMS8A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27fcac7-aacf-484b-78b1-08d79a2a03a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 02:15:53.9949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJi7WBBuVO0ZLxUUbGYE7HAdKZvHlKHGG91+eEX1YIAMh1zud713rjG+DvGF+d4HQXfCk54OdINKWaHbtTIUjQ==
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
 drivers/clk/imx/clk-imx8mq.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 4c0edca1a6d0..e928c1355ad8 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -403,22 +403,16 @@ static int imx8mq_clocks_probe(struct platform_device=
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
+	/* For DTS which still assign parents for gpu core src clk */
+	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D hws[IMX8MQ_CLK_GPU_CORE_DIV];
+	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D hws[IMX8MQ_CLK_GPU_SHADER_DIV];
=20
 	/* BUS */
 	hws[IMX8MQ_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
imx8mq_main_axi_sels, base + 0x8800);
--=20
2.16.4

