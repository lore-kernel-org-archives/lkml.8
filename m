Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FC4C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E27206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ISeLpAy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbgG1PRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:17:05 -0400
Received: from crapouillou.net ([89.234.176.41]:38796 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbgG1PRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595949410; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCAL3uifqrwrrscsGck77s7dOI7H4T7L/Psu4vIjeNo=;
        b=ISeLpAy0gBt9aVtGQ7vMvBc4q0lHCwa/EveW3oxDGe2VLWxcbo1TZtHCNHvgG+m9slP+pt
        QLRE2x9JexqOaaYyVPYr3sCqNRyz5RizX2/BQ+8GsWcYU+HJkZZGt+lmNeSZFP7YWvtTx4
        xOVVM7wsGxQiBskNouFyBFcQMP8iNyU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] drm/ingenic: Validate mode in a .mode_valid callback
Date:   Tue, 28 Jul 2020 17:16:41 +0200
Message-Id: <20200728151641.26124-3-paul@crapouillou.net>
In-Reply-To: <20200728151641.26124-1-paul@crapouillou.net>
References: <20200728151641.26124-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validate modes in the drm_crtc_helper_funcs.mode_valid() callback, which
is designed for this purpose, instead of doing it in
drm_crtc_helper_funcs.atomic_check().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 34 +++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 64eabab3ef69..5dab9c3d0a52 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -199,21 +199,8 @@ static int ingenic_drm_crtc_atomic_check(struct drm_crtc *crtc,
 {
 	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
 	struct drm_plane_state *f1_state, *f0_state, *ipu_state = NULL;
-	long rate;
-
-	if (!drm_atomic_crtc_needs_modeset(state))
-		return 0;
-
-	if (state->mode.hdisplay > priv->soc_info->max_width ||
-	    state->mode.vdisplay > priv->soc_info->max_height)
-		return -EINVAL;
 
-	rate = clk_round_rate(priv->pix_clk,
-			      state->adjusted_mode.clock * 1000);
-	if (rate < 0)
-		return rate;
-
-	if (priv->soc_info->has_osd) {
+	if (drm_atomic_crtc_needs_modeset(state) && priv->soc_info->has_osd) {
 		f1_state = drm_atomic_get_plane_state(state->state, &priv->f1);
 		if (IS_ERR(f1_state))
 			return PTR_ERR(f1_state);
@@ -242,6 +229,24 @@ static int ingenic_drm_crtc_atomic_check(struct drm_crtc *crtc,
 	return 0;
 }
 
+static enum drm_mode_status
+ingenic_drm_crtc_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode *mode)
+{
+	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
+	long rate;
+
+	if (mode->hdisplay > priv->soc_info->max_width)
+		return MODE_BAD_HVALUE;
+	if (mode->vdisplay > priv->soc_info->max_height)
+		return MODE_BAD_VVALUE;
+
+	rate = clk_round_rate(priv->pix_clk, mode->clock * 1000);
+	if (rate < 0)
+		return MODE_CLOCK_RANGE;
+
+	return MODE_OK;
+}
+
 static void ingenic_drm_crtc_atomic_begin(struct drm_crtc *crtc,
 					  struct drm_crtc_state *oldstate)
 {
@@ -655,6 +660,7 @@ static const struct drm_crtc_helper_funcs ingenic_drm_crtc_helper_funcs = {
 	.atomic_begin		= ingenic_drm_crtc_atomic_begin,
 	.atomic_flush		= ingenic_drm_crtc_atomic_flush,
 	.atomic_check		= ingenic_drm_crtc_atomic_check,
+	.mode_valid		= ingenic_drm_crtc_mode_valid,
 };
 
 static const struct drm_encoder_helper_funcs ingenic_drm_encoder_helper_funcs = {
-- 
2.27.0

