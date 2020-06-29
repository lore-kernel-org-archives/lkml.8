Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD93C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABAD20748
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbgF2UgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:36:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732178AbgF2TVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17948B02D;
        Mon, 29 Jun 2020 15:10:06 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 32/47] staging: vchiq: Pass vchiq's message when holding a message
Date:   Mon, 29 Jun 2020 17:09:30 +0200
Message-Id: <20200629150945.10720-33-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchi created an opaque structure to be held by services while they
process callback messages. The contents of this opaque structure are the
service handle, which all services already maintain, and a pointer to
vchiq's message structure, struct vchiq_header.

Let's get rid of this opaque structure and directly pass struct
vchiq_header, which is what ultimately vchiq consumes when handling
callback messages.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchi/vchi.h       | 14 ++---------
 .../interface/vchiq_arm/vchiq_shim.c          | 25 ++++++-------------
 2 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 74fd169e079a..72771fdee9d6 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -11,16 +11,6 @@
 // Macros to manipulate 'FOURCC' values
 #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
 
-// Opaque service information
-struct opaque_vchi_service_t;
-
-// Descriptor for a held message. Allocated by client, initialised by vchi_msg_hold,
-// vchi_msg_iter_hold or vchi_msg_iter_hold_next. Fields are for internal VCHI use only.
-struct vchi_held_msg {
-	struct opaque_vchi_service_t *service;
-	void *message;
-};
-
 // Opaque handle for a VCHIQ instance
 struct vchiq_instance;
 
@@ -67,7 +57,7 @@ extern int vchi_queue_kernel_message(unsigned handle, void *data,
 extern int32_t vchi_msg_hold(unsigned handle,
 			     void **data,        // } may be NULL, as info can be
 			     uint32_t *msg_size, // } obtained from HELD_MSG_T
-			     struct vchi_held_msg *message_descriptor);
+			     struct vchiq_header **message);
 
 /*******************************************************************************
  * Global service support API - operations on held messages
@@ -75,7 +65,7 @@ extern int32_t vchi_msg_hold(unsigned handle,
  ******************************************************************************/
 
 // Routine to release a held message after it has been processed
-extern int32_t vchi_held_msg_release(struct vchi_held_msg *message);
+extern int32_t vchi_held_msg_release(unsigned handle, struct vchiq_header *message);
 
 /******************************************************************************
  * Global bulk API
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 578346965da6..6eb9a9878641 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -113,7 +113,8 @@ EXPORT_SYMBOL(vchi_bulk_queue_transmit);
 /***********************************************************
  * Name: vchi_held_msg_release
  *
- * Arguments:  struct vchi_held_msg *message
+ * Arguments:  unsgined handle
+ *	       struct vchiq_header *message
  *
  * Description: Routine to release a held message (after it has been read with
  *              vchi_msg_hold)
@@ -121,7 +122,7 @@ EXPORT_SYMBOL(vchi_bulk_queue_transmit);
  * Returns: int32_t - success == 0
  *
  ***********************************************************/
-int32_t vchi_held_msg_release(struct vchi_held_msg *message)
+int32_t vchi_held_msg_release(unsigned handle, struct vchiq_header *message)
 {
 	/*
 	 * Convert the service field pointer back to an
@@ -131,8 +132,7 @@ int32_t vchi_held_msg_release(struct vchi_held_msg *message)
 	 * to a pointer.
 	 */
 
-	vchiq_release_message((unsigned int)(long)message->service,
-			      (struct vchiq_header *)message->message);
+	vchiq_release_message(handle, message);
 
 	return 0;
 }
@@ -144,7 +144,7 @@ EXPORT_SYMBOL(vchi_held_msg_release);
  * Arguments:  struct vchi_service *service,
  *             void **data,
  *             uint32_t *msg_size,
- *             struct vchi_held_msg *message_handle
+ *             struct vchiq_header **message
  *
  * Description: Routine to return a pointer to the current message (to allow
  *              in place processing). The message is dequeued - don't forget
@@ -155,7 +155,7 @@ EXPORT_SYMBOL(vchi_held_msg_release);
  *
  ***********************************************************/
 int32_t vchi_msg_hold(unsigned handle, void **data, uint32_t *msg_size,
-		      struct vchi_held_msg *message_handle)
+		      struct vchiq_header **message)
 {
 	struct vchiq_header *header;
 
@@ -165,18 +165,7 @@ int32_t vchi_msg_hold(unsigned handle, void **data, uint32_t *msg_size,
 
 	*data = header->data;
 	*msg_size = header->size;
-
-	/*
-	 * upcast the unsigned int which is an int
-	 * to a pointer and stuff it in the held message.
-	 * This pointer is opaque to everything except
-	 * vchi_held_msg_release which simply downcasts it back
-	 * to an int.
-	 */
-
-	message_handle->service =
-		(struct opaque_vchi_service_t *)(long)handle;
-	message_handle->message = header;
+	*message = header;
 
 	return 0;
 }
-- 
2.27.0

