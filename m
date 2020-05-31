Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FFAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 13:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70202206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 13:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuOaIXRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgEaNMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgEaNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 09:12:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115FEC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 06:12:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h95so2842828pje.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eYCtR5XyB8uUfd8xXmIEoD6CXSCHEWmBCVrdsJOKI14=;
        b=EuOaIXRX6UNAuI03P+SZF1/kwWXLjvWjU6NvoBr9uUNG4FOzQU1lO6NzHGii3nQ8JZ
         CHn6Pch07wPHqTbrLYFdCOci6KiUUCY8PdLf9tHnX1V2uD7wWuzYgc0EYBRNjoOrHna1
         STUM+LzTB3cu76b3OZXoV4XojZpQLzAn6L+oesG9aRZaV6EviTh8uhePndoMq8Ze8V0Q
         UYimf9+zaMxJUNN23PkI9m6/x1BQ7oeiHl4KnTYsZKcuk4s0QUfinQoYB9micQ3rn88L
         ZgQ8gFH35v1ojC9Xd8pagrCxKlu4ILHPV4yr0fmDDiRyoFW5a64+jgdinWXqN6Zh+tf0
         BNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eYCtR5XyB8uUfd8xXmIEoD6CXSCHEWmBCVrdsJOKI14=;
        b=GVqi/Brh11lm3/JaxCYjyqqs4+OYABrrcuhnXjomgJXqUuA/4WDBlVsc/WaQHHNVuO
         gRQ9qSXCwueAoqkFlIAYEfh7989sCs3F687e2os32gpM/n+UBmUX1UoN8AHyU9lvtTK4
         KKndMSj2JRJvgt4ZhQm0W5nI6CILX/LjhQlwkkCFYwb/bEioLsbJ9NgFnAxDmiUZqg82
         5QXrLvP60ryeWW7HQwIoeFbHJ+6gpvHgy0BO5SNqj1QVd1wuqu5bvtcPHLxNAnU6mw0w
         o7SZ3tsp14DacRdPHgUg04ISEiOvi5K68FthofOjkTN4Le4E+uBvh1jdxsnPQ2+tfv9C
         +8qA==
X-Gm-Message-State: AOAM532W7KLxsiTWZEiXP6IlSZNZIaeCQ82DpR28n9PtRKrB0XGTwF39
        NwG5JVb8u1KzkLctxoJZZx8=
X-Google-Smtp-Source: ABdhPJwmBYcznNqHHUuDeCfeV0pjzcwW3UxmM/z91hCyce6BMJ4xyeq+jeXmmXW4udl7uC11ysMPng==
X-Received: by 2002:a17:90b:28d:: with SMTP id az13mr16251573pjb.67.1590930772433;
        Sun, 31 May 2020 06:12:52 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id m2sm4701573pjk.52.2020.05.31.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 06:12:51 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: Optimize compute_crc(), blend()
Date:   Sun, 31 May 2020 22:12:37 +0900
Message-Id: <20200531131237.24781-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize looping pixels in compute_crc() and blend(). Calculate
src_offset in start of looping horizontally and increase it.
It's better than calculating in every pixels.

Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 32 +++++++++++++++-------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 4af2f19480f4..9d2a765ca1fb 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -28,14 +28,14 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
 	u32 crc = 0;
 
 	for (i = y_src; i < y_src + h_src; ++i) {
-		for (j = x_src; j < x_src + w_src; ++j) {
-			src_offset = composer->offset
-				     + (i * composer->pitch)
-				     + (j * composer->cpp);
+		src_offset = composer->offset + (i * composer->pitch)
+				+ (x_src * composer->cpp);
+		for (j = 0 ; j < w_src; ++j) {
 			/* XRGB format ignores Alpha channel */
 			memset(vaddr_out + src_offset + 24, 0,  8);
 			crc = crc32_le(crc, vaddr_out + src_offset,
 				       sizeof(u32));
+			src_offset += composer->cpp;
 		}
 	}
 
@@ -61,7 +61,7 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 		  struct vkms_composer *dest_composer,
 		  struct vkms_composer *src_composer)
 {
-	int i, j, j_dst, i_dst;
+	int i, j, i_dst;
 	int offset_src, offset_dst;
 
 	int x_src = src_composer->src.x1 >> 16;
@@ -73,21 +73,23 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 	int w_dst = drm_rect_width(&src_composer->dst);
 
 	int y_limit = y_src + h_dst;
-	int x_limit = x_src + w_dst;
 
-	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
-		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
-			offset_dst = dest_composer->offset
-				     + (i_dst * dest_composer->pitch)
-				     + (j_dst++ * dest_composer->cpp);
-			offset_src = src_composer->offset
-				     + (i * src_composer->pitch)
-				     + (j * src_composer->cpp);
+	for (i = y_src, i_dst = y_dst; i < y_limit; ++i, ++i_dst) {
+		offset_dst = dest_composer->offset
+		     + (i_dst * dest_composer->pitch)
+		     + (x_dst * dest_composer->cpp);
 
+		offset_src = src_composer->offset
+		     + (i * src_composer->pitch)
+		     + (x_src * src_composer->cpp);
+
+		for (j = 0; j < w_dst; ++j) {
 			memcpy(vaddr_dst + offset_dst,
 			       vaddr_src + offset_src, sizeof(u32));
+
+			offset_dst += dest_composer->cpp;
+			offset_src += src_composer->cpp;
 		}
-		i_dst++;
 	}
 }
 
-- 
2.17.1

