Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF83C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD0C20678
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgAKBHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 20:07:43 -0500
Received: from [167.172.186.51] ([167.172.186.51]:42370 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727862AbgAKBHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 20:07:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3300CDFDFC;
        Sat, 11 Jan 2020 01:07:47 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8kCThNlZmmB8; Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C2993DFE01;
        Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AnlUCaXlPKcH; Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5A4B6DFCD9;
        Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 2/3] drm/armada: optionally enable the peripheral clock
Date:   Sat, 11 Jan 2020 02:07:33 +0100
Message-Id: <20200111010734.286836-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111010734.286836-1-lkundrak@v3.sk>
References: <20200111010734.286836-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It needs to be enabled (at least on MMP2) in order for the register
writes to LCDC to work.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/gpu/drm/armada/armada_crtc.c | 7 +++++++
 drivers/gpu/drm/armada/armada_crtc.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armad=
a/armada_crtc.c
index da9ba8be8b097..0f343bf584c8c 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -772,6 +772,7 @@ static void armada_drm_crtc_destroy(struct drm_crtc *=
crtc)
=20
 	of_node_put(dcrtc->crtc.port);
=20
+	clk_disable_unprepare(dcrtc->periphclk);
 	kfree(dcrtc);
 }
=20
@@ -928,6 +929,11 @@ static int armada_drm_crtc_create(struct drm_device =
*drm, struct device *dev,
 	dcrtc->clk =3D ERR_PTR(-EINVAL);
 	dcrtc->spu_iopad_ctrl =3D CFG_VSCALE_LN_EN | CFG_IOPAD_DUMB24;
=20
+	dcrtc->periphclk =3D devm_clk_get(dev, "periph");
+	if (IS_ERR(dcrtc->periphclk))
+		dcrtc->periphclk =3D NULL;
+	WARN_ON(clk_prepare_enable(dcrtc->periphclk));
+
 	endpoint =3D of_get_next_child(port, NULL);
 	of_property_read_u32(endpoint, "bus-width", &bus_width);
 	of_node_put(endpoint);
@@ -1015,6 +1021,7 @@ static int armada_drm_crtc_create(struct drm_device=
 *drm, struct device *dev,
 err_crtc_init:
 	primary->funcs->destroy(primary);
 err_crtc:
+	clk_disable_unprepare(dcrtc->periphclk);
 	kfree(dcrtc);
=20
 	return ret;
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armad=
a/armada_crtc.h
index b21267d1745f1..48fc974a65808 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -39,6 +39,7 @@ struct armada_crtc {
 	void			*variant_data;
 	unsigned		num;
 	void __iomem		*base;
+	struct clk		*periphclk;
 	struct clk		*clk;
 	struct {
 		uint32_t	spu_v_h_total;
--=20
2.24.1

