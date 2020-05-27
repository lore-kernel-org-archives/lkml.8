Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC708C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E867207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgE0L55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:57:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:40786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbgE0LyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30B07AD2B;
        Wed, 27 May 2020 11:54:17 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 03/50] staging: vchiq: Move copy callback handling into vchiq
Date:   Wed, 27 May 2020 13:53:08 +0200
Message-Id: <20200527115400.31391-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All vchi users use the kernel variant of the copy callback. The only
user for the user space variant of the copy callback is in the ioctl
implementation. So move all this copying logic into vchiq, and expose a
new function that explicitly passes kernel messages.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_core.c          |  6 ++++
 .../interface/vchiq_arm/vchiq_core.h          |  7 ++++
 .../interface/vchiq_arm/vchiq_if.h            |  8 ++---
 .../interface/vchiq_arm/vchiq_shim.c          | 34 ++++---------------
 4 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index edcd97373809..67b2090c91db 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3147,6 +3147,12 @@ vchiq_queue_message(unsigned int handle,
 	return status;
 }
 
+enum vchiq_status vchiq_queue_kernel_message(unsigned int handle, void *context,
+				      size_t size)
+{
+	return vchiq_queue_message(handle, memcpy_copy_callback, context, size);
+}
+
 void
 vchiq_release_message(unsigned int handle,
 		      struct vchiq_header *header)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index cedd8e721aae..1fe6cd8b86c0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -587,6 +587,13 @@ lock_service(struct vchiq_service *service);
 extern void
 unlock_service(struct vchiq_service *service);
 
+extern enum vchiq_status
+vchiq_queue_message(unsigned int handle,
+		    ssize_t (*copy_callback)(void *context, void *dest,
+					     size_t offset, size_t maxsize),
+		    void *context,
+		    size_t size);
+
 /* The following functions are called from vchiq_core, and external
 ** implementations must be provided. */
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 39b77ea19210..b62fd6d6f1ac 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -105,12 +105,8 @@ extern enum vchiq_status vchiq_close_service(unsigned int service);
 extern enum vchiq_status vchiq_remove_service(unsigned int service);
 extern enum vchiq_status vchiq_use_service(unsigned int service);
 extern enum vchiq_status vchiq_release_service(unsigned int service);
-extern enum vchiq_status
-vchiq_queue_message(unsigned int handle,
-		    ssize_t (*copy_callback)(void *context, void *dest,
-					     size_t offset, size_t maxsize),
-		    void *context,
-		    size_t size);
+extern enum vchiq_status vchiq_queue_kernel_message(unsigned int handle,
+						    void *context, size_t size);
 extern void           vchiq_release_message(unsigned int service,
 	struct vchiq_header *header);
 extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 2c2bd7a9dc27..1c5ddea8b076 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -99,20 +99,15 @@ EXPORT_SYMBOL(vchi_msg_remove);
  *
  ***********************************************************/
 static
-int32_t vchi_msg_queue(struct vchi_service_handle *handle,
-	ssize_t (*copy_callback)(void *context, void *dest,
-				 size_t offset, size_t maxsize),
-	void *context,
-	uint32_t data_size)
+int32_t vchi_msg_queue(struct vchi_service_handle *handle, void *context,
+		       uint32_t data_size)
 {
 	struct shim_service *service = (struct shim_service *)handle;
 	enum vchiq_status status;
 
 	while (1) {
-		status = vchiq_queue_message(service->handle,
-					     copy_callback,
-					     context,
-					     data_size);
+		status = vchiq_queue_kernel_message(service->handle, context,
+						    data_size);
 
 		/*
 		 * vchiq_queue_message() may return VCHIQ_RETRY, so we need to
@@ -128,25 +123,10 @@ int32_t vchi_msg_queue(struct vchi_service_handle *handle,
 	return vchiq_status_to_vchi(status);
 }
 
-static ssize_t
-vchi_queue_kernel_message_callback(void *context,
-				   void *dest,
-				   size_t offset,
-				   size_t maxsize)
+int vchi_queue_kernel_message(struct vchi_service_handle *handle, void *data,
+			      unsigned int size)
 {
-	memcpy(dest, context + offset, maxsize);
-	return maxsize;
-}
-
-int
-vchi_queue_kernel_message(struct vchi_service_handle *handle,
-			  void *data,
-			  unsigned int size)
-{
-	return vchi_msg_queue(handle,
-			      vchi_queue_kernel_message_callback,
-			      data,
-			      size);
+	return vchi_msg_queue(handle, data, size);
 }
 EXPORT_SYMBOL(vchi_queue_kernel_message);
 
-- 
2.26.2

