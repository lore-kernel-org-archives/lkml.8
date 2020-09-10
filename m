Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC142C10DAA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28A922205
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbgIJCNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:13:46 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:42908 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgIJCFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:05:37 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 62E7F4826B1;
        Thu, 10 Sep 2020 10:05:28 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        abdoulaye berthe <abdoulaye.berthe@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        jinlong zhang <jinlong.zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/amd/display: optimize code runtime a bit
Date:   Wed,  9 Sep 2020 19:05:04 -0700
Message-Id: <20200910020520.9973-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh1KHR8aS0xJSkJPVkpOQkJMS0hOSUNMQkxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6Dgw5OT8dQx1ONQguAgIw
        SisaFE9VSlVKTkJCTEtITklCSEtCVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSEhCSTcG
X-HM-Tid: 0a7475c2b50f93bakuws62e7f4826b1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fnction is_cr_done & is_ch_eq_done, when done = false
happened once, no need to circle left ln_count.
This change is to make the code run a bit fast.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index b2be6ad5101d..53e30be8b66a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -373,34 +373,30 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 static bool is_cr_done(enum dc_lane_count ln_count,
 	union lane_status *dpcd_lane_status)
 {
-	bool done = true;
 	uint32_t lane;
 	/*LANEx_CR_DONE bits All 1's?*/
 	for (lane = 0; lane < (uint32_t)(ln_count); lane++) {
 		if (!dpcd_lane_status[lane].bits.CR_DONE_0)
-			done = false;
+			return false;
 	}
-	return done;
-
+	return true;
 }
 
 static bool is_ch_eq_done(enum dc_lane_count ln_count,
 	union lane_status *dpcd_lane_status,
 	union lane_align_status_updated *lane_status_updated)
 {
-	bool done = true;
 	uint32_t lane;
 	if (!lane_status_updated->bits.INTERLANE_ALIGN_DONE)
-		done = false;
+		return false;
 	else {
 		for (lane = 0; lane < (uint32_t)(ln_count); lane++) {
 			if (!dpcd_lane_status[lane].bits.SYMBOL_LOCKED_0 ||
 				!dpcd_lane_status[lane].bits.CHANNEL_EQ_DONE_0)
-				done = false;
+				return false;
 		}
 	}
-	return done;
-
+	return true;
 }
 
 static void update_drive_settings(
-- 
2.28.0

