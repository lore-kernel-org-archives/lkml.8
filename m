Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC1AC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795592053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DZkM1P92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgAPCQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:16:08 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:34693
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730202AbgAPCQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:16:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/azFUfv9NF3uRLqpzWNYUtFRA8GPEqVNBihW0KM3OsBC3VL9++Q2uuWeIli08JclpqSsNG1tFfNEvHCiO5lEdN/Vo2VCWVhPSvOouJSp2CjzGQPTc263/+hYGqce7wQDEAn4CSJX/iugikhFJ4/oh5kJLS5VMG0zWxhFSwkqYeQ72oz9IBcFOHM49J4ySKKygq+ICD3trA5+E0FvMc3lEmhsIqglEzDNZFCadi+JxNg1sYSS0aiO+ROTrcsp8HvXrgHw0YVgK+buLkuqtXe1jaAbFME81eSYbL9GgYxJRc2EHeFJKgrf0K2oBsxw31agCg5e+fxHacskS1zxrSDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9hHpYc1QTxFufeaor7kzXYM5HTjA4lTlgvKy/9O2tQ=;
 b=Q8xXgfxGDZA9aWXbKgC1y30Lh4jA+qvjYyD22KykKIWaF6KiEOWrznM8UegHagzrFthHGnGHfAD+2kxkqqrbpfOi/XDGNI8fupEQm9u3SeuIrbeUdIpp1HpvWNTndYzsAmsFdksmZ0brAVgYPNvjhOwU2tL7ojv3RJGedzU/9UKqvD/cS3O7BLL7NQlBB+0j1vy9cxXqnNMuJrj9eQMAPSLamgRlVc6uW9xlvxbcNJCKMdQr4/zkr5eD/s4hQPe56WKxasolffEwkS642lqojHyFU035k+kL6BUWyK2t81JpyhunmH60tHux8c0SgX5E/Fjz1tYN7oSYRCKibc28sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9hHpYc1QTxFufeaor7kzXYM5HTjA4lTlgvKy/9O2tQ=;
 b=DZkM1P92ep4ChLBVv95udBvtplGSfoMcs+3sazXrtqWuWJJ8hTRQ8NTcPMCyvYYdmBfw7+LCxnE9xOjP4xA6EW5EwMiVMX2cfasaRLQtr1yvFFzRfBrhmL+Dnm4UaejamyrQyx5mUkhU7VQX0g9bMrklqvDbEf6qca/myUESTec=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6289.eurprd04.prod.outlook.com (20.179.35.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 02:16:05 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 02:16:05 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Thu, 16 Jan 2020 02:16:00 +0000
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
Subject: [PATCH V3 4/4] clk: imx: imx8mn: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V3 4/4] clk: imx: imx8mn: use imx8m_clk_hw_composite_core
Thread-Index: AQHVzBLnUi048CdOXUiCDlIwVfTEcg==
Date:   Thu, 16 Jan 2020 02:16:05 +0000
Message-ID: <1579140562-8060-5-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: fc14da0a-fb52-492f-2731-08d79a2a0a56
x-ms-traffictypediagnostic: AM0PR04MB6289:|AM0PR04MB6289:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB62898B4299EE0C583E95C58E88360@AM0PR04MB6289.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(478600001)(4326008)(5660300002)(316002)(54906003)(110136005)(8936002)(81166006)(81156014)(8676002)(36756003)(6512007)(71200400001)(69590400006)(16526019)(6636002)(26005)(6506007)(186003)(86362001)(52116002)(64756008)(956004)(66946007)(66476007)(6486002)(66556008)(44832011)(66446008)(2616005)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6289;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G/15dWIM+PLYiB3jl6lbWH9SK1fu2lMHYChn3Ca4w6P2tHGg3dC1+UuU4QekqzPviW5BFb8uCVIFs2DOMfrNiVhq9DjcAAWL/iuv6vpFpw66mnUXTJoRCb8+paERLzrXSW2SGlNUw/iHW6InG0Fcq1YAFKL9CxZ/6jA1+MmxlHG/f+qFDVlPp6eO+fxJ8WfORJ99n3PsZNNF9wQTnCQPpt00c//eDGqDIJ17QHuqk9+vioYzdV+hoWVyGyKB35bNBxSMFozMLKHfV4rFGszSUBkqU1cJtqM6uvhkCA0bwjSf9s7MHS7vehvxihHvmDwnTu0PHYBskf0C3sHSGxE0szJOcu++ZYYyoUrhWV00AZW1/86/caxuj2jgnATrlVjOdqxFb9IzONz4iMW9E4bzQAGsbQUmk3s10RVEEtCEwU9vVNDJPIWUjg6MkPR6ieAnT+yH9gNQ9zAAN2o00mQz8CMqFrXiu0iiiEuitm/sIAJAjrr7ZSlTLXtoCxpfrKljcnWlaTXWQ7jSNBFly9a3OQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc14da0a-fb52-492f-2731-08d79a2a0a56
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 02:16:05.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xAGg5xxK2KHEbdN5A8BHGkKFODLlQRuYCqJntCZxnGtSxeQeJu4V2bgqt8SvtFMDyFxzedciGEr6qPDSnqfQQw==
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
 drivers/clk/imx/clk-imx8mn.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index c5e7316b4c66..ce2ba3dce483 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -413,15 +413,11 @@ static int imx8mn_clocks_probe(struct platform_device=
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
+	hws[IMX8MN_CLK_GPU_CORE_DIV] =3D imx8m_clk_hw_composite_core("gpu_core_di=
v", imx8mn_gpu_core_sels, base + 0x8180);
+	hws[IMX8MN_CLK_GPU_SHADER_DIV] =3D imx8m_clk_hw_composite_core("gpu_shade=
r_div", imx8mn_gpu_shader_sels, base + 0x8200);
=20
 	/* BUS */
 	hws[IMX8MN_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
imx8mn_main_axi_sels, base + 0x8800);
--=20
2.16.4

