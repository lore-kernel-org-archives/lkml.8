Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB1AC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6A92187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="FbqhuDju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgAOMF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:05:59 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:53212 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgAOMF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:05:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id CB66F27E0BA4;
        Wed, 15 Jan 2020 13:05:57 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9H-gUyI46-Z3; Wed, 15 Jan 2020 13:05:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 5E54A27E0A5D;
        Wed, 15 Jan 2020 13:05:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 5E54A27E0A5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1579089957;
        bh=6lzn2l0dYP+0ASaZ1AFTvqX7NmUFTFeakMQsyeR7hHs=;
        h=From:To:Date:Message-Id;
        b=FbqhuDjuk2130JSGH+9ERNx6mF16muyBUZxh5EpFXbxgdIi9RKCr7KE9w9FVdGTuU
         fg9X68hm1083IRQbZmolRemQpG1b1btt4jJhZ9BTYmdYDvuTwwKCTe6A6FWJ3j603y
         G0bekXgy7LpTFmB08sAAOThATM3AYcFkdGBAl2DM=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CaaC1VAcHASq; Wed, 15 Jan 2020 13:05:57 +0100 (CET)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 4956827E031E;
        Wed, 15 Jan 2020 13:05:57 +0100 (CET)
From:   Clement Leger <cleger@kalray.eu>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Clement Leger <cleger@kalray.eu>
Subject: [PATCH] virtio_ring: Use workqueue to execute virtqueue callback
Date:   Wed, 15 Jan 2020 13:05:35 +0100
Message-Id: <20200115120535.17454-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.15.0.276.g89ea799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in vring_interrupt, the vq callbacks are called directly.
However, these callbacks are not meant to be executed in IRQ context.
They do not return any irq_return_t value and some of them can do
locking (rpmsg_recv_done -> rpmsg_recv_single -> mutex_lock).
When compiled with DEBUG_ATOMIC_SLEEP, the kernel will spit out warnings
when such case shappen.

In order to allow calling these callbacks safely (without sleeping in
IRQ context), execute them in a workqueue if needed.

Signed-off-by: Clement Leger <cleger@kalray.eu>
---
 drivers/virtio/virtio_ring.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 867c7ebd3f10..0e4d0e5ca227 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -183,6 +183,9 @@ struct vring_virtqueue {
 	/* DMA, allocation, and size information */
 	bool we_own_ring;
 
+	/* Work struct for vq callback handling */
+	struct work_struct work;
+
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
 	unsigned int in_use;
@@ -2029,6 +2032,16 @@ static inline bool more_used(const struct vring_virtqueue *vq)
 	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
 }
 
+static void vring_work_handler(struct work_struct *work_struct)
+{
+	struct vring_virtqueue *vq = container_of(work_struct,
+						  struct vring_virtqueue,
+						  work);
+	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
+
+	vq->vq.callback(&vq->vq);
+}
+
 irqreturn_t vring_interrupt(int irq, void *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -2041,9 +2054,8 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 	if (unlikely(vq->broken))
 		return IRQ_HANDLED;
 
-	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
 	if (vq->vq.callback)
-		vq->vq.callback(&vq->vq);
+		schedule_work(&vq->work);
 
 	return IRQ_HANDLED;
 }
@@ -2110,6 +2122,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					vq->split.avail_flags_shadow);
 	}
 
+	INIT_WORK(&vq->work, vring_work_handler);
+
 	vq->split.desc_state = kmalloc_array(vring.num,
 			sizeof(struct vring_desc_state_split), GFP_KERNEL);
 	if (!vq->split.desc_state) {
@@ -2179,6 +2193,8 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	cancel_work_sync(&vq->work);
+
 	if (vq->we_own_ring) {
 		if (vq->packed_ring) {
 			vring_free_queue(vq->vq.vdev,
-- 
2.15.0.276.g89ea799

