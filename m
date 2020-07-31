Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6096C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8228C2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpFdItwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgGaMvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730743AbgGaMvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:51:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E0FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:51:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so32295460ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hf2m1CaACgkl3i0FS0MjmjyDubimZdTD8G//CB5QIMY=;
        b=WpFdItwLmE1h/jcPKXj3mRmyaF+TKN3FWkbAvN9i01/b/GBnQQrfqTYPD3KkCl+HER
         4a3yBnoP8xZ1+beeiIJ9vfMIpoL/Uq0aKjRgj9n3gDAB35PWSD+52cvI8qsbw9MMxnde
         Ogk+jE2mX/g7LFVkGpGWoSr7sD8Yog+cmIHDyOr5lEBZFzgPS2kU4Fuv8LCiEtAMJi4Y
         V/MPagzOAVhsCHI/ruYoFU5NgrrL0yQ5Bln8moUVlTyOMw3rTQ7cCkra3lYcATWDogf/
         jBRFwFf8eSKHB5WoChdB5jL9GonvtcReyID4iSV0w2pPa3lh5NAPcP/9Jan5UaU8YB8u
         zvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hf2m1CaACgkl3i0FS0MjmjyDubimZdTD8G//CB5QIMY=;
        b=SWK7tQ/XLO+rxbst2xx0TIa6jEH0AytNg73OcifyZ/EqhzwqJ5jh8PlUqtQ2jHvr2b
         S1jv+Aixyy/wNQ8dDATZ14tWK8uwXYuysssxgn/87U/612qfYwouKPRza5tUJlhRU1r0
         JwF3hVNNYuE2EOh74pyU+R6yKGBvUdss1fDNysY77caKzZ2iAT7VbXiEq0POHVB1Yxvq
         Aup4Hf0Ppns7Vqna8ViwzfXd9/u0Gx9Ue+NM1TnlqjN6WTHUYWpzDHDJw7tB59Bgojn6
         WpR237wzjKPMGG6+gDgqbiaxLGcHbLHDggk9+YXGCjn125TsM8w24CBvg0Cy4sgcX1K5
         HxnQ==
X-Gm-Message-State: AOAM533QvwNR5yESyN9I3WE63VQzyl05U1Q090PCY7SJgew0B3qJ9IMJ
        nG3PhXmh63TLgEqlhHVkq8c=
X-Google-Smtp-Source: ABdhPJyAr3EgNy6m0bxN5SP4DJ54ompCgY6CBLlI16M8yY4FlCVLhiNPKf3qPH+txZ2PmAgUTW2prA==
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr1932560ljk.309.1596199875447;
        Fri, 31 Jul 2020 05:51:15 -0700 (PDT)
Received: from a2klaptop.localdomain ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id s2sm1923362lfs.4.2020.07.31.05.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:51:14 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sstabellini@kernel.org, dan.carpenter@oracle.com,
        intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 2/6] drm/xen-front: Fix misused IS_ERR_OR_NULL checks
Date:   Fri, 31 Jul 2020 15:51:05 +0300
Message-Id: <20200731125109.18666-3-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731125109.18666-1-andr2000@gmail.com>
References: <20200731125109.18666-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

The patch c575b7eeb89f: "drm/xen-front: Add support for Xen PV
display frontend" from Apr 3, 2018, leads to the following static
checker warning:

	drivers/gpu/drm/xen/xen_drm_front_gem.c:140 xen_drm_front_gem_create()
	warn: passing zero to 'ERR_CAST'

drivers/gpu/drm/xen/xen_drm_front_gem.c
   133  struct drm_gem_object *xen_drm_front_gem_create(struct drm_device *dev,
   134                                                  size_t size)
   135  {
   136          struct xen_gem_object *xen_obj;
   137
   138          xen_obj = gem_create(dev, size);
   139          if (IS_ERR_OR_NULL(xen_obj))
   140                  return ERR_CAST(xen_obj);

Fix this and the rest of misused places with IS_ERR_OR_NULL in the
driver.

Fixes:  c575b7eeb89f: "drm/xen-front: Add support for Xen PV display frontend"

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/xen/xen_drm_front.c     | 4 ++--
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 8 ++++----
 drivers/gpu/drm/xen/xen_drm_front_kms.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 3e660fb111b3..88db2726e8ce 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -400,8 +400,8 @@ static int xen_drm_drv_dumb_create(struct drm_file *filp,
 	args->size = args->pitch * args->height;
 
 	obj = xen_drm_front_gem_create(dev, args->size);
-	if (IS_ERR_OR_NULL(obj)) {
-		ret = PTR_ERR_OR_ZERO(obj);
+	if (IS_ERR(obj)) {
+		ret = PTR_ERR(obj);
 		goto fail;
 	}
 
diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index f0b85e094111..4ec8a49241e1 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -83,7 +83,7 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
 
 	size = round_up(size, PAGE_SIZE);
 	xen_obj = gem_create_obj(dev, size);
-	if (IS_ERR_OR_NULL(xen_obj))
+	if (IS_ERR(xen_obj))
 		return xen_obj;
 
 	if (drm_info->front_info->cfg.be_alloc) {
@@ -117,7 +117,7 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
 	 */
 	xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
 	xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
-	if (IS_ERR_OR_NULL(xen_obj->pages)) {
+	if (IS_ERR(xen_obj->pages)) {
 		ret = PTR_ERR(xen_obj->pages);
 		xen_obj->pages = NULL;
 		goto fail;
@@ -136,7 +136,7 @@ struct drm_gem_object *xen_drm_front_gem_create(struct drm_device *dev,
 	struct xen_gem_object *xen_obj;
 
 	xen_obj = gem_create(dev, size);
-	if (IS_ERR_OR_NULL(xen_obj))
+	if (IS_ERR(xen_obj))
 		return ERR_CAST(xen_obj);
 
 	return &xen_obj->base;
@@ -194,7 +194,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
 
 	size = attach->dmabuf->size;
 	xen_obj = gem_create_obj(dev, size);
-	if (IS_ERR_OR_NULL(xen_obj))
+	if (IS_ERR(xen_obj))
 		return ERR_CAST(xen_obj);
 
 	ret = gem_alloc_pages_array(xen_obj, size);
diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index 78096bbcd226..ef11b1e4de39 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -60,7 +60,7 @@ fb_create(struct drm_device *dev, struct drm_file *filp,
 	int ret;
 
 	fb = drm_gem_fb_create_with_funcs(dev, filp, mode_cmd, &fb_funcs);
-	if (IS_ERR_OR_NULL(fb))
+	if (IS_ERR(fb))
 		return fb;
 
 	gem_obj = fb->obj[0];
-- 
2.17.1

