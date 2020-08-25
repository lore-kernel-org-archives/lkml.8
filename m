Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF81C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B723D20767
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGFoEHga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgHYLqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbgHYLp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:45:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0310C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 04:45:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so5646921wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 04:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Z4KyrBawh5I2x6NeIqjVgo7gnUcWLY3kFNO+RloeAYg=;
        b=IGFoEHgaIPsX9CXu6OXIGlc65XiYPBOtJgKPZAGkiYf3hxvLYZzjcEj+u1mw/CCR/Z
         aciCwtxxalXtYu9J/3oxzEQDNVJPNFt9o+JzrtROJKU+HsxcbOxxezLQxkhVxnwLlhW7
         j+pdNg2eEpchO0gy09C+cS28y8WO/Jh2rJ1QfvftJF4/+kJPuTTO0KKel2fQJZOlo2md
         mt+Sxk2+sWmqN7dDdXYW4tibOUl5WLhRV1W4agi64A0sLDGzM8nMOGem+qgI7wIQpj0u
         BD4YB1DgLwUdrz+TCRuYuHW5zREnZuhxOEvZgV0PqxaRpcAsn2JZZ5pxMwnAFVZQq8cS
         eY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Z4KyrBawh5I2x6NeIqjVgo7gnUcWLY3kFNO+RloeAYg=;
        b=Wam4H9UqYnvNlrLH0UUk6dWKpUxWTfIZXK0zAUthOtWl7VDHYvgpU9kCBrJCXnY7Rb
         iQhc/NbHrrkijCT3Wglcs+IuRJ/N4AgKaBZ4BaLfD5e94sum0jaBhPJEKRwmqHJlnYuy
         JXnThSiiq1xL8SMS1fP2sW8TaPvEW97sHbpmfvyxN5aE87OsuQB7Be+PnsO+NF6hcpmM
         Z8a3kKFilptnkWclzvnTOqVLJ3S1/0if502jPHGxVgOUIlcg+/qwRdTOtKnDv0vI/Huc
         yNVdptL40rZpIgckkP6UXJyDAMvJAgxMCpKWF0AtrcXTI5WPDbdKCzE4V3Sw/t4fJZkK
         uSzA==
X-Gm-Message-State: AOAM532hA5cJMn17inttFZPvWXZk19CA5GssgWzaZVjaKVxNRVtzHumF
        g2sYRkjhQsQQuuTBY6SVBAI=
X-Google-Smtp-Source: ABdhPJwA1geacmCXwy6uAKsMZ9o5Ac2JW6XM1SyfJ+UddpZGIjN2tx5d+0qDGoLY6mIhYBRhe/487A==
X-Received: by 2002:adf:e411:: with SMTP id g17mr10985118wrm.77.1598355940308;
        Tue, 25 Aug 2020 04:45:40 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id 126sm5729268wme.42.2020.08.25.04.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 04:45:39 -0700 (PDT)
Date:   Tue, 25 Aug 2020 08:45:32 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     twoerner@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2] drm/vkms: add alpha-premultiplied color blending
Message-ID: <20200825114532.abzdooluny2ekzvm@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VKMS blend function was ignoring the alpha channel and just
overwriting vaddr_src with vaddr_dst. This XRGB approach triggers a
warning when running the kms_cursor_crc/cursor-alpha-transparent test
case. In IGT, cairo_format_argb32 uses premultiplied alpha (according to
documentation). Also current DRM assumption is that alpha is
premultiplied. Therefore, this patch considers premultiplied alpha
blending eq to compose vaddr_src with vaddr_dst.

This change removes the following cursor-alpha-transparent warning:
"Suspicious CRC: All values are 0."

--

v2:
- static for local functions
- const for the read-only variable argb_src
- replaces variable names
- drops unnecessary comment

--

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 55 ++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 4f3b07a32b60..eaecc5a6c5db 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -32,8 +32,6 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
 			src_offset = composer->offset
 				     + (i * composer->pitch)
 				     + (j * composer->cpp);
-			/* XRGB format ignores Alpha channel */
-			bitmap_clear(vaddr_out + src_offset, 24, 8);
 			crc = crc32_le(crc, vaddr_out + src_offset,
 				       sizeof(u32));
 		}
@@ -42,27 +40,51 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
 	return crc;
 }
 
+static u8 blend_channel(u8 src, u8 dst, u8 alpha)
+{
+	u32 pre_blend;
+	u8 new_color;
+
+	pre_blend = (src * 255 + dst * (255 - alpha));
+
+	/* Faster div by 255 */
+	new_color = ((pre_blend + ((pre_blend + 257) >> 8)) >> 8);
+
+	return new_color;
+}
+
+static void alpha_blending(const u8 *argb_src, u8 *argb_dst)
+{
+	u8 alpha;
+
+	alpha = argb_src[3];
+	argb_dst[0] = blend_channel(argb_src[0], argb_dst[0], alpha);
+	argb_dst[1] = blend_channel(argb_src[1], argb_dst[1], alpha);
+	argb_dst[2] = blend_channel(argb_src[2], argb_dst[2], alpha);
+	/* Opaque primary */
+	argb_dst[3] = 0xFF;
+}
+
 /**
  * blend - blend value at vaddr_src with value at vaddr_dst
  * @vaddr_dst: destination address
  * @vaddr_src: source address
- * @dest_composer: destination framebuffer's metadata
+ * @dst_composer: destination framebuffer's metadata
  * @src_composer: source framebuffer's metadata
  *
- * Blend value at vaddr_src with value at vaddr_dst.
- * Currently, this function write value of vaddr_src on value
- * at vaddr_dst using buffer's metadata to locate the new values
- * from vaddr_src and their destination at vaddr_dst.
- *
- * TODO: Use the alpha value to blend vaddr_src with vaddr_dst
- *	 instead of overwriting it.
+ * Blend the vaddr_src value with the vaddr_dst value using the pre-multiplied
+ * alpha blending equation, since DRM currently assumes that the pixel color
+ * values have already been pre-multiplied with the alpha channel values. See
+ * more drm_plane_create_blend_mode_property(). This function uses buffer's
+ * metadata to locate the new composite values at vaddr_dst.
  */
 static void blend(void *vaddr_dst, void *vaddr_src,
-		  struct vkms_composer *dest_composer,
+		  struct vkms_composer *dst_composer,
 		  struct vkms_composer *src_composer)
 {
 	int i, j, j_dst, i_dst;
 	int offset_src, offset_dst;
+	u8 *pixel_dst, *pixel_src;
 
 	int x_src = src_composer->src.x1 >> 16;
 	int y_src = src_composer->src.y1 >> 16;
@@ -77,15 +99,16 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 
 	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
 		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
-			offset_dst = dest_composer->offset
-				     + (i_dst * dest_composer->pitch)
-				     + (j_dst++ * dest_composer->cpp);
+			offset_dst = dst_composer->offset
+				     + (i_dst * dst_composer->pitch)
+				     + (j_dst++ * dst_composer->cpp);
 			offset_src = src_composer->offset
 				     + (i * src_composer->pitch)
 				     + (j * src_composer->cpp);
 
-			memcpy(vaddr_dst + offset_dst,
-			       vaddr_src + offset_src, sizeof(u32));
+			pixel_src = (u8 *)(vaddr_src + offset_src);
+			pixel_dst = (u8 *)(vaddr_dst + offset_dst);
+			alpha_blending(pixel_src, pixel_dst);
 		}
 		i_dst++;
 	}
-- 
2.28.0

