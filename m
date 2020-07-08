Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7867EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1E6206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="lHwVohXF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sRjgkaBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGHRnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:43:09 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:58063 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbgGHRnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 2F06F333;
        Wed,  8 Jul 2020 13:42:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=V6hB5OZI4p8WU
        lDnHuuNH5BlEZyzxuf5+jlrv9rSDoo=; b=lHwVohXF5wG+1OhbQYRmmKZt0YaSb
        /SItRNMFeUNlBbthzyVnB0Y+/78qf4HWzIMujbnwLodGK5s8s35UTl07eE4UGn4G
        zLbKWBnM5bYDcfwk1C/51SM1xjCCpbHSGJLA2vtE28JWe0jhtH93ziE4P6QprKzb
        512/XAR3EEslFLHj3z8p6oJDRc7SzxPsj1HeBtilJ4zDO+KRbq3AVE0YhfndrMVW
        7n+UhSrJuYsw3PRgIWTDh04UP38trzrbYraodFH4Mj1HRjkv5PQA83DDoz8VS6++
        1jsUzaZASCTobpPT8jXN7iN6Dmf7+rFTFxmFWviYyjUBsUZ8iW+smRvTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=V6hB5OZI4p8WUlDnHuuNH5BlEZyzxuf5+jlrv9rSDoo=; b=sRjgkaBR
        32ag+6IS+rA+w1Huvg5hp5mDpzUha/p2LQsxrNe0o7GKSdpUFVS9lIc1RZ9miPpZ
        irowmgg1SBSM883LkoxCw67ddnCK7RKm8yCqYLzpRwA06tmOk0NRIwbXLHRaJmHW
        A+t/Ghf7R5DRVRmeLgsECFcKwsiU/w889mic/DIIiChvtxH90TYNpO05rM29+vs6
        ujpYs4P6x+R/qZ587ENi+JpOV0L28q7Gv11FQ1wddS7fxQCIIknUAozE90BYSuA/
        Rgoj++KN3/RbE+F0BrYbdYCZw9GgkoRztILJZ6zNI/JbhDdpFMuuxZInd5edA2ut
        hgaeEc9EUF6fLA==
X-ME-Sender: <xms:ogUGX1fvM-OQ3OOpdxbhjUllvxLrgAX5dG4AP_KI4ifLuMAHg4ahKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ogUGXzMuT8RHqWRwSqEhB2kpSf4qXZ-VUN5XqWH3wG6xeAcyyWwS0Q>
    <xmx:ogUGX-jVnIFX-LgVwQkXYFQJoyPvUvXOYgbiRIid3FGXZB3BkAmFPg>
    <xmx:ogUGX-_vuL6vtgIX1Kg8SGYg0rjNxbWf6UH3IzZf938_aqK9b1kpow>
    <xmx:ogUGXy-r_HfoJDcbKqcPdN0Qu2k6GbKpnCPyXEzgAjdbBOlGGNUHp9GTPBI>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6CB2330600A9;
        Wed,  8 Jul 2020 13:42:58 -0400 (EDT)
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
Subject: [PATCH v4 19/78] drm/vc4: crtc: Disable color management for HVS5
Date:   Wed,  8 Jul 2020 19:41:27 +0200
Message-Id: <968564f69e9ec5ea14a18e1b46b598f67b0bd044.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HVS5 uses different color matrices. Disable color management support
for now.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 17 +++++++++++------
 drivers/gpu/drm/vc4/vc4_hvs.c  |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 04744223460a..41bc61d5a61f 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -874,6 +874,7 @@ int vc4_crtc_init(struct drm_device *drm, struct vc4_crtc *vc4_crtc,
 		  const struct drm_crtc_funcs *crtc_funcs,
 		  const struct drm_crtc_helper_funcs *crtc_helper_funcs)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	struct drm_crtc *crtc = &vc4_crtc->base;
 	struct drm_plane *primary_plane;
 	unsigned int i;
@@ -893,13 +894,17 @@ int vc4_crtc_init(struct drm_device *drm, struct vc4_crtc *vc4_crtc,
 	drm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
 				  crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, crtc_helper_funcs);
-	drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
-	drm_crtc_enable_color_mgmt(crtc, 0, false, crtc->gamma_size);
 
-	/* We support CTM, but only for one CRTC at a time. It's therefore
-	 * implemented as private driver state in vc4_kms, not here.
-	 */
-	drm_crtc_enable_color_mgmt(crtc, 0, true, crtc->gamma_size);
+	if (!vc4->hvs->hvs5) {
+		drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
+
+		drm_crtc_enable_color_mgmt(crtc, 0, false, crtc->gamma_size);
+
+		/* We support CTM, but only for one CRTC at a time. It's therefore
+		 * implemented as private driver state in vc4_kms, not here.
+		 */
+		drm_crtc_enable_color_mgmt(crtc, 0, true, crtc->gamma_size);
+	}
 
 	for (i = 0; i < crtc->gamma_size; i++) {
 		vc4_crtc->lut_r[i] = i;
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 50e88f634799..50f9a9674a7e 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -443,7 +443,7 @@ void vc4_hvs_mode_set_nofb(struct drm_crtc *crtc)
 
 	HVS_WRITE(SCALER_DISPBKGNDX(vc4_state->assigned_channel),
 		  SCALER_DISPBKGND_AUTOHS |
-		  SCALER_DISPBKGND_GAMMA |
+		  ((!vc4->hvs->hvs5) ? SCALER_DISPBKGND_GAMMA : 0) |
 		  (interlace ? SCALER_DISPBKGND_INTERLACE : 0));
 
 	/* Reload the LUT, since the SRAMs would have been disabled if
-- 
git-series 0.9.1
