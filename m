Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFEDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59E020672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgF2Uf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:35:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:59510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732185AbgF2TVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2016AF7F;
        Mon, 29 Jun 2020 15:10:00 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 19/47] staging: vchi: Use enum vchiq_bulk_mode instead of vchi's transmission flags
Date:   Mon, 29 Jun 2020 17:09:17 +0200
Message-Id: <20200629150945.10720-20-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchi has a set of transfer flags which almost map 1:1 to vchiq's own
transfer modes. For the sake of simplicity let's use the later and
delete vchi's.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bcm2835-audio/bcm2835-vchiq.c             |  2 +-
 .../vc04_services/bcm2835-audio/bcm2835.h     |  1 +
 .../vc04_services/interface/vchi/vchi.h       |  4 +-
 .../interface/vchi/vchi_common.h              |  9 ----
 .../interface/vchiq_arm/vchiq_shim.c          | 44 ++-----------------
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  4 +-
 6 files changed, 9 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 68119246f10b..565853ec1e7a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -348,7 +348,7 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 		/* Send the message to the videocore */
 		status = vchi_bulk_queue_transmit(instance->service,
 						  src, count,
-						  VCHI_FLAGS_BLOCK_UNTIL_DATA_READ,
+						  VCHIQ_BULK_MODE_BLOCKING,
 						  NULL);
 	} else {
 		while (count > 0) {
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 2a94e825194f..7a0e4ab50fc7 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -9,6 +9,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
+#include "interface/vchiq_arm/vchiq_if.h"
 #include "interface/vchi/vchi.h"
 
 #define MAX_SUBSTREAMS   (8)
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 92ce811fc28d..9a74ca4e1062 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -105,14 +105,14 @@ extern int32_t vchi_held_msg_release(struct vchi_held_msg *message);
 extern int32_t vchi_bulk_queue_receive(struct vchi_service *service,
 				       void *data_dst,
 				       uint32_t data_size,
-				       enum vchi_flags flags,
+				       enum vchiq_bulk_mode mode,
 				       void *transfer_handle);
 
 // Routine to queue up data ready for transfer to the other (once they have signalled they are ready)
 extern int32_t vchi_bulk_queue_transmit(struct vchi_service *service,
 					const void *data_src,
 					uint32_t data_size,
-					enum vchi_flags flags,
+				        enum vchiq_bulk_mode mode,
 					void *transfer_handle);
 
 /******************************************************************************
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_common.h b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
index e07376fe4dfd..52b447c19445 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_common.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
@@ -4,15 +4,6 @@
 #ifndef VCHI_COMMON_H_
 #define VCHI_COMMON_H_
 
-//flags used when sending messages (must be bitmapped)
-enum vchi_flags {
-	VCHI_FLAGS_NONE                      = 0x0,
-	VCHI_FLAGS_BLOCK_UNTIL_OP_COMPLETE   = 0x1,   // waits for message to be received, or sent (NB. not the same as being seen on other side)
-	VCHI_FLAGS_CALLBACK_WHEN_OP_COMPLETE = 0x2,   // run a callback when message sent
-	VCHI_FLAGS_BLOCK_UNTIL_QUEUED        = 0x4,   // return once the transfer is in a queue ready to go
-	VCHI_FLAGS_BLOCK_UNTIL_DATA_READ     = 0x10,
-};
-
 //callback reasons when an event occurs on a service
 enum vchi_callback_reason {
 	/*
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 6c48d9ef45cb..c6b14d31492b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
+#include "vchiq_if.h"
 #include "../vchi/vchi.h"
 #include "vchiq.h"
 #include "vchiq_core.h"
@@ -57,30 +58,11 @@ EXPORT_SYMBOL(vchi_queue_kernel_message);
  *
  ***********************************************************/
 int32_t vchi_bulk_queue_receive(struct vchi_service *service, void *data_dst,
-				uint32_t data_size, enum vchi_flags flags,
+				uint32_t data_size, enum vchiq_bulk_mode mode,
 				void *bulk_handle)
 {
-	enum vchiq_bulk_mode mode;
 	enum vchiq_status status;
 
-	switch ((int)flags) {
-	case VCHI_FLAGS_CALLBACK_WHEN_OP_COMPLETE
-		| VCHI_FLAGS_BLOCK_UNTIL_QUEUED:
-		WARN_ON(!service->callback);
-		mode = VCHIQ_BULK_MODE_CALLBACK;
-		break;
-	case VCHI_FLAGS_BLOCK_UNTIL_OP_COMPLETE:
-		mode = VCHIQ_BULK_MODE_BLOCKING;
-		break;
-	case VCHI_FLAGS_BLOCK_UNTIL_QUEUED:
-	case VCHI_FLAGS_NONE:
-		mode = VCHIQ_BULK_MODE_NOCALLBACK;
-		break;
-	default:
-		WARN(1, "unsupported message\n");
-		return VCHIQ_ERROR;
-	}
-
 	while (1) {
 		status = vchiq_bulk_receive(service->handle, data_dst,
 			data_size, bulk_handle, mode);
@@ -116,31 +98,11 @@ EXPORT_SYMBOL(vchi_bulk_queue_receive);
 int32_t vchi_bulk_queue_transmit(struct vchi_service *service,
 				 const void *data_src,
 				 uint32_t data_size,
-				 enum vchi_flags flags,
+				 enum vchiq_bulk_mode mode,
 				 void *bulk_handle)
 {
-	enum vchiq_bulk_mode mode;
 	enum vchiq_status status;
 
-	switch ((int)flags) {
-	case VCHI_FLAGS_CALLBACK_WHEN_OP_COMPLETE
-		| VCHI_FLAGS_BLOCK_UNTIL_QUEUED:
-		WARN_ON(!service->callback);
-		mode = VCHIQ_BULK_MODE_CALLBACK;
-		break;
-	case VCHI_FLAGS_BLOCK_UNTIL_DATA_READ:
-	case VCHI_FLAGS_BLOCK_UNTIL_OP_COMPLETE:
-		mode = VCHIQ_BULK_MODE_BLOCKING;
-		break;
-	case VCHI_FLAGS_BLOCK_UNTIL_QUEUED:
-	case VCHI_FLAGS_NONE:
-		mode = VCHIQ_BULK_MODE_NOCALLBACK;
-		break;
-	default:
-		WARN(1, "unsupported message\n");
-		return VCHIQ_ERROR;
-	}
-
 	while (1) {
 		status = vchiq_bulk_transmit(service->handle, data_src,
 			data_size, bulk_handle, mode);
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index b63d4f5bda1c..5c9fd354a7fe 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -29,6 +29,7 @@
 #include "mmal-vchiq.h"
 #include "mmal-msg.h"
 
+#include "interface/vchiq_arm/vchiq_if.h"
 #include "interface/vchi/vchi.h"
 
 /*
@@ -300,8 +301,7 @@ static void buffer_to_host_work_cb(struct work_struct *work)
 				       * of 4 bytes
 				       */
 				      (len + 3) & ~3,
-				      VCHI_FLAGS_CALLBACK_WHEN_OP_COMPLETE |
-				      VCHI_FLAGS_BLOCK_UNTIL_QUEUED,
+				      VCHIQ_BULK_MODE_CALLBACK,
 				      msg_context);
 
 	vchi_service_release(instance->service);
-- 
2.27.0

