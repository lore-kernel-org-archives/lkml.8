Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2977C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7C320757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TufzN+pN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgH3OVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgH3OUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 10:20:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C68C061236
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 07:20:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w186so4002088qkd.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bwWKMSkRvOEL7YPRUvfw4HtVpw9bW0LN4U6a+UXn+Q=;
        b=TufzN+pNu74PL6ESl+o6lR3qczJn4loFbgr5N0BarA4Pbscrm+frzq70lvB8EhtG+t
         P5s2t1Hjk+t0zDmsFl/Ws54uZpVilXQQW6QMU82/dV8hfLfElNMNkQ85Q9+z9NjOTfc5
         cLwagE1GrgGsVX8SLilPtnqOIYPTEKvFFmwDrhlzlvCmSDLNKx9cz7LGOH5Qz/yUf/JY
         qPWHRXFx1aMfXeezKG96O+b9V9F0b7kqnEVTHsyOAIcLfN82O16nykd1Zaks42Ipt/hr
         i6GuhouHzMMrqnbzox3VPvyRfagVOtyHNQsX6/Jr9YMzwr+Ini7soxhqfI/tQ0DDPyFp
         C57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bwWKMSkRvOEL7YPRUvfw4HtVpw9bW0LN4U6a+UXn+Q=;
        b=h+cnwBjgUHYeDB8tzHrliqb0pTXDue1cQLz7sd52AuGwT7FzUqt3uH7d/I9pnLEVKX
         gqAvT/8qSd4q7K2iYycBXbVakfppExwQlJ864xqTWUXahG5jQHf/yfN8iwItsINduhd2
         Ic5QpWpvz9Vqisx+k3dS0wW6I8eMVo7Vh1y6Mlx+ADv4q3b0LuYBxC/UPaFaJAy67GZd
         ksRU2DfAA9LLOF980QhN6ii+JbM1e5+SjqLvz8KUlTG8vGMp2mW+BCMfBQmzIMIfYWwq
         JSVbSl6lO5wee7d4B2eMi+80dvq6l3J1yw/zH7XAKL3xeEF2w+g1FpuFCBqpSRhHfcuI
         vVVw==
X-Gm-Message-State: AOAM532OcnAo0CWk3uqxZLrOOX9NDwfmwUCeUSjs9w/XQI6rWJ/9JfVw
        WhcDcdOQPMJ/IwYyn4aetBdx/dI4LlKUaA==
X-Google-Smtp-Source: ABdhPJyPJkHpOhlBfpi6mKFBVfVZQcx17T2SFL1d7NKkZUq5JJCuCkeUo76htNk/OIFP+eGug4Nmew==
X-Received: by 2002:a37:8601:: with SMTP id i1mr7332702qkd.307.1598797236348;
        Sun, 30 Aug 2020 07:20:36 -0700 (PDT)
Received: from atma2.hitronhub.home ([2607:fea8:56e0:6d60::2db6])
        by smtp.gmail.com with ESMTPSA id o72sm5884861qka.113.2020.08.30.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 07:20:35 -0700 (PDT)
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     melissa.srw@gmail.com, Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        daniels@collabora.com, Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH v6 2/3] drm/vkms: Compute CRC without change input data
Date:   Sun, 30 Aug 2020 10:19:59 -0400
Message-Id: <20200830142000.146706-3-rodrigosiqueiramelo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200830142000.146706-1-rodrigosiqueiramelo@gmail.com>
References: <20200830142000.146706-1-rodrigosiqueiramelo@gmail.com>
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

Change in V5 (Melissa):
- Rebase and drop bitmap for alpha
Change in V4 (Emil):
- Move bitmap_clear operation and comments to get_pixel function

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 34 ++++++++++++++++++----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index f67d1baf1942..c5b32fe5870f 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -9,31 +9,41 @@
 
 #include "vkms_drv.h"
 
+static u32 get_pixel_from_buffer(int x, int y, const u8 *buffer,
+				 const struct vkms_composer *composer)
+{
+	u32 pixel;
+	int src_offset = composer->offset + (y * composer->pitch)
+				      + (x * composer->cpp);
+
+	pixel = *(u32 *)&buffer[src_offset];
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

