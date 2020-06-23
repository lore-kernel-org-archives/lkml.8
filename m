Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95DFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A83E2070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgFWQpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:38726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732483AbgFWQpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B8EDAECE;
        Tue, 23 Jun 2020 16:45:08 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 02/50] staging: mmal-vchiq: Allocate and free components as required
Date:   Tue, 23 Jun 2020 18:41:48 +0200
Message-Id: <20200623164235.29566-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

The existing code assumed that there would only ever be 4 components,
and never freed the entries once used.
Allow arbitrary creation and destruction of components.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 29 ++++++++++++-------
 .../vc04_services/vchiq-mmal/mmal-vchiq.h     |  1 +
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index daf21087f8f9..cbe262b111fe 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -32,8 +32,11 @@
 #define USE_VCHIQ_ARM
 #include "interface/vchi/vchi.h"
 
-/* maximum number of components supported */
-#define VCHIQ_MMAL_MAX_COMPONENTS 4
+/*
+ * maximum number of components supported.
+ * This matches the maximum permitted by default on the VPU
+ */
+#define VCHIQ_MMAL_MAX_COMPONENTS 64
 
 /*#define FULL_MSG_DUMP 1*/
 
@@ -168,8 +171,6 @@ struct vchiq_mmal_instance {
 	/* protect accesses to context_map */
 	struct mutex context_map_lock;
 
-	/* component to use next */
-	int component_idx;
 	struct vchiq_mmal_component component[VCHIQ_MMAL_MAX_COMPONENTS];
 
 	/* ordered workqueue to process all bulk operations */
@@ -1626,18 +1627,24 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 {
 	int ret;
 	int idx;		/* port index */
-	struct vchiq_mmal_component *component;
+	struct vchiq_mmal_component *component = NULL;
 
 	if (mutex_lock_interruptible(&instance->vchiq_mutex))
 		return -EINTR;
 
-	if (instance->component_idx == VCHIQ_MMAL_MAX_COMPONENTS) {
+	for (idx = 0; idx < VCHIQ_MMAL_MAX_COMPONENTS; idx++) {
+		if (!instance->component[idx].in_use) {
+			component = &instance->component[idx];
+			component->in_use = 1;
+			break;
+		}
+	}
+
+	if (!component) {
 		ret = -EINVAL;	/* todo is this correct error? */
 		goto unlock;
 	}
 
-	component = &instance->component[instance->component_idx];
-
 	ret = create_component(instance, component, name);
 	if (ret < 0) {
 		pr_err("%s: failed to create component %d (Not enough GPU mem?)\n",
@@ -1688,8 +1695,6 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 			goto release_component;
 	}
 
-	instance->component_idx++;
-
 	*component_out = component;
 
 	mutex_unlock(&instance->vchiq_mutex);
@@ -1699,6 +1704,8 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 release_component:
 	destroy_component(instance, component);
 unlock:
+	if (component)
+		component->in_use = 0;
 	mutex_unlock(&instance->vchiq_mutex);
 
 	return ret;
@@ -1721,6 +1728,8 @@ int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance,
 
 	ret = destroy_component(instance, component);
 
+	component->in_use = 0;
+
 	mutex_unlock(&instance->vchiq_mutex);
 
 	return ret;
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index 47897e81ec58..4e34728d87e5 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -82,6 +82,7 @@ struct vchiq_mmal_port {
 };
 
 struct vchiq_mmal_component {
+	u32 in_use:1;
 	u32 enabled:1;
 	u32 handle;  /* VideoCore handle for component */
 	u32 inputs;  /* Number of input ports */
-- 
2.27.0

