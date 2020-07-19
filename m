Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF816C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7741207DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="r0bAcO7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgGSJin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 05:38:43 -0400
Received: from crapouillou.net ([89.234.176.41]:56778 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgGSJin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 05:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595151520; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=4rTWGEb0TCGTaJ2JZjGbv3v8RlhO7/L0QwLQpPrWcug=;
        b=r0bAcO7F3neDY0RyulTXBBvvWuOMNDtLcerHQlbi7lSSukiwE84E4zJs0IYoWP+4OeAuce
        gDQpaxz2CIRGh6eUNFF47sTPUXES8zX5M/PmS4UUBmBnyL4ow2LAKVf0dd6jwa2FiAMHnV
        rkATg1J0JYFlzqEfLjNrq9WfPiWKy6c=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] drm/ingenic: Silence uninitialized-variable warning
Date:   Sun, 19 Jul 2020 11:38:34 +0200
Message-Id: <20200719093834.14084-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence compiler warning about used but uninitialized 'ipu_state'
variable. In practice, the variable would never be used when
uninitialized, but the compiler cannot know that 'priv->ipu_plane' will
always be NULL if CONFIG_INGENIC_IPU is disabled.

Silence the warning by initializing the value to NULL.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index b6d946fbeaf5..ada990a7f911 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -198,7 +198,7 @@ static int ingenic_drm_crtc_atomic_check(struct drm_crtc *crtc,
 					 struct drm_crtc_state *state)
 {
 	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
-	struct drm_plane_state *f1_state, *f0_state, *ipu_state;
+	struct drm_plane_state *f1_state, *f0_state, *ipu_state = NULL;
 	long rate;
 
 	if (!drm_atomic_crtc_needs_modeset(state))
@@ -229,7 +229,7 @@ static int ingenic_drm_crtc_atomic_check(struct drm_crtc *crtc,
 
 		/* If all the planes are disabled, we won't get a VBLANK IRQ */
 		priv->no_vblank = !f1_state->fb && !f0_state->fb &&
-				  !(priv->ipu_plane && ipu_state->fb);
+				  !(ipu_state && ipu_state->fb);
 	}
 
 	return 0;
-- 
2.27.0

