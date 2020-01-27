Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8535C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09B9217BA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K+aCfU7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgA0O1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:27:36 -0500
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:51919
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbgA0O1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:27:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey5iXwD58DNzl+A8N7h/kJXdzWpxwlohnuO2KfGlLpv63DF3thGr8xf0JOHXEz/Rh81KS8yC5XA/E3jr87zVe3rPNw3G9QyqXXzbK53sjA252frwRLyEmvbwiCJSdxtQZLcyugRO7TxfEED8jEHLFlRhlckQB0cKhR5RtThE68weNE51A7bu7LnQVOHtYu2V5YcAiUAa2YunqEnQ2RjQuLnCcabfZfi6Jatg3lpyLEZF0k+ADe0ANapEc/J/GBnvgGVTgZlYXu2cvpUIxRChnaJI03t+Ync7tgoxsyTBpk6rUH9fZMEA1cdG/u1z1JTK1YxHy06l60MCN/vfTQR2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaTlXF1DNcIZP3Y3JYGpDOX42fzlCSt2c+A6OSNAn5I=;
 b=naqOgxI/p+8neKKidktKdKFwX50MZfbx03hPfFM/Zz0S2vKcg50bnsb/UQyRbJSfD7u/IXXvSABQIY8Fn9Gz89wAEC97CMf3+oVJRvBiTtTQBHHJvkoHxIyoc2ysPcGpBYzHhYtB/cEU5zuOXI03hgu+mVzOPgMVvl17oJfzdNOLb46S/Gu+5XtE2O8DCwX3hdVuhcnaWhdURTqNn67hOza0sNhLhJA0gsjeAgcP/xSE0It42QL7Y9jTQMvtQmcYIeXnLB97ewNqnp3s9wRbiK8UvST98LQ6LeoXkm6CPj9APwEarE2yG7nF8mHLpoeiBszJBvtrzqFq/8PIXqR96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaTlXF1DNcIZP3Y3JYGpDOX42fzlCSt2c+A6OSNAn5I=;
 b=K+aCfU7O3/dQjFu8wxB+6swZLzNK7WCwQROXnpNheO/dEhtiRkncnlFrs1Q2c/MnWfqX7Ai9fVWLZMKV/DMS5PB8olUF5lUAnt8uVWzwi5cgATbVxTigYXwo6pNy4z8nJD72iv64Y1Dj41d+vilndNkr2CxKoRyKh43gr/Ii67k=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3952.eurprd04.prod.outlook.com (52.134.14.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.26; Mon, 27 Jan 2020 14:27:31 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 14:27:31 +0000
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM3PR05CA0141.eurprd05.prod.outlook.com (2603:10a6:207:3::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.21 via Frontend Transport; Mon, 27 Jan 2020 14:27:30 +0000
From:   "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Sebastien Fagard <sebastien.fagard@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/2] firmware: imx: scu-pd: Add missing audio PD ranges
Thread-Topic: [PATCH 1/2] firmware: imx: scu-pd: Add missing audio PD ranges
Thread-Index: AQHV1R3oPPw2flW2f0qi3/jjBmKDSQ==
Date:   Mon, 27 Jan 2020 14:27:31 +0000
Message-ID: <20200127142717.27570-2-daniel.baluta@oss.nxp.com>
References: <20200127142717.27570-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20200127142717.27570-1-daniel.baluta@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0141.eurprd05.prod.outlook.com
 (2603:10a6:207:3::19) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bde26b8-2bfe-4884-57b4-08d7a3350b4e
x-ms-traffictypediagnostic: VI1PR0402MB3952:|VI1PR0402MB3952:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3952140A66FD44618BF744B7B80B0@VI1PR0402MB3952.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(6512007)(81166006)(86362001)(8936002)(5660300002)(956004)(2616005)(54906003)(81156014)(8676002)(186003)(16526019)(71200400001)(6916009)(4326008)(52116002)(6486002)(478600001)(316002)(66476007)(66946007)(64756008)(66446008)(66556008)(1076003)(6506007)(26005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3952;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H4wOugJKpNUM64t8it4X9Uzf5GcKCm5T6L21eLsYv7843M5NCKjx8dXrzHZvuNiQQ99aa4RTSXhtvpoo/AqXTjAAuDyi/5tQPA6HMUJj5tC928AdlFg/AIcHBlcegBEBxrCORhLBTyIw8UAj6rNnz0cF8zLF0HJqT642BwuPo3/YQAtYHZCpyuiQ2rHs1rfI9mOyYSUNz6vx4ZQ3BgmG3/S/i8ACR2Qy6Eas+6c7lkyFi1DJT23E6arxE0FnmDrJvZn2XdJhGqifmy9PNYhvtDqdtkPkvyNxILfuwksiwW/pOUNwlDBz+ZtyElOyA0dy8KA2umAjluNvPgZ0Xjb9QENGJl76A26T4SSGNEJlL+hiXJGZb9aPgBcW5xxSKwQPDSOEg27gALbdubsoB/mmA5Ed8Jza6+37A75tOC03xJube1wSWC/xBbDXQnUqVhdV
x-ms-exchange-antispam-messagedata: 0aSZyWuzK+rhBHfBQTC4HYWUObF9j9rOjNGic8V+/jTuc11XWRoBkxyYrmNVdFrSTb+rLeXlFHTpkvYviU2c4dtuDJ/cFGKh+GbJuWsuS+hh+Lu3TWDQabUqr9PKpz+VUDAtlsbCglV8vYW6OBhX+Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bde26b8-2bfe-4884-57b4-08d7a3350b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 14:27:31.6718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DhF+Jd+KgSquOGvjVwqe4LekPvTU64JOa5ugKQRhRgQ3ZwaQ4KNt/n4fXAWtXnWiveSN3/NvMs+A2OakSrwwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

imx8qxp_scu_pd_ranges keeps PD ranges for both i.MX8QM and
i.MX8QXP.

The following PD are missing: audio-clk1/ spdif1 / sai3..7.
Add them now.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index b556612207e5..c10f63901c1c 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -109,6 +109,7 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_rang=
es[] =3D {
 	{ "audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, false, 0 },
 	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
 	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
+	{ "audio-clk-1", IMX_SC_R_AUDIO_CLK_1, 1, false, 0 },
 	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
 	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
 	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
@@ -116,7 +117,13 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ran=
ges[] =3D {
 	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
 	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
 	{ "spdif0", IMX_SC_R_SPDIF_0, 1, false, 0 },
+	{ "spdif1", IMX_SC_R_SPDIF_1, 1, false, 0 },
 	{ "sai", IMX_SC_R_SAI_0, 3, true, 0 },
+	{ "sai3", IMX_SC_R_SAI_3, 1, false, 0 },
+	{ "sai4", IMX_SC_R_SAI_4, 1, false, 0 },
+	{ "sai5", IMX_SC_R_SAI_5, 1, false, 0 },
+	{ "sai6", IMX_SC_R_SAI_6, 1, false, 0 },
+	{ "sai7", IMX_SC_R_SAI_7, 1, false, 0 },
 	{ "amix", IMX_SC_R_AMIX, 1, false, 0 },
 	{ "mqs0", IMX_SC_R_MQS_0, 1, false, 0 },
 	{ "dsp", IMX_SC_R_DSP, 1, false, 0 },
--=20
2.17.1

