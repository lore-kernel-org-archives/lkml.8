Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69026C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4978F207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbgE0L5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387671AbgE0Lyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AD89AAD17;
        Wed, 27 May 2020 11:54:36 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 23/50] staging: vchi: Use vchiq's enum vchiq_reason
Date:   Wed, 27 May 2020 13:53:28 +0200
Message-Id: <20200527115400.31391-24-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
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
 .../staging/vc04_services/vc-sm-cma/vc_sm.c   |  1 +
 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c  |  7 ++--
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 11 +++--
 6 files changed, 14 insertions(+), 70 deletions(-)

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
index 3a5545e0db6b..649a65f02578 100644
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
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
index e660f546a7e4..fcef607e9446 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
@@ -48,6 +48,7 @@
 #include <linux/types.h>
 #include <asm/cacheflush.h>
 
+#include "vchiq_if.h"
 #include "vchiq_connected.h"
 #include "vc_sm_cma_vchi.h"
 
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
index b7de8526fc54..7efe42d51e46 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
@@ -265,8 +265,7 @@ static int vc_sm_cma_vchi_videocore_io(void *arg)
 	return 0;
 }
 
-static void vc_sm_cma_vchi_callback(void *param,
-				    const enum vchi_callback_reason reason,
+static void vc_sm_cma_vchi_callback(void *param, const enum vchiq_reason reason,
 				    void *msg_handle)
 {
 	struct sm_instance *instance = param;
@@ -274,11 +273,11 @@ static void vc_sm_cma_vchi_callback(void *param,
 	(void)msg_handle;
 
 	switch (reason) {
-	case VCHI_CALLBACK_MSG_AVAILABLE:
+	case VCHIQ_MESSAGE_AVAILABLE:
 		complete(&instance->io_cmplt);
 		break;
 
-	case VCHI_CALLBACK_SERVICE_CLOSED:
+	case VCHIQ_SERVICE_CLOSED:
 		pr_info("%s: service CLOSED!!", __func__);
 	default:
 		break;
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 1d9a3f94799a..258cfab7d397 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -674,8 +674,7 @@ static void bulk_abort_cb(struct vchiq_mmal_instance *instance,
 }
 
 /* incoming event service callback */
-static void service_callback(void *param,
-			     const enum vchi_callback_reason reason,
+static void service_callback(void *param, const enum vchiq_reason reason,
 			     void *bulk_ctx)
 {
 	struct vchiq_mmal_instance *instance = param;
@@ -691,7 +690,7 @@ static void service_callback(void *param,
 	}
 
 	switch (reason) {
-	case VCHI_CALLBACK_MSG_AVAILABLE:
+	case VCHIQ_MESSAGE_AVAILABLE:
 		status = vchi_msg_hold(instance->service, (void **)&msg,
 				       &msg_len, &msg_handle);
 		if (status) {
@@ -756,15 +755,15 @@ static void service_callback(void *param,
 
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
2.26.2

