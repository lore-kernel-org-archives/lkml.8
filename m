Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21238C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94C6207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgE0L5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:57:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:40894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbgE0LyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A8046AC5B;
        Wed, 27 May 2020 11:54:25 +0000 (UTC)
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
Subject: [RFC 13/50] staging: vchi: Get rid of struct vchi_instance_handle
Date:   Wed, 27 May 2020 13:53:18 +0200
Message-Id: <20200527115400.31391-14-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea behind this was to create an opaque handle to struct
vchiq_instance. This can be achieved without creating a new type by
means of a forward declaration of struct vchiq_instance.

This saves us from a lot of useless casting and overall simplifies code.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bcm2835-audio/bcm2835-vchiq.c             | 20 ++++++-------
 .../vc04_services/bcm2835-audio/bcm2835.h     |  2 +-
 .../vc04_services/interface/vchi/vchi.h       | 12 ++++----
 .../interface/vchiq_arm/vchiq_shim.c          | 30 ++++++-------------
 .../staging/vc04_services/vc-sm-cma/vc_sm.c   |  8 ++---
 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c  |  4 +--
 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.h  |  2 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  8 ++---
 8 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 73144f1ce45e..8c9390153a26 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -122,7 +122,7 @@ static void audio_vchi_callback(void *param,
 }
 
 static int
-vc_vchi_audio_init(struct vchi_instance_handle *vchi_instance,
+vc_vchi_audio_init(struct vchiq_instance *vchiq_instance,
 		   struct bcm2835_audio_instance *instance)
 {
 	struct service_creation params = {
@@ -134,7 +134,7 @@ vc_vchi_audio_init(struct vchi_instance_handle *vchi_instance,
 	int status;
 
 	/* Open the VCHI service connections */
-	status = vchi_service_open(vchi_instance, &params,
+	status = vchi_service_open(vchiq_instance, &params,
 				   &instance->vchi_handle);
 
 	if (status) {
@@ -173,20 +173,20 @@ int bcm2835_new_vchi_ctx(struct device *dev, struct bcm2835_vchi_ctx *vchi_ctx)
 	int ret;
 
 	/* Initialize and create a VCHI connection */
-	ret = vchi_initialise(&vchi_ctx->vchi_instance);
+	ret = vchi_initialise(&vchi_ctx->instance);
 	if (ret) {
 		dev_err(dev, "failed to initialise VCHI instance (ret=%d)\n",
 			ret);
 		return -EIO;
 	}
 
-	ret = vchi_connect(vchi_ctx->vchi_instance);
+	ret = vchi_connect(vchi_ctx->instance);
 	if (ret) {
 		dev_dbg(dev, "failed to connect VCHI instance (ret=%d)\n",
 			ret);
 
-		kfree(vchi_ctx->vchi_instance);
-		vchi_ctx->vchi_instance = NULL;
+		kfree(vchi_ctx->instance);
+		vchi_ctx->instance = NULL;
 
 		return -EIO;
 	}
@@ -196,10 +196,10 @@ int bcm2835_new_vchi_ctx(struct device *dev, struct bcm2835_vchi_ctx *vchi_ctx)
 
 void bcm2835_free_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx)
 {
-	/* Close the VCHI connection - it will also free vchi_instance */
-	WARN_ON(vchi_disconnect(vchi_ctx->vchi_instance));
+	/* Close the VCHI connection - it will also free vchi_ctx->instance */
+	WARN_ON(vchi_disconnect(vchi_ctx->instance));
 
-	vchi_ctx->vchi_instance = NULL;
+	vchi_ctx->instance = NULL;
 }
 
 int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
@@ -217,7 +217,7 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
 	instance->alsa_stream = alsa_stream;
 	alsa_stream->instance = instance;
 
-	err = vc_vchi_audio_init(vchi_ctx->vchi_instance,
+	err = vc_vchi_audio_init(vchi_ctx->instance,
 				 instance);
 	if (err < 0)
 		goto free_instance;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index d2fe8d36ab7d..2a94e825194f 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -44,7 +44,7 @@ enum snd_bcm2835_ctrl {
 };
 
 struct bcm2835_vchi_ctx {
-	struct vchi_instance_handle *vchi_instance;
+	struct vchiq_instance *instance;
 };
 
 /* definition of the chip-specific record */
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 1daef5ad70f1..6b73d8fb394a 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -49,8 +49,8 @@ struct service_creation {
 	void *callback_param;
 };
 
-// Opaque handle for a VCHI instance
-struct vchi_instance_handle;
+// Opaque handle for a VCHIQ instance
+struct vchiq_instance;
 
 // Opaque handle for a server or client
 struct vchi_service_handle;
@@ -61,19 +61,19 @@ struct vchi_service_handle;
  *****************************************************************************/
 
 // Routine used to initialise the vchi on both local + remote connections
-extern int32_t vchi_initialise(struct vchi_instance_handle **instance_handle);
+extern int32_t vchi_initialise(struct vchiq_instance **instance);
 
-extern int32_t vchi_connect(struct vchi_instance_handle *instance_handle);
+extern int32_t vchi_connect(struct vchiq_instance *instance);
 
 //When this is called, ensure that all services have no data pending.
 //Bulk transfers can remain 'queued'
-extern int32_t vchi_disconnect(struct vchi_instance_handle *instance_handle);
+extern int32_t vchi_disconnect(struct vchiq_instance *instance);
 
 /******************************************************************************
  * Global service API
  *****************************************************************************/
 // Routine to open a named service
-extern int32_t vchi_service_open(struct vchi_instance_handle *instance_handle,
+extern int32_t vchi_service_open(struct vchiq_instance *instance,
 				 struct service_creation *setup,
 				 struct vchi_service_handle **handle);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 54c2492b7c83..8758704d61c9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -287,7 +287,7 @@ EXPORT_SYMBOL(vchi_msg_hold);
 /***********************************************************
  * Name: vchi_initialise
  *
- * Arguments: struct vchi_instance_handle **instance_handle
+ * Arguments: struct vchiq_instance **instance
  *
  * Description: Initialises the hardware but does not transmit anything
  *              When run as a Host App this will be called twice hence the need
@@ -297,23 +297,16 @@ EXPORT_SYMBOL(vchi_msg_hold);
  *
  ***********************************************************/
 
-int32_t vchi_initialise(struct vchi_instance_handle **instance_handle)
+int32_t vchi_initialise(struct vchiq_instance **instance)
 {
-	struct vchiq_instance *instance;
-	enum vchiq_status status;
-
-	status = vchiq_initialise(&instance);
-
-	*instance_handle = (struct vchi_instance_handle *)instance;
-
-	return status;
+	return vchiq_initialise(instance);
 }
 EXPORT_SYMBOL(vchi_initialise);
 
 /***********************************************************
  * Name: vchi_connect
  *
- * Arguments: struct vchi_instance_handle *instance_handle
+ * Arguments: struct vchiq_instance *instance
  *
  * Description: Starts the command service on each connection,
  *              causing INIT messages to be pinged back and forth
@@ -321,10 +314,8 @@ EXPORT_SYMBOL(vchi_initialise);
  * Returns: 0 if successful, failure otherwise
  *
  ***********************************************************/
-int32_t vchi_connect(struct vchi_instance_handle *instance_handle)
+int32_t vchi_connect(struct vchiq_instance *instance)
 {
-	struct vchiq_instance *instance = (struct vchiq_instance *)instance_handle;
-
 	return vchiq_connect(instance);
 }
 EXPORT_SYMBOL(vchi_connect);
@@ -332,7 +323,7 @@ EXPORT_SYMBOL(vchi_connect);
 /***********************************************************
  * Name: vchi_disconnect
  *
- * Arguments: struct vchi_instance_handle *instance_handle
+ * Arguments: struct vchiq_instance *instance
  *
  * Description: Stops the command service on each connection,
  *              causing DE-INIT messages to be pinged back and forth
@@ -340,10 +331,8 @@ EXPORT_SYMBOL(vchi_connect);
  * Returns: 0 if successful, failure otherwise
  *
  ***********************************************************/
-int32_t vchi_disconnect(struct vchi_instance_handle *instance_handle)
+int32_t vchi_disconnect(struct vchiq_instance *instance)
 {
-	struct vchiq_instance *instance = (struct vchiq_instance *)instance_handle;
-
 	return vchiq_shutdown(instance);
 }
 EXPORT_SYMBOL(vchi_disconnect);
@@ -352,7 +341,7 @@ EXPORT_SYMBOL(vchi_disconnect);
  * Name: vchi_service_open
  * Name: vchi_service_create
  *
- * Arguments: struct vchi_instance_handle *instance_handle
+ * Arguments: struct vchiq_instance *instance
  *            struct service_creation *setup,
  *            struct vchi_service_handle **handle
  *
@@ -446,11 +435,10 @@ static void service_free(struct shim_service *service)
 	}
 }
 
-int32_t vchi_service_open(struct vchi_instance_handle *instance_handle,
+int32_t vchi_service_open(struct vchiq_instance *instance,
 	struct service_creation *setup,
 	struct vchi_service_handle **handle)
 {
-	struct vchiq_instance *instance = (struct vchiq_instance *)instance_handle;
 	struct shim_service *service = service_alloc(instance, setup);
 
 	*handle = (struct vchi_service_handle *)service;
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
index cd5fb561debb..3f95ea90c08a 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
@@ -1505,7 +1505,7 @@ static const struct file_operations vc_sm_ops = {
 static void vc_sm_connected_init(void)
 {
 	int ret;
-	struct vchi_instance_handle *vchi_instance;
+	struct vchiq_instance *instance;
 	struct vc_sm_version version;
 	struct vc_sm_result_t version_result;
 
@@ -1515,7 +1515,7 @@ static void vc_sm_connected_init(void)
 	 * Initialize and create a VCHI connection for the shared memory service
 	 * running on videocore.
 	 */
-	ret = vchi_initialise(&vchi_instance);
+	ret = vchi_initialise(&instance);
 	if (ret) {
 		pr_err("[%s]: failed to initialise VCHI instance (ret=%d)\n",
 		       __func__, ret);
@@ -1523,7 +1523,7 @@ static void vc_sm_connected_init(void)
 		return;
 	}
 
-	ret = vchi_connect(vchi_instance);
+	ret = vchi_connect(instance);
 	if (ret) {
 		pr_err("[%s]: failed to connect VCHI instance (ret=%d)\n",
 		       __func__, ret);
@@ -1532,7 +1532,7 @@ static void vc_sm_connected_init(void)
 	}
 
 	/* Initialize an instance of the shared memory service. */
-	sm_state->sm_handle = vc_sm_cma_vchi_init(vchi_instance, 1,
+	sm_state->sm_handle = vc_sm_cma_vchi_init(instance, 1,
 						  vc_sm_vpu_event);
 	if (!sm_state->sm_handle) {
 		pr_err("[%s]: failed to initialize shared memory service\n",
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
index cd3f62844616..b142fadb2bb5 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
@@ -285,7 +285,7 @@ static void vc_sm_cma_vchi_callback(void *param,
 	}
 }
 
-struct sm_instance *vc_sm_cma_vchi_init(struct vchi_instance_handle *vchi_instance,
+struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
 					unsigned int num_connections,
 					vpu_event_cb vpu_event)
 {
@@ -328,7 +328,7 @@ struct sm_instance *vc_sm_cma_vchi_init(struct vchi_instance_handle *vchi_instan
 			.callback_param = instance,
 		};
 
-		status = vchi_service_open(vchi_instance,
+		status = vchi_service_open(vchiq_instance,
 					   &params, &instance->vchi_handle[i]);
 		if (status) {
 			pr_err("%s: failed to open VCHI service (%d)",
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
index e8db34bd1e91..44cc389364f4 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
@@ -28,7 +28,7 @@ typedef void (*vpu_event_cb)(struct sm_instance *instance,
 /*
  * Initialize the shared memory service, opens up vchi connection to talk to it.
  */
-struct sm_instance *vc_sm_cma_vchi_init(struct vchi_instance_handle *vchi_instance,
+struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
 					unsigned int num_connections,
 					vpu_event_cb vpu_event);
 
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 4c89bc0bec15..3504ea8aed4f 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -2098,7 +2098,7 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 {
 	int status;
 	struct vchiq_mmal_instance *instance;
-	static struct vchi_instance_handle *vchi_instance;
+	static struct vchiq_instance *vchiq_instance;
 	struct service_creation params = {
 		.version		= VCHI_VERSION_EX(VC_MMAL_VER, VC_MMAL_MIN_VER),
 		.service_id		= VC_MMAL_SERVER_NAME,
@@ -2120,14 +2120,14 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	BUILD_BUG_ON(sizeof(struct mmal_port) != 64);
 
 	/* create a vchi instance */
-	status = vchi_initialise(&vchi_instance);
+	status = vchi_initialise(&vchiq_instance);
 	if (status) {
 		pr_err("Failed to initialise VCHI instance (status=%d)\n",
 		       status);
 		return -EIO;
 	}
 
-	status = vchi_connect(vchi_instance);
+	status = vchi_connect(vchiq_instance);
 	if (status) {
 		pr_err("Failed to connect VCHI instance (status=%d)\n", status);
 		return -EIO;
@@ -2152,7 +2152,7 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	if (!instance->bulk_wq)
 		goto err_free;
 
-	status = vchi_service_open(vchi_instance, &params, &instance->handle);
+	status = vchi_service_open(vchiq_instance, &params, &instance->handle);
 	if (status) {
 		pr_err("Failed to open VCHI service connection (status=%d)\n",
 		       status);
-- 
2.26.2

