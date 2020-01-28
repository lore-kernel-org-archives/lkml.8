Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F29EC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFA024681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgA1L2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:28:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54669 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgA1L2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:28:33 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iwP2i-0002MT-7V; Tue, 28 Jan 2020 11:28:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix spelling mistake link_integiry_check -> link_integrity_check
Date:   Tue, 28 Jan 2020 11:28:27 +0000
Message-Id: <20200128112827.43682-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake on the struct field name link_integiry_check,
fix this by renaming it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h           | 2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c    | 8 ++++----
 .../gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c   | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index f98d3d9ecb6d..af78e4f1be68 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -63,7 +63,7 @@ struct mod_hdcp_transition_input_hdcp1 {
 	uint8_t hdcp_capable_dp;
 	uint8_t binfo_read_dp;
 	uint8_t r0p_available_dp;
-	uint8_t link_integiry_check;
+	uint8_t link_integrity_check;
 	uint8_t reauth_request_check;
 	uint8_t stream_encryption_dp;
 };
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 04845e43df15..37670db64855 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -283,8 +283,8 @@ static enum mod_hdcp_status wait_for_ready(struct mod_hdcp *hdcp,
 				hdcp, "bstatus_read"))
 			goto out;
 		if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
-				&input->link_integiry_check, &status,
-				hdcp, "link_integiry_check"))
+				&input->link_integrity_check, &status,
+				hdcp, "link_integrity_check"))
 			goto out;
 		if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
 				&input->reauth_request_check, &status,
@@ -431,8 +431,8 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
 			hdcp, "bstatus_read"))
 		goto out;
 	if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
-			&input->link_integiry_check, &status,
-			hdcp, "link_integiry_check"))
+			&input->link_integrity_check, &status,
+			hdcp, "link_integrity_check"))
 		goto out;
 	if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
 			&input->reauth_request_check, &status,
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
index 21ebc62bb9d9..76edcbe51f71 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
@@ -241,7 +241,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 		}
 		break;
 	case D1_A4_AUTHENTICATED:
-		if (input->link_integiry_check != PASS ||
+		if (input->link_integrity_check != PASS ||
 				input->reauth_request_check != PASS) {
 			/* 1A-07: restart hdcp on a link integrity failure */
 			fail_and_restart_in_ms(0, &status, output);
@@ -249,7 +249,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 		}
 		break;
 	case D1_A6_WAIT_FOR_READY:
-		if (input->link_integiry_check == FAIL ||
+		if (input->link_integrity_check == FAIL ||
 				input->reauth_request_check == FAIL) {
 			fail_and_restart_in_ms(0, &status, output);
 			break;
-- 
2.24.0

