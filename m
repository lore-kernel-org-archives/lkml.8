Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD69C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC0722522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="YS1TRkF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgAOMeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:34:23 -0500
Received: from mail-eopbgr40123.outbound.protection.outlook.com ([40.107.4.123]:20855
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbgAOMeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:34:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPkitwXeq5gtzrJiwUWCePD0dHk8iZbesASdVZTzOuM1dyI2aoqC4JpoeSwfzVzVnGGiKO++92RXM4rW4TRHNXQG6077YB+MDt/HC5Tb1cwNqya8UUXJH/cj7MUzVp6YIUs7oJsALRPb+6Z+RKgYZLdPCZos+FaDELL5HIlGc92BBM8aqFSjlWGkKwbu97p4RV9Wn0SFaoufbJgCtDnNILagN50gf7wh66vcwJlqLtAoxtJ8z+eYUTx+eoMBEbcj+QdSIN8B2MA5u8LSwXFvcNbOmmOmKf5q0fKZSQNrKV8YTMAxSAKO7he4pSG9uISNG6yxdptlGNVGuW4OXx59xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhzgeekTeIyC3wHMea3JEChJ2M8PtFHfhPKBkE45lgk=;
 b=ONhoy1pBMs+B9ScYi1D8h6yBknwiiFJvtDmxV4o4kmDywchgFN6GH5DoaIhFmKwfdkBx9Iva/7MSe4U6nOkC9yGybRpsQVY1Mn4NyzDbLRPTj6jIpb+w3pImYVDKwy6ACH4tuH2yBRdq9MKVRcFigZvewwzdsZ05A48qEfsWRLGyJwmu3wWFtqY4LPQeGTEHDuO4NcWJpklCX2ECEMGcFrH7YMf4csnhcYv1eZYlKjJwydCzQLa6bta6ZaqRhNKjBe8lLZqbRJ6eTVCYIGeus8Tq1vXRLDS9XEeCzNTZ0z2lQ3UIioxfI5Ot/OLy1AyMDGpN/1/AjkTW88npyBLRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhzgeekTeIyC3wHMea3JEChJ2M8PtFHfhPKBkE45lgk=;
 b=YS1TRkF27Anx1WAYGqdrYXN4huQBgZJMxVzmbi5QRdejPEGawDhWLveBPTPQ7iQH+MEzbfEfa/YrGJH0BVBWMBcYFr6VYEd28ZqTYxPjyU2I/R/VLFVEOEQj0ujERSeTMlw0F75zqKt0vB3gDq/5/vGavHjngLXJh8Meqgu3Xws=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 AM6SPR01MB0060.eurprd05.prod.outlook.com (10.255.22.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 12:34:17 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 12:34:17 +0000
Received: from localhost (194.105.145.90) by PR0P264CA0107.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 12:34:17 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Igor Opanyuk <igor.opanyuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/panel: make LVDS panel driver DPI capable
Thread-Topic: [PATCH 1/3] drm/panel: make LVDS panel driver DPI capable
Thread-Index: AQHVy6AaSAxSVrzF8Em1sZu2z5QUEg==
Date:   Wed, 15 Jan 2020 12:34:17 +0000
Message-ID: <20200115123401.2264293-2-oleksandr.suvorov@toradex.com>
References: <20200115123401.2264293-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20200115123401.2264293-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0107.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::23) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 993dc99c-9d21-4bf4-fa20-08d799b73cbd
x-ms-traffictypediagnostic: AM6SPR01MB0060:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6SPR01MB0060F1371051F621FE064BF8F9370@AM6SPR01MB0060.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(54906003)(52116002)(6496006)(6916009)(81156014)(316002)(66556008)(64756008)(8676002)(66446008)(66946007)(86362001)(71200400001)(44832011)(66476007)(4326008)(36756003)(16526019)(26005)(478600001)(2906002)(5660300002)(81166006)(8936002)(186003)(1076003)(6486002)(956004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6SPR01MB0060;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7bbg2GWQgngpzZ8EwcvH3+zSCq1oBfHdzqF58yg17+7uSvhIIhREyjEnpTch6vpxz1jJ0K5M6/EGgjbFAqrtUDG87QNKRJCpfn4iSXk0qv3ceOgIySzG7NBxyMYjMXRlgwcsbc00DhUwgtumnjf1oKgjnZuY4l9YRTYmioQRwIHjiyc0FwJv3Bkm13iTc6qU08uK+VBuo3jXhYdVuA+ns0de+EMCM9riBrRGer8HzBYeBtTkT33WsDYsj6BMrx76slo/8FHgP7ZNLbZxT1bxENkNGY/zHA7XIBPzGTp5JIwdx1RfxUiI70HCbC25PKm9qowHlfzCTRq5EJ8mm7ovC/pr0DP3Py5n/Ih0K7aXJVDoGg1eI15iC/Yj4sRKbmD4T59xQ/GqX9fiRiROoCwfTUGwY2ciIoR0AKYBbbhLNwjzeKrYLk0927P9QZD5cl7/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993dc99c-9d21-4bf4-fa20-08d799b73cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 12:34:17.6061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/Chl03QnR//EsuJdqDkioU5d+cIdLEV+RvjZZNAH17C/vg8du1GcZuoTfJjbv1y4TaEmzNiPRDXy7HqMJUDCNXRqd41iLrq2rcIVlYyyDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

The LVDS panel driver has almost everything which is required to
describe a simple parallel RGB panel (also known as DPI, Display
Pixel Interface).

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 drivers/gpu/drm/panel/panel-lvds.c | 40 +++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/pan=
el-lvds.c
index 5ce3f4a2b7a1..21a169aa3ae4 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -22,6 +22,11 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_panel.h>
=20
+enum panel_type {
+	PANEL_LVDS,
+	PANEL_DPI
+};
+
 struct panel_lvds {
 	struct drm_panel panel;
 	struct device *dev;
@@ -115,6 +120,7 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 	struct display_timing timing;
 	const char *mapping;
 	int ret;
+	enum panel_type type;
=20
 	ret =3D of_get_display_timing(np, "panel-timing", &timing);
 	if (ret < 0) {
@@ -147,13 +153,28 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvd=
s)
 		return -ENODEV;
 	}
=20
-	if (!strcmp(mapping, "jeida-18")) {
-		lvds->bus_format =3D MEDIA_BUS_FMT_RGB666_1X7X3_SPWG;
-	} else if (!strcmp(mapping, "jeida-24")) {
-		lvds->bus_format =3D MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
-	} else if (!strcmp(mapping, "vesa-24")) {
-		lvds->bus_format =3D MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
-	} else {
+	type =3D (enum panel_type)of_device_get_match_data(lvds->dev);
+	switch (type) {
+	case PANEL_LVDS:
+		if (!strcmp(mapping, "jeida-18"))
+			lvds->bus_format =3D MEDIA_BUS_FMT_RGB666_1X7X3_SPWG;
+		else if (!strcmp(mapping, "jeida-24"))
+			lvds->bus_format =3D MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
+		else if (!strcmp(mapping, "vesa-24"))
+			lvds->bus_format =3D MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
+		break;
+	case PANEL_DPI:
+		if (!strcmp(mapping, "rgb24"))
+			lvds->bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
+		else if (!strcmp(mapping, "rgb565"))
+			lvds->bus_format =3D MEDIA_BUS_FMT_RGB565_1X16;
+		else if (!strcmp(mapping, "bgr666"))
+			lvds->bus_format =3D MEDIA_BUS_FMT_RGB666_1X18;
+		else if (!strcmp(mapping, "lvds666"))
+			lvds->bus_format =3D MEDIA_BUS_FMT_RGB666_1X24_CPADHI;
+	};
+
+	if (!lvds->bus_format) {
 		dev_err(lvds->dev, "%pOF: invalid or missing %s DT property\n",
 			np, "data-mapping");
 		return -EINVAL;
@@ -247,7 +268,8 @@ static int panel_lvds_remove(struct platform_device *pd=
ev)
 }
=20
 static const struct of_device_id panel_lvds_of_table[] =3D {
-	{ .compatible =3D "panel-lvds", },
+	{ .compatible =3D "panel-lvds", .data =3D (void *)PANEL_LVDS },
+	{ .compatible =3D "panel-dpi", .data =3D (void *)PANEL_DPI },
 	{ /* Sentinel */ },
 };
=20
@@ -257,7 +279,7 @@ static struct platform_driver panel_lvds_driver =3D {
 	.probe		=3D panel_lvds_probe,
 	.remove		=3D panel_lvds_remove,
 	.driver		=3D {
-		.name	=3D "panel-lvds",
+		.name	=3D "panel-generic",
 		.of_match_table =3D panel_lvds_of_table,
 	},
 };
--=20
2.24.1

