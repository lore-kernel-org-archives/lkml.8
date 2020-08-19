Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41B1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD114206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgHSKMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:12:46 -0400
Received: from mail.v3.sk ([167.172.186.51]:51760 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727811AbgHSKMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:12:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 13571DEE69;
        Wed, 19 Aug 2020 10:11:25 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pcraDX_E9eNT; Wed, 19 Aug 2020 10:11:24 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 27933DFA72;
        Wed, 19 Aug 2020 10:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4-cUkoOugQ41; Wed, 19 Aug 2020 10:11:23 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6C0D5DFA71;
        Wed, 19 Aug 2020 10:11:23 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] drm/panel: simple: Add support for Innolux LS075AT011
Date:   Wed, 19 Aug 2020 12:12:06 +0200
Message-Id: <20200819101206.633253-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819101206.633253-1-lkundrak@v3.sk>
References: <20200819101206.633253-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Innolux LS075AT011 7.5" 1200x900 panel. There's
no public data sheet for the panel -- the values have been taken from Ope=
n
Firmware and the documentation for the display controller that drives
the panel and tested on the OLPC laptop.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
index cb6550d37e858..dfc69457ed2d4 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2121,6 +2121,30 @@ static const struct panel_desc innolux_g121x1_l03 =
=3D {
 	},
 };
=20
+static const struct display_timing innolux_ls075at011_timing =3D {
+	.pixelclock =3D { 56000000, 57000000, 58000000 },
+	.hactive =3D { 1200, 1200, 1200 },
+	.hfront_porch =3D { 26, 26, 26 },
+	.hback_porch =3D { 24, 24, 24 },
+	.hsync_len =3D { 6, 6, 6 },
+	.vactive =3D { 900, 900, 900 },
+	.vfront_porch =3D { 4, 4, 4 },
+	.vback_porch =3D { 5, 5, 5 },
+	.vsync_len =3D { 3, 3, 3 },
+	.flags =3D DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
+};
+
+static const struct panel_desc innolux_ls075at011 =3D {
+	.timings =3D &innolux_ls075at011_timing,
+	.num_timings =3D 1,
+	.bpc =3D 8,
+	.size =3D {
+		.width =3D 152,
+		.height =3D 115,
+	},
+	.connector_type =3D DRM_MODE_CONNECTOR_LVDS,
+};
+
 /*
  * Datasheet specifies that at 60 Hz refresh rate:
  * - total horizontal time: { 1506, 1592, 1716 }
@@ -3907,6 +3931,9 @@ static const struct of_device_id platform_of_match[=
] =3D {
 	}, {
 		.compatible =3D "innolux,g121x1-l03",
 		.data =3D &innolux_g121x1_l03,
+	}, {
+		.compatible =3D "innolux,ls075at011",
+		.data =3D &innolux_ls075at011,
 	}, {
 		.compatible =3D "innolux,n116bge",
 		.data =3D &innolux_n116bge,
--=20
2.26.2

