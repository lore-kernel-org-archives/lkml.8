Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFA0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B495A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="EnfzrFo5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOEb5FBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgE0Ptz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:49:55 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38611 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390158AbgE0Ptr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B1F8D58202B;
        Wed, 27 May 2020 11:49:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=fXAGH/GM+q4xx
        Pbojk7X1+ICqC0tJDMsSdwLOqBucRg=; b=EnfzrFo5+LJgapqqliSv/d7wKSHku
        0lQROWzzSzXJJhdJ9gpyi6/w+yE4NgWKe0hgB5UT0ZJIK+NzTKN26A23KEkjWNgZ
        5z8hI/nbqzID8cESUr/vOY7fp33dnn4H8UVI39QJO2UYxrwLeg+HHeuFE7p7v9QC
        lt9y+ghkZgChpsvF1XPhETKr5ER9w65n1pmX9TrJ7o75ssWFUMk2IwEzmuqc5jFc
        LTmxHOpYAr+DqCJRXrfTJEn7rfISTN9VNgfopfi6Fm4oBm1q2WpFSe38kjD7CCso
        RYhI3o0Qz1iZ4V7U2Xs609rDNPSVveso1yDWzbr3HW86IeaPh7lX/dLFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=fXAGH/GM+q4xxPbojk7X1+ICqC0tJDMsSdwLOqBucRg=; b=VOEb5FBf
        t86zD31/2KvuK6PHrVUK/U7ENRoFK7pOCoV02zua5ArWoKljHfHElCnvMBMuG2J/
        NAWNWQFuqsR0Z2G7G6vqRpsb0tfug3zHr3mOcy+yp+fzdVJTi1cx0qtKwRQQISke
        8TjaTu9oB73avRPs8dwXVeuiyQJPiQpem2srK7lx8AeuTDZDMWShoa/RlhCg1rgo
        TttuaCrvCLOhc7LmduusfJeHUJO3GJ+Kf0azzeXba5b0ljY0aWj2vXoAUXx52IEK
        Y6Dzv1fpKDRBEw1wfWE1eEzc54nso1xy6ly21jbx2BHx54bXoxz7DYXxp7wyFvIG
        DnugjeDUPsgr3A==
X-ME-Sender: <xms:GozOXiYqBCh-3uK2sgCX0HpkfLjwU6NV78aD5bj6f4bq2NJS_oXDLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:GozOXlYyot6uyIvhNjWv_wWzWWw7WkF0E9YnInNn_UHYbR4E6JSDhA>
    <xmx:GozOXs8K8XabMjcWyd-Q5YXELO1tmID11lqKQ1zKh8TqoQj5dn7DLQ>
    <xmx:GozOXkoAD_LiNOU5zADBJ8My_biQ8M_3xmex5BnCrC6c_UKVDc8A5Q>
    <xmx:GozOXhL-9MxPYdX6BHM2Iy_OTyO79JzulwQPPawkYIkirc9AUTQrDw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5407C30618B7;
        Wed, 27 May 2020 11:49:46 -0400 (EDT)
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
Subject: [PATCH v3 019/105] drm/vc4: plane: Register all the planes at once
Date:   Wed, 27 May 2020 17:47:49 +0200
Message-Id: <fb819978b338de6c970d39079538f12b7258f1c5.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating planes for each CRTC, we eventually want to create all
the planes for each CRTCs.

In order to make that more convenient, let's iterate on the CRTCs in the
plane creation function instead of its caller.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.c   |  9 ++----
 drivers/gpu/drm/vc4/vc4_drv.h   |  3 +--
 drivers/gpu/drm/vc4/vc4_plane.c | 54 +++++++++++++++++-----------------
 3 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index daf07a61a7b5..ed7893ee188a 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -250,7 +250,6 @@ static int vc4_drm_bind(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm;
-	struct drm_crtc *crtc;
 	struct vc4_dev *vc4;
 	struct device_node *node;
 	int ret = 0;
@@ -289,11 +288,9 @@ static int vc4_drm_bind(struct device *dev)
 	if (ret)
 		goto gem_destroy;
 
-	drm_for_each_crtc(crtc, drm) {
-		ret = vc4_plane_create_additional_planes(drm, crtc);
-		if (ret)
-			continue;
-	}
+	ret = vc4_plane_create_additional_planes(drm);
+	if (ret)
+		goto unbind_all;
 
 	drm_fb_helper_remove_conflicting_framebuffers(NULL, "vc4drmfb", false);
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index b43514901bb9..80633c488b04 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -855,8 +855,7 @@ int vc4_kms_load(struct drm_device *dev);
 /* vc4_plane.c */
 struct drm_plane *vc4_plane_init(struct drm_device *dev,
 				 enum drm_plane_type type);
-int vc4_plane_create_additional_planes(struct drm_device *dev,
-				       struct drm_crtc *crtc);
+int vc4_plane_create_additional_planes(struct drm_device *dev);
 u32 vc4_plane_write_dlist(struct drm_plane *plane, u32 __iomem *dlist);
 u32 vc4_plane_dlist_size(const struct drm_plane_state *state);
 void vc4_plane_async_set_fb(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 89d03605332e..824c188980b0 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1372,39 +1372,41 @@ struct drm_plane *vc4_plane_init(struct drm_device *dev,
 	return plane;
 }
 
-int vc4_plane_create_additional_planes(struct drm_device *drm,
-				       struct drm_crtc *crtc)
+int vc4_plane_create_additional_planes(struct drm_device *drm)
 {
 	struct drm_plane *cursor_plane;
+	struct drm_crtc *crtc;
 	unsigned int i;
 
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
+	drm_for_each_crtc(crtc, drm) {
+		/* Set up some arbitrary number of planes.  We're not limited
+		 * by a set number of physical registers, just the space in
+		 * the HVS (16k) and how small an plane can be (28 bytes).
+		 * However, each plane we set up takes up some memory, and
+		 * increases the cost of looping over planes, which atomic
+		 * modesetting does quite a bit.  As a result, we pick a
+		 * modest number of planes to expose, that should hopefully
+		 * still cover any sane usecase.
+		 */
+		for (i = 0; i < 8; i++) {
+			struct drm_plane *plane =
+				vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY);
 
-		if (IS_ERR(plane))
-			continue;
+			if (IS_ERR(plane))
+				continue;
 
-		plane->possible_crtcs = drm_crtc_mask(crtc);
-	}
+			plane->possible_crtcs = drm_crtc_mask(crtc);
+		}
 
-	/* Set up the legacy cursor after overlay initialization,
-	 * since we overlay planes on the CRTC in the order they were
-	 * initialized.
-	 */
-	cursor_plane = vc4_plane_init(drm, DRM_PLANE_TYPE_CURSOR);
-	if (!IS_ERR(cursor_plane)) {
-		cursor_plane->possible_crtcs = drm_crtc_mask(crtc);
-		crtc->cursor = cursor_plane;
+		/* Set up the legacy cursor after overlay initialization,
+		 * since we overlay planes on the CRTC in the order they were
+		 * initialized.
+		 */
+		cursor_plane = vc4_plane_init(drm, DRM_PLANE_TYPE_CURSOR);
+		if (!IS_ERR(cursor_plane)) {
+			cursor_plane->possible_crtcs = drm_crtc_mask(crtc);
+			crtc->cursor = cursor_plane;
+		}
 	}
 
 	return 0;
-- 
git-series 0.9.1
