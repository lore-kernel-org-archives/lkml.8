Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896F9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689D6206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbgF2UhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:37:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732160AbgF2TV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF806B048;
        Mon, 29 Jun 2020 15:10:08 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 38/47] staging: vchiq: Make vchiq_add_service() local
Date:   Mon, 29 Jun 2020 17:09:36 +0200
Message-Id: <20200629150945.10720-39-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
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
index dddd5ea5d917..1a050ac116fa 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -271,7 +271,7 @@ enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
 }
 EXPORT_SYMBOL(vchiq_connect);
 
-enum vchiq_status vchiq_add_service(
+static enum vchiq_status vchiq_add_service(
 	struct vchiq_instance             *instance,
 	const struct vchiq_service_params *params,
 	unsigned int       *phandle)
@@ -308,7 +308,6 @@ enum vchiq_status vchiq_add_service(
 
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
2.27.0

