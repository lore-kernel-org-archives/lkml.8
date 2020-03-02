Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676AAC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AEC2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RbeH33OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgCBMPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:15:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37808 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgCBMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:15:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so5355273pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 04:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDVKWN8XWWDBkIxhOMDWJ8WNqkbJxq41FKX/p0TJDsQ=;
        b=RbeH33OKo6ex4yBiWGoHZuPQZDFiMdnr74+jO7xV8RBZ/HBqXUwdgRgeWFajr7tksx
         nkaHJorAAEdADlX0fiP8/9c5+GvwCWUWeQ4VEYBE6+cMhEG6KMgTVJkGriOPtN/faamn
         kQPWVhol1Rc4kvzN1WSkWTuwQMD/+N+ZL/elI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDVKWN8XWWDBkIxhOMDWJ8WNqkbJxq41FKX/p0TJDsQ=;
        b=OQ9TcVRKMnLs8IKdMdrPCkfNgdsjO2SxxbUyHpdAghFEGQKR6bpJMJQR/NDMuP/92g
         Z9Q1vCdfuyueoXf23O6AAbwiRR+q4Ps+MrY3n2CdK5fSOtRrso4W1Xooj05oo9aAXUrW
         urARmccv5+DnvDlxLinHm220lID19lJ2WJeuF0BYQF/+4nnpDbATYrqys+Ujx79UUTia
         nKeRpEsnva+wJzDk458wDYBq3QyE/W9Yw4fwYrEBU1ZIUcmqTAPnhnFjQh3L2HEFVt+G
         EOaCAsKsmlqRY5ENKD7iMS2emfM2irwkU12qABOqyVU13MaK3vmqtcr1RaFIZDKeKfRY
         QuOw==
X-Gm-Message-State: APjAAAWbbG0RTR04N1KYos8A4FE37N+Qv1C4f0hz2U45813ULuwcG3OP
        bS4vm9A4g/g1Fbj8MmpILFWfGa/ozh8=
X-Google-Smtp-Source: APXvYqxZ1YfM7I9O5uFy/PJVuxbZj1mE7Mg7Fm9ZeSEO9i+JiSLEETE1w1UTUusb8qRcUt3IahS3Fw==
X-Received: by 2002:a65:53c9:: with SMTP id z9mr17640332pgr.405.1583151339181;
        Mon, 02 Mar 2020 04:15:39 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:30f2:7a9c:387e:6c7])
        by smtp.gmail.com with ESMTPSA id e9sm12708987pjt.16.2020.03.02.04.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 04:15:38 -0800 (PST)
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
Subject: [PATCH v2 1/4] dma-buf: add support for virtio exported objects
Date:   Mon,  2 Mar 2020 21:15:21 +0900
Message-Id: <20200302121524.7543-2-stevensd@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200302121524.7543-1-stevensd@chromium.org>
References: <20200302121524.7543-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a new dma-buf operation that allows dma-bufs to be used
by virtio drivers to share exported objects. The new operation allows
the importing driver to query the exporting driver for the UUID which
identifies the underlying exported object.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/dma-buf/dma-buf.c | 14 ++++++++++++++
 include/linux/dma-buf.h   | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d4097856c86b..a04632284ec2 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1158,6 +1158,20 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, void *vaddr)
 }
 EXPORT_SYMBOL_GPL(dma_buf_vunmap);
 
+#ifdef CONFIG_VIRTIO
+int dma_buf_get_uuid(struct dma_buf *dmabuf, uuid_t *uuid)
+{
+	if (WARN_ON(!dmabuf) || !uuid)
+		return -EINVAL;
+
+	if (!dmabuf->ops->get_uuid)
+		return -ENODEV;
+
+	return dmabuf->ops->get_uuid(dmabuf, uuid);
+}
+EXPORT_SYMBOL_GPL(dma_buf_get_uuid);
+#endif
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index abf5459a5b9d..f5fecf8abe6a 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -251,6 +251,23 @@ struct dma_buf_ops {
 
 	void *(*vmap)(struct dma_buf *);
 	void (*vunmap)(struct dma_buf *, void *vaddr);
+
+#ifdef CONFIG_VIRTIO
+	/**
+	 * @get_uuid
+	 *
+	 * This is called by dma_buf_get_uuid to get the UUID which identifies
+	 * the buffer to virtio devices.
+	 *
+	 * This callback is optional.
+	 *
+	 * Returns:
+	 *
+	 * 0 on success or a negative error code on failure. On success uuid
+	 * will be populated with the buffer's UUID.
+	 */
+	int (*get_uuid)(struct dma_buf *dmabuf, uuid_t *uuid);
+#endif
 };
 
 /**
@@ -444,4 +461,9 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
 		 unsigned long);
 void *dma_buf_vmap(struct dma_buf *);
 void dma_buf_vunmap(struct dma_buf *, void *vaddr);
+
+#ifdef CONFIG_VIRTIO
+int dma_buf_get_uuid(struct dma_buf *dmabuf, uuid_t *uuid);
+#endif
+
 #endif /* __DMA_BUF_H__ */
-- 
2.25.0.265.gbab2e86ba0-goog

