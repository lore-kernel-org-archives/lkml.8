Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9215C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC2E207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgE0L6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:58:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgE0LyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 413C8ADE3;
        Wed, 27 May 2020 11:54:16 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 02/50] staging: vchi: Get rid of vchi_queue_user_message()
Date:   Wed, 27 May 2020 13:53:07 +0200
Message-Id: <20200527115400.31391-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function has no users.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchi/vchi.h       |  6 ----
 .../interface/vchiq_arm/vchiq_shim.c          | 34 -------------------
 2 files changed, 40 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 686cfc536012..62d9d3efa755 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -111,12 +111,6 @@ vchi_queue_kernel_message(struct vchi_service_handle *handle,
 			  void *data,
 			  unsigned int size);
 
-/* Routine to send a message from user memory across a service */
-extern int
-vchi_queue_user_message(struct vchi_service_handle *handle,
-			void __user *data,
-			unsigned int size);
-
 // Routine to receive a msg from a service
 // Dequeue is equivalent to hold, copy into client buffer, release
 extern int32_t vchi_msg_dequeue(struct vchi_service_handle *handle,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 9a040651bb9b..2c2bd7a9dc27 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -150,40 +150,6 @@ vchi_queue_kernel_message(struct vchi_service_handle *handle,
 }
 EXPORT_SYMBOL(vchi_queue_kernel_message);
 
-struct vchi_queue_user_message_context {
-	void __user *data;
-};
-
-static ssize_t
-vchi_queue_user_message_callback(void *context,
-				 void *dest,
-				 size_t offset,
-				 size_t maxsize)
-{
-	struct vchi_queue_user_message_context *copycontext = context;
-
-	if (copy_from_user(dest, copycontext->data + offset, maxsize))
-		return -EFAULT;
-
-	return maxsize;
-}
-
-int
-vchi_queue_user_message(struct vchi_service_handle *handle,
-			void __user *data,
-			unsigned int size)
-{
-	struct vchi_queue_user_message_context copycontext = {
-		.data = data
-	};
-
-	return vchi_msg_queue(handle,
-			      vchi_queue_user_message_callback,
-			      &copycontext,
-			      size);
-}
-EXPORT_SYMBOL(vchi_queue_user_message);
-
 /***********************************************************
  * Name: vchi_bulk_queue_receive
  *
-- 
2.26.2

