Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AC6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 21:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1BC9206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 21:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="m1udSjW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgEPVvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 17:51:35 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46808 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgEPVve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 17:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589665871; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxOycF7x5Xfh3qQrptTLTKm/tEoeEcVgZ8q3htBi1cA=;
        b=m1udSjW/5z3tn0AAeEykySxfbNi61NRIya8NwgjF0btMMeVyaTXPTAhV8LUt/66RUsa+PK
        /Fk86RtVJaHdJyW3xFFY3la8zMVBbX7xh0ncM1YrYVP/dzHL7M6URy16cHsBzW6+3NQKsM
        VAg21Lw4ot5ontUY61GNpjtTSldrzjg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
Subject: [PATCH 04/12] gpu/drm: ingenic: Fix bogus crtc_atomic_check callback
Date:   Sat, 16 May 2020 23:50:49 +0200
Message-Id: <20200516215057.392609-4-paul@crapouillou.net>
In-Reply-To: <20200516215057.392609-1-paul@crapouillou.net>
References: <20200516215057.392609-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code was comparing the SoC's maximum height with the mode's width,
and vice-versa. D'oh.

Cc: stable@vger.kernel.org # v5.6
Fixes: a7c909b7c037 ("gpu/drm: ingenic: Check for display size in CRTC atomic check")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    This patch was previously sent standalone.
    I marked it as superseded in patchwork.
    Nothing has been changed here.

 drivers/gpu/drm/ingenic/ingenic-drm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 632d72177123..0c472382a08b 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -330,8 +330,8 @@ static int ingenic_drm_crtc_atomic_check(struct drm_crtc *crtc,
 	if (!drm_atomic_crtc_needs_modeset(state))
 		return 0;
 
-	if (state->mode.hdisplay > priv->soc_info->max_height ||
-	    state->mode.vdisplay > priv->soc_info->max_width)
+	if (state->mode.hdisplay > priv->soc_info->max_width ||
+	    state->mode.vdisplay > priv->soc_info->max_height)
 		return -EINVAL;
 
 	rate = clk_round_rate(priv->pix_clk,
-- 
2.26.2

