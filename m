Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7FEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF98D2070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbgFWQpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:45:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733083AbgFWQpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9213B13E;
        Tue, 23 Jun 2020 16:45:21 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 25/50] staging: vchiq: Introduce vchiq_validate_params()
Date:   Tue, 23 Jun 2020 18:42:11 +0200
Message-Id: <20200623164235.29566-26-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a new service validate the configuration parameters
provided, and remove unnecessary checks in vchi, now that we have
validated service's config.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_core.c              | 15 +++++++++++++++
 .../interface/vchiq_arm/vchiq_shim.c              |  4 ----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index ae9183db44ee..46b09b7154f8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2265,6 +2265,16 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	return VCHIQ_ERROR;
 }
 
+static int vchiq_validate_params(const struct vchiq_service_params *params)
+{
+	if (!params->callback || !params->fourcc) {
+		vchiq_loud_error("Can't add service, invalid params\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Called from application thread when a client or server service is created. */
 struct vchiq_service *
 vchiq_add_service_internal(struct vchiq_state *state,
@@ -2275,8 +2285,13 @@ vchiq_add_service_internal(struct vchiq_state *state,
 	struct vchiq_service *service;
 	struct vchiq_service __rcu **pservice = NULL;
 	struct vchiq_service_quota *service_quota;
+	int ret;
 	int i;
 
+	ret = vchiq_validate_params(params);
+	if (ret)
+		return NULL;
+
 	service = kmalloc(sizeof(*service), GFP_KERNEL);
 	if (!service)
 		return service;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index e09c595d6f9d..dcf8776834b1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -271,15 +271,11 @@ static enum vchiq_status shim_callback(enum vchiq_reason reason,
 	struct vchi_service *service =
 		(struct vchi_service *)VCHIQ_GET_SERVICE_USERDATA(handle);
 
-	if (!service->callback)
-		goto release;
-
 	if (reason == VCHIQ_MESSAGE_AVAILABLE)
 		vchiu_queue_push(&service->queue, header);
 
 	service->callback(service->callback_param, reason, bulk_user);
 
-release:
 	return VCHIQ_SUCCESS;
 }
 
-- 
2.27.0

