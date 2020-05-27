Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C69D207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgE0Ly3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:54:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:40894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbgE0LyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3DF3FAE44;
        Wed, 27 May 2020 11:54:20 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 07/50] staging: vchi: Get rid of not implemented function declarations
Date:   Wed, 27 May 2020 13:53:12 +0200
Message-Id: <20200527115400.31391-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They don't exist, they have no users, get rid of them.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchi/vchi.h       | 59 -------------------
 1 file changed, 59 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 1e8d17531e9d..2e41b5f7bdec 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -67,19 +67,12 @@ extern "C" {
 // Routine used to initialise the vchi on both local + remote connections
 extern int32_t vchi_initialise(struct vchi_instance_handle **instance_handle);
 
-extern int32_t vchi_exit(void);
-
 extern int32_t vchi_connect(struct vchi_instance_handle *instance_handle);
 
 //When this is called, ensure that all services have no data pending.
 //Bulk transfers can remain 'queued'
 extern int32_t vchi_disconnect(struct vchi_instance_handle *instance_handle);
 
-// helper functions
-extern void *vchi_allocate_buffer(struct vchi_service_handle *handle, uint32_t *length);
-extern void vchi_free_buffer(struct vchi_service_handle *handle, void *address);
-extern uint32_t vchi_current_time(struct vchi_instance_handle *instance_handle);
-
 /******************************************************************************
  * Global service API
  *****************************************************************************/
@@ -135,54 +128,14 @@ extern int32_t vchi_msg_hold(struct vchi_service_handle *handle,
 			     enum vchi_flags flags,
 			     struct vchi_held_msg *message_descriptor);
 
-// Initialise an iterator to look through messages in place
-extern int32_t vchi_msg_look_ahead(struct vchi_service_handle *handle,
-				   struct vchi_msg_iter *iter,
-				   enum vchi_flags flags);
-
 /*******************************************************************************
  * Global service support API - operations on held messages
  * and message iterators
  ******************************************************************************/
 
-// Routine to get the address of a held message
-extern void *vchi_held_msg_ptr(const struct vchi_held_msg *message);
-
-// Routine to get the size of a held message
-extern int32_t vchi_held_msg_size(const struct vchi_held_msg *message);
-
-// Routine to get the transmit timestamp as written into the header by the peer
-extern uint32_t vchi_held_msg_tx_timestamp(const struct vchi_held_msg *message);
-
-// Routine to get the reception timestamp, written as we parsed the header
-extern uint32_t vchi_held_msg_rx_timestamp(const struct vchi_held_msg *message);
-
 // Routine to release a held message after it has been processed
 extern int32_t vchi_held_msg_release(struct vchi_held_msg *message);
 
-// Indicates whether the iterator has a next message.
-extern int32_t vchi_msg_iter_has_next(const struct vchi_msg_iter *iter);
-
-// Return the pointer and length for the next message and advance the iterator.
-extern int32_t vchi_msg_iter_next(struct vchi_msg_iter *iter,
-				  void **data,
-				  uint32_t *msg_size);
-
-// Remove the last message returned by vchi_msg_iter_next.
-// Can only be called once after each call to vchi_msg_iter_next.
-extern int32_t vchi_msg_iter_remove(struct vchi_msg_iter *iter);
-
-// Hold the last message returned by vchi_msg_iter_next.
-// Can only be called once after each call to vchi_msg_iter_next.
-extern int32_t vchi_msg_iter_hold(struct vchi_msg_iter *iter,
-				  struct vchi_held_msg *message);
-
-// Return information for the next message, and hold it, advancing the iterator.
-extern int32_t vchi_msg_iter_hold_next(struct vchi_msg_iter *iter,
-				       void **data,        // } may be NULL
-				       uint32_t *msg_size, // }
-				       struct vchi_held_msg *message);
-
 /******************************************************************************
  * Global bulk API
  *****************************************************************************/
@@ -194,13 +147,6 @@ extern int32_t vchi_bulk_queue_receive(struct vchi_service_handle *handle,
 				       enum vchi_flags flags,
 				       void *transfer_handle);
 
-// Prepare interface for a transfer from the other side into relocatable memory.
-int32_t vchi_bulk_queue_receive_reloc(const struct vchi_service_handle *handle,
-				      uint32_t offset,
-				      uint32_t data_size,
-				      const enum vchi_flags flags,
-				      void * const bulk_handle);
-
 // Routine to queue up data ready for transfer to the other (once they have signalled they are ready)
 extern int32_t vchi_bulk_queue_transmit(struct vchi_service_handle *handle,
 					const void *data_src,
@@ -216,11 +162,6 @@ extern int32_t vchi_bulk_queue_transmit(struct vchi_service_handle *handle,
 }
 #endif
 
-extern int32_t vchi_bulk_queue_transmit_reloc(struct vchi_service_handle *handle,
-					      uint32_t offset,
-					      uint32_t data_size,
-					      enum vchi_flags flags,
-					      void *transfer_handle);
 #endif /* VCHI_H_ */
 
 /****************************** End of file **********************************/
-- 
2.26.2

