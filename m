Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F1C34022
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FC324691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814758;
	bh=Txxg0CwDxgoAcCHfdSwCfVEMIB5RTNNnMROmmxv2NIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0lKfFeaP+SeQwkjXFub1XSidt4g0nHxih+94CM6RMxX9JSWir23lEQ8iNNWg4K+Tc
	 KdO1qoYStAj5FOncDGPVXQFKt1iSmQD7ACoQUp0inXzaFJXvN+bHh4T8lmjLpRbHYC
	 zUYvw9Oks8nc9uXOFGTvrXbHlGw9FRaR+EPPlXyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgB0Op4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbgB0Npx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:45:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8777D2468D;
        Thu, 27 Feb 2020 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811153;
        bh=Txxg0CwDxgoAcCHfdSwCfVEMIB5RTNNnMROmmxv2NIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQRVerH9Awsrbpez4hroDbCS1rwBIKWm6rwj73U2rCd81FUcr5GUpROHpXxhKuzll
         WGxdTZIx2LRj1IAWGgk8VR4Wae6UbGjlkblwRxYw3ypMEnjrnMWI/ktDf+77AtGfta
         rNU2rNU2gVVgeT6wrsU018IZ8peX2MU2Toi7PG9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 022/165] drm/gma500: Fixup fbdev stolen size usage evaluation
Date:   Thu, 27 Feb 2020 14:34:56 +0100
Message-Id: <20200227132234.231640464@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit fd1a5e521c3c083bb43ea731aae0f8b95f12b9bd ]

psbfb_probe performs an evaluation of the required size from the stolen
GTT memory, but gets it wrong in two distinct ways:
- The resulting size must be page-size-aligned;
- The size to allocate is derived from the surface dimensions, not the fb
  dimensions.

When two connectors are connected with different modes, the smallest will
be stored in the fb dimensions, but the size that needs to be allocated must
match the largest (surface) dimensions. This is what is used in the actual
allocation code.

Fix this by correcting the evaluation to conform to the two points above.
It allows correctly switching to 16bpp when one connector is e.g. 1920x1080
and the other is 1024x768.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191107153048.843881-1-paul.kocialkowski@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/gma500/framebuffer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 3a44e705db538..d224fc12b7571 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -516,6 +516,7 @@ static int psbfb_probe(struct drm_fb_helper *helper,
 		container_of(helper, struct psb_fbdev, psb_fb_helper);
 	struct drm_device *dev = psb_fbdev->psb_fb_helper.dev;
 	struct drm_psb_private *dev_priv = dev->dev_private;
+	unsigned int fb_size;
 	int bytespp;
 
 	bytespp = sizes->surface_bpp / 8;
@@ -525,8 +526,11 @@ static int psbfb_probe(struct drm_fb_helper *helper,
 	/* If the mode will not fit in 32bit then switch to 16bit to get
 	   a console on full resolution. The X mode setting server will
 	   allocate its own 32bit GEM framebuffer */
-	if (ALIGN(sizes->fb_width * bytespp, 64) * sizes->fb_height >
-	                dev_priv->vram_stolen_size) {
+	fb_size = ALIGN(sizes->surface_width * bytespp, 64) *
+		  sizes->surface_height;
+	fb_size = ALIGN(fb_size, PAGE_SIZE);
+
+	if (fb_size > dev_priv->vram_stolen_size) {
                 sizes->surface_bpp = 16;
                 sizes->surface_depth = 16;
         }
-- 
2.20.1



