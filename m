Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9CDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8BC206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgF2TVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:21:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732204AbgF2TVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59B8BB066;
        Mon, 29 Jun 2020 15:10:10 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 42/47] staging: vchi: Move vchi_queue_kernel_message() into vchiq
Date:   Mon, 29 Jun 2020 17:09:40 +0200
Message-Id: <20200629150945.10720-43-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't really merge it with vchiq_queue_message() as it has internal
users that will not benefit from the retry mechanism
vchiq_queue_kernel_message() uses. So, for the sake of getting rid of
vchi, move it into vchiq.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bcm2835-audio/bcm2835-vchiq.c             |  8 +++----
 .../vc04_services/interface/vchi/vchi.h       |  4 ----
 .../interface/vchiq_arm/vchiq_core.c          | 23 ++++++++++++++++---
 .../interface/vchiq_arm/vchiq_if.h            |  4 ++--
 .../interface/vchiq_arm/vchiq_shim.c          | 22 ------------------
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 14 +++++------
 6 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 28d64bc895cd..efaa2ae11f52 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -44,8 +44,8 @@ static int bcm2835_audio_send_msg_locked(struct bcm2835_audio_instance *instance
 		init_completion(&instance->msg_avail_comp);
 	}
 
-	status = vchi_queue_kernel_message(instance->service_handle,
-					   m, sizeof(*m));
+	status = vchiq_queue_kernel_message(instance->service_handle,
+					    m, sizeof(*m));
 	if (status) {
 		dev_err(instance->dev,
 			"vchi message queue failed: %d, msg=%d\n",
@@ -350,8 +350,8 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 		while (count > 0) {
 			int bytes = min(instance->max_packet, count);
 
-			status = vchi_queue_kernel_message(instance->service_handle,
-							   src, bytes);
+			status = vchiq_queue_kernel_message(instance->service_handle,
+							    src, bytes);
 			src += bytes;
 			count -= bytes;
 		}
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index c800796f9986..6de5df43cc29 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -37,10 +37,6 @@ extern int32_t vchi_service_use(unsigned handle);
 // Routine to decrement ref count on a named service
 extern int32_t vchi_service_release(unsigned handle);
 
-/* Routine to send a message from kernel memory across a service */
-extern int vchi_queue_kernel_message(unsigned handle, void *data,
-				     unsigned int size);
-
 // Routine to look at a message in place.
 // The message is dequeued, so the caller is left holding it; the descriptor is
 // filled in and must be released when the user has finished with the message.
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index bb69c91c44b0..39d15f9f4a18 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3213,11 +3213,28 @@ vchiq_queue_message(unsigned int handle,
 	return status;
 }
 
-enum vchiq_status vchiq_queue_kernel_message(unsigned int handle, void *context,
-				      size_t size)
+int vchiq_queue_kernel_message(unsigned handle, void *data, unsigned size)
 {
-	return vchiq_queue_message(handle, memcpy_copy_callback, context, size);
+	enum vchiq_status status;
+
+	while (1) {
+		status = vchiq_queue_message(handle, memcpy_copy_callback,
+					     data, size);
+
+		/*
+		 * vchiq_queue_message() may return VCHIQ_RETRY, so we need to
+		 * implement a retry mechanism since this function is supposed
+		 * to block until queued
+		 */
+		if (status != VCHIQ_RETRY)
+			break;
+
+		msleep(1);
+	}
+
+	return status;
 }
+EXPORT_SYMBOL(vchiq_queue_kernel_message);
 
 void
 vchiq_release_message(unsigned int handle,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 931debcd6492..6374eda4ea0c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -89,8 +89,8 @@ extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
 extern enum vchiq_status vchiq_close_service(unsigned int service);
 extern enum vchiq_status vchiq_use_service(unsigned int service);
 extern enum vchiq_status vchiq_release_service(unsigned int service);
-extern enum vchiq_status vchiq_queue_kernel_message(unsigned int handle,
-						    void *context, size_t size);
+extern int vchiq_queue_kernel_message(unsigned handle, void *data,
+				      unsigned size);
 extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
 extern void           vchiq_release_message(unsigned int service,
 	struct vchiq_header *header);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 33493643b5f8..57ac6a289a08 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -9,28 +9,6 @@
 #include "../vchi/vchi.h"
 #include "vchiq.h"
 
-int vchi_queue_kernel_message(unsigned handle, void *data, unsigned int size)
-{
-	enum vchiq_status status;
-
-	while (1) {
-		status = vchiq_queue_kernel_message(handle, data, size);
-
-		/*
-		 * vchiq_queue_message() may return VCHIQ_RETRY, so we need to
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
-EXPORT_SYMBOL(vchi_queue_kernel_message);
-
 /***********************************************************
  * Name: vchi_held_msg_release
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 4c6a6f4d89fc..c7a425db1d29 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -440,10 +440,9 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 
 	vchi_service_use(instance->service_handle);
 
-	ret = vchi_queue_kernel_message(instance->service_handle,
-					&m,
-					sizeof(struct mmal_msg_header) +
-					sizeof(m.u.buffer_from_host));
+	ret = vchiq_queue_kernel_message(instance->service_handle, &m,
+					 sizeof(struct mmal_msg_header) +
+					 sizeof(m.u.buffer_from_host));
 
 	vchi_service_release(instance->service_handle);
 
@@ -681,10 +680,9 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_instance *instance,
 
 	vchi_service_use(instance->service_handle);
 
-	ret = vchi_queue_kernel_message(instance->service_handle,
-					msg,
-					sizeof(struct mmal_msg_header) +
-					payload_len);
+	ret = vchiq_queue_kernel_message(instance->service_handle, msg,
+					 sizeof(struct mmal_msg_header) +
+					 payload_len);
 
 	vchi_service_release(instance->service_handle);
 
-- 
2.27.0

