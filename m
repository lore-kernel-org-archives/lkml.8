Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F70C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CA9207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgE0L5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:57:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgE0LyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A26A8ACF2;
        Wed, 27 May 2020 11:54:18 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 05/50] staging: vchi: Get rid of vchi_service_set_option()
Date:   Wed, 27 May 2020 13:53:10 +0200
Message-Id: <20200527115400.31391-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users for that function.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchi/vchi.h       |  5 ---
 .../interface/vchiq_arm/vchiq_shim.c          | 31 -------------------
 2 files changed, 36 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 62d9d3efa755..1e8d17531e9d 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -100,11 +100,6 @@ extern int32_t vchi_service_use(const struct vchi_service_handle *handle);
 // Routine to decrement ref count on a named service
 extern int32_t vchi_service_release(const struct vchi_service_handle *handle);
 
-// Routine to set a control option for a named service
-extern int32_t vchi_service_set_option(const struct vchi_service_handle *handle,
-				       enum vchi_service_option option,
-				       int value);
-
 /* Routine to send a message from kernel memory across a service */
 extern int
 vchi_queue_kernel_message(struct vchi_service_handle *handle,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 081ab67ad6fd..429b0c71e455 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -567,37 +567,6 @@ int32_t vchi_service_close(const struct vchi_service_handle *handle)
 }
 EXPORT_SYMBOL(vchi_service_close);
 
-int32_t vchi_service_set_option(const struct vchi_service_handle *handle,
-				enum vchi_service_option option,
-				int value)
-{
-	int32_t ret = -1;
-	struct shim_service *service = (struct shim_service *)handle;
-	enum vchiq_service_option vchiq_option;
-
-	switch (option) {
-	case VCHI_SERVICE_OPTION_TRACE:
-		vchiq_option = VCHIQ_SERVICE_OPTION_TRACE;
-		break;
-	case VCHI_SERVICE_OPTION_SYNCHRONOUS:
-		vchiq_option = VCHIQ_SERVICE_OPTION_SYNCHRONOUS;
-		break;
-	default:
-		service = NULL;
-		break;
-	}
-	if (service) {
-		enum vchiq_status status =
-			vchiq_set_service_option(service->handle,
-						vchiq_option,
-						value);
-
-		ret = vchiq_status_to_vchi(status);
-	}
-	return ret;
-}
-EXPORT_SYMBOL(vchi_service_set_option);
-
 int32_t vchi_get_peer_version(const struct vchi_service_handle *handle, short *peer_version)
 {
 	int32_t ret = -1;
-- 
2.26.2

