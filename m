Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550CCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAAD207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgE0Lyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:54:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:40866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728930AbgE0LyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6073FAD17;
        Wed, 27 May 2020 11:54:19 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 06/50] staging: vchi: Get rid of vchiq_status_to_vchi()
Date:   Wed, 27 May 2020 13:53:11 +0200
Message-Id: <20200527115400.31391-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchiq functions return an enum and vchi's ints. Those are compatible, no
need to explicitly cast them.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_shim.c          | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 429b0c71e455..0fc5fa05c6c2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -9,8 +9,6 @@
 
 #include "vchiq_util.h"
 
-#define vchiq_status_to_vchi(status) ((int32_t)status)
-
 struct shim_service {
 	unsigned int handle;
 
@@ -105,7 +103,7 @@ int vchi_queue_kernel_message(struct vchi_service_handle *handle, void *data,
 		msleep(1);
 	}
 
-	return vchiq_status_to_vchi(status);
+	return status;
 }
 EXPORT_SYMBOL(vchi_queue_kernel_message);
 
@@ -146,7 +144,7 @@ int32_t vchi_bulk_queue_receive(struct vchi_service_handle *handle, void *data_d
 		break;
 	default:
 		WARN(1, "unsupported message\n");
-		return vchiq_status_to_vchi(VCHIQ_ERROR);
+		return VCHIQ_ERROR;
 	}
 
 	while (1) {
@@ -163,7 +161,7 @@ int32_t vchi_bulk_queue_receive(struct vchi_service_handle *handle, void *data_d
 		msleep(1);
 	}
 
-	return vchiq_status_to_vchi(status);
+	return status;
 }
 EXPORT_SYMBOL(vchi_bulk_queue_receive);
 
@@ -207,7 +205,7 @@ int32_t vchi_bulk_queue_transmit(struct vchi_service_handle *handle,
 		break;
 	default:
 		WARN(1, "unsupported message\n");
-		return vchiq_status_to_vchi(VCHIQ_ERROR);
+		return VCHIQ_ERROR;
 	}
 
 	while (1) {
@@ -225,7 +223,7 @@ int32_t vchi_bulk_queue_transmit(struct vchi_service_handle *handle,
 		msleep(1);
 	}
 
-	return vchiq_status_to_vchi(status);
+	return status;
 }
 EXPORT_SYMBOL(vchi_bulk_queue_transmit);
 
@@ -372,7 +370,7 @@ int32_t vchi_initialise(struct vchi_instance_handle **instance_handle)
 
 	*instance_handle = (struct vchi_instance_handle *)instance;
 
-	return vchiq_status_to_vchi(status);
+	return status;
 }
 EXPORT_SYMBOL(vchi_initialise);
 
@@ -410,7 +408,7 @@ int32_t vchi_disconnect(struct vchi_instance_handle *instance_handle)
 {
 	struct vchiq_instance *instance = (struct vchiq_instance *)instance_handle;
 
-	return vchiq_status_to_vchi(vchiq_shutdown(instance));
+	return vchiq_shutdown(instance);
 }
 EXPORT_SYMBOL(vchi_disconnect);
 
@@ -561,7 +559,7 @@ int32_t vchi_service_close(const struct vchi_service_handle *handle)
 		if (status == VCHIQ_SUCCESS)
 			service_free(service);
 
-		ret = vchiq_status_to_vchi(status);
+		ret = status;
 	}
 	return ret;
 }
@@ -576,7 +574,7 @@ int32_t vchi_get_peer_version(const struct vchi_service_handle *handle, short *p
 		enum vchiq_status status;
 
 		status = vchiq_get_peer_version(service->handle, peer_version);
-		ret = vchiq_status_to_vchi(status);
+		ret = status;
 	}
 	return ret;
 }
@@ -598,7 +596,7 @@ int32_t vchi_service_use(const struct vchi_service_handle *handle)
 
 	struct shim_service *service = (struct shim_service *)handle;
 	if (service)
-		ret = vchiq_status_to_vchi(vchiq_use_service(service->handle));
+		ret = vchiq_use_service(service->handle);
 	return ret;
 }
 EXPORT_SYMBOL(vchi_service_use);
@@ -619,8 +617,7 @@ int32_t vchi_service_release(const struct vchi_service_handle *handle)
 
 	struct shim_service *service = (struct shim_service *)handle;
 	if (service)
-		ret = vchiq_status_to_vchi(
-			vchiq_release_service(service->handle));
+		ret = vchiq_release_service(service->handle);
 	return ret;
 }
 EXPORT_SYMBOL(vchi_service_release);
-- 
2.26.2

