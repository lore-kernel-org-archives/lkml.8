Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FA7C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C1A206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272152;
	bh=FQqG5CuWZNvAahuC516eH5urLJCxfYr2WeJpFtvzYYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RJUg9WiXHfCnXzWBrXjInNW+2tka3vPwv6+aQIITQsrlWxGCAaGguDdb6f5Xaa2vF
	 xG5hcrkM3JFH/fh+gO960yQc2Ai7t+lAnHmN/VP2gJKMwyH4GhmiHgjV4nDL2oJDM6
	 eXRFzfQSsLyIwM0XWR8hgVs3MZsVCBYpTWcH4XN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgBUICa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:02:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730889AbgBUIC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:02:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6456320801;
        Fri, 21 Feb 2020 08:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272147;
        bh=FQqG5CuWZNvAahuC516eH5urLJCxfYr2WeJpFtvzYYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZ4GHinh9+m1i6YhZAGba49RpwjfjJHkhA6P74Vvc5RD9F2X0uK9qWxpX+canwuPk
         XlRamfwQ6VDrCC302PZkww5DAFFs9hufN1avdP7xkBQ03bt2MNwuncM1zdeDzdwCY+
         Uo/IvgUkFDlp8ssytC1nI9Am6dNHG0inWalc1MSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 007/344] drm/gma500: Fixup fbdev stolen size usage evaluation
Date:   Fri, 21 Feb 2020 08:36:46 +0100
Message-Id: <20200221072349.948222886@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
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
index 218f3bb15276e..90237abee0885 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -462,6 +462,7 @@ static int psbfb_probe(struct drm_fb_helper *helper,
 		container_of(helper, struct psb_fbdev, psb_fb_helper);
 	struct drm_device *dev = psb_fbdev->psb_fb_helper.dev;
 	struct drm_psb_private *dev_priv = dev->dev_private;
+	unsigned int fb_size;
 	int bytespp;
 
 	bytespp = sizes->surface_bpp / 8;
@@ -471,8 +472,11 @@ static int psbfb_probe(struct drm_fb_helper *helper,
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



