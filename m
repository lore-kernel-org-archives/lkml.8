Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1D4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3D206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="gCSAXXOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgF2XxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:53:03 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49800 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgF2XxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1593474745; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzZtxTYFppOxJnlICRZ7phC+Q8/+aCXEQXT9OW1NRwk=;
        b=gCSAXXOz9YfYM8EBmvMKB6y2ngfnt0p1yuQOOK0p9czTJ18w+dNdekcOleASnuhCec9kwF
        mwY9vBd8Cgl/DvhY9wlm2yz/4LGOOe/hGGv3vweWIEs/8Hrj1PBqYyvThi3gfq1G6/4v+O
        xtYE/eeQxWm4RpdMxYcxNy3G3weJ4Cs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 06/10] drm/ingenic: Set DMA descriptor chain address in probe
Date:   Tue, 30 Jun 2020 01:52:06 +0200
Message-Id: <20200629235210.441709-6-paul@crapouillou.net>
In-Reply-To: <20200629235210.441709-1-paul@crapouillou.net>
References: <20200629235210.441709-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address of the DMA descriptor never changes. It can therefore be set
in the probe function.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 924c8daf071a..f7b0c5dc8cd8 100644
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

