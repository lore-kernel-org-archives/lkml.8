Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB440C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8AF2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="DW4WPfv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgGPQiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:38:55 -0400
Received: from crapouillou.net ([89.234.176.41]:49676 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPQiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594917532; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=ZxOxYK7rdmy6ZMNe+mLCkT04eXTl/5csusRl6Ybtnow=;
        b=DW4WPfv3e2cU56e/brqKRNV82UdkvShqbXyCKQm5WjfWo0pIU1vAqz/epRSvWuSfBm6f3E
        J4+2HW//hDT1v9V7Tl0zxpWz0va8yn7OErFgf0TuWZC6P+rUiJOcfOt/IyIPB77ZfGgAbf
        h+JAJUyQzDYPW/GSi6bFpx9I4JaEqg8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        stable@vger.kernel.org
Subject: [PATCH v3 01/12] drm/ingenic: Fix incorrect assumption about plane->index
Date:   Thu, 16 Jul 2020 18:38:35 +0200
Message-Id: <20200716163846.174790-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

plane->index is NOT the index of the color plane in a YUV frame.
Actually, a YUV frame is represented by a single drm_plane, even though
it contains three Y, U, V planes.

v2-v3: No change

Cc: stable@vger.kernel.org # v5.3
Fixes: 90b86fcc47b4 ("DRM: Add KMS driver for the Ingenic JZ47xx SoCs")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index deb37b4a8e91..606d8acb0954 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -386,7 +386,7 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
 		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
 		width = state->src_w >> 16;
 		height = state->src_h >> 16;
-		cpp = state->fb->format->cpp[plane->index];
+		cpp = state->fb->format->cpp[0];
 
 		priv->dma_hwdesc->addr = addr;
 		priv->dma_hwdesc->cmd = width * height * cpp / 4;
-- 
2.27.0

