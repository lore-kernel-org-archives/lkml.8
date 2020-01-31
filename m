Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A668C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB482467B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgAaKjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:39:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:57048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgAaKjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:39:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2A9EB001;
        Fri, 31 Jan 2020 10:39:05 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 02/21] staging: vc04_services: Get rid of resume_blocked in struct vchiq_arm_state
Date:   Fri, 31 Jan 2020 11:38:18 +0100
Message-Id: <20200131103836.14312-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131103836.14312-1-nsaenzjulienne@suse.de>
References: <20200131103836.14312-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boolean value is never set to true, hence remove it and all the code that
depends on it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 51 +------------------
 .../interface/vchiq_arm/vchiq_arm.h           |  1 -
 2 files changed, 2 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 4458c1e60fa3..af4dc23f5510 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2270,10 +2270,7 @@ vchiq_videocore_wanted(struct vchiq_state *state)
 		return 1;
 	else if (!arm_state->videocore_use_count)
 		/* usage count zero - check for override unless we're forcing */
-		if (arm_state->resume_blocked)
-			return 0;
-		else
-			return vchiq_platform_videocore_wanted(state);
+		return vchiq_platform_videocore_wanted(state);
 	else
 		/* non-zero usage count - videocore still required */
 		return 1;
@@ -2567,7 +2564,6 @@ static inline void
 unblock_resume(struct vchiq_arm_state *arm_state)
 {
 	complete_all(&arm_state->resume_blocker);
-	arm_state->resume_blocked = 0;
 }
 
 /* Initiate suspend via slot handler. Should be called with the write lock
@@ -2724,46 +2720,6 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	}
 
 	write_lock_bh(&arm_state->susp_res_lock);
-	while (arm_state->resume_blocked) {
-		/* If we call 'use' while force suspend is waiting for suspend,
-		 * then we're about to block the thread which the force is
-		 * waiting to complete, so we're bound to just time out. In this
-		 * case, set the suspend state such that the wait will be
-		 * canceled, so we can complete as quickly as possible. */
-		if (arm_state->resume_blocked && arm_state->vc_suspend_state ==
-				VC_SUSPEND_IDLE) {
-			set_suspend_state(arm_state, VC_SUSPEND_FORCE_CANCELED);
-			break;
-		}
-		/* If suspend is already in progress then we need to block */
-		if (!try_wait_for_completion(&arm_state->resume_blocker)) {
-			/* Indicate that there are threads waiting on the resume
-			 * blocker.  These need to be allowed to complete before
-			 * a _second_ call to force suspend can complete,
-			 * otherwise low priority threads might never actually
-			 * continue */
-			arm_state->blocked_count++;
-			write_unlock_bh(&arm_state->susp_res_lock);
-			vchiq_log_info(vchiq_susp_log_level, "%s %s resume "
-				"blocked - waiting...", __func__, entity);
-			if (wait_for_completion_killable(
-					&arm_state->resume_blocker)) {
-				vchiq_log_error(vchiq_susp_log_level, "%s %s "
-					"wait for resume blocker interrupted",
-					__func__, entity);
-				ret = VCHIQ_ERROR;
-				write_lock_bh(&arm_state->susp_res_lock);
-				arm_state->blocked_count--;
-				write_unlock_bh(&arm_state->susp_res_lock);
-				goto out;
-			}
-			vchiq_log_info(vchiq_susp_log_level, "%s %s resume "
-				"unblocked", __func__, entity);
-			write_lock_bh(&arm_state->susp_res_lock);
-			if (--arm_state->blocked_count == 0)
-				complete_all(&arm_state->blocked_blocker);
-		}
-	}
 
 	stop_suspend_timer(arm_state);
 
@@ -2861,10 +2817,7 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 	--(*entity_uc);
 
 	if (!vchiq_videocore_wanted(state)) {
-		if (vchiq_platform_use_suspend_timer() &&
-				!arm_state->resume_blocked) {
-			/* Only use the timer if we're not trying to force
-			 * suspend (=> resume_blocked) */
+		if (vchiq_platform_use_suspend_timer()) {
 			start_suspend_timer(arm_state);
 		} else {
 			vchiq_log_info(vchiq_susp_log_level,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index f0044289b6bc..c904f7be9084 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -74,7 +74,6 @@ struct vchiq_arm_state {
 	** ARM is suspending
 	*/
 	struct completion resume_blocker;
-	int resume_blocked;
 	struct completion blocked_blocker;
 	int blocked_count;
 
-- 
2.25.0

