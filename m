Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08327C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA15C2467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T4qoyRrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgA1IGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:06:41 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:4525
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbgA1IGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:06:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcTZS67YXKo02xzIVwD4oMEVSFzG2Xggn7x8gKybgw/bIVC+l81B2yfLZRBeLjYpRVjv2QwLVO1cIDEqLmEAmkOeh4qHI7yLgdbBjsCVU1YXfcqm8QPKVNtdTzq9A8cMW7H2fsVuuAA3qO/lRLWjdjQkRTKxJTLBjR690rRA6Wb9sCX+ezBzosP6LrPSlK9ONrD3ieGlPLiPNycs4W/u5XBYN9c4DCjfIR2dJukSLnkVp58KnHiPTzCvnO0Zg/xdKLphnVofH3VeWB/JWseuSgG+H0CuV2UxqJfMT9bZRKOJOy9kCv9HmwtP1fqCJy1/GO8hhavYLCjXoatU4+52Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mcnEvcfcRTM/xbDBnLnflFfaGT4x5i+8ek1kujgnJA=;
 b=nc8e8CNg4e6RoWMSv4ukUDwtT/a82gYWNbf/uaX3naDLr9hjWsSZaFWL+1P9YinPn9dWy73HxXkNFw7ZJJ+6ZdGi/f3sbqmZ/1GR+jKkWwRRW6WYrFw2guEnO76baiysTHvD/DGKyHN3t7Su/B1VnqzzQFEXpL5mlctHzfsB8XSCCnqTB7TRycqO08v3Zs5ObDecpTOiWam8/ckJvFgZy33G5Bxw0xSPZ53BzOX8jdKoaoiR6W2EmRs2EUmh6TdCYbg+K+nDNEFRf8xvBHjBoHWn1MTL2kGaiUWWkxV06mfK/+TwTeIECmSpRE2BlaNHL9eOq7uIxB2sevvfgZZz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mcnEvcfcRTM/xbDBnLnflFfaGT4x5i+8ek1kujgnJA=;
 b=T4qoyRrOpuV+4o9tQnYh/7085Si8W2nn9BuJf/iB5dAvO9UwYPj42+Li3in/VtZHdlyjSTCZe95faqWOlP3aYjAA/rKmaD8TjtzuLQ9a6xfck5QY+P3PQGXtlvAXk3/idkYGmGW3jgpMIveYGseGRX1iMjgS119YhmFz+IbC6oY=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3423.eurprd04.prod.outlook.com (52.134.4.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 08:06:31 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 08:06:31 +0000
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM4PR0701CA0015.eurprd07.prod.outlook.com (2603:10a6:200:42::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.13 via Frontend Transport; Tue, 28 Jan 2020 08:06:30 +0000
From:   "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/4] ASoC: SOF: Rename i.MX8 platform to i.MX8X
Thread-Topic: [PATCH 1/4] ASoC: SOF: Rename i.MX8 platform to i.MX8X
Thread-Index: AQHV1bHZin203cfhfk6wRFW9b+E5DA==
Date:   Tue, 28 Jan 2020 08:06:31 +0000
Message-ID: <20200128080518.29970-2-daniel.baluta@oss.nxp.com>
References: <20200128080518.29970-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20200128080518.29970-1-daniel.baluta@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0701CA0015.eurprd07.prod.outlook.com
 (2603:10a6:200:42::25) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11bb4cc2-bea7-41d1-8f95-08d7a3c8fbde
x-ms-traffictypediagnostic: VI1PR0402MB3423:|VI1PR0402MB3423:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB34232D36B522B2399C566A50B80A0@VI1PR0402MB3423.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(5660300002)(6486002)(66556008)(66476007)(66446008)(64756008)(52116002)(66946007)(110136005)(316002)(54906003)(16526019)(8676002)(8936002)(81166006)(81156014)(186003)(956004)(2616005)(71200400001)(1076003)(26005)(2906002)(478600001)(6506007)(6512007)(86362001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3423;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1IxkTZCYsYY/2AjEGKWPHBdXuqfMGu4spjjJJyj3loiTyGO/glpwtz/5k65AeewTuKX2fb+voS1rUQ042wOmZerfZmwV74c7Rf46UC6N5/9Mlg3JqiAuTqWDQT8aloyURzJViXm/lJoSrMLnJk8TGPZ5Y/P9Y3JIV+qNenkcvrDSKggdp5bphzJGGB7t3ELqVdmcx2CsqtagDvw3C1j7o0KNZiLTcNSgEsfD6J3ElDSKDs+KB0im1dHEszBlg5F4Xd4xZQO12+Y0/hWqBJO/333eQwk28HsoBPkUNrS8+5oY7m+8LQJxOhQL9h4aWdZL1aH5GKk6bRm64YIZd6OloyvSci+sEcj22B7H+iQDGIYO/MpCDXjY4Cub/dZyW5IKKx0qChlJwAUB8MUlqWOjn4/TXxP3NCAp66nIpZwaQ+LnZrtLxFjFRTiJVRTDt+lR
x-ms-exchange-antispam-messagedata: CNVbdr1x4Ir+mUmysKJQXujdjaL4xgfA3xr7CYKEciWtiUzapteywOO9fzXnZ80vvYBThx+t055eCExK5EheOarxp9Z/ArG/6p12bMCmbEVQP+Q45smeZJDmE/wCT3YK5X675faO4c5GLcpTq88EGQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bb4cc2-bea7-41d1-8f95-08d7a3c8fbde
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 08:06:31.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwoSsgcraQnHIROF4eBfpY8M3LIwsKTRgI7fbyA0OFgMbAvVtoA5NY6p66XpmyLvfcrGyf/OcfnaSnDOwAPtJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Olaru <paul.olaru@nxp.com>

i.MX8 and i.MX8X platforms are very similar and were treated the same.
Anyhow, we need to account for the differences somehow.

Current supported platform is i.MX8QXP which is from i.MX8X family.
Rename i.MX8 platform to i.MX8X to prepare for future i.MX8 platforms.

Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/imx/imx8.c   | 10 +++++-----
 sound/soc/sof/sof-of-dev.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index aef6ca167b9c..94481adc2240 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -138,7 +138,7 @@ static int imx8_send_msg(struct snd_sof_dev *sdev, stru=
ct snd_sof_ipc_msg *msg)
 /*
  * DSP control.
  */
-static int imx8_run(struct snd_sof_dev *sdev)
+static int imx8x_run(struct snd_sof_dev *sdev)
 {
 	struct imx8_priv *dsp_priv =3D (struct imx8_priv *)sdev->private;
 	int ret;
@@ -361,13 +361,13 @@ static struct snd_soc_dai_driver imx8_dai[] =3D {
 },
 };
=20
-/* i.MX8  ops */
-struct snd_sof_dsp_ops sof_imx8_ops =3D {
+/* i.MX8X ops */
+struct snd_sof_dsp_ops sof_imx8x_ops =3D {
 	/* probe and remove */
 	.probe		=3D imx8_probe,
 	.remove		=3D imx8_remove,
 	/* DSP core boot */
-	.run		=3D imx8_run,
+	.run		=3D imx8x_run,
=20
 	/* Block IO */
 	.block_read	=3D sof_block_read,
@@ -399,6 +399,6 @@ struct snd_sof_dsp_ops sof_imx8_ops =3D {
 			SNDRV_PCM_INFO_PAUSE |
 			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP
 };
-EXPORT_SYMBOL(sof_imx8_ops);
+EXPORT_SYMBOL(sof_imx8x_ops);
=20
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 39ea8af6213f..2da1bd859d98 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -19,9 +19,9 @@ extern struct snd_sof_dsp_ops sof_imx8_ops;
 static struct sof_dev_desc sof_of_imx8qxp_desc =3D {
 	.default_fw_path =3D "imx/sof",
 	.default_tplg_path =3D "imx/sof-tplg",
-	.default_fw_filename =3D "sof-imx8.ri",
+	.default_fw_filename =3D "sof-imx8x.ri",
 	.nocodec_tplg_filename =3D "sof-imx8-nocodec.tplg",
-	.ops =3D &sof_imx8_ops,
+	.ops =3D &sof_imx8x_ops,
 };
 #endif
=20
--=20
2.17.1

