Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155EDC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF1F222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WnUWgdYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBZEbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:31:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33802 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgBZEbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582691455; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XF+6O0zVwMpssxe/NPpst6+w+SnWT3lSa/N6HXCCB8k=;
        b=WnUWgdYBrn4vYJskBy79Cx5OPVeQikQfKzUQv5FN+BnWT5BuZDdb69lhL+kDvk//Rj2Rvs
        5wXw8NocFtk6X62MmZlwelkq4WYC1w/PDdQvTVcD/MZvAUjKpWcnIsKHBrnOMT9zUJBl5r
        1kiwce6oRjf1fjFdRfVEyT4B8Cir1ew=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/3] gpu/drm: ingenic: Switch emulated fbdev to 16bpp
Date:   Wed, 26 Feb 2020 01:30:40 -0300
Message-Id: <20200226043041.289764-2-paul@crapouillou.net>
In-Reply-To: <20200226043041.289764-1-paul@crapouillou.net>
References: <20200226043041.289764-1-paul@crapouillou.net>
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

v2: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 5493a80d7d2f..3f8cc98d41fe 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -807,7 +807,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 		goto err_devclk_disable;
 	}
 
-	ret = drm_fbdev_generic_setup(drm, 32);
+	ret = drm_fbdev_generic_setup(drm, 16);
 	if (ret)
 		dev_warn(dev, "Unable to start fbdev emulation: %i", ret);
 
-- 
2.25.0

