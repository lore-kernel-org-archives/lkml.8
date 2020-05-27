Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1C1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FC6207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgE0L6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:58:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:40806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbgE0LyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9E3AAD66;
        Wed, 27 May 2020 11:54:17 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 04/50] staging: vchi: Merge vchi_msg_queue() into vchi_queue_kernel_message()
Date:   Wed, 27 May 2020 13:53:09 +0200
Message-Id: <20200527115400.31391-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no gains from that extra indirection level. Also, get rid of
the function description, the whole file will disappear soon.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_shim.c          | 29 +++----------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 1c5ddea8b076..081ab67ad6fd 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -84,30 +84,15 @@ int32_t vchi_msg_remove(struct vchi_service_handle *handle)
 }
 EXPORT_SYMBOL(vchi_msg_remove);
 
-/***********************************************************
- * Name: vchi_msg_queue
- *
- * Arguments:  struct vchi_service_handle *handle,
- *             ssize_t (*copy_callback)(void *context, void *dest,
- *				        size_t offset, size_t maxsize),
- *	       void *context,
- *             uint32_t data_size
- *
- * Description: Thin wrapper to queue a message onto a connection
- *
- * Returns: int32_t - success == 0
- *
- ***********************************************************/
-static
-int32_t vchi_msg_queue(struct vchi_service_handle *handle, void *context,
-		       uint32_t data_size)
+int vchi_queue_kernel_message(struct vchi_service_handle *handle, void *data,
+			       unsigned int size)
 {
 	struct shim_service *service = (struct shim_service *)handle;
 	enum vchiq_status status;
 
 	while (1) {
-		status = vchiq_queue_kernel_message(service->handle, context,
-						    data_size);
+		status = vchiq_queue_kernel_message(service->handle, data,
+						    size);
 
 		/*
 		 * vchiq_queue_message() may return VCHIQ_RETRY, so we need to
@@ -122,12 +107,6 @@ int32_t vchi_msg_queue(struct vchi_service_handle *handle, void *context,
 
 	return vchiq_status_to_vchi(status);
 }
-
-int vchi_queue_kernel_message(struct vchi_service_handle *handle, void *data,
-			      unsigned int size)
-{
-	return vchi_msg_queue(handle, data, size);
-}
 EXPORT_SYMBOL(vchi_queue_kernel_message);
 
 /***********************************************************
-- 
2.26.2

