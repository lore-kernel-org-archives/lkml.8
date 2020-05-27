Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F60AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E0320873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="x/1ORGoT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TGkzH4nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390175AbgE0Ptw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:49:52 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38611 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390149AbgE0Pto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A6C7B582020;
        Wed, 27 May 2020 11:49:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=gDst8pSlUcWHc
        EnrYJS9Z/70ORiXIttU9dJbHxYUVKA=; b=x/1ORGoTDi9ZisYWj+hK3m80HjHb9
        CmkUoFCmek6ro3cw04MQg6zAD2hwylmHY5CZnLEyuMQiQFQC1rQ11tfBKJI0T3kw
        X/8edq7tRmeiKx6y+kQkAFcw4UkGyBQ1mFB2ahshHVojNlzw2JH6mES9FaTPx1XO
        E0boR6DmFizdUrIwAFL5y+pudC4+j+5E8JKGRKRFJp6yVrbLHpQHiRwlwCf96qPg
        eR9JY9X4JdhxaEo8uvhL9xshcvGzzwMCT34Smv6WtZzj4waDz9Hq7wrlty684LML
        TtJsPtjuZtauRyUxW/r5kbw3qrXBC4L9Qv6nCbyUCgEThohDPSfAZqXjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=gDst8pSlUcWHcEnrYJS9Z/70ORiXIttU9dJbHxYUVKA=; b=TGkzH4nD
        VPX92C36eEK6o2jlIjIrEzhOrN60mU7lpWyYA/pSayd5oU0yy79tIJMLImdXP7/x
        +6y8z+58mtlkSyUQjrEiBvbKMH751EXeyGZeDiwsR5OmY/dTnF0gqhapfgyfBUu5
        tPywtTa425bPuQjfipLMgDHco+PdM4P6XHJPdvnupaAWGgEIsht27KOkgvk/nhZQ
        2RKPFuE3FSeps/qRgsuhzh1AC4nAQgHw+v7Lh1DwL2daA8k1u6nRa2MhzM7fWQAP
        +x8MlTZ7e5laWerdpB/gHbu2ZzXk9dVzanvz97+rvWWmLb5V2bxA7B0Wnsk9WC6k
        bt9WKkcLl+ckDA==
X-ME-Sender: <xms:F4zOXqTEEPaMsNxlG4QrMenUFg-VcDCaUg7Op_RDIMthZ_jxdar0gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:F4zOXvwt9ZwfEPRpLQefY9q2i51k5xlsLKL08x0yo_nGV8wCT3s8Sg>
    <xmx:F4zOXn1UZf8TgCFWpJq5QZAdlpV2TPqdkR-cCGB7InQCr2ueJK2Hng>
    <xmx:F4zOXmCzLFasZJ0HzYZddwphSzatQINu3p-MtSUrUaZoigGaWF1L5g>
    <xmx:F4zOXjgvNg0Lj0tVCIK9k9dEUjGSQO3RMFdhT9JEKNuFsatdSKiuuA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4626830618B7;
        Wed, 27 May 2020 11:49:43 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 017/105] drm/vc4: plane: Move planes creation to its own function
Date:   Wed, 27 May 2020 17:47:47 +0200
Message-Id: <a378ea56214179f1f25fcd36ecc69511edd1e790.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The planes so far were created as part of the CRTC binding code with
each planes created associated only to one CRTC. However, the hardware
in the vc4 doesn't really have such constraint and can be used with any
CRTC.

In order to rework this, let's first move the overlay and cursor planes
creation to a function of its own.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c  | 33 +++---------------------------
 drivers/gpu/drm/vc4/vc4_drv.h   |  2 ++-
 drivers/gpu/drm/vc4/vc4_plane.c | 38 ++++++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 591a10ae1950..29c72c322c6b 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1144,7 +1144,7 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm = dev_get_drvdata(master);
 	struct vc4_crtc *vc4_crtc;
 	struct drm_crtc *crtc;
-	struct drm_plane *primary_plane, *cursor_plane, *destroy_plane, *temp;
+	struct drm_plane *primary_plane, *destroy_plane, *temp;
 	const struct of_device_id *match;
 	int ret, i;
 
@@ -1192,34 +1192,9 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	 */
 	drm_crtc_enable_color_mgmt(crtc, 0, true, crtc->gamma_size);
 
-	/* Set up some arbitrary number of planes.  We're not limited
-	 * by a set number of physical registers, just the space in
-	 * the HVS (16k) and how small an plane can be (28 bytes).
-	 * However, each plane we set up takes up some memory, and
-	 * increases the cost of looping over planes, which atomic
-	 * modesetting does quite a bit.  As a result, we pick a
-	 * modest number of planes to expose, that should hopefully
-	 * still cover any sane usecase.
-	 */
-	for (i = 0; i < 8; i++) {
-		struct drm_plane *plane =
-			vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY);
-
-		if (IS_ERR(plane))
-			continue;
-
-		plane->possible_crtcs = drm_crtc_mask(crtc);
-	}
-
-	/* Set up the legacy cursor after overlay initialization,
-	 * since we overlay planes on the CRTC in the order they were
-	 * initialized.
-	 */
-	cursor_plane = vc4_plane_init(drm, DRM_PLANE_TYPE_CURSOR);
-	if (!IS_ERR(cursor_plane)) {
-		cursor_plane->possible_crtcs = drm_crtc_mask(crtc);
-		crtc->cursor = cursor_plane;
-	}
+	ret = vc4_plane_create_additional_planes(drm, crtc);
+	if (ret)
+		goto err_destroy_planes;
 
 	vc4_crtc_get_cob_allocation(vc4_crtc);
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 9b57ea2ba93f..b43514901bb9 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -855,6 +855,8 @@ int vc4_kms_load(struct drm_device *dev);
 /* vc4_plane.c */
 struct drm_plane *vc4_plane_init(struct drm_device *dev,
 				 enum drm_plane_type type);
+int vc4_plane_create_additional_planes(struct drm_device *dev,
+				       struct drm_crtc *crtc);
 u32 vc4_plane_write_dlist(struct drm_plane *plane, u32 __iomem *dlist);
 u32 vc4_plane_dlist_size(const struct drm_plane_state *state);
 void vc4_plane_async_set_fb(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 602927745f84..89d03605332e 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1371,3 +1371,41 @@ struct drm_plane *vc4_plane_init(struct drm_device *dev,
 
 	return plane;
 }
+
+int vc4_plane_create_additional_planes(struct drm_device *drm,
+				       struct drm_crtc *crtc)
+{
+	struct drm_plane *cursor_plane;
+	unsigned int i;
+
+	/* Set up some arbitrary number of planes.  We're not limited
+	 * by a set number of physical registers, just the space in
+	 * the HVS (16k) and how small an plane can be (28 bytes).
+	 * However, each plane we set up takes up some memory, and
+	 * increases the cost of looping over planes, which atomic
+	 * modesetting does quite a bit.  As a result, we pick a
+	 * modest number of planes to expose, that should hopefully
+	 * still cover any sane usecase.
+	 */
+	for (i = 0; i < 8; i++) {
+		struct drm_plane *plane =
+			vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY);
+
+		if (IS_ERR(plane))
+			continue;
+
+		plane->possible_crtcs = drm_crtc_mask(crtc);
+	}
+
+	/* Set up the legacy cursor after overlay initialization,
+	 * since we overlay planes on the CRTC in the order they were
+	 * initialized.
+	 */
+	cursor_plane = vc4_plane_init(drm, DRM_PLANE_TYPE_CURSOR);
+	if (!IS_ERR(cursor_plane)) {
+		cursor_plane->possible_crtcs = drm_crtc_mask(crtc);
+		crtc->cursor = cursor_plane;
+	}
+
+	return 0;
+}
-- 
git-series 0.9.1
