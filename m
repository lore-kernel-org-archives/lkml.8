Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319F9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE6C207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrAQkFT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgHRQCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgHRQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:02:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8FC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:02:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 128so9956965pgd.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8CE3NEQmVRAQk8SeoQWuBofL/MMdsAZ7wPp6ycr/jPc=;
        b=PrAQkFT0ao4oEqu0oXGLnDdvVaoItpjRDtF1+2PnvmWYEDH84b+Eqb8sXDCx9w4ZE5
         paw+nQVHkxE4v9S2FRTJfzgs01qcsRT5zYK8whc3vwN9D92j5XeQapbEH9Em9eTVeop8
         f+RS6/OmGSHfj4HLsMit9qOOl73V5XjA9fhCGq8HrYzq8Hbvbu3usR+g2klIq2NMkSuz
         QKMCcU2wVZb59IGoS1xE8VqJiZreygOLAP+A7jA94AixnQob4jr2/OgScvLHdq8psgtj
         8j7FPc2PXjodZhUJYsZi018Zfv9XWvm7BXEk+bU1lC+UuZmTOTKfRWTxGdt3g69bOduj
         qGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8CE3NEQmVRAQk8SeoQWuBofL/MMdsAZ7wPp6ycr/jPc=;
        b=qFn/one0xSAjOcMMhhBwhYfHRElDilf62E3iTo936LqvwUp3oEuvUj6vG4WvCrSPNf
         DuyUnVwBma3H+WLDlvSU1c+1Cr08wVQBJDSR48ZAkRkP7JRvMe5ir+8hCQBQxWX/3x4q
         d4Kax1fIl/jwlAD/2fuSodiyHpP6A7uuMKFxiWCJ93NbiUjt0aPKrRab7oUwL+OAkrZd
         oqxVjCFaNozo42tYJpFmgaZrvRNPbyjDeVi3nZNS0XFwIZ1fW4LkT2hBuE4ytwNt2N2g
         mHrYKh5j7xh8RgQVf8fcQL2C0fbihu3a022x5m6ESqFY8IcvwsGBwiWhMSDer6Ksq2qP
         IXQQ==
X-Gm-Message-State: AOAM530rBEv2nur2QHW9NRGRkxvI74IOShD4BRHteAg03FwhmU9KkRA7
        5k/UbCMBdBkg2NsVIo8ZXh4=
X-Google-Smtp-Source: ABdhPJzbc/f60fNKlmZkmTn6d7uXjcwOGKKY/TMIqF+fK3OP2elNRBEgf+BJEBdbs0ZK1z600GDsIQ==
X-Received: by 2002:a62:3856:: with SMTP id f83mr16079581pfa.35.1597766552881;
        Tue, 18 Aug 2020 09:02:32 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id g16sm297997pjz.52.2020.08.18.09.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:02:32 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Sidong Yang <realwakka@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] drm/vkms: Use alpha value to blend values.
Date:   Tue, 18 Aug 2020 16:02:15 +0000
Message-Id: <20200818160215.19550-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote this patch for TODO list in vkms documentation.

Use alpha value to blend source value and destination value Instead of
just overwrite with source value.

Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 4f3b07a32b60..e3230e2a99af 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -77,6 +77,9 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 
 	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
 		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
+			u8 *src, *dst;
+			u32 alpha, inv_alpha;
+
 			offset_dst = dest_composer->offset
 				     + (i_dst * dest_composer->pitch)
 				     + (j_dst++ * dest_composer->cpp);
@@ -84,8 +87,15 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 				     + (i * src_composer->pitch)
 				     + (j * src_composer->cpp);
 
-			memcpy(vaddr_dst + offset_dst,
-			       vaddr_src + offset_src, sizeof(u32));
+			src = vaddr_src + offset_src;
+			dst = vaddr_dst + offset_dst;
+			alpha = src[3] + 1;
+			inv_alpha = 256 - src[3];
+			dst[0] = (alpha * src[0] + inv_alpha * dst[0]) >> 8;
+			dst[1] = (alpha * src[1] + inv_alpha * dst[1]) >> 8;
+			dst[2] = (alpha * src[2] + inv_alpha * dst[2]) >> 8;
+			dst[3] = 0xff;
+
 		}
 		i_dst++;
 	}
-- 
2.17.1

