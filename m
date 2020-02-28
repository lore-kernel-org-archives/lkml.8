Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E6C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE962468D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olqIOHkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgB1Qlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:41:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41643 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgB1Qlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:41:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so4048726eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ldf8hYsODju3QfMuQceixPCm/gYiMPapiNP2c55hvY8=;
        b=olqIOHkF6nsW9UYb36nMIzd9lU3s+uRqS8wOR3h+TWG0ta18aKezAaCKixv6gGPxUK
         c73TR/s6tYA9rZOfOJF4Ady5JMGtZY+hzChGh6zLbscqlrLWUMVqi/C2YcYch6GUV1/g
         s61HJHjR2efaala0vgj64Lj9PlShUwxgCshyR7y28f2vS5WpYFIwPBXT9+u/kxW+OLnP
         plrBWmysnZ2K4ReVWEZxPeP3v1vACgn5hyiCXW4cBmJBdIa6dW6PiKy9mLvM/X5uC8WL
         vYi/06mnmp2hD3XGRHYvd/YAg2Dg3ZZTT4jzHlE56A3+6daLQZSTkB+TwlUNHpdT7jq2
         mkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ldf8hYsODju3QfMuQceixPCm/gYiMPapiNP2c55hvY8=;
        b=Sqg1r6rnkeww7GiBlfBOQFHbqg3ABHYtbADMtckADyEW6vKaYjxhdEaMxznfNK6Tzn
         +2eXE/h/P7kq0gFUKec2E2sb9V6olQ3GYspY+MRcZSFgiEtQ/y3ivYJq85MmgMKzz8Df
         vY9TqO6GpMNXZNNTvA3muH2yY2mh3iOEj1YQXrIfTDGxmkxPeigLN4filceKmB3rwf5N
         1XbYwJignr8lGhPwaIIny3/itI+JM1vw5ijlc8aNao8gaGL3ZQ0h1PLlccSO87hPFaNg
         D1qB6xsCG9VkD2oYienjoDhOHGBTlAPPj6VZe6LpbR9IwEylYFSXo3pu7Hwl2V/s4eZt
         vX2g==
X-Gm-Message-State: APjAAAWs/YrTtKJoC4qFj3BeoCV+Mp0rBTgBHiZ+ok6gF2s6xclbzWtG
        MX0HyunF2i0B57YBGQ/LYl0=
X-Google-Smtp-Source: APXvYqyBIXoVMdxp+IBNcq5UuXpt1k3/I3znDe1yS0Q/R9hOHsI1A7Z2npgvGIC0J9uYyTHKpa9bxg==
X-Received: by 2002:a05:6402:c08:: with SMTP id co8mr5180686edb.197.1582908113875;
        Fri, 28 Feb 2020 08:41:53 -0800 (PST)
Received: from smtp.gmail.com (1.77.115.89.rev.vodafone.pt. [89.115.77.1])
        by smtp.gmail.com with ESMTPSA id b14sm579365edx.64.2020.02.28.08.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:41:52 -0800 (PST)
Date:   Fri, 28 Feb 2020 13:41:45 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/amd/display: dc_link: code clean up on
 enable_link_dp function
Message-ID: <922a2d0df348e72588405dedd4f9a296448f51c3.1582907436.git.melissa.srw@gmail.com>
References: <cover.1582907436.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582907436.git.melissa.srw@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style clean up on enable_link_dp function as suggested by
checkpatch.pl:

CHECK: Lines should not end with a '('
WARNING: line over 80 characters
WARNING: suspect code indent for conditional statements (8, 24)
CHECK: braces {} should be used on all arms of this statement
ERROR: else should follow close brace '}'
CHECK: Comparison to NULL could be written
       "link->preferred_training_settings.fec_enable"

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 02e1ad318203..eb9894e416ed 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1498,9 +1498,8 @@ static void enable_stream_features(struct pipe_ctx *pipe_ctx)
 	}
 }
 
-static enum dc_status enable_link_dp(
-		struct dc_state *state,
-		struct pipe_ctx *pipe_ctx)
+static enum dc_status enable_link_dp(struct dc_state *state,
+				     struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	enum dc_status status;
@@ -1532,7 +1531,8 @@ static enum dc_status enable_link_dp(
 	pipe_ctx->stream_res.pix_clk_params.requested_sym_clk =
 			link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
 	if (state->clk_mgr && !apply_seamless_boot_optimization)
-		state->clk_mgr->funcs->update_clocks(state->clk_mgr, state, false);
+		state->clk_mgr->funcs->update_clocks(state->clk_mgr,
+						     state, false);
 
 	// during mode switch we do DP_SET_POWER off then on, and OUI is lost
 	dpcd_set_source_specific_data(link);
@@ -1540,21 +1540,20 @@ static enum dc_status enable_link_dp(
 	skip_video_pattern = true;
 
 	if (link_settings.link_rate == LINK_RATE_LOW)
-			skip_video_pattern = false;
-
-	if (perform_link_training_with_retries(
-			&link_settings,
-			skip_video_pattern,
-			LINK_TRAINING_ATTEMPTS,
-			pipe_ctx,
-			pipe_ctx->stream->signal)) {
+		skip_video_pattern = false;
+
+	if (perform_link_training_with_retries(&link_settings,
+					       skip_video_pattern,
+					       LINK_TRAINING_ATTEMPTS,
+					       pipe_ctx,
+					       pipe_ctx->stream->signal)) {
 		link->cur_link_settings = link_settings;
 		status = DC_OK;
-	}
-	else
+	} else {
 		status = DC_FAIL_DP_LINK_TRAINING;
+	}
 
-	if (link->preferred_training_settings.fec_enable != NULL)
+	if (link->preferred_training_settings.fec_enable)
 		fec_enable = *link->preferred_training_settings.fec_enable;
 	else
 		fec_enable = true;
-- 
2.25.0

