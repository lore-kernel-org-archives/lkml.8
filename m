Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84475C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E03520835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="QWcutVPM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rbqjyqcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgFKNi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:38:58 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:37343 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbgFKNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:38:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 341CF5801DA;
        Thu, 11 Jun 2020 09:38:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 09:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=KzjF/zYfZPYHT
        8af9UYnaX06cbgELFVBWlG/eyDAYlI=; b=QWcutVPMftmUFObhmTNdV2zbQ2pF6
        0UBcPIAyQ5A21IaHryKrVlHK3AYTA89PMzrtQDv5qYJ12Ef5zOuzre4iLoy8hlZt
        AeAhXsyW/arUUzF+gSeipY1nf/SzgDIlfHGxhI5V37Ebco/AIy7vpX1rsNtcvqNf
        ljsqkll9DDld3lZ+0m/VcXKDsMjaXRZMctY5idpiKE0lYK6IvM5Fn5oJ67EUW72K
        7ROC9P2wUZYJC9ucRCHpcv/0Nzjn337OI4lAgeclV1AeaLE3qbhHIGEIxVVUNLZR
        SUD4Ei8JnPppWFYB5wsAMdvX1L1HjkXf1SWprtU9/WvJbltbGqci01sxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=KzjF/zYfZPYHT8af9UYnaX06cbgELFVBWlG/eyDAYlI=; b=Rbqjyqcv
        2MrmhnyWo3gGP0vUmDdDl13m9If0rQ7XYs8thsfMHRZHCPzgrTPIhmnYU9fldw3/
        DwvMkp3PxLToUCH1VdmrLRLF0nZ70sX/yp51ccJ/hG1YwBoSJ/nFEqsN7hI1772q
        xvVyWVxGciOTOticCh17hiahZi7axazGgHNHXa8EkdiyRZS0Ruo2TLt/hsrsL5VP
        YsE/+W+Ch6dNZYJS1WL2vdpnzocI2QPrvU7MbXFUCMpHr7v7WFwOItFKLYhkayeo
        FHwQxW4GcxdBv51u0IbRzOFVL8/hSRBNmSHx278DRgk33SxQmnNrSPykBsJUbE3u
        E2UpurNSpjqGiQ==
X-ME-Sender: <xms:4zPiXh7ppYOP-V_Cf3rxRbLqbWffD7fMJUr727B8jZPZ0ZJBih7F3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:4zPiXu5Rs1ASeJO2_aRzLFpAm4tv2b2_AQ5T-fgjEY_5GvoE4Z3WQA>
    <xmx:4zPiXocOvlqWJBZhiipCyUQkv7eDzPKa3wEBzsoaVsJ-bDgNICDrIQ>
    <xmx:4zPiXqLlUB_EXNPozuFtDQOhOOJAhFe4y4UvcQ1T7NicOBaYvMneCw>
    <xmx:4zPiXqozbTb0YXVpJIPpL2SzTfs9Dh30xZIHUqtOORjEXD0ZuRAdAw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 55005328023A;
        Thu, 11 Jun 2020 09:37:04 -0400 (EDT)
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
Subject: [PATCH v4 3/9] drm/vc4: crtc: Make state functions public
Date:   Thu, 11 Jun 2020 15:36:48 +0200
Message-Id: <658f40aa01d7a45cbf6feebfc3dc6549f100d110.1591882579.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
References: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need the CRTC state related functions to be exported so that we can
reuse them for the TXP.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 21 ++++++++++-----------
 drivers/gpu/drm/vc4/vc4_drv.h  | 10 ++++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 879161841628..6e71bc13e339 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -184,7 +184,7 @@ static bool vc4_crtc_get_scanout_position(struct drm_crtc *crtc,
 	return ret;
 }
 
-static void vc4_crtc_destroy(struct drm_crtc *crtc)
+void vc4_crtc_destroy(struct drm_crtc *crtc)
 {
 	drm_crtc_cleanup(crtc);
 }
@@ -698,11 +698,11 @@ static int vc4_async_page_flip(struct drm_crtc *crtc,
 	return 0;
 }
 
-static int vc4_page_flip(struct drm_crtc *crtc,
-			 struct drm_framebuffer *fb,
-			 struct drm_pending_vblank_event *event,
-			 uint32_t flags,
-			 struct drm_modeset_acquire_ctx *ctx)
+int vc4_page_flip(struct drm_crtc *crtc,
+		  struct drm_framebuffer *fb,
+		  struct drm_pending_vblank_event *event,
+		  uint32_t flags,
+		  struct drm_modeset_acquire_ctx *ctx)
 {
 	if (flags & DRM_MODE_PAGE_FLIP_ASYNC)
 		return vc4_async_page_flip(crtc, fb, event, flags);
@@ -710,7 +710,7 @@ static int vc4_page_flip(struct drm_crtc *crtc,
 		return drm_atomic_helper_page_flip(crtc, fb, event, flags, ctx);
 }
 
-static struct drm_crtc_state *vc4_crtc_duplicate_state(struct drm_crtc *crtc)
+struct drm_crtc_state *vc4_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct vc4_crtc_state *vc4_state, *old_vc4_state;
 
@@ -726,8 +726,8 @@ static struct drm_crtc_state *vc4_crtc_duplicate_state(struct drm_crtc *crtc)
 	return &vc4_state->base;
 }
 
-static void vc4_crtc_destroy_state(struct drm_crtc *crtc,
-				   struct drm_crtc_state *state)
+void vc4_crtc_destroy_state(struct drm_crtc *crtc,
+			    struct drm_crtc_state *state)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(crtc->dev);
 	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(state);
@@ -744,8 +744,7 @@ static void vc4_crtc_destroy_state(struct drm_crtc *crtc,
 	drm_atomic_helper_crtc_destroy_state(crtc, state);
 }
 
-static void
-vc4_crtc_reset(struct drm_crtc *crtc)
+void vc4_crtc_reset(struct drm_crtc *crtc)
 {
 	if (crtc->state)
 		vc4_crtc_destroy_state(crtc, crtc->state);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 7912445dffe5..c4873ae84231 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -775,6 +775,16 @@ void vc4_bo_remove_from_purgeable_pool(struct vc4_bo *bo);
 
 /* vc4_crtc.c */
 extern struct platform_driver vc4_crtc_driver;
+void vc4_crtc_destroy(struct drm_crtc *crtc);
+int vc4_page_flip(struct drm_crtc *crtc,
+		  struct drm_framebuffer *fb,
+		  struct drm_pending_vblank_event *event,
+		  uint32_t flags,
+		  struct drm_modeset_acquire_ctx *ctx);
+struct drm_crtc_state *vc4_crtc_duplicate_state(struct drm_crtc *crtc);
+void vc4_crtc_destroy_state(struct drm_crtc *crtc,
+			    struct drm_crtc_state *state);
+void vc4_crtc_reset(struct drm_crtc *crtc);
 void vc4_crtc_handle_vblank(struct vc4_crtc *crtc);
 void vc4_crtc_txp_armed(struct drm_crtc_state *state);
 void vc4_crtc_get_margins(struct drm_crtc_state *state,
-- 
git-series 0.9.1
