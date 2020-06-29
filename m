Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FB6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B857206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbgF2Ufg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:35:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:59504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbgF2TVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E57ADB040;
        Mon, 29 Jun 2020 15:10:09 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 41/47] staging: vchi: Get rid of vchi_bulk_queue_transmit()
Date:   Mon, 29 Jun 2020 17:09:39 +0200
Message-Id: <20200629150945.10720-42-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its vchiq counterpart, vchiq_bulk_transmit() is only used by vchi. We
can then merge both functions by moving vchi_bulk_queue_transmit()'s
retry mechanism into vchiq_bulk_transmit() and let services call the
later.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bcm2835-audio/bcm2835-vchiq.c             |  7 +-
 .../vc04_services/interface/vchi/vchi.h       | 11 ----
 .../interface/vchiq_arm/vchiq_arm.c           | 38 +++++++----
 .../interface/vchiq_arm/vchiq_shim.c          | 66 ++++---------------
 4 files changed, 41 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 55f1e684eef1..28d64bc895cd 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -343,10 +343,9 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 	count = size;
 	if (!instance->max_packet) {
 		/* Send the message to the videocore */
-		status = vchi_bulk_queue_transmit(instance->service_handle,
-						  src, count,
-						  VCHIQ_BULK_MODE_BLOCKING,
-						  NULL);
+		status = vchiq_bulk_transmit(instance->service_handle, src,
+					     count, NULL,
+					     VCHIQ_BULK_MODE_BLOCKING);
 	} else {
 		while (count > 0) {
 			int bytes = min(instance->max_packet, count);
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index ca20b99122f2..c800796f9986 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -54,17 +54,6 @@ struct vchiq_header *vchi_msg_hold(unsigned handle);
 // Routine to release a held message after it has been processed
 extern int32_t vchi_held_msg_release(unsigned handle, struct vchiq_header *message);
 
-/******************************************************************************
- * Global bulk API
- *****************************************************************************/
-
-// Routine to queue up data ready for transfer to the other (once they have signalled they are ready)
-extern int32_t vchi_bulk_queue_transmit(unsigned handle,
-					const void *data_src,
-					uint32_t data_size,
-				        enum vchiq_bulk_mode mode,
-					void *transfer_handle);
-
 /******************************************************************************
  * Configuration plumbing
  *****************************************************************************/
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 1165824711a5..98d6fa84deab 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -355,19 +355,31 @@ vchiq_bulk_transmit(unsigned int handle, const void *data,
 {
 	enum vchiq_status status;
 
-	switch (mode) {
-	case VCHIQ_BULK_MODE_NOCALLBACK:
-	case VCHIQ_BULK_MODE_CALLBACK:
-		status = vchiq_bulk_transfer(handle, (void *)data, size,
-					     userdata, mode,
-					     VCHIQ_BULK_TRANSMIT);
-		break;
-	case VCHIQ_BULK_MODE_BLOCKING:
-		status = vchiq_blocking_bulk_transfer(handle,
-			(void *)data, size, VCHIQ_BULK_TRANSMIT);
-		break;
-	default:
-		return VCHIQ_ERROR;
+	while (1) {
+		switch (mode) {
+		case VCHIQ_BULK_MODE_NOCALLBACK:
+		case VCHIQ_BULK_MODE_CALLBACK:
+			status = vchiq_bulk_transfer(handle, (void *)data, size,
+						     userdata, mode,
+						     VCHIQ_BULK_TRANSMIT);
+			break;
+		case VCHIQ_BULK_MODE_BLOCKING:
+			status = vchiq_blocking_bulk_transfer(handle,
+				(void *)data, size, VCHIQ_BULK_TRANSMIT);
+			break;
+		default:
+			return VCHIQ_ERROR;
+		}
+
+		/*
+		 * vchiq_*_bulk_transfer() may return VCHIQ_RETRY, so we need
+		 * to implement a retry mechanism since this function is
+		 * supposed to block until queued
+		 */
+		if (status != VCHIQ_RETRY)
+			break;
+
+		msleep(1);
 	}
 
 	return status;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index f69936a9eb29..33493643b5f8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -31,46 +31,6 @@ int vchi_queue_kernel_message(unsigned handle, void *data, unsigned int size)
 }
 EXPORT_SYMBOL(vchi_queue_kernel_message);
 
-/***********************************************************
- * Name: vchi_bulk_queue_transmit
- *
- * Arguments:  VCHI_BULK_HANDLE_T handle,
- *             const void *data_src,
- *             uint32_t data_size,
- *             enum vchi_flags flags,
- *             void *bulk_handle
- *
- * Description: Routine to transmit some data
- *
- * Returns: int32_t - success == 0
- *
- ***********************************************************/
-int32_t vchi_bulk_queue_transmit(unsigned handle, const void *data_src,
-				 uint32_t data_size, enum vchiq_bulk_mode mode,
-				 void *bulk_handle)
-{
-	enum vchiq_status status;
-
-	while (1) {
-		status = vchiq_bulk_transmit(handle, data_src, data_size,
-					     bulk_handle, mode);
-
-		/*
-		 * vchiq_bulk_transmit() may return VCHIQ_RETRY, so we need to
-		 * implement a retry mechanism since this function is supposed
-		 * to block until queued
-		 */
-		if (status != VCHIQ_RETRY)
-			break;
-
-		msleep(1);
-	}
-
-	return status;
-}
-EXPORT_SYMBOL(vchi_bulk_queue_transmit);
-
-
 /***********************************************************
  * Name: vchi_held_msg_release
  *
@@ -80,10 +40,10 @@ EXPORT_SYMBOL(vchi_bulk_queue_transmit);
  * Description: Routine to release a held message (after it has been read with
  *              vchi_msg_hold)
  *
- * Returns: int32_t - success == 0
+ * Returns: int - success == 0
  *
  ***********************************************************/
-int32_t vchi_held_msg_release(unsigned handle, struct vchiq_header *message)
+int vchi_held_msg_release(unsigned handle, struct vchiq_header *message)
 {
 	/*
 	 * Convert the service field pointer back to an
@@ -104,7 +64,7 @@ EXPORT_SYMBOL(vchi_held_msg_release);
  *
  * Arguments:  struct vchi_service *service,
  *             void **data,
- *             uint32_t *msg_size,
+ *             unsigned *msg_size,
  *             struct vchiq_header **message
  *
  * Description: Routine to return a pointer to the current message (to allow
@@ -112,7 +72,7 @@ EXPORT_SYMBOL(vchi_held_msg_release);
  *              to release the message using vchi_held_msg_release when you're
  *              finished.
  *
- * Returns: int32_t - success == 0
+ * Returns: int - success == 0
  *
  ***********************************************************/
 struct vchiq_header *vchi_msg_hold(unsigned handle)
@@ -134,7 +94,7 @@ EXPORT_SYMBOL(vchi_msg_hold);
  *
  ***********************************************************/
 
-int32_t vchi_initialise(struct vchiq_instance **instance)
+int vchi_initialise(struct vchiq_instance **instance)
 {
 	return vchiq_initialise(instance);
 }
@@ -151,7 +111,7 @@ EXPORT_SYMBOL(vchi_initialise);
  * Returns: 0 if successful, failure otherwise
  *
  ***********************************************************/
-int32_t vchi_connect(struct vchiq_instance *instance)
+int vchi_connect(struct vchiq_instance *instance)
 {
 	return vchiq_connect(instance);
 }
@@ -168,7 +128,7 @@ EXPORT_SYMBOL(vchi_connect);
  * Returns: 0 if successful, failure otherwise
  *
  ***********************************************************/
-int32_t vchi_disconnect(struct vchiq_instance *instance)
+int vchi_disconnect(struct vchiq_instance *instance)
 {
 	return vchiq_shutdown(instance);
 }
@@ -184,11 +144,11 @@ EXPORT_SYMBOL(vchi_disconnect);
  *
  * Description: Routine to open a service
  *
- * Returns: int32_t - success == 0
+ * Returns: int - success == 0
  *
  ***********************************************************/
 
-int32_t vchi_service_open(struct vchiq_instance *instance,
+int vchi_service_open(struct vchiq_instance *instance,
 		      struct vchiq_service_params *params,
 		      unsigned *handle)
 {
@@ -196,13 +156,13 @@ int32_t vchi_service_open(struct vchiq_instance *instance,
 }
 EXPORT_SYMBOL(vchi_service_open);
 
-int32_t vchi_service_close(unsigned handle)
+int vchi_service_close(unsigned handle)
 {
 	return vchiq_close_service(handle);
 }
 EXPORT_SYMBOL(vchi_service_close);
 
-int32_t vchi_get_peer_version(unsigned handle, short *peer_version)
+int vchi_get_peer_version(unsigned handle, short *peer_version)
 {
 	return vchiq_get_peer_version(handle, peer_version);
 }
@@ -218,7 +178,7 @@ EXPORT_SYMBOL(vchi_get_peer_version);
  * Returns: void
  *
  ***********************************************************/
-int32_t vchi_service_use(unsigned handle)
+int vchi_service_use(unsigned handle)
 {
 	return vchiq_use_service(handle);
 }
@@ -234,7 +194,7 @@ EXPORT_SYMBOL(vchi_service_use);
  * Returns: void
  *
  ***********************************************************/
-int32_t vchi_service_release(unsigned handle)
+int vchi_service_release(unsigned handle)
 {
 	return vchiq_release_service(handle);
 }
-- 
2.27.0

