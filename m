Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE79AC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C762072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YkAbiYxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgAQD2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:28:40 -0500
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:38359
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727015AbgAQD2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:28:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfbwxUh7hOHO8O2aejxQz5Cfb0fSyOmABbXu9WKwWO+7cg1q9L/eRIqxkLP+SdDNZW9N2cO2ao0ABiWQjeFKNhiT5AkMgsodJSmbYE1WbtltPGFxFnKhbVgBSmzL90WXkfNyD1HE/I/DLIs0Y5q2iriHLEdyXKkrj4Wu708IRbENMWthIZNHeSo6Y5nSlPND0tbHxAvQS2BT9QdVn3yAQlUlwsYthOHgW1LWAv4+52NIHsxGvUyO9seRxP8KL+POfSnmoYrW+nohPGYJD+ymZGNSLXUouNfPaXtkWxdx1xPZ2t1L+u/4BNUndSsjZQz8W3S0d97QuH+jvqTy6GdWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//8jhs7rs+O9Gw3wNQH5NyAluIcKlNz04jBJ9uUMdes=;
 b=F50NOCr9MeWwew+IGtsxG57aJktrJFGvhQvoGMm3yw166ZK9JmlTDiFy6+pH4+JFu3unzlU3pUlqXrL4ozjuRRakMXDBRZ1ztjtkC3/HP6+YuqJEHqJB+ya7wMX2tL+OwNNFSzCVqiCMvjulVNeshZCEWSyg9zNMcsNM3Gh4PP6vFm0GWrmckHSuTOOkp0fTeUQJPi39Wrhe7L2J0MRgEmMtNhCejjmuZln7A+X3Mz7Q/m3WG4Q/PKXPF1httlr+n/CiWX30p/uZiN4yb0bRtaOTIfk8z0Tdt6UjD3f76qSrjfsdJXAuxaErro2Hmp8ekiqSsgoyUQ8qzMA2i+X9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//8jhs7rs+O9Gw3wNQH5NyAluIcKlNz04jBJ9uUMdes=;
 b=YkAbiYxFyto8tIXot3nqGdQ+iR7XpLXZRrhFG6KhaLbH8HYyvDe3VQLp42HVDZ5BrYELmgGim4mUCGzlHfLWJ3mONvGbAULVAPN+t1zdlN5To16N+IuW/F9ABKGeac3DWXOQX1fcCBRCAof6+ITe1/zItR2RgoQZ3/1GqqoLaes=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5987.eurprd04.prod.outlook.com (20.178.114.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Fri, 17 Jan 2020 03:28:33 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Fri, 17 Jan 2020
 03:28:33 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0005.apcprd06.prod.outlook.com (2603:1096:202:2e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.18 via Frontend Transport; Fri, 17 Jan 2020 03:28:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] nvmem: imx: ocotp: add i.MX8MP support
Thread-Topic: [PATCH] nvmem: imx: ocotp: add i.MX8MP support
Thread-Index: AQHVzOYys8WB3+BLO0KUDipX7ftHWA==
Date:   Fri, 17 Jan 2020 03:28:33 +0000
Message-ID: <1579231433-14201-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:202:2e::17) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78393aa3-4716-4117-9bc3-08d79afd5481
x-ms-traffictypediagnostic: AM0PR04MB5987:|AM0PR04MB5987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5987DAEDB2237407A6B0423188310@AM0PR04MB5987.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(44832011)(81166006)(8936002)(71200400001)(86362001)(316002)(69590400006)(110136005)(956004)(6506007)(6512007)(8676002)(52116002)(81156014)(16526019)(4326008)(5660300002)(6486002)(26005)(54906003)(2616005)(64756008)(66946007)(186003)(66476007)(36756003)(478600001)(66556008)(2906002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5987;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZgnkBHC2U40WrIkCms9WvdnySYh8zhQI8nux+9YE2mcIglc9tgXDCapinFrQkNeiP+BOgnpO5Qf8NfW1djF+XgecCAjwcFiICvguYhUr/gnUA6JqiruNSk/41r7DVotQZGYwMHhu6quNTmRFck8JYrXEMkG8MGaDOLkUg5ov9ybbGROXnbaABey/UJgC+lEnsdJe7GbYfFeS16zfDXk2VYSpBwpT6yEJoXq4sKjTU0fLKO/y5jZAeXc9puhdXkLoOrCwoCPQGhxjP8jqoD0xmSpx8KBImDLgq6fwTI/xwAYozs9VB6+M64SBc2JT1nDfvD5iwDEn0yvDS4lDVAvbFsEnNwCoezAWUJtWvSjw7WxIyrzXSlA0eMBXRLkUDuQh9PRXG1D3XkhwjnxyuObvPsUAWluO+D7OahbmQxy/+XsBw736BJHLvSKKFFs6Jp0JuI8GvIpHDOUlWZ/iURUY6qgS6fO5vqz7cweS+TAbJ+zE+PIxntbqhhyqEGfENcZ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78393aa3-4716-4117-9bc3-08d79afd5481
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 03:28:33.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0fYWZ2QxsrgkjrGEaRernDON8Bg0+U9GL0htN+EXPUonHLjkcDcIl7idwoosEkiuxOm7nqrisQV0MYtFmYp5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP has 96 banks with each bank 4 words. And it has different
ctrl register layout, so add new macros for that.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

dt-bindings doc has been posted by Anson Huang

 drivers/nvmem/imx-ocotp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 4ba9cc8f76df..794858093086 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -44,6 +44,11 @@
 #define IMX_OCOTP_BM_CTRL_ERROR		0x00000200
 #define IMX_OCOTP_BM_CTRL_REL_SHADOWS	0x00000400
=20
+#define IMX_OCOTP_BM_CTRL_ADDR_8MP		0x000001FF
+#define IMX_OCOTP_BM_CTRL_BUSY_8MP		0x00000200
+#define IMX_OCOTP_BM_CTRL_ERROR_8MP		0x00000400
+#define IMX_OCOTP_BM_CTRL_REL_SHADOWS_8MP	0x00000800
+
 #define IMX_OCOTP_BM_CTRL_DEFAULT				\
 	{							\
 		.bm_addr =3D IMX_OCOTP_BM_CTRL_ADDR,		\
@@ -52,6 +57,14 @@
 		.bm_rel_shadows =3D IMX_OCOTP_BM_CTRL_REL_SHADOWS,\
 	}
=20
+#define IMX_OCOTP_BM_CTRL_8MP					\
+	{							\
+		.bm_addr =3D IMX_OCOTP_BM_CTRL_ADDR_8MP,		\
+		.bm_busy =3D IMX_OCOTP_BM_CTRL_BUSY_8MP,		\
+		.bm_error =3D IMX_OCOTP_BM_CTRL_ERROR_8MP,	\
+		.bm_rel_shadows =3D IMX_OCOTP_BM_CTRL_REL_SHADOWS_8MP,\
+	}
+
 #define TIMING_STROBE_PROG_US		10	/* Min time to blow a fuse */
 #define TIMING_STROBE_READ_NS		37	/* Min time before read */
 #define TIMING_RELAX_NS			17
@@ -520,6 +533,13 @@ static const struct ocotp_params imx8mn_params =3D {
 	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
+static const struct ocotp_params imx8mp_params =3D {
+	.nregs =3D 384,
+	.bank_address_words =3D 0,
+	.set_timing =3D imx_ocotp_set_imx6_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_8MP,
+};
+
 static const struct of_device_id imx_ocotp_dt_ids[] =3D {
 	{ .compatible =3D "fsl,imx6q-ocotp",  .data =3D &imx6q_params },
 	{ .compatible =3D "fsl,imx6sl-ocotp", .data =3D &imx6sl_params },
@@ -532,6 +552,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] =3D=
 {
 	{ .compatible =3D "fsl,imx8mq-ocotp", .data =3D &imx8mq_params },
 	{ .compatible =3D "fsl,imx8mm-ocotp", .data =3D &imx8mm_params },
 	{ .compatible =3D "fsl,imx8mn-ocotp", .data =3D &imx8mn_params },
+	{ .compatible =3D "fsl,imx8mp-ocotp", .data =3D &imx8mp_params },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
--=20
2.16.4

