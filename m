Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30E4C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 20:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94E42072C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 20:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IttaYxyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgCUUgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 16:36:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44304 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgCUUgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 16:36:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id z3so11519143edq.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 13:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZZ8vMEMrPzAmCCEBSbU8aR5UX0QpU9PFQ1YG0DRV08Y=;
        b=IttaYxyjD1JYhBBOqIdM+9UpYtHnFoKk0/PzLFAQvrnz1/GlrqsgArmSJ9zmLkoNHl
         le8t7zck7thQKq+I30w2OlvuVkPshfI8avRRtZOSw+ddn4jWuCIBkl1s97bXBa+CQBVE
         ly/Lxh+N/wFaFtPYpv3Ag/QXfRMVrR/tUqXYH9vy3u7cKliybR6MHGPrzH7RnPdrI0CI
         HKhYdDYg4YhiWY3YRZlq5ldLK7+f7dnwl3EQNV41eGg/w5HScKZ6iq1AKIop2XAtb9Cw
         IVud8nbkuDvbjvZfn669sQMyxPkbQZZavuiYtBnxcB57F3G+SxyBJ0xM9rmTEE6DSW+m
         UINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZZ8vMEMrPzAmCCEBSbU8aR5UX0QpU9PFQ1YG0DRV08Y=;
        b=PMlqOe3x64d1jwyDEX18LUawIAfpNeaUy263eRYo6RJaJJxl92SCmrgWeFXBumPWVJ
         e7UO8buvLX/VFusKu98IRXzY3xWvPCotVeshsEyBmYBiAFyUHBNhyLsJZFrwfL91oQqN
         kYgOrloL8rWvPg+50Krw+0yAFbMXTepGMcMpdEVNfPMWXpySMaC5I2d8v1dMPvJ5bNtR
         R297EeSCtq9/rhJEBO/dwwqFgwiVoiZmpIhd9pOtBpIG9xIIuqj+YxkakjKRdyRHVG0D
         NJ5qt3ZRG71qIAtlFyrBg5oHpRTyBTd40A92GOaOS6AWwuqQ9XYUGHMoEYVwxwOhqzho
         IfSA==
X-Gm-Message-State: ANhLgQ0UO6kRA1DOsYTscgDW3m1iWn/1v4E16U5VgW3kRxlXA9NRlm+d
        ML8P7a88D++SSYidZNExqG4=
X-Google-Smtp-Source: ADFU+vukBYjeON5F6ElcikyjD2ci8Wh81K5f1NPZQSPa4qKB245eQEJz/JeGy420N6MHU+jzMww35Q==
X-Received: by 2002:a17:906:34db:: with SMTP id h27mr13452108ejb.111.1584823008214;
        Sat, 21 Mar 2020 13:36:48 -0700 (PDT)
Received: from smtp.gmail.com ([2001:818:e238:a000:51c6:2c09:a768:9c37])
        by smtp.gmail.com with ESMTPSA id ca12sm683498edb.47.2020.03.21.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 13:36:47 -0700 (PDT)
Date:   Sat, 21 Mar 2020 17:36:40 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rodrigo.Siqueira@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: use bitfield op to get xrgb on compute crc
Message-ID: <20200321203640.dwyk25jvnn2rffpw@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous memset operation was not correctly setting zero on the
alpha channel to compute the crc, and as a result, the
pipe-A-cursor-alpha-transparent subtest of the IGT test kms_cursor_crc
was crashing. To avoid errors of misinterpretation related to
endianness, this solution uses a bitfield operation to extract the RGB
values from each pixel and ignores the alpha channel as expected.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 4af2f19480f4..8c1c005bb717 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/crc32.h>
+#include <linux/bitfield.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -9,6 +10,8 @@
 
 #include "vkms_drv.h"
 
+#define XRGB_MSK GENMASK(23, 0)
+
 /**
  * compute_crc - Compute CRC value on output frame
  *
@@ -26,6 +29,7 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
 	int h_src = drm_rect_height(&composer->src) >> 16;
 	int w_src = drm_rect_width(&composer->src) >> 16;
 	u32 crc = 0;
+	u32 *pixel;
 
 	for (i = y_src; i < y_src + h_src; ++i) {
 		for (j = x_src; j < x_src + w_src; ++j) {
@@ -33,7 +37,8 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
 				     + (i * composer->pitch)
 				     + (j * composer->cpp);
 			/* XRGB format ignores Alpha channel */
-			memset(vaddr_out + src_offset + 24, 0,  8);
+			pixel = vaddr_out + src_offset;
+			*pixel = FIELD_GET(XRGB_MSK, *(u32 *)pixel);
 			crc = crc32_le(crc, vaddr_out + src_offset,
 				       sizeof(u32));
 		}
-- 
2.25.1

