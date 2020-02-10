Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47344C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2743A2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgBJJFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:05:37 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60945 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgBJJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:05:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=zhabin@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tpb7N0C_1581325531;
Received: from localhost(mailfrom:zhabin@linux.alibaba.com fp:SMTPD_---0Tpb7N0C_1581325531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Feb 2020 17:05:31 +0800
From:   Zha Bin <zhabin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, zhabin@linux.alibaba.com,
        jing2.liu@linux.intel.com, chao.p.peng@linux.intel.com
Subject: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Date:   Mon, 10 Feb 2020 17:05:17 +0800
Message-Id: <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1581305609.git.zhabin@linux.alibaba.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
In-Reply-To: <cover.1581305609.git.zhabin@linux.alibaba.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Jiang <gerry@linux.alibaba.com>

The standard virtio-mmio devices use notification register to signal
backend. This will cause vmexits and slow down the performance when we
passthrough the virtio-mmio devices to guest virtual machines.
We proposed to update virtio over MMIO spec to add the per-queue
notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM to
configure notify location for each queue.

[1] https://lkml.org/lkml/2020/1/21/31

Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 drivers/virtio/virtio_mmio.c       | 37 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_config.h |  8 +++++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 97d5725..1733ab97 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -90,6 +90,9 @@ struct virtio_mmio_device {
 	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
+
+	unsigned short notify_base;
+	unsigned short notify_multiplier;
 };
 
 struct virtio_mmio_vq_info {
@@ -98,6 +101,9 @@ struct virtio_mmio_vq_info {
 
 	/* the list node for the virtqueues list */
 	struct list_head node;
+
+	/* Notify Address*/
+	unsigned int notify_addr;
 };
 
 
@@ -119,13 +125,23 @@ static u64 vm_get_features(struct virtio_device *vdev)
 	return features;
 }
 
+static void vm_transport_features(struct virtio_device *vdev, u64 features)
+{
+	if (features & BIT_ULL(VIRTIO_F_MMIO_NOTIFICATION))
+		__virtio_set_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION);
+}
+
 static int vm_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	u64 features = vdev->features;
 
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
+	/* Give virtio_mmio a chance to accept features. */
+	vm_transport_features(vdev, features);
+
 	/* Make sure there is are no mixed devices */
 	if (vm_dev->version == 2 &&
 			!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
@@ -272,10 +288,13 @@ static void vm_reset(struct virtio_device *vdev)
 static bool vm_notify(struct virtqueue *vq)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
+	struct virtio_mmio_vq_info *info = vq->priv;
 
-	/* We write the queue's selector into the notification register to
+	/* We write the queue's selector into the Notify Address to
 	 * signal the other end */
-	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
+	if (info)
+		writel(vq->index, vm_dev->base + info->notify_addr);
+
 	return true;
 }
 
@@ -434,6 +453,12 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	vq->priv = info;
 	info->vq = vq;
 
+	if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION))
+		info->notify_addr = vm_dev->notify_base +
+				vm_dev->notify_multiplier * vq->index;
+	else
+		info->notify_addr = VIRTIO_MMIO_QUEUE_NOTIFY;
+
 	spin_lock_irqsave(&vm_dev->lock, flags);
 	list_add(&info->node, &vm_dev->virtqueues);
 	spin_unlock_irqrestore(&vm_dev->lock, flags);
@@ -471,6 +496,14 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return irq;
 	}
 
+	if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION)) {
+		unsigned int notify = readl(vm_dev->base +
+				VIRTIO_MMIO_QUEUE_NOTIFY);
+
+		vm_dev->notify_base = notify & 0xffff;
+		vm_dev->notify_multiplier = (notify >> 16) & 0xffff;
+	}
+
 	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
 	if (err)
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index ff8e7dc..5d93c01 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -52,7 +52,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		38
+#define VIRTIO_TRANSPORT_F_END		40
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -88,4 +88,10 @@
  * Does the device support Single Root I/O Virtualization?
  */
 #define VIRTIO_F_SR_IOV			37
+
+/*
+ * This feature indicates the enhanced notification support on MMIO transport
+ * layer.
+ */
+#define VIRTIO_F_MMIO_NOTIFICATION	39
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
-- 
1.8.3.1

