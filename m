Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A4FB2068F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHETTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:19:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgHER5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:57:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k3IkV-0004vS-Cw; Wed, 05 Aug 2020 12:42:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gma500: fix spelling mistake "pannel" -> "panel"
Date:   Wed,  5 Aug 2020 13:42:27 +0100
Message-Id: <20200805124227.20005-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There a handful of spelling mistakes. fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/gma500/mdfld_dsi_output.c | 4 ++--
 drivers/gpu/drm/gma500/psb_intel_sdvo.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_output.c b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
index f350ac1ead18..2f3486f32fed 100644
--- a/drivers/gpu/drm/gma500/mdfld_dsi_output.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
@@ -366,7 +366,7 @@ static enum drm_mode_status mdfld_dsi_connector_mode_valid(struct drm_connector
 	/**
 	 * FIXME: current DC has no fitting unit, reject any mode setting
 	 * request
-	 * Will figure out a way to do up-scaling(pannel fitting) later.
+	 * Will figure out a way to do up-scaling(panel fitting) later.
 	 **/
 	if (fixed_mode) {
 		if (mode->hdisplay != fixed_mode->hdisplay)
@@ -531,7 +531,7 @@ void mdfld_dsi_output_init(struct drm_device *dev,
 	dsi_config->connector = dsi_connector;
 
 	if (!dsi_config->fixed_mode) {
-		DRM_ERROR("No pannel fixed mode was found\n");
+		DRM_ERROR("No panel fixed mode was found\n");
 		goto dsi_init_err0;
 	}
 
diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
index 06e44f47e73e..907f966d6f22 100644
--- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
+++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
@@ -125,7 +125,7 @@ struct psb_intel_sdvo {
 	bool is_lvds;
 
 	/**
-	 * This is sdvo fixed pannel mode pointer
+	 * This is sdvo fixed panel mode pointer
 	 */
 	struct drm_display_mode *sdvo_lvds_fixed_mode;
 
-- 
2.27.0

