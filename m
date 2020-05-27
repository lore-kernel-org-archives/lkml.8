Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA020C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91CDF208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgE0Lz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:55:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387907AbgE0Lyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1DA71AF38;
        Wed, 27 May 2020 11:54:56 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 41/50] staging: vchiq: Make vchiq_add_service() local
Date:   Wed, 27 May 2020 13:53:46 +0200
Message-Id: <20200527115400.31391-42-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is being exported although there is no use for it outside
of vchiq's core code. Keep it local then.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +--
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h  | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 4230f33ac38a..4d98d4d3ee8a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -277,7 +277,7 @@ enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
 }
 EXPORT_SYMBOL(vchiq_connect);
 
-enum vchiq_status vchiq_add_service(
+static enum vchiq_status vchiq_add_service(
 	struct vchiq_instance             *instance,
 	const struct vchiq_service_params *params,
 	unsigned int       *phandle)
@@ -314,7 +314,6 @@ enum vchiq_status vchiq_add_service(
 
 	return status;
 }
-EXPORT_SYMBOL(vchiq_add_service);
 
 enum vchiq_status vchiq_open_service(
 	struct vchiq_instance             *instance,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 407e7dc31108..b852980447dc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -94,9 +94,6 @@ struct vchiq_instance;
 extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
 extern enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance);
 extern enum vchiq_status vchiq_connect(struct vchiq_instance *instance);
-extern enum vchiq_status vchiq_add_service(struct vchiq_instance *instance,
-	const struct vchiq_service_params *params,
-	unsigned int *pservice);
 extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
 	const struct vchiq_service_params *params,
 	unsigned int *pservice);
-- 
2.26.2

