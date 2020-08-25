Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E76C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4294E2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRvBhDEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgHYCcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgHYCcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:32:01 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C3C061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:32:00 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so8013594qtn.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVrepQbKS5smnSSp+87jEgzSFfpHNiyewdFx9duqOuI=;
        b=nRvBhDEI2BV+7EkphcVZVX66VEDD/PwjhzFsTQK4NxX+EE6wLIEL664mNEQMeaUFKx
         OS1dJafMgXYxr8be451Uq1L8f1iq5lfV0il3Y1wQ7YUQhAQrqMvtH3kLIOe3J4znjE1s
         tPTo5RNXQtnvydNifkvx3L+nuKPNf/EPeNIbFLdXf+mXFzZp3AHcQDcuE9QpUXDAiJx2
         gd+Tmk4/NX3ImimYlJHQTLJcsf+SRjrFMrPOlNI6PcVZngoHv4W8XVRBTlAWJmReIpxC
         phUE1ngDlu0uCM/dUBIe4y7xLRpluQ74HrtCWtFilFkALDIZjw+M4wCFqAYnzqS1GKL7
         Ip1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVrepQbKS5smnSSp+87jEgzSFfpHNiyewdFx9duqOuI=;
        b=VFro7LLmVS+okjtRndgPbB40N5FxCaCzbEfa/C34psGxPlgHvWiMuBKj/TlIfula/n
         qAzHvrlzmbpeYdLoUIiUorasYgD/iROi2MB8xCv/DHtwMgl5Jl1xQadtEvBFCvtDHhSW
         /yWSWQeZzg+aSl/k49isUfhEbURPXAGQRJkSGgXL+zKfsLcH36EjLTJ4Z5y7p/GCMct1
         20W3V2RkbYkCykmVC4Hvkj675TbyG9YpA/bn9gk2Xhq2ZkiK4zYt+ZJWI3dCtp9Vphkw
         Z1ixl8i2/rD7219uaL5VAZgavSJlgediee86qAa2GbnLDC+zYhC8Ntt1ZauPTsT4kGw6
         J8BA==
X-Gm-Message-State: AOAM531CqaR/30eLCuIxeT59IEwTxUzuozPFvbTRnGSTUtFxJ9sQL6wh
        YqgeyRvHaNVHOwbhCMxjhEXh6qKtmec=
X-Google-Smtp-Source: ABdhPJyXGRbgzqM5yxyFWq1Z08wxyCE0jq38h47EW23TfJl30UMuiznhKk/MLSOCvZ8ETpHpO78l4w==
X-Received: by 2002:ac8:4652:: with SMTP id f18mr7395756qto.142.1598322719808;
        Mon, 24 Aug 2020 19:31:59 -0700 (PDT)
Received: from atma2.hitronhub.home ([2607:fea8:56e0:6d60::2db6])
        by smtp.gmail.com with ESMTPSA id x137sm11095372qkb.47.2020.08.24.19.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:31:59 -0700 (PDT)
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        melissa.srw@gmail.com, daniels@collabora.com,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH v5 2/3] drm/vkms: Compute CRC without change input data
Date:   Mon, 24 Aug 2020 22:31:41 -0400
Message-Id: <20200825023142.2561220-3-rodrigosiqueiramelo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825023142.2561220-1-rodrigosiqueiramelo@gmail.com>
References: <20200825023142.2561220-1-rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compute_crc() function is responsible for calculating the
framebuffer CRC value; due to the XRGB format, this function has to
ignore the alpha channel during the CRC computation. Therefore,
compute_crc() set zero to the alpha channel directly in the input
framebuffer, which is not a problem since this function receives a copy
of the original buffer. However, if we want to use this function in a
context without a buffer copy, it will change the initial value. This
patch makes compute_crc() calculate the CRC value without modifying the
input framebuffer.

Change in V4 (Emil):
- Move bitmap_clear operation and comments to get_pixel function

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 38 ++++++++++++++++++----------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 4d8bc04bb6ee..387b0690a64a 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -9,33 +9,43 @@
 
 #include "vkms_drv.h"
 
+static u32 get_pixel_from_buffer(int x, int y, const u8 *buffer,
+				 const struct vkms_composer *composer)
+{
+	u32 pixel;
+	int src_offset = composer->offset + (y * composer->pitch)
+				      + (x * composer->cpp);
+
+	pixel = *(u32 *)&buffer[src_offset];
+	/* XRGB format ignores Alpha channel */
+	bitmap_clear((void *)&pixel, 0, 8);
+
+	return pixel;
+}
+
 /**
  * compute_crc - Compute CRC value on output frame
  *
- * @vaddr_out: address to final framebuffer
+ * @vaddr: address to final framebuffer
  * @composer: framebuffer's metadata
  *
  * returns CRC value computed using crc32 on the visible portion of
  * the final framebuffer at vaddr_out
  */
-static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
+static uint32_t compute_crc(const u8 *vaddr,
+			    const struct vkms_composer *composer)
 {
-	int i, j, src_offset;
+	int x, y;
+	u32 crc = 0, pixel = 0;
 	int x_src = composer->src.x1 >> 16;
 	int y_src = composer->src.y1 >> 16;
 	int h_src = drm_rect_height(&composer->src) >> 16;
 	int w_src = drm_rect_width(&composer->src) >> 16;
-	u32 crc = 0;
-
-	for (i = y_src; i < y_src + h_src; ++i) {
-		for (j = x_src; j < x_src + w_src; ++j) {
-			src_offset = composer->offset
-				     + (i * composer->pitch)
-				     + (j * composer->cpp);
-			/* XRGB format ignores Alpha channel */
-			bitmap_clear(vaddr_out + src_offset, 24, 8);
-			crc = crc32_le(crc, vaddr_out + src_offset,
-				       sizeof(u32));
+
+	for (y = y_src; y < y_src + h_src; ++y) {
+		for (x = x_src; x < x_src + w_src; ++x) {
+			pixel = get_pixel_from_buffer(x, y, vaddr, composer);
+			crc = crc32_le(crc, (void *)&pixel, sizeof(u32));
 		}
 	}
 
-- 
2.28.0

