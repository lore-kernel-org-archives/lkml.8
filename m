Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532B0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B2120706
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="iAcLYGIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbgEZDXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 23:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388713AbgEZDXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 23:23:05 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F58BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:23:05 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id er16so8879133qvb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZjkvReBVpxbpSNmHSMVv60YPHC0WHPyESfR7wPaf0g=;
        b=iAcLYGImXt7qU+Oj1+OrSH57RdqT0EzL8qM0lMEU0Fw9Z2OuBXZsRENIkFPa7zKuqd
         dhDJFAVOXSO/u5g85UjqfVfA38EJhysYo/k2Jr5sCg8MhlaWXp/jT9hvrWbxNg+Khr9f
         ZbuugSxq4Z+4ysN6DfC4lnb1zQw+Xy3nHU23FKOHHJCxGI/yDixXer5//HYetBpzSuta
         gRmqtXHWrkK5sPPWQyRLYjgTRomva9uRYh392t/3EjtehTLwNzgmLnymLpbUlYAYrhhi
         0I/egqEEolBC8qVZcKTW8GZqcSVbLwwvrJDN7/kBlW4R8tPYALp3l7vrcmzI+PyvDhWx
         A10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZjkvReBVpxbpSNmHSMVv60YPHC0WHPyESfR7wPaf0g=;
        b=kVt9RgjqrQ5PgLZqImh+p0zP4UG5ULZQcx4OjBhXNGSevSmvOi8A8QPctVI7E56JGs
         W7ce549tvNbwG/xr1tt04AazjwvllmS0O57namUjKUtnBZ9g4Wtoh2gXvvcDZw6JRWV2
         tSKAkn1fJ5JgYu1Oh4LMDCyTcDI6EJ8+pqGzE6/LgS1ICPwTpXsP5q1C5k9hm1IaNwZK
         irllUTYNMJymdOW3/iLpxbIaSeE5krNmjqg79mcsNfB/TtMSP833gYtf2ngoD+ppUyVq
         UhM7tFwYTBqPQW8fzsaCPVK2nnFxwsAPSBsRg8gq/JLE3FFAkF01CZAk/JrT/DBpVXxB
         f36A==
X-Gm-Message-State: AOAM533NBzkp9tfTL5rpw282+LunqYUI8n2dHc24JaLxRcOJSSiiWTv5
        YflSqDs/mBlPcrwQgqKBeUfB6w==
X-Google-Smtp-Source: ABdhPJzRkywAd6OOmXgCnPe/1+ksB8fOOWAWM2ed8Hl4/LLIF4lXfUb2uE2H7ftcxkzujzi2+9sbxg==
X-Received: by 2002:a0c:fe88:: with SMTP id d8mr17702304qvs.208.1590463384541;
        Mon, 25 May 2020 20:23:04 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id k20sm2530796qtu.16.2020.05.25.20.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 20:23:04 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/8] drm/msm/dpu: intf timing path for displayport
Date:   Mon, 25 May 2020 23:22:13 -0400
Message-Id: <20200526032235.21930-7-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200526032235.21930-1-jonathan@marek.ca>
References: <20200526032235.21930-1-jonathan@marek.ca>
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

