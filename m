Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41326C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A22C206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbgF2UfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:35:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:59496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732199AbgF2TVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D05DAFBE;
        Mon, 29 Jun 2020 15:10:05 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 30/47] staging: vchi: Use struct vchiq_service_params
Date:   Mon, 29 Jun 2020 17:09:28 +0200
Message-Id: <20200629150945.10720-31-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For initialization, vchi has its own params structure, which is then
translated to vchiq's params structure. They are essentially the same,
so lets directly use vchiq's.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bcm2835-audio/bcm2835-vchiq.c             |  9 +++++----
 .../vc04_services/interface/vchi/vchi.h       | 19 +------------------
 .../interface/vchiq_arm/vchiq_shim.c          | 12 ++----------
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 11 ++++++-----
 4 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 71750ef891dd..c1537a41a2fe 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -122,11 +122,12 @@ static int
 vc_vchi_audio_init(struct vchiq_instance *vchiq_instance,
 		   struct bcm2835_audio_instance *instance)
 {
-	struct service_creation params = {
-		.version		= VCHI_VERSION_EX(VC_AUDIOSERV_VER, VC_AUDIOSERV_MIN_VER),
-		.service_id		= VC_AUDIO_SERVER_NAME,
+	struct vchiq_service_params params = {
+		.version		= VC_AUDIOSERV_VER,
+		.version_min		= VC_AUDIOSERV_MIN_VER,
+		.fourcc			= VC_AUDIO_SERVER_NAME,
 		.callback		= audio_vchi_callback,
-		.callback_param		= instance,
+		.userdata		= instance,
 	};
 	int status;
 
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index cb66ea1ffad2..4afa6e9f57c4 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -8,12 +8,6 @@
  * Global defs
  *****************************************************************************/
 
-struct vchi_version {
-	uint32_t version;
-	uint32_t version_min;
-};
-#define VCHI_VERSION_EX(v_, m_) { v_, m_ }
-
 // Macros to manipulate 'FOURCC' values
 #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
 
@@ -31,17 +25,6 @@ struct vchi_service {
 	unsigned int handle;
 };
 
-// structure used to provide the information needed to open a server or a client
-struct service_creation {
-	struct vchi_version version;
-	int32_t service_id;
-	enum vchiq_status (*callback)(enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
-	void *callback_param;
-};
-
 // Opaque handle for a VCHIQ instance
 struct vchiq_instance;
 
@@ -64,7 +47,7 @@ extern int32_t vchi_disconnect(struct vchiq_instance *instance);
  *****************************************************************************/
 // Routine to open a named service
 extern int32_t vchi_service_open(struct vchiq_instance *instance,
-				 struct service_creation *setup,
+				 struct vchiq_service_params *setup,
 				 struct vchi_service **service);
 
 extern int32_t vchi_get_peer_version(struct vchi_service *service,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index fb9fd5fec42c..30083927b33d 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -265,23 +265,15 @@ static void service_free(struct vchi_service *service)
 }
 
 int32_t vchi_service_open(struct vchiq_instance *instance,
-	struct service_creation *setup,
+	struct vchiq_service_params *params,
 	struct vchi_service **service)
 {
 
 	*service = service_alloc();
 	if (*service) {
-		struct vchiq_service_params params;
 		enum vchiq_status status;
 
-		memset(&params, 0, sizeof(params));
-		params.fourcc = setup->service_id;
-		params.callback = setup->callback;
-		params.userdata = setup->callback_param;
-		params.version = setup->version.version;
-		params.version_min = setup->version.version_min;
-
-		status = vchiq_open_service(instance, &params,
+		status = vchiq_open_service(instance, params,
 			&((*service)->handle));
 		if (status != VCHIQ_SUCCESS) {
 			service_free(*service);
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 2abf0f6664f9..4788bb645dc5 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1860,11 +1860,12 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	int status;
 	struct vchiq_mmal_instance *instance;
 	static struct vchiq_instance *vchiq_instance;
-	struct service_creation params = {
-		.version		= VCHI_VERSION_EX(VC_MMAL_VER, VC_MMAL_MIN_VER),
-		.service_id		= VC_MMAL_SERVER_NAME,
+	struct vchiq_service_params params = {
+		.version		= VC_MMAL_VER,
+		.version_min		= VC_MMAL_MIN_VER,
+		.fourcc			= VC_MMAL_SERVER_NAME,
 		.callback		= service_callback,
-		.callback_param		= NULL,
+		.userdata		= NULL,
 	};
 
 	/* compile time checks to ensure structure size as they are
@@ -1906,7 +1907,7 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	mutex_init(&instance->context_map_lock);
 	idr_init_base(&instance->context_map, 1);
 
-	params.callback_param = instance;
+	params.userdata = instance;
 
 	instance->bulk_wq = alloc_ordered_workqueue("mmal-vchiq",
 						    WQ_MEM_RECLAIM);
-- 
2.27.0

