Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CF2C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF832071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389650AbgAXOqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:46:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:43572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389004AbgAXOqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:46:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68410AF22;
        Fri, 24 Jan 2020 14:46:41 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH 14/22] staging: vc04_services: Delete vc_suspend_complete completion
Date:   Fri, 24 Jan 2020 15:46:08 +0100
Message-Id: <20200124144617.2213-15-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124144617.2213-1-nsaenzjulienne@suse.de>
References: <20200124144617.2213-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is waiting on it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 7 -------
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.h  | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 774ce4aa216f..da95bb1ec0eb 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2356,8 +2356,6 @@ vchiq_arm_init_state(struct vchiq_state *state,
 		atomic_set(&arm_state->ka_use_ack_count, 0);
 		atomic_set(&arm_state->ka_release_count, 0);
 
-		init_completion(&arm_state->vc_suspend_complete);
-
 		init_completion(&arm_state->vc_resume_complete);
 		/* Initialise to 'done' state.  We only want to block on resume
 		 * completion while videocore is suspended. */
@@ -2436,18 +2434,14 @@ set_suspend_state(struct vchiq_arm_state *arm_state,
 	/* state specific additional actions */
 	switch (new_state) {
 	case VC_SUSPEND_FORCE_CANCELED:
-		complete_all(&arm_state->vc_suspend_complete);
 		break;
 	case VC_SUSPEND_REJECTED:
-		complete_all(&arm_state->vc_suspend_complete);
 		break;
 	case VC_SUSPEND_FAILED:
-		complete_all(&arm_state->vc_suspend_complete);
 		arm_state->vc_resume_state = VC_RESUME_RESUMED;
 		complete_all(&arm_state->vc_resume_complete);
 		break;
 	case VC_SUSPEND_IDLE:
-		reinit_completion(&arm_state->vc_suspend_complete);
 		break;
 	case VC_SUSPEND_REQUESTED:
 		break;
@@ -2455,7 +2449,6 @@ set_suspend_state(struct vchiq_arm_state *arm_state,
 		set_resume_state(arm_state, VC_RESUME_IDLE);
 		break;
 	case VC_SUSPEND_SUSPENDED:
-		complete_all(&arm_state->vc_suspend_complete);
 		break;
 	default:
 		BUG();
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 9a8ecc089c69..ac065f284372 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -46,7 +46,6 @@ struct vchiq_arm_state {
 	atomic_t ka_use_ack_count;
 	atomic_t ka_release_count;
 
-	struct completion vc_suspend_complete;
 	struct completion vc_resume_complete;
 
 	rwlock_t susp_res_lock;
-- 
2.25.0

