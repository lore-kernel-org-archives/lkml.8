Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969DFC3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711B62475B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697351;
	bh=Txxg0CwDxgoAcCHfdSwCfVEMIB5RTNNnMROmmxv2NIQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=k5O3qj2zrQXpoplKvy2lHEXHRNDDcoX3BXSpm7FeKtK7wNJdoybXToIwFiFPIIxS4
	 fWjzLaxMf32ibzq9+dBsVv+u5StxrWIIrm90fexHRm33XN83cJquV+ZwP+KynTV9rJ
	 K/nsVJOdvt2BL0J5Z5Pfvi14hnn8TwbAi+2XWsao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405458AbgBNQW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405373AbgBNQVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44CD72469F;
        Fri, 14 Feb 2020 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697284;
        bh=Txxg0CwDxgoAcCHfdSwCfVEMIB5RTNNnMROmmxv2NIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=tSochnqaQk9HZ+V+pfQLu7f2M7Y/DXB+uD54lrtvDZg5SrlHzfJ4qYFiUUN8UB+Tu
         e0O73K2Wcg2NioF2L5gK3b6GOSvq6sjoURlO5ssppGXwOdBitalpOJ/xoecfRfg1Uc
         0K+L2rciZrL9tv7k9ZU4CLgdEFgzZw1a/dUkbepM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 001/141] drm/gma500: Fixup fbdev stolen size usage evaluation
Date:   Fri, 14 Feb 2020 11:19:01 -0500
Message-Id: <20200214162122.19794-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

