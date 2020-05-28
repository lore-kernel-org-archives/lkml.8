Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F42C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CB5207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJdX3nPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405352AbgE1RE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405191AbgE1REz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:04:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882C7C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:04:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x10so11825431plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3QDLjzxkd7M9KUqjGIPcBygG7uxGYVtFUrGbmOGT24g=;
        b=jJdX3nPMQjqjPMCy3PvCgI97FsITB8PRe+x824sB3Mqz21dNeIFmDEKyMRzPhl/Ghu
         hV5/s5t/8ccuNalsO9ZfRoRW05oKP6h88Vpdm7iu4Wz3hadT+JInoaon+CQAK8Q8t1Pb
         mZ3tpUWBLCcaQ5Pl1lP959clJOS/jW6XMHa+MYCJKOO+ICCh+gPWUFhhLOThWwF7++JL
         K8PFAf/TItqdCfeXl0YxTF4ZBZE1CkWIpGVcCkWPC/4r8M4YXBHtGElcZpbIpCogte1Y
         HNX4p0xW/uhRtVfhPsn9AyL2Fv1F1Z494Hn4WaAaso9MiVbKPV8O5mnAsEd9/aKITf6+
         xlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3QDLjzxkd7M9KUqjGIPcBygG7uxGYVtFUrGbmOGT24g=;
        b=qEDmcIF3FtzxdXPWuHZcEiyPvoHVquT+KZnj+3Rq45Hi8SnMprhyljvIboalyyk2ZN
         hfbUJsRKXSL6E6AxviZnD/UCCfBh6FPpATgeq/tp398m8tPOk4qEbqyO20/aoVhJ5Cwj
         MHZVoK4Kktm0d1SNq68ibegnPcK2h+fZJeFzpXPGTI67nmbk0vT65itgnsvmVS3vq/g3
         X/Zjf/udPWCcmgCrS8bCiWRFVhGLQa7qq8ltSmJbpUd7YNh7DvyVw6Ed001Xf53/2qWg
         WP/LLgm4A71udIUiP71fxhjktvsJ6ja3uUz75s9RPwVq7kVdRvlJ8ChoQ2T4YJcfqxxd
         66uw==
X-Gm-Message-State: AOAM532nvlWEjwVjd1TCXHwFFyhOiDnF8ycK2iUpVJD9Cz9beS5NfU0f
        sj9Hm2Yn2ySSzgISVpneFCQ=
X-Google-Smtp-Source: ABdhPJzxsYqiDwRtUoYkQYtunVIxV8wXSlXowktbdEfaQIiid86PV7fpBBMxhCwXnFlmMSewOzMAjA==
X-Received: by 2002:a17:90a:7b8b:: with SMTP id z11mr5134803pjc.234.1590685494994;
        Thu, 28 May 2020 10:04:54 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id f11sm5298916pfk.58.2020.05.28.10.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 10:04:54 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/kms: Optimize compute_crc(), blend()
Date:   Fri, 29 May 2020 02:04:42 +0900
Message-Id: <20200528170442.22337-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I'm newbie in linux kernel and interested in drm module.
Please check this patch and give some advice for me.
I want to participate in developing kernel and community.

Thanks,

Sidong

Optimize looping pixels in compute_crc() and blend(). Calculate
src_offset in start of looping horizontally and increase it.
It's better than calculating in every pixels.

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

