Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC59C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF2B20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgAaKjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:39:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:57248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbgAaKjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:39:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4430AFF6;
        Fri, 31 Jan 2020 10:39:17 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 17/21] staging: vc04_services: Get rid of the rest of suspend/resume state handling
Date:   Fri, 31 Jan 2020 11:38:33 +0100
Message-Id: <20200131103836.14312-18-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131103836.14312-1-nsaenzjulienne@suse.de>
References: <20200131103836.14312-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only remaining state doesn't provide any information anymore nor the
completion that depends on it, which is set to complete_all() before any
user may wait on it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 52 -------------------
 .../interface/vchiq_arm/vchiq_arm.h           | 11 ----
 2 files changed, 63 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index cee643a33642..e753ccffd588 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -48,10 +48,6 @@
 int vchiq_arm_log_level = VCHIQ_LOG_DEFAULT;
 int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
 
-#define VC_RESUME_NUM_OFFSET 1 /* number of values before idle which are -ve */
-static const char *const resume_state_names[] = {
-	"VC_RESUME_RESUMED"
-};
 /* The number of times we allow force suspend to timeout before actually
 ** _forcing_ suspend.  This is to cater for SW which fails to release vchiq
 ** correctly - we don't want to prevent ARM suspend indefinitely in this case.
@@ -2342,11 +2338,6 @@ vchiq_arm_init_state(struct vchiq_state *state,
 		atomic_set(&arm_state->ka_use_ack_count, 0);
 		atomic_set(&arm_state->ka_release_count, 0);
 
-		init_completion(&arm_state->vc_resume_complete);
-		/* Initialise to 'done' state.  We only want to block on resume
-		 * completion while videocore is suspended. */
-		set_resume_state(arm_state, VC_RESUME_RESUMED);
-
 		arm_state->state = state;
 		arm_state->first_connect = 0;
 
@@ -2354,24 +2345,6 @@ vchiq_arm_init_state(struct vchiq_state *state,
 	return VCHIQ_SUCCESS;
 }
 
-void
-set_resume_state(struct vchiq_arm_state *arm_state,
-		 enum vc_resume_status new_state)
-{
-	/* set the state in all cases */
-	arm_state->vc_resume_state = new_state;
-
-	/* state specific additional actions */
-	switch (new_state) {
-	case VC_RESUME_RESUMED:
-		complete_all(&arm_state->vc_resume_complete);
-		break;
-	default:
-		BUG();
-		break;
-	}
-}
-
 void
 vchiq_platform_check_suspend(struct vchiq_state *state)
 {
@@ -2427,22 +2400,6 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 
 	write_unlock_bh(&arm_state->susp_res_lock);
 
-	/* Completion is in a done state when we're not suspended, so this won't
-	 * block for the non-suspended case. */
-	if (!try_wait_for_completion(&arm_state->vc_resume_complete)) {
-		vchiq_log_info(vchiq_susp_log_level, "%s %s wait for resume",
-			__func__, entity);
-		if (wait_for_completion_killable(
-				&arm_state->vc_resume_complete)) {
-			vchiq_log_error(vchiq_susp_log_level, "%s %s wait for "
-				"resume interrupted", __func__, entity);
-			ret = VCHIQ_ERROR;
-			goto out;
-		}
-		vchiq_log_info(vchiq_susp_log_level, "%s %s resumed", __func__,
-			entity);
-	}
-
 	if (ret == VCHIQ_SUCCESS) {
 		enum vchiq_status status = VCHIQ_SUCCESS;
 		long ack_cnt = atomic_xchg(&arm_state->ka_use_ack_count, 0);
@@ -2634,7 +2591,6 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 	int only_nonzero = 0;
 	static const char *nz = "<-- preventing suspend";
 
-	enum vc_resume_status  vc_resume_state;
 	int peer_count;
 	int vc_use_count;
 	int active_services;
@@ -2648,7 +2604,6 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 		return;
 
 	read_lock_bh(&arm_state->susp_res_lock);
-	vc_resume_state  = arm_state->vc_resume_state;
 	peer_count = arm_state->peer_use_count;
 	vc_use_count = arm_state->videocore_use_count;
 	active_services = state->unused_service;
@@ -2677,13 +2632,6 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 
 	read_unlock_bh(&arm_state->susp_res_lock);
 
-	vchiq_log_warning(vchiq_susp_log_level,
-		"-- Videcore suspend state: %s --",
-		suspend_state_names[vc_suspend_state + VC_SUSPEND_NUM_OFFSET]);
-	vchiq_log_warning(vchiq_susp_log_level,
-		"-- Videcore resume state: %s --",
-		resume_state_names[vc_resume_state + VC_RESUME_NUM_OFFSET]);
-
 	if (only_nonzero)
 		vchiq_log_warning(vchiq_susp_log_level, "Too many active "
 			"services (%d).  Only dumping up to first %d services "
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index b1fad282db04..54c8796d5004 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -14,10 +14,6 @@
 #include "vchiq_core.h"
 #include "vchiq_debugfs.h"
 
-enum vc_resume_status {
-	VC_RESUME_RESUMED      /* Videocore resumed successfully (active) */
-};
-
 enum USE_TYPE_E {
 	USE_TYPE_SERVICE,
 	USE_TYPE_SERVICE_NO_RESUME,
@@ -32,10 +28,7 @@ struct vchiq_arm_state {
 	atomic_t ka_use_ack_count;
 	atomic_t ka_release_count;
 
-	struct completion vc_resume_complete;
-
 	rwlock_t susp_res_lock;
-	enum vc_resume_status vc_resume_state;
 
 	struct vchiq_state *state;
 
@@ -122,8 +115,4 @@ vchiq_instance_get_trace(struct vchiq_instance *instance);
 extern void
 vchiq_instance_set_trace(struct vchiq_instance *instance, int trace);
 
-extern void
-set_resume_state(struct vchiq_arm_state *arm_state,
-		 enum vc_resume_status new_state);
-
 #endif /* VCHIQ_ARM_H */
-- 
2.25.0

