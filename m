Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5E3C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0B021D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghjQ5U1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBZWHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:07:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33195 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgBZWHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:07:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id r21so742062edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=smlCNyZtkUS5wtodeApayWhfct5DN5V19mI08hkP2Xo=;
        b=ghjQ5U1NmSHaFr6tU8IENHZwipVNP5jyCzhU6nV7h62ZPW7X/96FvJA4rm+8dx9NLp
         Lzd5H3l47KL7iTnNZY7zVeqQ/HnDHNpQuZP7ARkYx2TTibZvYng1c2fUWKKEjHGkzxtW
         j1PlGGs0/1wf50f7E3QadDLs3ZBZRg9/DvGaOqo/8AvBqVzwQBjqD1DQuwqCnO3lK2bT
         rwoIV172jr0CeKH9b1pAVwxqkMxt0yqC4ZUhM2SxcG9cd9GwMlXDtdBrZARBHOHdwr41
         VUFjM18z3YNswbBL+eHJYJPQ3udUr/0Hk8gGHg5rhle/X6/ZmXBw1ZALYJwNCy1zxr7l
         3ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=smlCNyZtkUS5wtodeApayWhfct5DN5V19mI08hkP2Xo=;
        b=KovPrCTmtMXCmnG5ecK5DEpKMNkIIusyVx7n3TtN6tyWc1llL+0d55gmstCS9fFRGe
         ii0+XPgohzgmQLpHEzhmABqV0IVYGxthGoTG3W7tnZ2vJdodrzdDu0AEwARVSpvSMb8m
         HVG8CqsmBXQzsMPJ+xk8/KusXCDX1NWf4bwcr347JmDeSmDUSs0Tj7BFpwkv6BuiYy7q
         qiUB5TGR3p6jgWFHwaRXXltKXxZFVZRvZciHRfa34NDkralPPw/HGqJT3TMXIcVUbvGA
         /t9yRic1o+liAK8KNcHE/KfWWJ+sNQBC5c2a6rulcKBatXiKEJX2/xJtRhgNwDA/BW4w
         ntpg==
X-Gm-Message-State: APjAAAVQ/0iLwDP8SxGknwMWmqeKfwcdQf1s13ajiDr4Kx+EiGUSEDnv
        /oHVE+23hi4AbYa5gbaQhFA=
X-Google-Smtp-Source: APXvYqydPKo4Tg7/Ss78gnfFNnIqgFyswXLCr8T6+nOwPFGDOTqqAMzZ17XdJSY95CGjyb3Ru2edmw==
X-Received: by 2002:aa7:ca10:: with SMTP id y16mr489172eds.217.1582754840773;
        Wed, 26 Feb 2020 14:07:20 -0800 (PST)
Received: from smtp.gmail.com ([2001:818:e238:a000:51c6:2c09:a768:9c37])
        by smtp.gmail.com with ESMTPSA id dd20sm167771ejb.59.2020.02.26.14.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:07:20 -0800 (PST)
Date:   Wed, 26 Feb 2020 19:07:12 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: dc_link: code clean up on
 enable_link_dp function
Message-ID: <990112183d2bc344bd921bb55eee2f8cc2cd8bd5.1582752490.git.melissa.srw@gmail.com>
References: <cover.1582752490.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582752490.git.melissa.srw@gmail.com>
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
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a09119c10d7c..0f28b5694144 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1480,9 +1480,8 @@ static void enable_stream_features(struct pipe_ctx *pipe_ctx)
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
@@ -1512,27 +1511,28 @@ static enum dc_status enable_link_dp(
 
 	pipe_ctx->stream_res.pix_clk_params.requested_sym_clk =
 			link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
-	if (state->clk_mgr && !apply_seamless_boot_optimization)
-		state->clk_mgr->funcs->update_clocks(state->clk_mgr, state, false);
+	if (state->clk_mgr && !apply_seamless_boot_optimization) {
+		state->clk_mgr->funcs->update_clocks(state->clk_mgr,
+						     state, false);
+	}
 
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

