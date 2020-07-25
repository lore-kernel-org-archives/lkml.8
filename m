Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5323BC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E351206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbNTN2vP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgGYD0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 23:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgGYD0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:26:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15203C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 20:26:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so6277759pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 20:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H0jwgkKJw1F2QGrxp3XRsBO4Zv0vbxAb7H7LFDlABiQ=;
        b=RbNTN2vPJ+dA/LwMFiC3sJgHNi9P7iDpEf0QPN9vRRqQ7v6rh8ugXQpi5Vouhpb/+x
         E/SZz2L0MCrCHEVHr9cQu4Fa+J9Oq6lk738yyuyDRw+2Ej5YQOGNQjVEs6rpQ38YxvVY
         mrkXyY/dpROjus1mzoaCe3ZvJaPBbZsCVRiB3LkavibRHIGwVH5CbMFDNohLUpHSyO1R
         Hf0jM7DvjDSq3Id5l1M0ElsmQ1zPlI5eziR8fpmSC7io0yxpn4ckZiTj+RBX2EA7SUhy
         pmLxYj5HhfjFkeeE+7fkuSm24xWP8b4xfqAthKMGLZI9OKgeJEKSaT1uD/uQzBOK3UST
         A6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H0jwgkKJw1F2QGrxp3XRsBO4Zv0vbxAb7H7LFDlABiQ=;
        b=HjMc6+t0mkuA9ryhQigN2+sRZG5IU/ir9amK3VC35Db+0ddzSsNnFkiFTc0XiUtJE8
         5civnDgS7A7CGGMW0y5N8hMaWiOvREshoGR73/AAmZiH7WZrzGF3jAi/Z1C7Arl7UGxR
         Qk4QGkhUHOXSUTSEpqJLPjTnx8Rd4lUlmhlnh56JA1kFM+to2Xui2zZ8AX4EiAt5jeZl
         uVRwINNZ5mtKWCy7mncsyKMMIscTCt/NAqFuBiVANlo21RnlrFXKAZrHulg17NCDV70M
         4rRffyNNosF3ig00FZS1WTOT7AfXG0tmLz8P4dnw3w6h7h3O5U4bUPPCXhUDR30HZYih
         ApJw==
X-Gm-Message-State: AOAM531jdahI41mi2EdpCwxfniwmDxyJIYylZhG+OHSuVw6fYY/rD6lb
        pNfYveznmNBsZJk376YWDJvFpPJeuxE=
X-Google-Smtp-Source: ABdhPJye4Zi1p+g7i5EeVNtB5XOqoG/SM8okB5VAhbaF1GX8NRKfTkCuaLkqofWvksTtGS/kYQYgww==
X-Received: by 2002:a63:fe42:: with SMTP id x2mr11177808pgj.207.1595647597349;
        Fri, 24 Jul 2020 20:26:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 204sm7754074pfx.3.2020.07.24.20.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 20:26:36 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH] dma-heap: Add proper kref handling on dma-buf heaps
Date:   Sat, 25 Jul 2020 03:26:33 +0000
Message-Id: <20200725032633.125006-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper refcounting on the dma_heap structure.
While existing heaps are built-in, we may eventually
have heaps loaded from modules, and we'll need to be
able to properly handle the references to the heaps

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/dma-heap.c | 31 +++++++++++++++++++++++++++----
 include/linux/dma-heap.h   |  6 ++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index afd22c9dbdcf..90c3720acc1c 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -40,6 +40,8 @@ struct dma_heap {
 	dev_t heap_devt;
 	struct list_head list;
 	struct cdev heap_cdev;
+	int minor;
+	struct kref refcount;
 };
 
 static LIST_HEAD(heap_list);
@@ -190,11 +192,31 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
 	return heap->priv;
 }
 
+static void dma_heap_release(struct kref *ref)
+{
+	struct dma_heap *heap = container_of(ref, struct dma_heap, refcount);
+
+	/* Remove heap from the list */
+	mutex_lock(&heap_list_lock);
+	list_del(&heap->list);
+	mutex_unlock(&heap_list_lock);
+
+	device_destroy(dma_heap_class, heap->heap_devt);
+	cdev_del(&heap->heap_cdev);
+	xa_erase(&dma_heap_minors, heap->minor);
+
+	kfree(heap);
+}
+
+void dma_heap_put(struct dma_heap *h)
+{
+	kref_put(&h->refcount, dma_heap_release);
+}
+
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 {
 	struct dma_heap *heap, *h, *err_ret;
 	struct device *dev_ret;
-	unsigned int minor;
 	int ret;
 
 	if (!exp_info->name || !strcmp(exp_info->name, "")) {
@@ -223,12 +245,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	if (!heap)
 		return ERR_PTR(-ENOMEM);
 
+	kref_init(&heap->refcount);
 	heap->name = exp_info->name;
 	heap->ops = exp_info->ops;
 	heap->priv = exp_info->priv;
 
 	/* Find unused minor number */
-	ret = xa_alloc(&dma_heap_minors, &minor, heap,
+	ret = xa_alloc(&dma_heap_minors, &heap->minor, heap,
 		       XA_LIMIT(0, NUM_HEAP_MINORS - 1), GFP_KERNEL);
 	if (ret < 0) {
 		pr_err("dma_heap: Unable to get minor number for heap\n");
@@ -237,7 +260,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	}
 
 	/* Create device */
-	heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), minor);
+	heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), heap->minor);
 
 	cdev_init(&heap->heap_cdev, &dma_heap_fops);
 	ret = cdev_add(&heap->heap_cdev, heap->heap_devt, 1);
@@ -267,7 +290,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 err2:
 	cdev_del(&heap->heap_cdev);
 err1:
-	xa_erase(&dma_heap_minors, minor);
+	xa_erase(&dma_heap_minors, heap->minor);
 err0:
 	kfree(heap);
 	return err_ret;
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 454e354d1ffb..c1572f29cfac 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -56,4 +56,10 @@ void *dma_heap_get_drvdata(struct dma_heap *heap);
  */
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info);
 
+/**
+ * dma_heap_put - drops a reference to a dmabuf heaps, potentially freeing it
+ * @heap:		heap pointer
+ */
+void dma_heap_put(struct dma_heap *heap);
+
 #endif /* _DMA_HEAPS_H */
-- 
2.17.1

