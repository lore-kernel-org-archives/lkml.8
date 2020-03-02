Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C78C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB470214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KtxIhZ5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgCBMPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:15:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgCBMPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:15:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id h8so5343493pgs.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 04:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MCeo2KlvghZWVQTpBB2M3t/GqxIcmv4hUXrDyywqjuA=;
        b=KtxIhZ5KSuM307kYGYUjWPph23TtSi3zkl41oYk+e1N7AfE29LJ3C6CKjZkYNgKjpw
         4L7yKKgpbAX7P0xTk/2dEvii1zi6OjS959+FmubaRaysgfdGmCfNOp6qbVyZpA/iBBmT
         psh7VxYuvg7KhzEYy0kpZHTDWLa1eXUASldIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MCeo2KlvghZWVQTpBB2M3t/GqxIcmv4hUXrDyywqjuA=;
        b=djfcViUH492N/QgsrF2XAnVwf8mevhFNkpCVAcYjFWjFy16jhNAUNq29rzRqJisSRD
         4EtDqtXTgmwuxnz1mS2KMH5y3LSA2rQYPcO3pE6cG5vMZBlWQWBxZbru/HJsVlSxZQI5
         dlsOMzZLG6lHOi7hT6gZb8M2Dh8k5Ts6YFE0ip9ofjskgBP+7eF7uSMCtJ3HAm0Cp6c+
         qkYkqYkFZwHDn364630ZM8Zyr9D50N2cVs04u38A+5ppOA28Vc8NSU9697G4kAnwx7XW
         vJGKPTjHaM7uBOkWSsmhL3/g8FBi1RVSBz0FVN7cibYbZbBtEKS5vHas16QS1kKJ5Vlf
         jb+A==
X-Gm-Message-State: APjAAAWukCrTJuy9oKfG6OglihBTKlHUxdfsUFDGx2PiYfQt/C1GfrDV
        55xo91bub7wpnTxypomf12erbg==
X-Google-Smtp-Source: APXvYqxIIxTmqhb5EzFiF3tO0HTYSibpGKOCSX4H52SA6OGSHfrVeCkQaE0nBxoudGWjDs99vgRxuQ==
X-Received: by 2002:a63:fc62:: with SMTP id r34mr19239431pgk.437.1583151344152;
        Mon, 02 Mar 2020 04:15:44 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:30f2:7a9c:387e:6c7])
        by smtp.gmail.com with ESMTPSA id w26sm21819818pfj.119.2020.03.02.04.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 04:15:43 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
To:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Stevens <stevensd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        virtio-dev@lists.oasis-open.org
Subject: [PATCH v2 2/4] drm/prime: add support for virtio exported objects
Date:   Mon,  2 Mar 2020 21:15:22 +0900
Message-Id: <20200302121524.7543-3-stevensd@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200302121524.7543-1-stevensd@chromium.org>
References: <20200302121524.7543-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change exposes dma-buf's get_uuid callback to PRIME drivers.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/gpu/drm/drm_prime.c | 27 +++++++++++++++++++++++++++
 include/drm/drm_drv.h       | 15 +++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 86d9b0e45c8c..fc6e932a4fa6 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -779,6 +779,30 @@ int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma)
 }
 EXPORT_SYMBOL(drm_gem_dmabuf_mmap);
 
+#ifdef CONFIG_VIRTIO
+/**
+ * drm_gem_dmabuf_get_uuid - dma_buf get_uuid implementation for GEM
+ * @dma_buf: buffer to query
+ * @uuid: uuid outparam
+ *
+ * Queries the buffer's virtio UUID. This can be used as the
+ * &dma_buf_ops.get_uuid callback. Calls into &drm_driver.gem_prime_get_uuid.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int drm_gem_dmabuf_get_uuid(struct dma_buf *dma_buf, uuid_t *uuid)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+	struct drm_device *dev = obj->dev;
+
+	if (!dev->driver->gem_prime_get_uuid)
+		return -ENODEV;
+
+	return dev->driver->gem_prime_get_uuid(obj, uuid);
+}
+EXPORT_SYMBOL(drm_gem_dmabuf_get_uuid);
+#endif
+
 static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
 	.cache_sgt_mapping = true,
 	.attach = drm_gem_map_attach,
@@ -789,6 +813,9 @@ static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
 	.mmap = drm_gem_dmabuf_mmap,
 	.vmap = drm_gem_dmabuf_vmap,
 	.vunmap = drm_gem_dmabuf_vunmap,
+#ifdef CONFIG_VIRTIO
+	.get_uuid = drm_gem_dmabuf_get_uuid,
+#endif
 };
 
 /**
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 77685ed7aa65..3cbe9aa6b44a 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -32,6 +32,10 @@
 
 #include <drm/drm_device.h>
 
+#ifdef CONFIG_VIRTIO
+#include <linux/uuid.h>
+#endif
+
 struct drm_file;
 struct drm_gem_object;
 struct drm_master;
@@ -639,6 +643,17 @@ struct drm_driver {
 	int (*gem_prime_mmap)(struct drm_gem_object *obj,
 				struct vm_area_struct *vma);
 
+#ifdef CONFIG_VIRTIO
+	/**
+	 * @gem_prime_get_uuid
+	 *
+	 * get_uuid hook for GEM drivers. Retrieves the virtio uuid of the
+	 * given GEM buffer.
+	 */
+	int (*gem_prime_get_uuid)(struct drm_gem_object *obj,
+				  uuid_t *uuid);
+#endif
+
 	/**
 	 * @dumb_create:
 	 *
-- 
2.25.0.265.gbab2e86ba0-goog

