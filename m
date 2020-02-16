Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A0C76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9048B20729
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="s1ZPUDAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgBPP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 10:58:40 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:46002 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgBPP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 10:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581868713; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=euW6vOeEXRNCpOLcFmuhhSlyzof0lbP27ls/IkheQ7E=;
        b=s1ZPUDAQHlYJWMS0XZmG7j7/K3bIsZh1BdvwMjHBtHbB7MCBtq0oHJnBl+WXkflcMc8yGA
        7aS++Wirv/IuMH3nNApbhX5r4X5v62NKqcNfxs/u/GYK8fbymRkYM0PDPb7lG2CKHd+qS0
        45RNQZdbVfdUCegLkxLdlIXFnjAw4wE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] gpu/drm: ingenic: Switch emulated fbdev to 16bpp
Date:   Sun, 16 Feb 2020 12:58:10 -0300
Message-Id: <20200216155811.68463-2-paul@crapouillou.net>
In-Reply-To: <20200216155811.68463-1-paul@crapouillou.net>
References: <20200216155811.68463-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fbdev emulation is only ever used on Ingenic SoCs to run old SDL1
based games at 16bpp (rgb565). Recent applications generally talk to
DRM directly, and can request their favourite pixel format; so we can
make everybody happy by switching the emulated fbdev to 16bpp.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 034961a40e98..9aa88fabbd2a 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -808,7 +808,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 		goto err_devclk_disable;
 	}
 
-	ret = drm_fbdev_generic_setup(drm, 32);
+	ret = drm_fbdev_generic_setup(drm, 16);
 	if (ret)
 		dev_warn(dev, "Unable to start fbdev emulation: %i", ret);
 
-- 
2.25.0

