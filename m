Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F87FC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF1721734
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgAaKkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:40:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:57168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgAaKjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:39:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C08A8AF96;
        Fri, 31 Jan 2020 10:39:10 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 08/21] staging: vc04_services: Get rid of vchiq_platform_suspend/resume()
Date:   Fri, 31 Jan 2020 11:38:24 +0100
Message-Id: <20200131103836.14312-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131103836.14312-1-nsaenzjulienne@suse.de>
References: <20200131103836.14312-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchiq_platform_suspend() and vchiq_platform_resume() do nothing, get rid
of them.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_2835_arm.c             | 12 ------------
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c    |  8 +-------
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h    |  3 ---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c   |  4 ----
 .../vc04_services/interface/vchiq_arm/vchiq_core.h   |  3 ---
 5 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 5f59145f251b..65e26a90c1db 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -257,18 +257,6 @@ int vchiq_dump_platform_state(void *dump_context)
 	return vchiq_dump(dump_context, buf, len + 1);
 }
 
-enum vchiq_status
-vchiq_platform_suspend(struct vchiq_state *state)
-{
-	return VCHIQ_ERROR;
-}
-
-enum vchiq_status
-vchiq_platform_resume(struct vchiq_state *state)
-{
-	return VCHIQ_SUCCESS;
-}
-
 int
 vchiq_platform_videocore_wanted(struct vchiq_state *state)
 {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 2dfa5793d83b..850774ded8db 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2572,7 +2572,6 @@ void
 vchiq_platform_check_suspend(struct vchiq_state *state)
 {
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
-	int susp = 0;
 
 	if (!arm_state)
 		goto out;
@@ -2581,15 +2580,10 @@ vchiq_platform_check_suspend(struct vchiq_state *state)
 
 	write_lock_bh(&arm_state->susp_res_lock);
 	if (arm_state->vc_suspend_state == VC_SUSPEND_REQUESTED &&
-			arm_state->vc_resume_state == VC_RESUME_RESUMED) {
+			arm_state->vc_resume_state == VC_RESUME_RESUMED)
 		set_suspend_state(arm_state, VC_SUSPEND_IN_PROGRESS);
-		susp = 1;
-	}
 	write_unlock_bh(&arm_state->susp_res_lock);
 
-	if (susp)
-		vchiq_platform_suspend(state);
-
 out:
 	vchiq_log_trace(vchiq_susp_log_level, "%s exit", __func__);
 	return;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 61c50d7d4396..1874a01f5201 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -112,9 +112,6 @@ vchiq_release_service(unsigned int handle);
 extern enum vchiq_status
 vchiq_check_service(struct vchiq_service *service);
 
-extern enum vchiq_status
-vchiq_platform_suspend(struct vchiq_state *state);
-
 extern int
 vchiq_platform_videocore_wanted(struct vchiq_state *state);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 71342826ed33..ef8340ab8a52 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1895,10 +1895,6 @@ slot_handler_func(void *v)
 				}
 				break;
 
-			case VCHIQ_CONNSTATE_PAUSED:
-				vchiq_platform_resume(state);
-				break;
-
 			case VCHIQ_CONNSTATE_RESUMING:
 				if (queue_message(state, NULL,
 					VCHIQ_MAKE_MSG(VCHIQ_MSG_RESUME, 0, 0),
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 72c88fe5feb1..535a67cc68ed 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -593,9 +593,6 @@ remote_event_signal(struct remote_event *event);
 void
 vchiq_platform_check_suspend(struct vchiq_state *state);
 
-extern enum vchiq_status
-vchiq_platform_resume(struct vchiq_state *state);
-
 extern int
 vchiq_dump(void *dump_context, const char *str, int len);
 
-- 
2.25.0

