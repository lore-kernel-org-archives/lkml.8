Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793A9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA420672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbgF2Ugn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:36:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732164AbgF2TV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74E87AF69;
        Mon, 29 Jun 2020 15:09:57 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 11/47] staging: vchi: Get rid of struct vchi_instance_handle
Date:   Mon, 29 Jun 2020 17:09:09 +0200
Message-Id: <20200629150945.10720-12-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
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
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  8 ++---
 5 files changed, 30 insertions(+), 42 deletions(-)

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
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 7fb502f90a89..30f97c4bb9fc 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1864,7 +1864,7 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 {
 	int status;
 	struct vchiq_mmal_instance *instance;
-	static struct vchi_instance_handle *vchi_instance;
+	static struct vchiq_instance *vchiq_instance;
 	struct service_creation params = {
 		.version		= VCHI_VERSION_EX(VC_MMAL_VER, VC_MMAL_MIN_VER),
 		.service_id		= VC_MMAL_SERVER_NAME,
@@ -1886,14 +1886,14 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
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
@@ -1918,7 +1918,7 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	if (!instance->bulk_wq)
 		goto err_free;
 
-	status = vchi_service_open(vchi_instance, &params, &instance->handle);
+	status = vchi_service_open(vchiq_instance, &params, &instance->handle);
 	if (status) {
 		pr_err("Failed to open VCHI service connection (status=%d)\n",
 		       status);
-- 
2.27.0

