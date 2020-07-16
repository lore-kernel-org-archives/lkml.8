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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E37C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D796A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGPCmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:42:47 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55362 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727891AbgGPCmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:42:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0U2rVPuE_1594867357;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0U2rVPuE_1594867357)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jul 2020 10:42:39 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     mst@redhat.com, david@redhat.com, jasowang@redhat.com,
        akpm@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [RFC for qemu v4 2/2] virtio_balloon: Add dcvq to deflate continuous pages
Date:   Thu, 16 Jul 2020 10:41:55 +0800
Message-Id: <1594867315-8626-6-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594867315-8626-1-git-send-email-teawater@gmail.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a vq dcvq to deflate continuous pages.
When VIRTIO_BALLOON_F_CONT_PAGES is set, try to get continuous pages
from icvq and use madvise MADV_WILLNEED with the pages.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 hw/virtio/virtio-balloon.c         | 14 +++++++++-----
 include/hw/virtio/virtio-balloon.h |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d36a5c8..165adf7 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -138,7 +138,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
 }
 
 static void balloon_deflate_page(VirtIOBalloon *balloon,
-                                 MemoryRegion *mr, hwaddr mr_offset)
+                                 MemoryRegion *mr, hwaddr mr_offset,
+                                 size_t size)
 {
     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
     ram_addr_t rb_offset;
@@ -153,10 +154,11 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
     rb_page_size = qemu_ram_pagesize(rb);
 
     host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
+    size &= ~(rb_page_size - 1);
 
     /* When a page is deflated, we hint the whole host page it lives
      * on, since we can't do anything smaller */
-    ret = qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
+    ret = qemu_madvise(host_addr, size, QEMU_MADV_WILLNEED);
     if (ret != 0) {
         warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
                     strerror(errno));
@@ -354,7 +356,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
             pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
             offset += 4;
 
-            if (vq == s->icvq) {
+            if (vq == s->icvq || vq == s->dcvq) {
                 uint32_t psize_ptr;
                 if (iov_to_buf(elem->out_sg, elem->out_num, offset, &psize_ptr, 4) != 4) {
                     break;
@@ -383,8 +385,9 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
                     balloon_inflate_page(s, section.mr,
                                          section.offset_within_region,
                                          psize, &pbp);
-                } else if (vq == s->dvq) {
-                    balloon_deflate_page(s, section.mr, section.offset_within_region);
+                } else if (vq == s->dvq || vq == s->dcvq) {
+                    balloon_deflate_page(s, section.mr, section.offset_within_region,
+                                         psize);
                 } else {
                     g_assert_not_reached();
                 }
@@ -838,6 +841,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
         s->icvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
+        s->dcvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     }
 
     reset_stats(s);
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 6a2514d..848a7fb 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq, *dcvq;
     uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;
-- 
2.7.4

