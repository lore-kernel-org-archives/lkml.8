Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CDAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6EC207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgE0L5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:57:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:41248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387608AbgE0Lyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 18955AD2B;
        Wed, 27 May 2020 11:54:34 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 21/50] staging: vchi: Get rid of flags argument in vchi_msg_hold()
Date:   Wed, 27 May 2020 13:53:26 +0200
Message-Id: <20200527115400.31391-22-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users are ignoring the flags argument. So for the sake of
simplicity delete it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c      |  3 +--
 drivers/staging/vc04_services/interface/vchi/vchi.h  |  1 -
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c   | 12 +++---------
 .../staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c |  2 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c    |  2 +-
 5 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 5018b5baa009..68119246f10b 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -102,8 +102,7 @@ static void audio_vchi_callback(void *param,
 	if (reason != VCHI_CALLBACK_MSG_AVAILABLE)
 		return;
 
-	status = vchi_msg_hold(instance->service, (void **)&m, &size,
-			       VCHI_FLAGS_NONE, &handle);
+	status = vchi_msg_hold(instance->service, (void **)&m, &size, &handle);
 	if (status)
 		return;
 
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 55e51e5a1fdc..92ce811fc28d 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -87,7 +87,6 @@ extern int vchi_queue_kernel_message(struct vchi_service *service, void *data,
 extern int32_t vchi_msg_hold(struct vchi_service *service,
 			     void **data,        // } may be NULL, as info can be
 			     uint32_t *msg_size, // } obtained from HELD_MSG_T
-			     enum vchi_flags flags,
 			     struct vchi_held_msg *message_descriptor);
 
 /*******************************************************************************
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 0c3473861a8d..0466512cfe3c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -195,7 +195,6 @@ EXPORT_SYMBOL(vchi_held_msg_release);
  * Arguments:  struct vchi_service *service,
  *             void **data,
  *             uint32_t *msg_size,
- *             enum vchi_flags flags,
  *             struct vchi_held_msg *message_handle
  *
  * Description: Routine to return a pointer to the current message (to allow
@@ -207,17 +206,12 @@ EXPORT_SYMBOL(vchi_held_msg_release);
  *
  ***********************************************************/
 int32_t vchi_msg_hold(struct vchi_service *service, void **data,
-		      uint32_t *msg_size, enum vchi_flags flags,
-		      struct vchi_held_msg *message_handle)
+		      uint32_t *msg_size, struct vchi_held_msg *message_handle)
 {
 	struct vchiq_header *header;
 
-	WARN_ON((flags != VCHI_FLAGS_NONE) &&
-		(flags != VCHI_FLAGS_BLOCK_UNTIL_OP_COMPLETE));
-
-	if (flags == VCHI_FLAGS_NONE)
-		if (vchiu_queue_is_empty(&service->queue))
-			return -1;
+	if (vchiu_queue_is_empty(&service->queue))
+		return -1;
 
 	header = vchiu_queue_pop(&service->queue);
 
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
index 72b09685db31..826cac7922d2 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
@@ -237,7 +237,7 @@ static int vc_sm_cma_vchi_videocore_io(void *arg)
 		} while (1);
 
 		while (!vchi_msg_hold(instance->service, (void **)&reply,
-				       &reply_len, VCHI_FLAGS_NONE, &msg)) {
+				      &reply_len, &msg)) {
 			if (reply->trans_id & 0x80000000) {
 				/* Async event or cmd from the VPU */
 				if (instance->vpu_event)
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 5183aff453eb..9f905f529d91 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -693,7 +693,7 @@ static void service_callback(void *param,
 	switch (reason) {
 	case VCHI_CALLBACK_MSG_AVAILABLE:
 		status = vchi_msg_hold(instance->service, (void **)&msg,
-				       &msg_len, VCHI_FLAGS_NONE, &msg_handle);
+				       &msg_len, &msg_handle);
 		if (status) {
 			pr_err("Unable to dequeue a message (%d)\n", status);
 			break;
-- 
2.26.2

