Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA0BC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320BB20739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="A9llEpHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgGPM47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:56:59 -0400
Received: from crapouillou.net ([89.234.176.41]:59350 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgGPM45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594904215; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=DUN8mRRTBoSNE5wMk07ynYLLgnvVyFadqpMluACqVzo=;
        b=A9llEpHYyVXFBQJ+53KuAtojE88Sbp0dYxrXJpLeyeCNQeGJnTPeIIXOvS6y6loRvjzqiK
        +8SmbAgNEi70JtQqVdOuetgZtYhNFinJb4fi8ekKE4UVXRw9getW4wk065sdZENPxrlNv1
        yKfwx/rcemLi0fqStgsCpo3Mf+SjekU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/panel-simple: Fix inverted V/H SYNC for Frida FRD350H54004 panel
Date:   Thu, 16 Jul 2020 14:56:46 +0200
Message-Id: <20200716125647.10964-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FRD350H54004 panel was marked as having active-high VSYNC and HSYNC
signals, which sorts-of worked, but resulted in the picture fading out
under certain circumstances.

Fix this issue by marking VSYNC and HSYNC signals active-low.

v2: Rebase on drm-misc-next

Fixes: 7b6bd8433609 ("drm/panel: simple: Add support for the Frida FRD350H54004 panel")
Cc: stable@vger.kernel.org # v5.5
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index f42249b72548..8b0bab9dd075 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1763,7 +1763,7 @@ static const struct drm_display_mode frida_frd350h54004_mode = {
 	.vsync_start = 240 + 2,
 	.vsync_end = 240 + 2 + 6,
 	.vtotal = 240 + 2 + 6 + 2,
-	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
 };
 
 static const struct panel_desc frida_frd350h54004 = {
-- 
2.27.0

