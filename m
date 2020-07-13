Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C49C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B2620738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXkjoQfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgGMOhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:37:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1554DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:37:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so5597544pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6h4nc4PcIrIUv15+ByYYiTsFlJJxjA7wtMBBwHQX5v0=;
        b=BXkjoQfx48H2e6nBUni5xxwkx5mRQrvIrPnoDE+R8Qva8vJwI+BS0BPVCEmsH2q+yr
         I461L736DFMAP+3S4jPi5ynyR4LyBhETmOpXzWTiiqyk4YmxNBwsq0WEd7oO3+VhErRV
         KgrrHOYFYzLdSRBB2j/v9xLwH3OW5YWoNyrbPKjI29gNCrTPxpsUaYZwSPPZ0Z8pq02M
         YjiCkTmMqXlm5j4kXJARs4goGChtn3lzj25n4TcqDtII8yUu78H+SZnMSq68BFAFOBon
         mlZfie0wJtmVDmzqmRxXeiCsHE5S5v1g9drYRQGuj6IdyRPTxwrIzGsxDYLqZJ+yxZWU
         tFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6h4nc4PcIrIUv15+ByYYiTsFlJJxjA7wtMBBwHQX5v0=;
        b=HJ17lgkHnb0Hv8JeF4N4dtXji+ahpGXm5i6nhPBiiyDJV8OavYVIzM8AV9ouYZxcCu
         npWt8jtzhioaU8T4NAxOkAzb8fIUTZI2psl5waZD7VVq1MQXWaxbyAJfbaewUR8ULNut
         VejDBZFzwzl10hZ/rFhLJD3qJbr1EUaOwgfR3jh2VK2KNZ23/m4mQ6gutNcWxoEaRMBQ
         rFRKtPJLi0ytX2KV8LNe3+XnJKAK4K9W2lmkjJt25FGqNxaHBxu8TTWsD3b/k2+Y4K0P
         pA9myfNur6O3OLLP3gloLzrD/xx+7DPEAxNQqDnrvFdAuCjqreRFtq6xdMtKNYt9m17J
         Hg2Q==
X-Gm-Message-State: AOAM530Vw94oCXWM9sbjoM2clL+R2dE5dBBGeKwPD7oEzBXp+pp0FUT+
        nllJ28qVSYDfmTn6X/rhax4=
X-Google-Smtp-Source: ABdhPJxlYOPflhEqsOIGOMz/15FQEGURw1GaUxETKRiOmGKPsMhrDUr8X9XyvRWLjRPkZMdC/uXvvQ==
X-Received: by 2002:a17:902:b113:: with SMTP id q19mr1388plr.170.1594651035151;
        Mon, 13 Jul 2020 07:37:15 -0700 (PDT)
Received: from localhost.localdomain ([103.88.59.5])
        by smtp.googlemail.com with ESMTPSA id b13sm15094820pjl.7.2020.07.13.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:37:14 -0700 (PDT)
From:   Baidyanath Kundu <kundubaidya99@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Baidyanath Kundu <kundubaidya99@gmail.com>
Subject: [PATCH] Staging: vc04_services: Fix unsigned int warnings
Date:   Mon, 13 Jul 2020 20:06:53 +0530
Message-Id: <20200713143653.32332-1-kundubaidya99@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Baidyanath Kundu <kundubaidya99@gmail.com>
---
 .../staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c   | 4 ++--
 .../vc04_services/include/linux/raspberrypi/vchiq.h       | 8 ++++----
 .../vc04_services/interface/vchiq_arm/vchiq_core.c        | 6 +++---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c     | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 8c9ddd86fbbd..292fcee9d6f2 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -9,7 +9,7 @@
 
 struct bcm2835_audio_instance {
 	struct device *dev;
-	unsigned service_handle;
+	unsigned int service_handle;
 	struct completion msg_avail_comp;
 	struct mutex vchi_mutex;
 	struct bcm2835_alsa_stream *alsa_stream;
@@ -91,7 +91,7 @@ static int bcm2835_audio_send_simple(struct bcm2835_audio_instance *instance,
 
 static enum vchiq_status audio_vchi_callback(enum vchiq_reason reason,
 					     struct vchiq_header *header,
-					     unsigned handle, void *userdata)
+					     unsigned int handle, void *userdata)
 {
 	struct bcm2835_audio_instance *instance = vchiq_get_service_userdata(handle);
 	struct vc_audio_msg *m;
diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index cb9ef9a4150b..18d63df368c4 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -84,11 +84,11 @@ extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
 extern enum vchiq_status vchiq_close_service(unsigned int service);
 extern enum vchiq_status vchiq_use_service(unsigned int service);
 extern enum vchiq_status vchiq_release_service(unsigned int service);
-extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
+extern void vchiq_msg_queue_push(unsigned int handle, struct vchiq_header *header);
 extern void           vchiq_release_message(unsigned int service,
 	struct vchiq_header *header);
-extern int vchiq_queue_kernel_message(unsigned handle, void *data,
-				      unsigned size);
+extern int vchiq_queue_kernel_message(unsigned int handle, void *data,
+				      unsigned int size);
 extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
 	const void *data, unsigned int size, void *userdata,
 	enum vchiq_bulk_mode mode);
@@ -98,6 +98,6 @@ extern enum vchiq_status vchiq_bulk_receive(unsigned int service,
 extern void *vchiq_get_service_userdata(unsigned int service);
 extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
       short *peer_version);
-extern struct vchiq_header *vchiq_msg_hold(unsigned handle);
+extern struct vchiq_header *vchiq_msg_hold(unsigned int handle);
 
 #endif /* VCHIQ_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 1bc4ce577614..af64cde82d36 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2275,7 +2275,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	return VCHIQ_ERROR;
 }
 
-void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header)
+void vchiq_msg_queue_push(unsigned int handle, struct vchiq_header *header)
 {
 	struct vchiq_service *service = find_service_by_handle(handle);
 	int pos;
@@ -2293,7 +2293,7 @@ void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header)
 }
 EXPORT_SYMBOL(vchiq_msg_queue_push);
 
-struct vchiq_header *vchiq_msg_hold(unsigned handle)
+struct vchiq_header *vchiq_msg_hold(unsigned int handle)
 {
 	struct vchiq_service *service = find_service_by_handle(handle);
 	struct vchiq_header *header;
@@ -3214,7 +3214,7 @@ vchiq_queue_message(unsigned int handle,
 	return status;
 }
 
-int vchiq_queue_kernel_message(unsigned handle, void *data, unsigned size)
+int vchiq_queue_kernel_message(unsigned int handle, void *data, unsigned int size)
 {
 	enum vchiq_status status;
 
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index a075cd63da7f..dc767730db43 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -163,7 +163,7 @@ struct mmal_msg_context {
 };
 
 struct vchiq_mmal_instance {
-	unsigned service_handle;
+	unsigned int service_handle;
 
 	/* ensure serialised access to service */
 	struct mutex vchiq_mutex;
@@ -548,7 +548,7 @@ static void bulk_abort_cb(struct vchiq_mmal_instance *instance,
 /* incoming event service callback */
 static enum vchiq_status service_callback(enum vchiq_reason reason,
 					  struct vchiq_header *header,
-					  unsigned handle, void *bulk_ctx)
+					  unsigned int handle, void *bulk_ctx)
 {
 	struct vchiq_mmal_instance *instance = vchiq_get_service_userdata(handle);
 	u32 msg_len;
-- 
2.17.1

