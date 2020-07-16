Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4369DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2813B20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGPCmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:42:36 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41555 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727833AbgGPCmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:42:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0U2rTvA2_1594867348;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0U2rTvA2_1594867348)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jul 2020 10:42:32 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     mst@redhat.com, david@redhat.com, jasowang@redhat.com,
        akpm@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [RFC for Linux v4 2/2] virtio_balloon: Add deflate_cont_vq to deflate continuous pages
Date:   Thu, 16 Jul 2020 10:41:52 +0800
Message-Id: <1594867315-8626-3-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594867315-8626-1-git-send-email-teawater@gmail.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a vq deflate_cont_vq to deflate continuous pages.
When VIRTIO_BALLOON_F_CONT_PAGES is set, call leak_balloon_cont to leak
the balloon.
leak_balloon_cont will call balloon_page_list_dequeue_cont get continuous
pages from balloon and report them use deflate_cont_vq.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 drivers/virtio/virtio_balloon.c    | 73 ++++++++++++++++++++++++++++++++----
 include/linux/balloon_compaction.h |  3 ++
 mm/balloon_compaction.c            | 76 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index b89f566..258b3d9 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -44,6 +44,7 @@
 
 #define VIRTIO_BALLOON_INFLATE_MAX_ORDER min((int) (sizeof(__virtio32) * BITS_PER_BYTE - \
 						    1 - PAGE_SHIFT), (MAX_ORDER-1))
+#define VIRTIO_BALLOON_DEFLATE_MAX_PAGES_NUM (((__virtio32)~0U) >> PAGE_SHIFT)
 
 #ifdef CONFIG_BALLOON_COMPACTION
 static struct vfsmount *balloon_mnt;
@@ -56,6 +57,7 @@ enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_FREE_PAGE,
 	VIRTIO_BALLOON_VQ_REPORTING,
 	VIRTIO_BALLOON_VQ_INFLATE_CONT,
+	VIRTIO_BALLOON_VQ_DEFLATE_CONT,
 	VIRTIO_BALLOON_VQ_MAX
 };
 
@@ -65,7 +67,8 @@ enum virtio_balloon_config_read {
 
 struct virtio_balloon {
 	struct virtio_device *vdev;
-	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq, *inflate_cont_vq;
+	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq,
+			 *inflate_cont_vq, *deflate_cont_vq;
 
 	/* Balloon's own wq for cpu-intensive work items */
 	struct workqueue_struct *balloon_wq;
@@ -215,6 +218,16 @@ static void set_page_pfns(struct virtio_balloon *vb,
 					  page_to_balloon_pfn(page) + i);
 }
 
+static void set_page_pfns_size(struct virtio_balloon *vb,
+			       __virtio32 pfns[], struct page *page,
+			       size_t size)
+{
+	/* Set the first pfn of the continuous pages.  */
+	pfns[0] = cpu_to_virtio32(vb->vdev, page_to_balloon_pfn(page));
+	/* Set the size of the continuous pages.  */
+	pfns[1] = (__virtio32) size;
+}
+
 static void set_page_pfns_order(struct virtio_balloon *vb,
 				__virtio32 pfns[], struct page *page,
 				unsigned int order)
@@ -222,10 +235,7 @@ static void set_page_pfns_order(struct virtio_balloon *vb,
 	if (order == 0)
 		return set_page_pfns(vb, pfns, page);
 
-	/* Set the first pfn of the continuous pages.  */
-	pfns[0] = cpu_to_virtio32(vb->vdev, page_to_balloon_pfn(page));
-	/* Set the size of the continuous pages.  */
-	pfns[1] = PAGE_SIZE << order;
+	set_page_pfns_size(vb, pfns, page, PAGE_SIZE << order);
 }
 
 static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
@@ -367,6 +377,42 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
 	return num_freed_pages;
 }
 
+static unsigned int leak_balloon_cont(struct virtio_balloon *vb, size_t num)
+{
+	unsigned int num_freed_pages;
+	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
+	LIST_HEAD(pages);
+	size_t num_pages;
+
+	mutex_lock(&vb->balloon_lock);
+	for (vb->num_pfns = 0, num_freed_pages = 0;
+	     vb->num_pfns < ARRAY_SIZE(vb->pfns) && num_freed_pages < num;
+	     vb->num_pfns += 2,
+	     num_freed_pages += num_pages << (PAGE_SHIFT - VIRTIO_BALLOON_PFN_SHIFT)) {
+		struct page *page;
+
+		num_pages = balloon_page_list_dequeue_cont(vb_dev_info, &pages, &page,
+						min_t(size_t,
+						      VIRTIO_BALLOON_DEFLATE_MAX_PAGES_NUM,
+						      num - num_freed_pages));
+		if (!num_pages)
+			break;
+		set_page_pfns_size(vb, vb->pfns + vb->num_pfns, page, num_pages << PAGE_SHIFT);
+	}
+	vb->num_pages -= num_freed_pages;
+
+	/*
+	 * Note that if
+	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
+	 * is true, we *have* to do it in this order
+	 */
+	if (vb->num_pfns != 0)
+		tell_host(vb, vb->deflate_cont_vq);
+	release_pages_balloon(vb, &pages);
+	mutex_unlock(&vb->balloon_lock);
+	return num_freed_pages;
+}
+
 static inline void update_stat(struct virtio_balloon *vb, int idx,
 			       u16 tag, u64 val)
 {
@@ -551,8 +597,12 @@ static void update_balloon_size_func(struct work_struct *work)
 
 	if (diff > 0)
 		diff -= fill_balloon(vb, diff);
-	else
-		diff += leak_balloon(vb, -diff);
+	else {
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
+			diff += leak_balloon_cont(vb, -diff);
+		else
+			diff += leak_balloon(vb, -diff);
+	}
 	update_balloon_size(vb);
 
 	if (diff)
@@ -587,6 +637,8 @@ static int init_vqs(struct virtio_balloon *vb)
 	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
 	names[VIRTIO_BALLOON_VQ_INFLATE_CONT] = NULL;
 	callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] = NULL;
+	names[VIRTIO_BALLOON_VQ_DEFLATE_CONT] = NULL;
+	callbacks[VIRTIO_BALLOON_VQ_DEFLATE_CONT] = NULL;
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
@@ -606,6 +658,8 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
 		names[VIRTIO_BALLOON_VQ_INFLATE_CONT] = "inflate_cont";
 		callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] = balloon_ack;
+		names[VIRTIO_BALLOON_VQ_DEFLATE_CONT] = "deflate_cont";
+		callbacks[VIRTIO_BALLOON_VQ_DEFLATE_CONT] = balloon_ack;
 	}
 
 	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
@@ -643,9 +697,12 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
 		vb->inflate_cont_vq
 			= vqs[VIRTIO_BALLOON_VQ_INFLATE_CONT];
+		vb->deflate_cont_vq
+			= vqs[VIRTIO_BALLOON_VQ_DEFLATE_CONT];
+	}
 
 	return 0;
 }
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 8180bbf..7cb2a75 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -70,6 +70,9 @@ extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 				      struct list_head *pages);
 extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 				     struct list_head *pages, size_t n_req_pages);
+extern size_t balloon_page_list_dequeue_cont(struct balloon_dev_info *b_dev_info,
+					     struct list_head *pages, struct page **first_page,
+					     size_t max_req_pages);
 
 static inline struct page *balloon_page_alloc(void)
 {
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 397d0b9..ea7d91f 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -111,6 +111,82 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 }
 EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 
+/**
+ * balloon_page_list_dequeue_cont() - removes continuous pages from balloon's page list
+ *				      and returns a list of the continuous pages.
+ * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @pages: pointer to the list of pages that would be returned to the caller.
+ * @max_req_pages: max number of requested pages.
+ *
+ * Driver must call this function to properly de-allocate a previous enlisted
+ * balloon pages before definitively releasing it back to the guest system.
+ * This function tries to remove @max_req_pages continuous pages from the ballooned
+ * pages and return them to the caller in the @pages list.
+ *
+ * Note that this function may fail to dequeue some pages even if the balloon
+ * isn't empty - since the page list can be temporarily empty due to compaction
+ * of isolated pages.
+ *
+ * Return: number of pages that were added to the @pages list.
+ */
+size_t balloon_page_list_dequeue_cont(struct balloon_dev_info *b_dev_info,
+				      struct list_head *pages, struct page **first_page,
+				      size_t max_req_pages)
+{
+	struct page *page, *tmp;
+	unsigned long flags, tail_pfn;
+	size_t n_pages = 0;
+	bool got_first = false;
+
+	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
+	list_for_each_entry_safe_reverse(page, tmp, &b_dev_info->pages, lru) {
+		unsigned long pfn;
+
+		if (n_pages == max_req_pages)
+			break;
+
+		pfn = page_to_pfn(page);
+
+		if (got_first && pfn != tail_pfn + 1)
+			break;
+
+		/*
+		 * Block others from accessing the 'page' while we get around to
+		 * establishing additional references and preparing the 'page'
+		 * to be released by the balloon driver.
+		 */
+		if (!trylock_page(page)) {
+			if (!got_first)
+				continue;
+			else
+				break;
+		}
+
+		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) && PageIsolated(page)) {
+			/* raced with isolation */
+			unlock_page(page);
+			if (!got_first)
+				continue;
+			else
+				break;
+		}
+		balloon_page_delete(page);
+		__count_vm_event(BALLOON_DEFLATE);
+		list_add(&page->lru, pages);
+		unlock_page(page);
+		n_pages++;
+		tail_pfn = pfn;
+		if (!got_first) {
+			got_first = true;
+			*first_page = page;
+		}
+	}
+	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
+
+	return n_pages;
+}
+EXPORT_SYMBOL_GPL(balloon_page_list_dequeue_cont);
+
 /*
  * balloon_pages_alloc - allocates a new page for insertion into the balloon
  *			 page list.
-- 
2.7.4

