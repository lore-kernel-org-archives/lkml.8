Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07DEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECD82065E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="voLL/W4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgGPQje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:39:34 -0400
Received: from crapouillou.net ([89.234.176.41]:50380 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgGPQjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594917538; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9ifTY1m3M2BZvpvyxKFluHrLjILBFcZljDwob1WLiY=;
        b=voLL/W4t1hP3L7Qfd7lzjvVLiMO3HYF7LECYrIWIS69OKHkEur22pt/Xqut6Vhr/Zb0J6U
        4/yEL8p/MseMMNU9MUc0a5fVHxeSKlUvayOr7rHDsasCuFtvdbE0FZkuQhNidYx8VxEJbG
        k4Lh4TkCVaEBHRc0GdO8v1kHZYYD9Sc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 06/12] drm/ingenic: Set DMA descriptor chain address in probe
Date:   Thu, 16 Jul 2020 18:38:40 +0200
Message-Id: <20200716163846.174790-6-paul@crapouillou.net>
In-Reply-To: <20200716163846.174790-1-paul@crapouillou.net>
References: <20200716163846.174790-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address of the DMA descriptor never changes. It can therefore be set
in the probe function.

v2-v3: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 9e845234c7b5..c769a54f0274 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -358,8 +358,6 @@ static void ingenic_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 		ingenic_drm_crtc_update_ctrl(priv, finfo);
 
 		clk_set_rate(priv->pix_clk, state->adjusted_mode.clock * 1000);
-
-		regmap_write(priv->map, JZ_REG_LCD_DA0, priv->dma_hwdesc->next);
 	}
 
 	if (event) {
@@ -757,6 +755,9 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* Set address of our DMA descriptor chain */
+	regmap_write(priv->map, JZ_REG_LCD_DA0, priv->dma_hwdesc_phys);
+
 	ret = drm_dev_register(drm, 0);
 	if (ret) {
 		dev_err(dev, "Failed to register DRM driver\n");
-- 
2.27.0

