Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04037C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6270206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmD9vMwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgG3UZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgG3UZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:25:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:25:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so26077788wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4YsKWelpae7Y1+xemmp6VK2YWsEOoYbYZuWlAGBx8x8=;
        b=WmD9vMwiGZxymz2aRm2EXNkvN6yIiWDtjrUR+ki0OvZ3q6ag6xUUyO/PZF0Cmg2BQM
         wTwFRDSoBMZjxbncjHdvnJ/M6QtOWy+uoaDVLY/cSUcheDHSQ7PsThIlNB2bR3aCcw73
         8Ywqv3AMjkoY3oZU53D2GdBgHO9WwqKQD+pJRxXGboiqGlq8NhY/xA0iUhDka52p/dvm
         lLekms/R3iPZeTRXsVrUMIiQuUY+7FBGRTxvTY/TREbULB61PQdg61nj4hncrecXGKmn
         NyK0ESFmwxUDacgqOP8Mv09uDDjtQfOtcqfIKS52gSGkd7T/wl2l3EebUqQ5HLRAwCOX
         02Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4YsKWelpae7Y1+xemmp6VK2YWsEOoYbYZuWlAGBx8x8=;
        b=HM20VzYQVIs05MsYdfDncXdHRn2d7R6ng1Igkj6xyZoazfkHbb6G1VO33HbgCOqyLN
         kgWOnfKZPF4QoJYTWz2+l3uq1tu7UKSnQUoP3uwI9Hq+kdDg21ysv34NZFvqG7ivvAxp
         x8aoVSeCJN0QMB4uoOYZETyYcSzybZao6HsXnGU4LVdmN/ERjk0DLXJxqXSrPc5x04ox
         h/vZ3gNRl5XQjV+/dTasDk4gKifTTlxOe3BjO8l0eebGJLmpr788QQ+yx302MyPvNI8U
         aFALsNrm9Nd4OJOdl56cmZHQH8n1HvZDOSL9sd+lx1VOSmXtnlUwhJIJ8qZWO+hH50PQ
         Dbhg==
X-Gm-Message-State: AOAM531IXqcGoHbzG1scFbcFCEKgtoYREbZp6ygvUzag1NI/mrGTPQ3X
        oPcRuGy6uLYptCued9aMxm8=
X-Google-Smtp-Source: ABdhPJzNALvML/QpB+h/O6L02OLC+VZbNf0WhhYyg+bv2xKyFI/sFBJ3HwhfAd2l/RN0tefJgxZ9hw==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr432689wro.164.1596140732077;
        Thu, 30 Jul 2020 13:25:32 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id n5sm10611542wrx.22.2020.07.30.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 13:25:31 -0700 (PDT)
Date:   Thu, 30 Jul 2020 17:25:24 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     twoerner@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] drm/vkms: fix xrgb on compute crc
Message-ID: <20200730202524.5upzuh4irboru7my@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous memset operation was not correctly zeroing the alpha
channel to compute the crc, and as a result, the IGT subtest
kms_cursor_crc/pipe-A-cursor-alpha-transparent fails.

Fixes: db7f419c06d7c ("drm/vkms: Compute CRC with Cursor Plane")

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 4af2f19480f4..b8b060354667 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -33,7 +33,7 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
 				     + (i * composer->pitch)
 				     + (j * composer->cpp);
 			/* XRGB format ignores Alpha channel */
-			memset(vaddr_out + src_offset + 24, 0,  8);
+			bitmap_clear(vaddr_out + src_offset, 24, 8);
 			crc = crc32_le(crc, vaddr_out + src_offset,
 				       sizeof(u32));
 		}
-- 
2.27.0

