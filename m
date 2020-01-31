Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13FBC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922E920CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgAaKjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:39:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:57102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgAaKjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:39:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E5D7EAFF6;
        Fri, 31 Jan 2020 10:39:13 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 12/21] staging: vc04_services: Get rid of vchiq_arm_vcsuspend()
Date:   Fri, 31 Jan 2020 11:38:28 +0100
Message-Id: <20200131103836.14312-13-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131103836.14312-1-nsaenzjulienne@suse.de>
References: <20200131103836.14312-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not used.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 51 -------------------
 .../interface/vchiq_arm/vchiq_arm.h           |  3 --
 2 files changed, 54 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 7c620366dfb6..a33f0fb5d45f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2500,57 +2500,6 @@ need_resume(struct vchiq_state *state)
 			(arm_state->vc_resume_state < VC_RESUME_REQUESTED);
 }
 
-/* Initiate suspend via slot handler. Should be called with the write lock
- * held */
-enum vchiq_status
-vchiq_arm_vcsuspend(struct vchiq_state *state)
-{
-	enum vchiq_status status = VCHIQ_ERROR;
-	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
-
-	if (!arm_state)
-		goto out;
-
-	vchiq_log_trace(vchiq_susp_log_level, "%s", __func__);
-	status = VCHIQ_SUCCESS;
-
-	switch (arm_state->vc_suspend_state) {
-	case VC_SUSPEND_REQUESTED:
-		vchiq_log_info(vchiq_susp_log_level, "%s: suspend already "
-			"requested", __func__);
-		break;
-	case VC_SUSPEND_IN_PROGRESS:
-		vchiq_log_info(vchiq_susp_log_level, "%s: suspend already in "
-			"progress", __func__);
-		break;
-
-	default:
-		/* We don't expect to be in other states, so log but continue
-		 * anyway */
-		vchiq_log_error(vchiq_susp_log_level,
-			"%s unexpected suspend state %s", __func__,
-			suspend_state_names[arm_state->vc_suspend_state +
-						VC_SUSPEND_NUM_OFFSET]);
-		/* fall through */
-	case VC_SUSPEND_REJECTED:
-	case VC_SUSPEND_FAILED:
-		/* Ensure any idle state actions have been run */
-		set_suspend_state(arm_state, VC_SUSPEND_IDLE);
-		/* fall through */
-	case VC_SUSPEND_IDLE:
-		vchiq_log_info(vchiq_susp_log_level,
-			"%s: suspending", __func__);
-		set_suspend_state(arm_state, VC_SUSPEND_REQUESTED);
-		/* kick the slot handler thread to initiate suspend */
-		request_poll(state, NULL, 0);
-		break;
-	}
-
-out:
-	vchiq_log_trace(vchiq_susp_log_level, "%s exit %d", __func__, status);
-	return status;
-}
-
 void
 vchiq_platform_check_suspend(struct vchiq_state *state)
 {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 0a4efcf95a61..606a519dd3db 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -88,9 +88,6 @@ int vchiq_platform_init(struct platform_device *pdev,
 extern struct vchiq_state *
 vchiq_get_state(void);
 
-extern enum vchiq_status
-vchiq_arm_vcsuspend(struct vchiq_state *state);
-
 extern enum vchiq_status
 vchiq_arm_vcresume(struct vchiq_state *state);
 
-- 
2.25.0

