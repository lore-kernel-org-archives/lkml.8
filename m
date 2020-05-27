Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D0AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE66A207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgE0LzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:55:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:41600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387807AbgE0Lyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C13CEAC91;
        Wed, 27 May 2020 11:54:47 +0000 (UTC)
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
Subject: [RFC 33/50] staging: vchi: Use struct vchiq_service_params
Date:   Wed, 27 May 2020 13:53:38 +0200
Message-Id: <20200527115400.31391-34-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
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
 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c  | 11 ++++++-----
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 11 ++++++-----
 5 files changed, 20 insertions(+), 42 deletions(-)

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
index e6773cd51b44..e76399e083f6 100644
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
 	if (service) {
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
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
index 5088f72f57c9..a37607d07335 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
@@ -290,11 +290,12 @@ static enum vchiq_status vc_sm_cma_vchi_callback(enum vchiq_reason reason,
 struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
 					vpu_event_cb vpu_event)
 {
-	struct service_creation params = {
-		.version = VCHI_VERSION_EX(VC_SM_VER, VC_SM_MIN_VER),
-		.service_id = VC_SM_SERVER_NAME,
+	struct vchiq_service_params params = {
+		.version = VC_SM_VER,
+		.version_min = VC_SM_MIN_VER,
+		.fourcc = VC_SM_SERVER_NAME,
 		.callback = vc_sm_cma_vchi_callback,
-		.callback_param = NULL,
+		.userdata = NULL,
 	};
 	struct sm_instance *instance;
 	int status;
@@ -318,7 +319,7 @@ struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
 		init_completion(&instance->free_blk[i].cmplt);
 		list_add(&instance->free_blk[i].head, &instance->free_list);
 	}
-	params.callback_param = instance;
+	params.userdata = instance;
 
 	/* Open the VCHI service connections */
 	status = vchi_service_open(vchiq_instance, &params, &instance->service);
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 3207d0612515..a3ad8aa8b8cc 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -2094,11 +2094,12 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
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
@@ -2140,7 +2141,7 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	mutex_init(&instance->context_map_lock);
 	idr_init_base(&instance->context_map, 1);
 
-	params.callback_param = instance;
+	params.userdata = instance;
 
 	instance->bulk_wq = alloc_ordered_workqueue("mmal-vchiq",
 						    WQ_MEM_RECLAIM);
-- 
2.26.2

