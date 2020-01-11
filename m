Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920AAC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F4B20678
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgAKBHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 20:07:42 -0500
Received: from [167.172.186.51] ([167.172.186.51]:42354 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727864AbgAKBHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 20:07:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D273FDFDFA;
        Sat, 11 Jan 2020 01:07:46 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aNZD6b0bpy-r; Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7972FDFDFC;
        Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4Q2aoFcT2k_i; Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 17BC5DFDFA;
        Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 1/3] drm/armada: add bus-width property to the output endpoint
Date:   Sat, 11 Jan 2020 02:07:32 +0100
Message-Id: <20200111010734.286836-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111010734.286836-1-lkundrak@v3.sk>
References: <20200111010734.286836-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to choose a different pixel format for the
endpoint. Modelled after what other LCD controllers use, including
marvell,pxa2xx-lcdc and atmel,hlcdc-display-controller and perhaps more.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/gpu/drm/armada/armada_crtc.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armad=
a/armada_crtc.c
index c2b92acd1e9ad..da9ba8be8b097 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -904,6 +904,8 @@ static int armada_drm_crtc_create(struct drm_device *=
drm, struct device *dev,
 	struct armada_private *priv =3D drm->dev_private;
 	struct armada_crtc *dcrtc;
 	struct drm_plane *primary;
+	struct device_node *endpoint;
+	u32 bus_width =3D 24;
 	void __iomem *base;
 	int ret;
=20
@@ -923,8 +925,31 @@ static int armada_drm_crtc_create(struct drm_device =
*drm, struct device *dev,
 	dcrtc->variant =3D variant;
 	dcrtc->base =3D base;
 	dcrtc->num =3D drm->mode_config.num_crtc;
-	dcrtc->cfg_dumb_ctrl =3D DUMB24_RGB888_0;
+	dcrtc->clk =3D ERR_PTR(-EINVAL);
 	dcrtc->spu_iopad_ctrl =3D CFG_VSCALE_LN_EN | CFG_IOPAD_DUMB24;
+
+	endpoint =3D of_get_next_child(port, NULL);
+	of_property_read_u32(endpoint, "bus-width", &bus_width);
+	of_node_put(endpoint);
+
+	switch (bus_width) {
+	case 12:
+		dcrtc->cfg_dumb_ctrl =3D DUMB12_RGB444_0;
+		break;
+	case 16:
+		dcrtc->cfg_dumb_ctrl =3D DUMB16_RGB565_0;
+		break;
+	case 18:
+		dcrtc->cfg_dumb_ctrl =3D DUMB18_RGB666_0;
+		break;
+	case 24:
+		dcrtc->cfg_dumb_ctrl =3D DUMB24_RGB888_0;
+		break;
+	default:
+		DRM_ERROR("unsupported bus width: %d\n", bus_width);
+		return -EINVAL;
+	}
+
 	spin_lock_init(&dcrtc->irq_lock);
 	dcrtc->irq_ena =3D CLEAN_SPU_IRQ_ISR;
=20
--=20
2.24.1

