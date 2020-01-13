Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F204AC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEFA20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAMOFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:05:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41577 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgAMOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:05:39 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ir0LW-0004fy-Oz; Mon, 13 Jan 2020 14:05:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/gma500: clean up two indentation issues
Date:   Mon, 13 Jan 2020 14:05:34 +0000
Message-Id: <20200113140534.209440-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of statements that are indented too deeply,
clean these up by removing the extraneous tabs. Also remove an
empty line.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index 5772b2dce0d6..b5360bd405c5 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -1529,8 +1529,7 @@ cdv_intel_dp_start_link_train(struct gma_encoder *encoder)
 	clock_recovery = false;
 
 	DRM_DEBUG_KMS("Start train\n");
-		reg = DP | DP_LINK_TRAIN_PAT_1;
-
+	reg = DP | DP_LINK_TRAIN_PAT_1;
 
 	for (;;) {
 		/* Use intel_dp->train_set[0] to set the voltage and pre emphasis values */
@@ -1603,7 +1602,7 @@ cdv_intel_dp_complete_link_train(struct gma_encoder *encoder)
 	cr_tries = 0;
 
 	DRM_DEBUG_KMS("\n");
-		reg = DP | DP_LINK_TRAIN_PAT_2;
+	reg = DP | DP_LINK_TRAIN_PAT_2;
 
 	for (;;) {
 
-- 
2.24.0

