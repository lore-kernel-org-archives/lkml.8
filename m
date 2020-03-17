Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B03C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF4F20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hxJgJ/Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCQRGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:06:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38923 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgCQRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:06:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id f7so69079wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6QHkzV5BBkFfgyNZs6t/GKJbiMk0jnjw8C1dAu/YqA=;
        b=hxJgJ/CsEzZ4gWXbhwVkCscaWC4g9ZHYHHOoCzpnECMslLCAGScgK7zGzJV3JxKcgy
         0nqrSDECdp4yCB6zMNDu+pqFodd+/KOYXXn/AyCcEAmjnSzChD6YexgVL9wDssuvgft0
         G5LXQyTe0arN/FwTIgny0CU7fk+c4HU+frngE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6QHkzV5BBkFfgyNZs6t/GKJbiMk0jnjw8C1dAu/YqA=;
        b=UQARtpk6FjIjfCv6vMIrMs3grJsZAo9L9tx8fm+me78vhKsTXZBW8HaAZXNJQkVe2F
         n/xc0j9YLjNG56R32/NruXcIZzLe5xnEj/AiRWdw14ahfPz7yw0AMbkgePPRZipEWP1n
         Z6NGn7ar8Z+e38swFN4Cq7N4QxK3Qc1I8QKtgX2dN6ohy7FQG8JFlbPetS0TAd3NB/fz
         +hzNSz94M2WagGBqnXzWusCQ5cK8GjukXlIP6Z7fMmz05sxxC7IRwJb6QdpInMutfa4i
         kv5+vQPh6DDR04CFi1i1EgcSCCNXLPGeKnHQ1mecKPZWsSwTyKBqjvQVFWI4m4M9Teng
         pINw==
X-Gm-Message-State: ANhLgQ2NJ3Dn1JjgXeIuzcs2UhW8oe1E6vwzkElEKQkpsNAZv0O/cVBN
        Yft5i/7x4CZFyEKSZvuDAL34o87fGmd5L+WV
X-Google-Smtp-Source: ADFU+vtEgUB27vopeq8X2Q5eJtXEH8LMvVllU0OTEgK/JvAgmr4x4sQcJhvU6XRVrE6Zq2zfHcOSww==
X-Received: by 2002:a05:600c:2105:: with SMTP id u5mr220153wml.163.1584464768185;
        Tue, 17 Mar 2020 10:06:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x17sm61790wmi.28.2020.03.17.10.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 10:06:07 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, Joe Perches <joe@perches.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] MAINTAINERS: Better regex for dma_buf|fence|resv
Date:   Tue, 17 Mar 2020 18:06:02 +0100
Message-Id: <20200317170602.1021982-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're getting some random other stuff that we're not relly interested
in, so match only word boundaries. Also avoid the capture group while
at it.

Suggested by Joe Perches.

Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: Joe Perches <joe@perches.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
v2: No single quotes in MAINTAINERS (Joe)
---
 MAINTAINERS                   |  2 +-
 drivers/gpu/drm/drm_managed.c | 27 +++++++++++++++++----------
 include/drm/drm_managed.h     |  2 +-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3005be638c2c..ed6088a01bfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5025,7 +5025,7 @@ F:	include/linux/dma-buf*
 F:	include/linux/reservation.h
 F:	include/linux/*fence.h
 F:	Documentation/driver-api/dma-buf.rst
-K:	dma_(buf|fence|resv)
+K:	\bdma_(?:buf|fence|resv)\b
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DMA-BUF HEAPS FRAMEWORK
diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
index 5148ef786c3b..c256c9679eb5 100644
--- a/drivers/gpu/drm/drm_managed.c
+++ b/drivers/gpu/drm/drm_managed.c
@@ -52,6 +52,12 @@ struct drmres {
 	u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
 };
 
+static void free_dr(struct drmres *dr)
+{
+	kfree_const(dr->node.name);
+	kfree(dr);
+}
+
 void drm_managed_release(struct drm_device *dev)
 {
 	struct drmres *dr, *tmp;
@@ -65,13 +71,13 @@ void drm_managed_release(struct drm_device *dev)
 			dr->node.release(dev, dr->node.size ? *(void **)&dr->data : NULL);
 
 		list_del(&dr->node.entry);
-		kfree(dr);
+		free_dr(dr);
 	}
 	drm_dbg_drmres(dev, "drmres release end\n");
 }
 
 /*
- * Always inline so that kmallc_track_caller tracks the actual interesting
+ * Always inline so that kmalloc_track_caller tracks the actual interesting
  * caller outside of drm_managed.c.
  */
 static __always_inline struct drmres * alloc_dr(drmres_release_t release,
@@ -120,7 +126,7 @@ static void add_dr(struct drm_device *dev, struct drmres *dr)
 /**
  * drmm_add_final_kfree - add release action for the final kfree()
  * @dev: DRM device
- * @parent: pointer to the kmalloc allocation containing @dev
+ * @container: pointer to the kmalloc allocation containing @dev
  *
  * Since the allocation containing the struct &drm_device must be allocated
  * before it can be initialized with drm_dev_init() there's no way to allocate
@@ -129,12 +135,13 @@ static void add_dr(struct drm_device *dev, struct drmres *dr)
  * will be released in the final drm_dev_put() for @dev, after all other release
  * actions installed through drmm_add_action() have been processed.
  */
-void drmm_add_final_kfree(struct drm_device *dev, void *parent)
+void drmm_add_final_kfree(struct drm_device *dev, void *container)
 {
 	WARN_ON(dev->managed.final_kfree);
-	WARN_ON(dev < (struct drm_device *) parent);
-	WARN_ON(dev + 1 >= (struct drm_device *) (parent + ksize(parent)));
-	dev->managed.final_kfree = parent;
+	WARN_ON(dev < (struct drm_device *) container);
+	WARN_ON(dev + 1 >=
+		(struct drm_device *) (container + ksize(container)));
+	dev->managed.final_kfree = container;
 }
 EXPORT_SYMBOL(drmm_add_final_kfree);
 
@@ -154,7 +161,7 @@ int __drmm_add_action(struct drm_device *dev,
 		return -ENOMEM;
 	}
 
-	dr->node.name = name;
+	dr->node.name = kstrdup_const(name, GFP_KERNEL);
 	if (data) {
 		void_ptr = (void **)&dr->data;
 		*void_ptr = data;
@@ -212,7 +219,7 @@ void drmm_remove_action(struct drm_device *dev,
 	if (WARN_ON(!dr))
 		return;
 
-	kfree(dr);
+	free_dr(dr);
 }
 EXPORT_SYMBOL(drmm_remove_action);
 
@@ -300,6 +307,6 @@ void drmm_kfree(struct drm_device *dev, void *data)
 	if (WARN_ON(!dr_match))
 		return;
 
-	kfree(dr_match);
+	free_dr(dr_match);
 }
 EXPORT_SYMBOL(drmm_kfree);
diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
index af152cfb173c..e4021484c78d 100644
--- a/include/drm/drm_managed.h
+++ b/include/drm/drm_managed.h
@@ -51,7 +51,7 @@ void drmm_remove_action(struct drm_device *dev,
 			drmres_release_t action,
 			void *data);
 
-void drmm_add_final_kfree(struct drm_device *dev, void *parent);
+void drmm_add_final_kfree(struct drm_device *dev, void *container);
 
 void *drmm_kmalloc(struct drm_device *dev, size_t size, gfp_t gfp) __malloc;
 
-- 
2.25.1

