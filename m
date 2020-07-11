Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03250C433EB
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD5020657
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="o704Ym7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGKAu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgGKAuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:50:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007F3C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j10so5890169qtq.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZjkvReBVpxbpSNmHSMVv60YPHC0WHPyESfR7wPaf0g=;
        b=o704Ym7dIhKXAkyDL8wWtM4GXO7WB+4QK8fwOAGIviSDXDDm0/+HMQIQ/ljFUGi6vu
         FD8S6XgLIGOgfVANnGtaQnj6TrfXjfs4oghvM+iSUGO0Nq6YVKkL6unc5KpoPLDcKQWd
         IBvJ3aMtJlbvSqkCtRGAoy0CyeyNpKYEhn+hcHlXjVVVzETEcfVxw1Aw1Z2lthekKnv2
         R3EKsdFsM40+3TfLhz1x+n3RYAxPTl9g/Vh+Nqmku88ML+Mtd+XC8m5nFLRMBPknRrg/
         8tO8eEu3b3vWHKHKn7hBzPSLpybOAf3I3JBZsxb5Nihub8DeCs8DAwcVQ6gecq1Ezkr2
         dcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZjkvReBVpxbpSNmHSMVv60YPHC0WHPyESfR7wPaf0g=;
        b=ReSYwxpN7FbtrmW3f4fQ2ZSP5JFUZAi/dyXzPmNMQOp1BKc1dRgrTqRxo1G12z7Yrm
         hD41aA3SnNS50F8b5/peXRrQTnilZbl3ULxufsBkIQ2xcK1KHBw0uiWZV5S65uHHnzjC
         CnSEXMExpaqL5E4eKwFFOvy7/FD4NrZPZUEcrfDGzQYccx2FG8alxS8BXEzU4SfQbu5o
         dZlUfi3gkCghbWqM/HDSfarrtYUCA31Q1eIG+ijzHSim3dTGU5aTbirKBGP3jAKNH2y/
         k5tkTdNqfDDw31C70TDTGPcssVFm9Y8L3JQYnUjgj9+89ibYr1T7N25pZxAXIiUZdX4A
         85+Q==
X-Gm-Message-State: AOAM531v/qSkJRHiZmoiWwOXvu4Kp8RuRdiK0xf54Tq6LLqvZGFDJeSg
        v+hCYoBEEzmMVWZD1YxKLbg4kA==
X-Google-Smtp-Source: ABdhPJyB7Ha2yTM+Stl8pYFfDl5fldqN1HEwj9OFsLXc478vVz/hiCOClq5YiBaMnQ0i3Sp/gZ75Xw==
X-Received: by 2002:ac8:4e08:: with SMTP id c8mr74451649qtw.299.1594428622218;
        Fri, 10 Jul 2020 17:50:22 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g20sm10427510qtc.46.2020.07.10.17.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 17:50:21 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 6/8] drm/msm/dpu: intf timing path for displayport
Date:   Fri, 10 Jul 2020 20:47:29 -0400
Message-Id: <20200711004752.30760-7-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200711004752.30760-1-jonathan@marek.ca>
References: <20200711004752.30760-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the correct timings for displayport, from downstream driver.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 64f556d693dd..6f0f54588124 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -107,11 +107,6 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 	display_v_end = ((vsync_period - p->v_front_porch) * hsync_period) +
 	p->hsync_skew - 1;
 
-	if (ctx->cap->type == INTF_EDP || ctx->cap->type == INTF_DP) {
-		display_v_start += p->hsync_pulse_width + p->h_back_porch;
-		display_v_end -= p->h_front_porch;
-	}
-
 	hsync_start_x = p->h_back_porch + p->hsync_pulse_width;
 	hsync_end_x = hsync_period - p->h_front_porch - 1;
 
@@ -144,10 +139,25 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 	hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
 	display_hctl = (hsync_end_x << 16) | hsync_start_x;
 
+	if (ctx->cap->type == INTF_EDP || ctx->cap->type == INTF_DP) {
+		active_h_start = hsync_start_x;
+		active_h_end = active_h_start + p->xres - 1;
+		active_v_start = display_v_start;
+		active_v_end = active_v_start + (p->yres * hsync_period) - 1;
+
+		display_v_start += p->hsync_pulse_width + p->h_back_porch;
+
+		active_hctl = (active_h_end << 16) | active_h_start;
+		display_hctl = active_hctl;
+	}
+
 	den_polarity = 0;
 	if (ctx->cap->type == INTF_HDMI) {
 		hsync_polarity = p->yres >= 720 ? 0 : 1;
 		vsync_polarity = p->yres >= 720 ? 0 : 1;
+	} else if (ctx->cap->type == INTF_DP) {
+		hsync_polarity = p->hsync_polarity;
+		vsync_polarity = p->vsync_polarity;
 	} else {
 		hsync_polarity = 0;
 		vsync_polarity = 0;
-- 
2.26.1

