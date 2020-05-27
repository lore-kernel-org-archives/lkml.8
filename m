Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFE9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD20207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgE0L53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:57:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgE0Lyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 58AD0AC5B;
        Wed, 27 May 2020 11:54:31 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 18/50] staging: vc04_services: vc-sm-cma: Get rid of the multiple connections option
Date:   Wed, 27 May 2020 13:53:23 +0200
Message-Id: <20200527115400.31391-19-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple connections are not handled by the IO thread, so it's not
really necessary to handle them on initialization.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/vc-sm-cma/vc_sm.c   |  3 +-
 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c  | 67 ++++++-------------
 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.h  |  1 -
 3 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
index 3f95ea90c08a..e660f546a7e4 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
@@ -1532,8 +1532,7 @@ static void vc_sm_connected_init(void)
 	}
 
 	/* Initialize an instance of the shared memory service. */
-	sm_state->sm_handle = vc_sm_cma_vchi_init(instance, 1,
-						  vc_sm_vpu_event);
+	sm_state->sm_handle = vc_sm_cma_vchi_init(instance, vc_sm_vpu_event);
 	if (!sm_state->sm_handle) {
 		pr_err("[%s]: failed to initialize shared memory service\n",
 		       __func__);
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
index 32706eb2838b..72b09685db31 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
@@ -46,8 +46,7 @@ struct sm_cmd_rsp_blk {
 };
 
 struct sm_instance {
-	u32 num_connections;
-	struct vchi_service *service[VCHI_MAX_NUM_CONNECTIONS];
+	struct vchi_service *service;
 	struct task_struct *io_thread;
 	struct completion io_cmplt;
 
@@ -187,13 +186,13 @@ static int vc_sm_cma_vchi_videocore_io(void *arg)
 
 	while (1) {
 		if (svc_use)
-			vchi_service_release(instance->service[0]);
+			vchi_service_release(instance->service);
 		svc_use = 0;
 
 		if (wait_for_completion_interruptible(&instance->io_cmplt))
 			continue;
 
-		vchi_service_use(instance->service[0]);
+		vchi_service_use(instance->service);
 		svc_use = 1;
 
 		do {
@@ -214,7 +213,7 @@ static int vc_sm_cma_vchi_videocore_io(void *arg)
 
 			/* Send the command */
 			status =
-				bcm2835_vchi_msg_queue(instance->service[0],
+				bcm2835_vchi_msg_queue(instance->service,
 						       cmd->msg, cmd->length);
 			if (status) {
 				pr_err("%s: failed to queue message (%d)",
@@ -237,7 +236,7 @@ static int vc_sm_cma_vchi_videocore_io(void *arg)
 
 		} while (1);
 
-		while (!vchi_msg_hold(instance->service[0], (void **)&reply,
+		while (!vchi_msg_hold(instance->service, (void **)&reply,
 				       &reply_len, VCHI_FLAGS_NONE, &msg)) {
 			if (reply->trans_id & 0x80000000) {
 				/* Async event or cmd from the VPU */
@@ -286,21 +285,20 @@ static void vc_sm_cma_vchi_callback(void *param,
 }
 
 struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
-					unsigned int num_connections,
 					vpu_event_cb vpu_event)
 {
-	u32 i;
+	struct service_creation params = {
+		.version = VCHI_VERSION_EX(VC_SM_VER, VC_SM_MIN_VER),
+		.service_id = VC_SM_SERVER_NAME,
+		.callback = vc_sm_cma_vchi_callback,
+		.callback_param = NULL,
+	};
 	struct sm_instance *instance;
 	int status;
+	int i;
 
 	pr_debug("%s: start", __func__);
 
-	if (num_connections > VCHI_MAX_NUM_CONNECTIONS) {
-		pr_err("%s: unsupported number of connections %u (max=%u)",
-		       __func__, num_connections, VCHI_MAX_NUM_CONNECTIONS);
-
-		goto err_null;
-	}
 	/* Allocate memory for this instance */
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
 
@@ -317,25 +315,15 @@ struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
 		init_completion(&instance->free_blk[i].cmplt);
 		list_add(&instance->free_blk[i].head, &instance->free_list);
 	}
+	params.callback_param = instance;
 
 	/* Open the VCHI service connections */
-	instance->num_connections = num_connections;
-	for (i = 0; i < num_connections; i++) {
-		struct service_creation params = {
-			.version = VCHI_VERSION_EX(VC_SM_VER, VC_SM_MIN_VER),
-			.service_id = VC_SM_SERVER_NAME,
-			.callback = vc_sm_cma_vchi_callback,
-			.callback_param = instance,
-		};
-
-		status = vchi_service_open(vchiq_instance,
-					   &params, &instance->service[i]);
-		if (status) {
-			pr_err("%s: failed to open VCHI service (%d)",
-			       __func__, status);
-
-			goto err_close_services;
-		}
+	status = vchi_service_open(vchiq_instance, &params, &instance->service);
+	if (status) {
+		pr_err("%s: failed to open VCHI service (%d)",
+		       __func__, status);
+
+		goto err_close_services;
 	}
 
 	/* Create the thread which takes care of all io to/from videoocore. */
@@ -354,12 +342,8 @@ struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
 	return instance;
 
 err_close_services:
-	for (i = 0; i < instance->num_connections; i++) {
-		if (instance->service[i])
-			vchi_service_close(instance->service[i]);
-	}
+	vchi_service_close(instance->service);
 	kfree(instance);
-err_null:
 	pr_debug("%s: FAILED", __func__);
 	return NULL;
 }
@@ -367,7 +351,6 @@ struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
 int vc_sm_cma_vchi_stop(struct sm_instance **handle)
 {
 	struct sm_instance *instance;
-	u32 i;
 
 	if (!handle) {
 		pr_err("%s: invalid pointer to handle %p", __func__, handle);
@@ -381,14 +364,8 @@ int vc_sm_cma_vchi_stop(struct sm_instance **handle)
 
 	instance = *handle;
 
-	/* Close all VCHI service connections */
-	for (i = 0; i < instance->num_connections; i++) {
-		s32 success;
-
-		vchi_service_use(instance->service[i]);
-
-		success = vchi_service_close(instance->service[i]);
-	}
+	vchi_service_use(instance->service);
+	vchi_service_close(instance->service);
 
 	kfree(instance);
 
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
index 44cc389364f4..09ef0fc59566 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
@@ -29,7 +29,6 @@ typedef void (*vpu_event_cb)(struct sm_instance *instance,
  * Initialize the shared memory service, opens up vchi connection to talk to it.
  */
 struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
-					unsigned int num_connections,
 					vpu_event_cb vpu_event);
 
 /*
-- 
2.26.2

