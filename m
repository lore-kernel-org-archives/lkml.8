Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051DEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB47E207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgE0Lz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:55:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387903AbgE0Lyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B1AFAC64;
        Wed, 27 May 2020 11:54:55 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 40/50] staging: vchiq: Get rid of unnecessary definitions in vchiq_if.h
Date:   Wed, 27 May 2020 13:53:45 +0200
Message-Id: <20200527115400.31391-41-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those functions don't actually exist, nor have any use, nor the macros.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_if.h              | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index b3d4c14536bd..407e7dc31108 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -8,11 +8,9 @@
 
 #define VCHIQ_SLOT_SIZE     4096
 #define VCHIQ_MAX_MSG_SIZE  (VCHIQ_SLOT_SIZE - sizeof(struct vchiq_header))
-#define VCHIQ_CHANNEL_SIZE  VCHIQ_MAX_MSG_SIZE /* For backwards compatibility */
 
 #define VCHIQ_MAKE_FOURCC(x0, x1, x2, x3) \
 			(((x0) << 24) | ((x1) << 16) | ((x2) << 8) | (x3))
-#define VCHIQ_GET_SERVICE_USERDATA(service) vchiq_get_service_userdata(service)
 
 enum vchiq_reason {
 	VCHIQ_SERVICE_OPENED,         /* service, -, -             */
@@ -92,7 +90,6 @@ struct vchiq_config {
 };
 
 struct vchiq_instance;
-typedef void (*vchiq_remote_callback)(void *cb_arg);
 
 extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
 extern enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance);
@@ -118,25 +115,11 @@ extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
 extern enum vchiq_status vchiq_bulk_receive(unsigned int service,
 	void *data, unsigned int size, void *userdata,
 	enum vchiq_bulk_mode mode);
-extern enum vchiq_status vchiq_bulk_transmit_handle(unsigned int service,
-	const void *offset, unsigned int size,
-	void *userdata,	enum vchiq_bulk_mode mode);
-extern enum vchiq_status vchiq_bulk_receive_handle(unsigned int service,
-	void *offset, unsigned int size, void *userdata,
-	enum vchiq_bulk_mode mode);
 extern int   vchiq_get_client_id(unsigned int service);
 extern void *vchiq_get_service_userdata(unsigned int service);
 extern void vchiq_get_config(struct vchiq_config *config);
 extern enum vchiq_status vchiq_set_service_option(unsigned int service,
 	enum vchiq_service_option option, int value);
-
-extern enum vchiq_status vchiq_remote_use(struct vchiq_instance *instance,
-	vchiq_remote_callback callback, void *cb_arg);
-extern enum vchiq_status vchiq_remote_release(struct vchiq_instance *instance);
-
-extern enum vchiq_status vchiq_dump_phys_mem(unsigned int service,
-	void *ptr, size_t num_bytes);
-
 extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
       short *peer_version);
 extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
-- 
2.26.2

