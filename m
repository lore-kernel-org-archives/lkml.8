Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9282EC35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6916224681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TCfsrCyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgA1GDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:03:22 -0500
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:16770
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgA1GDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:03:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlblF9/7WRdavX6zT489BUX6KVAVilfCw/2GQXMde9pBTcdRqoGLONPGZ1U4b6yprYTiGQWq7/hTvjMQAj15nCgFePCO3OYOABsPNZ6XlLqNCT35QyGpNaserD+tPMTXmreMuhUo8ga4wV3jgxBTntGW/cIIvF7qiFo0dl7J5t4ppwXOzzZV90Oa9Ut+Co8bWs2ADpnXPDiWrfSvbkkUcqnWhc3rL3t4W/07V27G/pMNsKPTCY3ZTq/CpqF8RvMR9kz/8HHoOYe4xNH2HuDZVuHjwlTj4IcowqExqGLHd1dzo7YQIio1UKRNqWfkgJrfUxIfFiDMdnVh7eWwd4hyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am3QQVO4A2Q8JSmD12ha7Qy1WjL/Iw3B8FFXaDsVf1Q=;
 b=jcZuIQyYsxTdUgsn3rXgAX0WpeYUewN3hKResN1w6JKKTAvlrt1j+744IMAK7lSeP5ZEJnjd1HCdWtKzO5lnhSdhxhPmimyD5dOKKkrCwDgy13B1EU3nenYjHGiIapImXbsfNQrGPXVxct/W3mn1JtrYXfcJRe7vBEUt5XFCT0Ueumhxiv6nNZVCJutoTlXKvMHPbrNYjT1rL/ZSZQOTSFEl3T+91hlM10UHX6NX2loiDIN18mUZYcvMLkHxFDWZsXfacJWKSkObepSVzTxJ9rywKLx0yVFIpwIDL3cAYF9gu9CTCogrxXPeGukhFoJ05bK+J5h4u1SDrdHGt3xJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am3QQVO4A2Q8JSmD12ha7Qy1WjL/Iw3B8FFXaDsVf1Q=;
 b=TCfsrCyrgSVzFftGDaUmKg30rOJjrVcmlUVwifxy+SoJw2tW0ZBLsuHW4ElnSAzlAID400cLptQICc8FAlucdbzL+eRGdI3wFZREGEpWS+A1vNj2gvVXw2SMhVkcsG4GT6BJVBobWi+ljIh2bjWxTa0PG8SQHGcOO5PMGBtbOY8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5377.eurprd04.prod.outlook.com (20.178.113.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 06:03:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 06:03:18 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0087.apcprd04.prod.outlook.com (2603:1096:202:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.20 via Frontend Transport; Tue, 28 Jan 2020 06:03:14 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/2] soc: imx: increase build coverage for imx8m soc driver
Thread-Topic: [PATCH V3 2/2] soc: imx: increase build coverage for imx8m soc
 driver
Thread-Index: AQHV1aCigJa3dHmiEUaofW1PYvJuZA==
Date:   Tue, 28 Jan 2020 06:03:17 +0000
Message-ID: <1580191098-5886-3-git-send-email-peng.fan@nxp.com>
References: <1580191098-5886-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1580191098-5886-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0f90412-cef8-4f46-3f89-08d7a3b7c51d
x-ms-traffictypediagnostic: AM0PR04MB5377:|AM0PR04MB5377:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB537795F4F8D6B1D3FE0436EB880A0@AM0PR04MB5377.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2616005)(956004)(52116002)(86362001)(8936002)(8676002)(81156014)(81166006)(36756003)(64756008)(66446008)(66556008)(66476007)(44832011)(2906002)(16526019)(5660300002)(66946007)(478600001)(6486002)(110136005)(54906003)(26005)(316002)(71200400001)(6512007)(6506007)(69590400006)(186003)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5377;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1mEfX4lIYF8GlVtFXkAdv3UUndh0I61K572ZNhaSAJrfoBQ7FS3kF6YOmWvlKYFOwiGuNyqCxBZfONNnUcpQNTPdtpPdOZb9fiQjAGmPpWl09Kf1M6TgxYOq6Hldmx6c+lTAeGXQTs44gYUS5vgJXIBMk2Et1RUFTe4bwU3BTL8jmLZOahZiwdSDz+HvvdfT+qsiOjidwO9uKDZbyJwAfOgvxccrA1hcy8fl+BAQc8NsZ1dP/tsPrDChtGFlo0SIkTTaSeJnGDX80LHYrQ5dtKtD/HbbsqVvIcQboYwfVOAHNtwSB+mzKH1+p1/i6ZX92wuJJm9DX/9V097qMAWKhwIDAQkh12SB1ZtaDqEjPy9p+4IwnS1LhFvrSpPjnlH8fa3ynJLTQKAE73fvB9rfUdoI188y82+m3l8tVk1KbA0O9ctxI0asH0CrbSsBsQSmfRjVHkbUxyPDt3Zf0K8dAAk6kt3yYXqdWgE1dyABTwqr8jH7Z5mPq8QptS3ZS/HOZLTPg/DNilO7+88jpjFa1EXDOdxw5IxAdbR/Xx06RkCZpEzUrGk1hmrEpVuGxyo
x-ms-exchange-antispam-messagedata: 0Gn1R85pswAlGXV4jz4ura+j/drq60ka8VPxceP69Vxk26FX/ACqJk+O/CL0r42ZULAceSUcwWKM7xHVkI9Kv1zsPmkAXiF6pV0y2OvYyJd5Ll/qiNR9zuYM/5nrGVAsqMm9/5Kp3CN7jUweLx+xgA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f90412-cef8-4f46-3f89-08d7a3b7c51d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 06:03:17.9117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+SqGCFqsDmT+rNIHl0d6jn+h3dnzrHL2WY2zpqYJsYCBb+nKo8bf/OrV59+VGI8zcMAHH6xsd4fnoFQrTLF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The soc-imx8.c driver is actually for i.MX8M family, so rename it
to soc-imx8m.c.

Use CONFIG_SOC_IMX8M as build gate, not CONFIG_ARCH_MXC, to control
whether build this driver, also make it possible for compile test.

Default set it to y for ARCH_MXC && ARM64

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/Makefile                        | 2 +-
 drivers/soc/imx/Kconfig                     | 9 +++++++++
 drivers/soc/imx/Makefile                    | 2 +-
 drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} | 0
 4 files changed, 11 insertions(+), 2 deletions(-)
 rename drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} (100%)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 2ec355003524..614986cd1713 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_ARCH_DOVE)		+=3D dove/
 obj-$(CONFIG_MACH_DOVE)		+=3D dove/
 obj-y				+=3D fsl/
 obj-$(CONFIG_ARCH_GEMINI)	+=3D gemini/
-obj-$(CONFIG_ARCH_MXC)		+=3D imx/
+obj-y				+=3D imx/
 obj-$(CONFIG_ARCH_IXP4XX)	+=3D ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+=3D lantiq/
 obj-y				+=3D mediatek/
diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 0281ef9a1800..70019cefa617 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -17,4 +17,13 @@ config IMX_SCU_SOC
 	  Controller Unit SoC info module, it will provide the SoC info
 	  like SoC family, ID and revision etc.
=20
+config SOC_IMX8M
+	bool "i.MX8M SoC family support"
+	depends on ARCH_MXC || COMPILE_TEST
+	default ARCH_MXC && ARM64
+	help
+	  If you say yes here you get support for the NXP i.MX8M family
+	  support, it will provide the SoC info like SoC family,
+	  ID and revision etc.
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index cf9ca42ff739..103e2c93c342 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
-obj-$(CONFIG_ARCH_MXC) +=3D soc-imx8.o
+obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
 obj-$(CONFIG_IMX_SCU_SOC) +=3D soc-imx-scu.o
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8m.c
similarity index 100%
rename from drivers/soc/imx/soc-imx8.c
rename to drivers/soc/imx/soc-imx8m.c
--=20
2.16.4

