Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070BFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E351C206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbgF2TV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:21:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:59256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732156AbgF2TVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84E5EB05D;
        Mon, 29 Jun 2020 15:10:09 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 40/47] staging: vchi: Get rid of vchi_bulk_queue_receive()
Date:   Mon, 29 Jun 2020 17:09:38 +0200
Message-Id: <20200629150945.10720-41-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its vchiq counterpart, vchiq_bulk_receive() is only used by vchi. We can
then merge both functions by moving vchi_bulk_queue_receive()'s retry
mechanism into vchiq_bulk_receive() and let services call the later.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchi/vchi.h       |  7 ----
 .../interface/vchiq_arm/vchiq_arm.c           | 42 ++++++++++++-------
 .../interface/vchiq_arm/vchiq_shim.c          | 38 -----------------
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 20 ++++-----
 4 files changed, 37 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index d24e7027c08f..ca20b99122f2 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -58,13 +58,6 @@ extern int32_t vchi_held_msg_release(unsigned handle, struct vchiq_header *messa
  * Global bulk API
  *****************************************************************************/
 
-// Routine to prepare interface for a transfer from the other side
-extern int32_t vchi_bulk_queue_receive(unsigned handle,
-				       void *data_dst,
-				       uint32_t data_size,
-				       enum vchiq_bulk_mode mode,
-				       void *transfer_handle);
-
 // Routine to queue up data ready for transfer to the other (once they have signalled they are ready)
 extern int32_t vchi_bulk_queue_transmit(unsigned handle,
 					const void *data_src,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 1a050ac116fa..1165824711a5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -374,24 +374,36 @@ vchiq_bulk_transmit(unsigned int handle, const void *data,
 }
 EXPORT_SYMBOL(vchiq_bulk_transmit);
 
-enum vchiq_status
-vchiq_bulk_receive(unsigned int handle, void *data,
-	unsigned int size, void *userdata, enum vchiq_bulk_mode mode)
+enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
+				     unsigned int size, void *userdata,
+				     enum vchiq_bulk_mode mode)
 {
 	enum vchiq_status status;
 
-	switch (mode) {
-	case VCHIQ_BULK_MODE_NOCALLBACK:
-	case VCHIQ_BULK_MODE_CALLBACK:
-		status = vchiq_bulk_transfer(handle, data, size, userdata,
-					     mode, VCHIQ_BULK_RECEIVE);
-		break;
-	case VCHIQ_BULK_MODE_BLOCKING:
-		status = vchiq_blocking_bulk_transfer(handle,
-			(void *)data, size, VCHIQ_BULK_RECEIVE);
-		break;
-	default:
-		return VCHIQ_ERROR;
+	while (1) {
+		switch (mode) {
+		case VCHIQ_BULK_MODE_NOCALLBACK:
+		case VCHIQ_BULK_MODE_CALLBACK:
+			status = vchiq_bulk_transfer(handle, data, size, userdata,
+						     mode, VCHIQ_BULK_RECEIVE);
+			break;
+		case VCHIQ_BULK_MODE_BLOCKING:
+			status = vchiq_blocking_bulk_transfer(handle,
+				(void *)data, size, VCHIQ_BULK_RECEIVE);
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
index 52654123463d..f69936a9eb29 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -31,44 +31,6 @@ int vchi_queue_kernel_message(unsigned handle, void *data, unsigned int size)
 }
 EXPORT_SYMBOL(vchi_queue_kernel_message);
 
-/***********************************************************
- * Name: vchi_bulk_queue_receive
- *
- * Arguments:  VCHI_BULK_HANDLE_T handle,
- *             void *data_dst,
- *             const uint32_t data_size,
- *             enum vchi_flags flags
- *             void *bulk_handle
- *
- * Description: Routine to setup a rcv buffer
- *
- * Returns: int32_t - success == 0
- *
- ***********************************************************/
-int32_t vchi_bulk_queue_receive(unsigned handle, void *data_dst,
-				uint32_t data_size, enum vchiq_bulk_mode mode,
-				void *bulk_handle)
-{
-	enum vchiq_status status;
-
-	while (1) {
-		status = vchiq_bulk_receive(handle, data_dst, data_size,
-					    bulk_handle, mode);
-		/*
-		 * vchiq_bulk_receive() may return VCHIQ_RETRY, so we need to
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
-EXPORT_SYMBOL(vchi_bulk_queue_receive);
-
 /***********************************************************
  * Name: vchi_bulk_queue_transmit
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 2c5027c1f0bb..4c6a6f4d89fc 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -279,7 +279,7 @@ static void buffer_work_cb(struct work_struct *work)
  * VCHI will allow up to 4 bulk receives to be scheduled before blocking.
  * If we block in the service_callback context then we can't process the
  * VCHI_CALLBACK_BULK_RECEIVED message that would otherwise allow the blocked
- * vchi_bulk_queue_receive() call to complete.
+ * vchiq_bulk_receive() call to complete.
  */
 static void buffer_to_host_work_cb(struct work_struct *work)
 {
@@ -295,19 +295,19 @@ static void buffer_to_host_work_cb(struct work_struct *work)
 		len = 8;
 	/* queue the bulk submission */
 	vchi_service_use(instance->service_handle);
-	ret = vchi_bulk_queue_receive(instance->service_handle,
-				      msg_context->u.bulk.buffer->buffer,
-				      /* Actual receive needs to be a multiple
-				       * of 4 bytes
-				       */
-				      (len + 3) & ~3,
-				      VCHIQ_BULK_MODE_CALLBACK,
-				      msg_context);
+	ret = vchiq_bulk_receive(instance->service_handle,
+				 msg_context->u.bulk.buffer->buffer,
+			         /* Actual receive needs to be a multiple
+			          * of 4 bytes
+			          */
+			         (len + 3) & ~3,
+			         msg_context,
+			         VCHIQ_BULK_MODE_CALLBACK);
 
 	vchi_service_release(instance->service_handle);
 
 	if (ret != 0)
-		pr_err("%s: ctx: %p, vchi_bulk_queue_receive failed %d\n",
+		pr_err("%s: ctx: %p, vchiq_bulk_receive failed %d\n",
 		       __func__, msg_context, ret);
 }
 
-- 
2.27.0

