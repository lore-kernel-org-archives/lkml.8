Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E21C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BE8214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbgAXOq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:46:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:43706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389457AbgAXOqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:46:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F856AF0D;
        Fri, 24 Jan 2020 14:46:45 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH 19/22] staging: vc04_services: Get rid of vc_suspend_state in struct vchiq_arm_state
Date:   Fri, 24 Jan 2020 15:46:13 +0100
Message-Id: <20200124144617.2213-20-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124144617.2213-1-nsaenzjulienne@suse.de>
References: <20200124144617.2213-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's never used.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c     | 11 ++---------
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h     |  1 -
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 577ecfefce3c..049512589375 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2619,7 +2619,6 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 	int only_nonzero = 0;
 	static const char *nz = "<-- preventing suspend";
 
-	enum vc_suspend_status vc_suspend_state;
 	enum vc_resume_status  vc_resume_state;
 	int peer_count;
 	int vc_use_count;
@@ -2634,7 +2633,6 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 		return;
 
 	read_lock_bh(&arm_state->susp_res_lock);
-	vc_suspend_state = arm_state->vc_suspend_state;
 	vc_resume_state  = arm_state->vc_resume_state;
 	peer_count = arm_state->peer_use_count;
 	vc_use_count = arm_state->videocore_use_count;
@@ -2664,9 +2662,6 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 
 	read_unlock_bh(&arm_state->susp_res_lock);
 
-	vchiq_log_warning(vchiq_susp_log_level,
-		"-- Videcore suspend state: %s --",
-		suspend_state_names[vc_suspend_state + VC_SUSPEND_NUM_OFFSET]);
 	vchiq_log_warning(vchiq_susp_log_level,
 		"-- Videcore resume state: %s --",
 		resume_state_names[vc_resume_state + VC_RESUME_NUM_OFFSET]);
@@ -2713,12 +2708,10 @@ vchiq_check_service(struct vchiq_service *service)
 	if (ret == VCHIQ_ERROR) {
 		vchiq_log_error(vchiq_susp_log_level,
 			"%s ERROR - %c%c%c%c:%d service count %d, "
-			"state count %d, videocore suspend state %s", __func__,
+			"state count %d", __func__,
 			VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
 			service->client_id, service->service_use_count,
-			arm_state->videocore_use_count,
-			suspend_state_names[arm_state->vc_suspend_state +
-						VC_SUSPEND_NUM_OFFSET]);
+			arm_state->videocore_use_count);
 	}
 out:
 	return ret;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index e2f7fa865694..780c352a5d64 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -34,7 +34,6 @@ struct vchiq_arm_state {
 	struct completion vc_resume_complete;
 
 	rwlock_t susp_res_lock;
-	enum vc_suspend_status vc_suspend_state;
 	enum vc_resume_status vc_resume_state;
 
 	struct vchiq_state *state;
-- 
2.25.0

