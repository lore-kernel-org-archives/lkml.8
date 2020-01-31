Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAB2C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2862424689
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgAaKjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:39:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:57102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbgAaKjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:39:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7360AF43;
        Fri, 31 Jan 2020 10:39:09 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 07/21] staging: vc04_services: Get rid of vchiq_platform_paused/resumed()
Date:   Fri, 31 Jan 2020 11:38:23 +0100
Message-Id: <20200131103836.14312-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131103836.14312-1-nsaenzjulienne@suse.de>
References: <20200131103836.14312-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchiq_platform_paused() and vchiq_platform_resumed() do nothing.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 10 ----------
 .../vc04_services/interface/vchiq_arm/vchiq_core.c     |  3 ---
 .../vc04_services/interface/vchiq_arm/vchiq_core.h     |  6 ------
 3 files changed, 19 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 1ffb2aea947c..5f59145f251b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -269,16 +269,6 @@ vchiq_platform_resume(struct vchiq_state *state)
 	return VCHIQ_SUCCESS;
 }
 
-void
-vchiq_platform_paused(struct vchiq_state *state)
-{
-}
-
-void
-vchiq_platform_resumed(struct vchiq_state *state)
-{
-}
-
 int
 vchiq_platform_videocore_wanted(struct vchiq_state *state)
 {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 76351078affb..71342826ed33 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1798,7 +1798,6 @@ parse_rx_slots(struct vchiq_state *state)
 			}
 			/* At this point slot_mutex is held */
 			vchiq_set_conn_state(state, VCHIQ_CONNSTATE_PAUSED);
-			vchiq_platform_paused(state);
 			break;
 		case VCHIQ_MSG_RESUME:
 			vchiq_log_trace(vchiq_core_log_level,
@@ -1807,7 +1806,6 @@ parse_rx_slots(struct vchiq_state *state)
 			/* Release the slot mutex */
 			mutex_unlock(&state->slot_mutex);
 			vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
-			vchiq_platform_resumed(state);
 			break;
 
 		case VCHIQ_MSG_REMOTE_USE:
@@ -1908,7 +1906,6 @@ slot_handler_func(void *v)
 					!= VCHIQ_RETRY) {
 					vchiq_set_conn_state(state,
 						VCHIQ_CONNSTATE_CONNECTED);
-					vchiq_platform_resumed(state);
 				} else {
 					/* This should really be impossible,
 					** since the PAUSE should have flushed
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index c31f953a9986..72c88fe5feb1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -593,15 +593,9 @@ remote_event_signal(struct remote_event *event);
 void
 vchiq_platform_check_suspend(struct vchiq_state *state);
 
-extern void
-vchiq_platform_paused(struct vchiq_state *state);
-
 extern enum vchiq_status
 vchiq_platform_resume(struct vchiq_state *state);
 
-extern void
-vchiq_platform_resumed(struct vchiq_state *state);
-
 extern int
 vchiq_dump(void *dump_context, const char *str, int len);
 
-- 
2.25.0

