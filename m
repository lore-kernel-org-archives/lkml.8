Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59873C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0AF20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbgF2UgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:36:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:59454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732179AbgF2TVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 172EBAF67;
        Mon, 29 Jun 2020 15:09:57 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 10/47] staging: vchi: Get rid of vchi_msg_peek()
Date:   Mon, 29 Jun 2020 17:09:08 +0200
Message-Id: <20200629150945.10720-11-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There already is a function that covers most of the functionality
vchi_msg_peek() provides: vchi_msg_hold(). The main difference being
that the later removes the message from vchu's queue while the other
does it later on, while releasing the message.

There are no users of this function that can't be trivially converted to
vchi_msg_hold(). So, for the sake of removing duplicate code, get rid of
vchi_msg_peek().

Note that the opposite change could be performed as well. But
vchi_msg_peek()'s implementation was deemed less robust as messages have
to be released in order.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchi/vchi.h       | 12 ----
 .../interface/vchiq_arm/vchiq_shim.c          | 64 -------------------
 .../interface/vchiq_arm/vchiq_util.c          | 12 ----
 .../interface/vchiq_arm/vchiq_util.h          |  1 -
 4 files changed, 89 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 1a981e98e82b..1daef5ad70f1 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -103,18 +103,6 @@ extern int32_t vchi_msg_dequeue(struct vchi_service_handle *handle,
 				uint32_t *actual_msg_size,
 				enum vchi_flags flags);
 
-// Routine to look at a message in place.
-// The message is not dequeued, so a subsequent call to peek or dequeue
-// will return the same message.
-extern int32_t vchi_msg_peek(struct vchi_service_handle *handle,
-			     void **data,
-			     uint32_t *msg_size,
-			     enum vchi_flags flags);
-
-// Routine to remove a message after it has been read in place with peek
-// The first message on the queue is dequeued.
-extern int32_t vchi_msg_remove(struct vchi_service_handle *handle);
-
 // Routine to look at a message in place.
 // The message is dequeued, so the caller is left holding it; the descriptor is
 // filled in and must be released when the user has finished with the message.
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 75d87b6992c4..54c2492b7c83 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -18,70 +18,6 @@ struct shim_service {
 	void *callback_param;
 };
 
-/***********************************************************
- * Name: vchi_msg_peek
- *
- * Arguments:  struct vchi_service_handle *handle,
- *             void **data,
- *             uint32_t *msg_size,
-
- *             enum vchi_flags flags
- *
- * Description: Routine to return a pointer to the current message (to allow in
- *              place processing). The message can be removed using
- *              vchi_msg_remove when you're finished
- *
- * Returns: int32_t - success == 0
- *
- ***********************************************************/
-int32_t vchi_msg_peek(struct vchi_service_handle *handle,
-		      void **data,
-		      uint32_t *msg_size,
-		      enum vchi_flags flags)
-{
-	struct shim_service *service = (struct shim_service *)handle;
-	struct vchiq_header *header;
-
-	WARN_ON((flags != VCHI_FLAGS_NONE) &&
-		(flags != VCHI_FLAGS_BLOCK_UNTIL_OP_COMPLETE));
-
-	if (flags == VCHI_FLAGS_NONE)
-		if (vchiu_queue_is_empty(&service->queue))
-			return -1;
-
-	header = vchiu_queue_peek(&service->queue);
-
-	*data = header->data;
-	*msg_size = header->size;
-
-	return 0;
-}
-EXPORT_SYMBOL(vchi_msg_peek);
-
-/***********************************************************
- * Name: vchi_msg_remove
- *
- * Arguments:  struct vchi_service_handle *handle,
- *
- * Description: Routine to remove a message (after it has been read with
- *              vchi_msg_peek)
- *
- * Returns: int32_t - success == 0
- *
- ***********************************************************/
-int32_t vchi_msg_remove(struct vchi_service_handle *handle)
-{
-	struct shim_service *service = (struct shim_service *)handle;
-	struct vchiq_header *header;
-
-	header = vchiu_queue_pop(&service->queue);
-
-	vchiq_release_message(service->handle, header);
-
-	return 0;
-}
-EXPORT_SYMBOL(vchi_msg_remove);
-
 int vchi_queue_kernel_message(struct vchi_service_handle *handle, void *data,
 			       unsigned int size)
 {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index 644844d88fed..c1c81f9ab9e6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -55,18 +55,6 @@ void vchiu_queue_push(struct vchiu_queue *queue, struct vchiq_header *header)
 	complete(&queue->push);
 }
 
-struct vchiq_header *vchiu_queue_peek(struct vchiu_queue *queue)
-{
-	while (queue->write == queue->read) {
-		if (wait_for_completion_interruptible(&queue->push))
-			flush_signals(current);
-	}
-
-	complete(&queue->push); // We haven't removed anything from the queue.
-
-	return queue->storage[queue->read & (queue->size - 1)];
-}
-
 struct vchiq_header *vchiu_queue_pop(struct vchiu_queue *queue)
 {
 	struct vchiq_header *header;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
index f03a4250de0d..1c90a8da1a92 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
@@ -44,7 +44,6 @@ extern int vchiu_queue_is_empty(struct vchiu_queue *queue);
 extern void vchiu_queue_push(struct vchiu_queue *queue,
 			     struct vchiq_header *header);
 
-extern struct vchiq_header *vchiu_queue_peek(struct vchiu_queue *queue);
 extern struct vchiq_header *vchiu_queue_pop(struct vchiu_queue *queue);
 
 #endif
-- 
2.27.0

