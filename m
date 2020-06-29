Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB75FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1445206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbgF2TWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:22:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:59528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbgF2TVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50BFBAF82;
        Mon, 29 Jun 2020 15:10:01 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 20/47] staging: vchi: Use vchiq's enum vchiq_reason
Date:   Mon, 29 Jun 2020 17:09:18 +0200
Message-Id: <20200629150945.10720-21-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enum vchi_callback_reason maps 1:1 to enum vchiq_reason, in an effort to
simplify things, let's use the later, and get rid of the extra
indirection.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bcm2835-audio/bcm2835-vchiq.c             |  5 +--
 .../interface/vchi/vchi_common.h              | 20 +---------
 .../interface/vchiq_arm/vchiq_shim.c          | 40 +------------------
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 11 +++--
 4 files changed, 10 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 565853ec1e7a..0f97eda4ec90 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -89,8 +89,7 @@ static int bcm2835_audio_send_simple(struct bcm2835_audio_instance *instance,
 	return bcm2835_audio_send_msg(instance, &m, wait);
 }
 
-static void audio_vchi_callback(void *param,
-				const enum vchi_callback_reason reason,
+static void audio_vchi_callback(void *param, const enum vchiq_reason reason,
 				void *msg_handle)
 {
 	struct bcm2835_audio_instance *instance = param;
@@ -99,7 +98,7 @@ static void audio_vchi_callback(void *param,
 	unsigned size;
 	int status;
 
-	if (reason != VCHI_CALLBACK_MSG_AVAILABLE)
+	if (reason != VCHIQ_MESSAGE_AVAILABLE)
 		return;
 
 	status = vchi_msg_hold(instance->service, (void **)&m, &size, &handle);
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_common.h b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
index 52b447c19445..24e8665e214a 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_common.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
@@ -4,27 +4,9 @@
 #ifndef VCHI_COMMON_H_
 #define VCHI_COMMON_H_
 
-//callback reasons when an event occurs on a service
-enum vchi_callback_reason {
-	/*
-	 * This indicates that there is data available handle is the msg id that
-	 * was transmitted with the data
-	 * When a message is received and there was no FULL message available
-	 * previously, send callback
-	 * Tasks get kicked by the callback, reset their event and try and read
-	 * from the fifo until it fails
-	 */
-	VCHI_CALLBACK_SERVICE_CLOSED,
-	VCHI_CALLBACK_MSG_AVAILABLE,
-	VCHI_CALLBACK_BULK_SENT,
-	VCHI_CALLBACK_BULK_RECEIVED,
-	VCHI_CALLBACK_BULK_TRANSMIT_ABORTED,
-	VCHI_CALLBACK_BULK_RECEIVE_ABORTED,
-};
-
 //Callback used by all services / bulk transfers
 typedef void (*vchi_callback)(void *callback_param, //my service local param
-			      enum vchi_callback_reason reason,
+			      enum vchiq_reason reason,
 			      void *handle); //for transmitting msg's only
 
 #endif // VCHI_COMMON_H_
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index c6b14d31492b..f2998c0ca5b1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -274,46 +274,10 @@ static enum vchiq_status shim_callback(enum vchiq_reason reason,
 	if (!service->callback)
 		goto release;
 
-	switch (reason) {
-	case VCHIQ_MESSAGE_AVAILABLE:
+	if (reason == VCHIQ_MESSAGE_AVAILABLE)
 		vchiu_queue_push(&service->queue, header);
 
-		service->callback(service->callback_param,
-				  VCHI_CALLBACK_MSG_AVAILABLE, NULL);
-
-		break;
-
-	case VCHIQ_BULK_TRANSMIT_DONE:
-		service->callback(service->callback_param,
-				  VCHI_CALLBACK_BULK_SENT, bulk_user);
-		break;
-
-	case VCHIQ_BULK_RECEIVE_DONE:
-		service->callback(service->callback_param,
-				  VCHI_CALLBACK_BULK_RECEIVED, bulk_user);
-		break;
-
-	case VCHIQ_SERVICE_CLOSED:
-		service->callback(service->callback_param,
-				  VCHI_CALLBACK_SERVICE_CLOSED, NULL);
-		break;
-
-	case VCHIQ_BULK_TRANSMIT_ABORTED:
-		service->callback(service->callback_param,
-				  VCHI_CALLBACK_BULK_TRANSMIT_ABORTED,
-				  bulk_user);
-		break;
-
-	case VCHIQ_BULK_RECEIVE_ABORTED:
-		service->callback(service->callback_param,
-				  VCHI_CALLBACK_BULK_RECEIVE_ABORTED,
-				  bulk_user);
-		break;
-
-	default:
-		WARN(1, "not supported\n");
-		break;
-	}
+	service->callback(service->callback_param, reason, bulk_user);
 
 release:
 	return VCHIQ_SUCCESS;
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 5c9fd354a7fe..f710ccccb14c 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -549,8 +549,7 @@ static void bulk_abort_cb(struct vchiq_mmal_instance *instance,
 }
 
 /* incoming event service callback */
-static void service_callback(void *param,
-			     const enum vchi_callback_reason reason,
+static void service_callback(void *param, const enum vchiq_reason reason,
 			     void *bulk_ctx)
 {
 	struct vchiq_mmal_instance *instance = param;
@@ -566,7 +565,7 @@ static void service_callback(void *param,
 	}
 
 	switch (reason) {
-	case VCHI_CALLBACK_MSG_AVAILABLE:
+	case VCHIQ_MESSAGE_AVAILABLE:
 		status = vchi_msg_hold(instance->service, (void **)&msg,
 				       &msg_len, &msg_handle);
 		if (status) {
@@ -631,15 +630,15 @@ static void service_callback(void *param,
 
 		break;
 
-	case VCHI_CALLBACK_BULK_RECEIVED:
+	case VCHIQ_BULK_RECEIVE_DONE:
 		bulk_receive_cb(instance, bulk_ctx);
 		break;
 
-	case VCHI_CALLBACK_BULK_RECEIVE_ABORTED:
+	case VCHIQ_BULK_RECEIVE_ABORTED:
 		bulk_abort_cb(instance, bulk_ctx);
 		break;
 
-	case VCHI_CALLBACK_SERVICE_CLOSED:
+	case VCHIQ_SERVICE_CLOSED:
 		/* TODO: consider if this requires action if received when
 		 * driver is not explicitly closing the service
 		 */
-- 
2.27.0

