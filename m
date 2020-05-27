Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75F9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87881208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgE0Lye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:54:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:40894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgE0LyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77FDCAF16;
        Wed, 27 May 2020 11:54:22 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 10/50] staging: vchiq: Get rid of VCHIQ_SERVICE_OPENEND callback reason
Date:   Wed, 27 May 2020 13:53:15 +0200
Message-Id: <20200527115400.31391-11-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody uses it and it's routinely discarded in vchi.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c       | 9 ---------
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c       | 4 ----
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index ef31e541c902..ae9183db44ee 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1484,15 +1484,6 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 					: VCHIQ_SRVSTATE_OPEN);
 			}
 
-			service->remoteport = remoteport;
-			service->client_id = ((int *)header->data)[1];
-			if (make_service_callback(service, VCHIQ_SERVICE_OPENED,
-				NULL, NULL) == VCHIQ_RETRY) {
-				/* Bail out if not ready */
-				service->remoteport = VCHIQ_PORT_FREE;
-				goto bail_not_ready;
-			}
-
 			/* Success - the message has been dealt with */
 			unlock_service(service);
 			return 1;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 55f9e34ea50e..75d87b6992c4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -461,10 +461,6 @@ static enum vchiq_status shim_callback(enum vchiq_reason reason,
 				  VCHI_CALLBACK_SERVICE_CLOSED, NULL);
 		break;
 
-	case VCHIQ_SERVICE_OPENED:
-		/* No equivalent VCHI reason */
-		break;
-
 	case VCHIQ_BULK_TRANSMIT_ABORTED:
 		service->callback(service->callback_param,
 				  VCHI_CALLBACK_BULK_TRANSMIT_ABORTED,
-- 
2.26.2

