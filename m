Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D30C3B184
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72D92080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBJJFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:05:38 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43136 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbgBJJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:05:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=zhabin@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tpb9F9i_1581325531;
Received: from localhost(mailfrom:zhabin@linux.alibaba.com fp:SMTPD_---0Tpb9F9i_1581325531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Feb 2020 17:05:32 +0800
From:   Zha Bin <zhabin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, zhabin@linux.alibaba.com,
        jing2.liu@linux.intel.com, chao.p.peng@linux.intel.com
Subject: [PATCH v2 2/5] virtio-mmio: refactor common functionality
Date:   Mon, 10 Feb 2020 17:05:18 +0800
Message-Id: <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
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

Common functionality is refactored into virtio_mmio_common.h
in order to MSI support in later patch set.

Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 drivers/virtio/virtio_mmio.c        | 21 +--------------------
 drivers/virtio/virtio_mmio_common.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 20 deletions(-)
 create mode 100644 drivers/virtio/virtio_mmio_common.h

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 1733ab97..41e1c93 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -61,13 +61,12 @@
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <uapi/linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
+#include "virtio_mmio_common.h"
 
 
 
@@ -77,24 +76,6 @@
 
 
 
-#define to_virtio_mmio_device(_plat_dev) \
-	container_of(_plat_dev, struct virtio_mmio_device, vdev)
-
-struct virtio_mmio_device {
-	struct virtio_device vdev;
-	struct platform_device *pdev;
-
-	void __iomem *base;
-	unsigned long version;
-
-	/* a list of queues so we can dispatch IRQs */
-	spinlock_t lock;
-	struct list_head virtqueues;
-
-	unsigned short notify_base;
-	unsigned short notify_multiplier;
-};
-
 struct virtio_mmio_vq_info {
 	/* the actual virtqueue */
 	struct virtqueue *vq;
diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/virtio_mmio_common.h
new file mode 100644
index 0000000..90cb304
--- /dev/null
+++ b/drivers/virtio/virtio_mmio_common.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
+#define _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
+/*
+ * Virtio MMIO driver - common functionality for all device versions
+ *
+ * This module allows virtio devices to be used over a memory-mapped device.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/virtio.h>
+
+#define to_virtio_mmio_device(_plat_dev) \
+	container_of(_plat_dev, struct virtio_mmio_device, vdev)
+
+struct virtio_mmio_device {
+	struct virtio_device vdev;
+	struct platform_device *pdev;
+
+	void __iomem *base;
+	unsigned long version;
+
+	/* a list of queues so we can dispatch IRQs */
+	spinlock_t lock;
+	struct list_head virtqueues;
+
+	unsigned short notify_base;
+	unsigned short notify_multiplier;
+};
+
+#endif
-- 
1.8.3.1

