Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF7C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43B12070B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tF2OVncK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgDTNUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbgDTNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:20:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46ECC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:20:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so12100386wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPdZQyRabt6he4bhfa5uiDoDto3iaERte2f8Bkdq2dw=;
        b=tF2OVncK+ugkAA0A6/qVKJOT2F+p1Xs+5i9grlHooTDlg6Xh4UXsF6uAmEs1dcFDT8
         o5OhLCJ0mYBEMkKpj6VVsq0/afAdQ5ds/MC+4PXXMoeNk3a2vwbR87IoOZUN6B5CxzwZ
         aMJ35ThdS6B/A9OWe1PAyCfDQDve3XV3cc9d16fuGBEnbhpvNc0DLKAmR7bHc90tq/MO
         2g3eFdXnKnRJPwuiNPfBJWZhNYyTVC4s3siecJR2qEctGPo/a/Xxtt87gnoRpB1Y2jHT
         GHojSiqt35ROFpABxTxzHxAKnveIfz2S86dEoJNZAaY9011wZDahmwerFOoMRbuUs+BX
         kZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPdZQyRabt6he4bhfa5uiDoDto3iaERte2f8Bkdq2dw=;
        b=jRQKcaap+Oz2VsNReDG5E3tlx0FzknrjSfNJmdO3IxCjbgJW8VBhWs1LjSheFA4bZn
         JTJELQPQ7NL/OlGSPgN+hpE+W9kHGanVYd7r0dzSLmMZmCd6RRSA3VZ/xYIK2/UAXWoI
         fVdXx0Ipk1D5w9ENCLPgti2XPjEvJcMVp+b+l3YOou6tiuiHFCZIH9b1FsqFvPnaK+1K
         S0Mr8DKvCWhm4iCQI8Q7jK2zK8NebSxL+iZK4pWckNCf5DeUk1b3C1t4v+cRVYrO9ab8
         6JkLo4FVCzjKzZ34p9J4xbldWoxhTYQT6wDF/QEZsmtZXuQ0CQY8XsgAcU5PzF6NAXA3
         alcg==
X-Gm-Message-State: AGi0PubWEKu4Terw4EQ8W977nKeKRpPRvW06B8lSVyTM1bKC3UPr7qRk
        Gs0ijepP7N1y8UZsC+hXNVZRuk9D
X-Google-Smtp-Source: APiQypLTT+egxtT73HLwY0UOVwG+pILDTsDsZ1ej+0/Fx34zgMak60ZvBvwtp3mCSthkZBRng6HwzA==
X-Received: by 2002:adf:f748:: with SMTP id z8mr9539405wrp.45.1587388808377;
        Mon, 20 Apr 2020 06:20:08 -0700 (PDT)
Received: from PC192-168-2-103.speedport.ip (p5B05E57B.dip0.t-ipconnect.de. [91.5.229.123])
        by smtp.gmail.com with ESMTPSA id z76sm1545815wmc.9.2020.04.20.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:20:08 -0700 (PDT)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, david@redhat.com, mst@redhat.com,
        jmoyer@redhat.com, pankaj.gupta@cloud.ionos.com,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [RFC 2/2] virtio_pmem: Async virtio-pmem flush
Date:   Mon, 20 Apr 2020 15:19:47 +0200
Message-Id: <20200420131947.41991-3-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
References: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch enables asynchronous flush for virtio pmem
 using work queue. Also, it coalesce the flush requests
 when a flush is already in process.

Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 drivers/nvdimm/nd_virtio.c   | 62 ++++++++++++++++++++++++++----------
 drivers/nvdimm/virtio_pmem.c |  9 ++++++
 drivers/nvdimm/virtio_pmem.h | 14 ++++++++
 3 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 10351d5b49fa..ef53d0a0d134 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -97,29 +97,57 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	return err;
 };
 
+static void submit_async_flush(struct work_struct *ws);
+
 /* The asynchronous flush callback function */
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 {
-	/*
-	 * Create child bio for asynchronous flush and chain with
-	 * parent bio. Otherwise directly call nd_region flush.
-	 */
-	if (bio && bio->bi_iter.bi_sector != -1) {
-		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
-
-		if (!child)
-			return -ENOMEM;
-		bio_copy_dev(child, bio);
-		child->bi_opf = REQ_PREFLUSH;
-		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
-		return 0;
+	struct virtio_device *vdev = nd_region->provider_data;
+	struct virtio_pmem *vpmem  = vdev->priv;
+	ktime_t start = ktime_get_boottime();
+
+	spin_lock_irq(&vpmem->lock);
+	wait_event_lock_irq(vpmem->sb_wait,
+			    !vpmem->flush_bio ||
+			    ktime_after(vpmem->last_flush, start),
+			    vpmem->lock);
+
+	if (!ktime_after(vpmem->last_flush, start)) {
+		WARN_ON(vpmem->flush_bio);
+		vpmem->flush_bio = bio;
+		bio = NULL;
 	}
-	if (virtio_pmem_flush(nd_region))
-		return -EIO;
+	spin_unlock_irq(&vpmem->lock);
 
+	if (!bio) {
+		INIT_WORK(&vpmem->flush_work, submit_async_flush);
+		queue_work(vpmem->pmem_wq, &vpmem->flush_work);
+		return 1;
+	}
+
+	bio->bi_opf &= ~REQ_PREFLUSH;
 	return 0;
 };
 EXPORT_SYMBOL_GPL(async_pmem_flush);
+
+static void submit_async_flush(struct work_struct *ws)
+{
+	struct virtio_pmem *vpmem = container_of(ws, struct virtio_pmem, flush_work);
+	struct bio *bio = vpmem->flush_bio;
+
+	vpmem->start_flush = ktime_get_boottime();
+	bio->bi_status = errno_to_blk_status(virtio_pmem_flush(vpmem->nd_region));
+	vpmem->last_flush = vpmem->start_flush;
+	vpmem->flush_bio = NULL;
+	wake_up(&vpmem->sb_wait);
+
+	/* Submit parent bio only for PREFLUSH */
+	if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
+		bio->bi_opf &= ~REQ_PREFLUSH;
+		submit_bio(bio);
+	} else if (bio && (bio->bi_opf & REQ_FUA)) {
+		bio->bi_opf &= ~REQ_FUA;
+		bio_endio(bio);
+	}
+}
 MODULE_LICENSE("GPL");
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 5e3d07b47e0c..4ab135d820fd 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -24,6 +24,7 @@ static int init_vq(struct virtio_pmem *vpmem)
 		return PTR_ERR(vpmem->req_vq);
 
 	spin_lock_init(&vpmem->pmem_lock);
+	spin_lock_init(&vpmem->lock);
 	INIT_LIST_HEAD(&vpmem->req_list);
 
 	return 0;
@@ -58,6 +59,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_err;
 	}
 
+	vpmem->pmem_wq = alloc_workqueue("vpmem_wq", WQ_MEM_RECLAIM, 0);
+	if (!vpmem->pmem_wq) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+	init_waitqueue_head(&vpmem->sb_wait);
 	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
 			start, &vpmem->start);
 	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
@@ -90,10 +97,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_nd;
 	}
 	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
+	vpmem->nd_region = nd_region;
 	return 0;
 out_nd:
 	nvdimm_bus_unregister(vpmem->nvdimm_bus);
 out_vq:
+	destroy_workqueue(vpmem->pmem_wq);
 	vdev->config->del_vqs(vdev);
 out_err:
 	return err;
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index 0dddefe594c4..9d3615a324bf 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -35,9 +35,23 @@ struct virtio_pmem {
 	/* Virtio pmem request queue */
 	struct virtqueue *req_vq;
 
+	struct bio *flush_bio;
+	/* last_flush is when the last completed flush was started */
+	ktime_t last_flush, start_flush;
+
+	/* work queue for deferred flush */
+	struct work_struct flush_work;
+	struct workqueue_struct *pmem_wq;
+
+	/* Synchronize flush wait queue data */
+	spinlock_t lock;
+	/* for waiting for previous flush to complete */
+	wait_queue_head_t sb_wait;
+
 	/* nvdimm bus registers virtio pmem device */
 	struct nvdimm_bus *nvdimm_bus;
 	struct nvdimm_bus_descriptor nd_desc;
+	struct nd_region *nd_region;
 
 	/* List to store deferred work if virtqueue is full */
 	struct list_head req_list;
-- 
2.20.1

