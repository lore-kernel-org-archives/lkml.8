Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3BEC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01416206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgELJmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:42:03 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43709 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727859AbgELJmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:42:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TyKuOL0_1589276512;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TyKuOL0_1589276512)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 May 2020 17:41:58 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org,
        xdeguillard@vmware.com, namit@vmware.com,
        gregkh@linuxfoundation.org, david@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc:     wei.guo.simon@linux.alibaba.com, qixuan.wu@linux.alibaba.com,
        Hui Zhu <teawater@gmail.com>,
        Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [RFC v3 for QEMU] virtio-balloon: Add option cont-pages to set VIRTIO_BALLOON_VQ_INFLATE_CONT
Date:   Tue, 12 May 2020 17:41:40 +0800
Message-Id: <1589276501-16026-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the guest kernel has many fragmentation pages, use virtio_balloon
will split THP of QEMU when it calls MADV_DONTNEED madvise to release
the balloon pages.
Set option cont-pages to on will open flags VIRTIO_BALLOON_VQ_INFLATE_CONT
and set default continuous pages order to THP order.
Then It will get continuous pages PFN that its order is current_pages_order
from VQ ivq use use madvise MADV_DONTNEED release the page.
This will handle the THP split issue.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 hw/virtio/virtio-balloon.c                      | 77 +++++++++++++++++--------
 include/hw/virtio/virtio-balloon.h              |  2 +
 include/standard-headers/linux/virtio_balloon.h |  5 ++
 3 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7..84d47d3 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -34,6 +34,7 @@
 #include "hw/virtio/virtio-access.h"
 
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
+#define CONT_PAGES_ORDER   9
 
 typedef struct PartiallyBalloonedPage {
     ram_addr_t base_gpa;
@@ -72,6 +73,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
     RAMBlock *rb;
     size_t rb_page_size;
     int subpages;
+    size_t inflate_size = BALLOON_PAGE_SIZE << balloon->current_pages_order;
+    int pages_num;
 
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
@@ -81,7 +84,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
     if (rb_page_size == BALLOON_PAGE_SIZE) {
         /* Easy case */
 
-        ram_block_discard_range(rb, rb_offset, rb_page_size);
+        ram_block_discard_range(rb, rb_offset, inflate_size);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
@@ -99,32 +102,38 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
 
     rb_aligned_offset = QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
     subpages = rb_page_size / BALLOON_PAGE_SIZE;
-    base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
-               (rb_offset - rb_aligned_offset);
 
-    if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
-        /* We've partially ballooned part of a host page, but now
-         * we're trying to balloon part of a different one.  Too hard,
-         * give up on the old partial page */
-        virtio_balloon_pbp_free(pbp);
-    }
+    for (pages_num = inflate_size / BALLOON_PAGE_SIZE;
+         pages_num > 0; pages_num--) {
+        base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
+                   (rb_offset - rb_aligned_offset);
 
-    if (!pbp->bitmap) {
-        virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
-    }
+        if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
+            /* We've partially ballooned part of a host page, but now
+            * we're trying to balloon part of a different one.  Too hard,
+            * give up on the old partial page */
+            virtio_balloon_pbp_free(pbp);
+        }
 
-    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
-            pbp->bitmap);
+        if (!pbp->bitmap) {
+            virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
+        }
 
-    if (bitmap_full(pbp->bitmap, subpages)) {
-        /* We've accumulated a full host page, we can actually discard
-         * it now */
+        set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
+                pbp->bitmap);
 
-        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
-        /* We ignore errors from ram_block_discard_range(), because it
-         * has already reported them, and failing to discard a balloon
-         * page is not fatal */
-        virtio_balloon_pbp_free(pbp);
+        if (bitmap_full(pbp->bitmap, subpages)) {
+            /* We've accumulated a full host page, we can actually discard
+            * it now */
+
+            ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
+            /* We ignore errors from ram_block_discard_range(), because it
+            * has already reported them, and failing to discard a balloon
+            * page is not fatal */
+            virtio_balloon_pbp_free(pbp);
+        }
+
+        mr_offset += BALLOON_PAGE_SIZE;
     }
 }
 
@@ -345,7 +354,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
             offset += 4;
 
             section = memory_region_find(get_system_memory(), pa,
-                                         BALLOON_PAGE_SIZE);
+                                BALLOON_PAGE_SIZE << s->current_pages_order);
             if (!section.mr) {
                 trace_virtio_balloon_bad_addr(pa);
                 continue;
@@ -618,9 +627,12 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
     if (s->qemu_4_0_config_size) {
         return sizeof(struct virtio_balloon_config);
     }
-    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
         return sizeof(struct virtio_balloon_config);
     }
+    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
+        return offsetof(struct virtio_balloon_config, current_pages_order);
+    }
     if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         return offsetof(struct virtio_balloon_config, poison_val);
     }
@@ -646,6 +658,11 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
                        cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
     }
 
+    if (virtio_has_feature(dev->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
+        config.max_pages_order = cpu_to_le32(CONT_PAGES_ORDER);
+        config.current_pages_order = cpu_to_le32(dev->current_pages_order);
+    }
+
     trace_virtio_balloon_get_config(config.num_pages, config.actual);
     memcpy(config_data, &config, virtio_balloon_config_size(dev));
 }
@@ -693,6 +710,9 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
 
     memcpy(&config, config_data, virtio_balloon_config_size(dev));
     dev->actual = le32_to_cpu(config.actual);
+    if (virtio_has_feature(dev->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
+        dev->current_pages_order = le32_to_cpu(config.current_pages_order);
+    }
     if (dev->actual != oldactual) {
         qapi_event_send_balloon_change(vm_ram_size -
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
@@ -816,6 +836,13 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
             virtio_error(vdev, "iothread is missing");
         }
     }
+
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
+        s->current_pages_order = CONT_PAGES_ORDER;
+    } else {
+        s->current_pages_order = 0;
+    }
+
     reset_stats(s);
 }
 
@@ -916,6 +943,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_BIT("cont-pages", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_CONT_PAGES, false),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d1c968d..e0dce0d 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -70,6 +70,8 @@ typedef struct VirtIOBalloon {
     uint32_t host_features;
 
     bool qemu_4_0_config_size;
+
+    uint32_t current_pages_order;
 } VirtIOBalloon;
 
 #endif
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9375ca2..b5386ce 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous pages */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -51,6 +52,10 @@ struct virtio_balloon_config {
 	uint32_t free_page_report_cmd_id;
 	/* Stores PAGE_POISON if page poisoning is in use */
 	uint32_t poison_val;
+	/* Max pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
+	uint32_t max_pages_order;
+	/* Current pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
+	uint32_t current_pages_order;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
1.8.3.1

