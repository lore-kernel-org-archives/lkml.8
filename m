Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36381C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DE122B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+vVLXOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgCBVko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:40:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35057 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgCBVko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:40:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id m3so706250wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 13:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=EvaxHgYpXoDlneHBTnvp220zewZT/Dua7ByW1c58oMM=;
        b=S+vVLXOOCuXYWey7XAChOvwKwuJRQMnKENNTKM40Mj1Tg6UfXe34t/e6IvB+L+uSF7
         hTbyMvoov+1/O7AbN/vQKFMr1CqYqPYl3ex8zyQcLUz/gKD3pW905tV3Hf80KoC1y+Ew
         Wu6EbNmVvODGw+UUUlgSyiD9wA3KCEHzBXGu3k3+0S5u2AYzYwr0L8b9IiC/CZYe5lHZ
         DHId1NAtWgYwNQj/Z3TLCObVUo4gb4RExIT15PxXr4eVa/5G14SHAl/y4q5qF1ZjwP4j
         jGZoq2AtA+MFrCDdgQJWhvSNXOFl8OqATHEwoMdOqf2ZiDmT7ViMuIMIskuOtVtnTLS2
         525Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EvaxHgYpXoDlneHBTnvp220zewZT/Dua7ByW1c58oMM=;
        b=rVNXpsDj95mXemfEXinyn1ZfInu2R58Ypo8SzvZYrU1Gm+ZlT3CA/SdoFagdkiM+sj
         ZzgFU02NSuZT6covESXOq0XcjXcMrKxa72YymUbrwV+T22YmSaVkYmIyPsB7xKb8LmnC
         Clg2uI8UpOEiOwjYCun/ARopXrjEtujGRoOyYrTiVVVNaqXDWZPq6z4GGoAJUai74dPa
         mbrscLSD02vtPHYIpmi9+8i4mysPN8eWRrh7usLp/oG/xYbrBn3UCRR328voeZ16Bqv8
         nwLo8bC1aZ30Iw1zrQ+TnX7/Ke7q4zzB2NDg4AgT0r70Xd1wRWdCUoVdCa6vx+h53So7
         hp9A==
X-Gm-Message-State: ANhLgQ0BPqk1XTElaDOIIyuJIwi8CS9IXQ7/fkwdGyNoIKt698jck373
        uelIFalNNwZOXplfl+21Xgw=
X-Google-Smtp-Source: ADFU+vtx+RNSkvUMoP7PTL0HRKKdFg14C8X9vKbHZNAxbT4QVdLB2v53LcbjfMxoYpRLPuT273yH4g==
X-Received: by 2002:a1c:155:: with SMTP id 82mr352841wmb.99.1583185242656;
        Mon, 02 Mar 2020 13:40:42 -0800 (PST)
Received: from smtp.gmail.com ([2001:818:e238:a000:51c6:2c09:a768:9c37])
        by smtp.gmail.com with ESMTPSA id s12sm349963wmj.39.2020.03.02.13.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:40:41 -0800 (PST)
Date:   Mon, 2 Mar 2020 18:40:29 -0300
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
Subject: [PATCH] drm/amd/display: dcn20: remove an unused function
Message-ID: <20200302214029.zxakr6il6f52yixb@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dpp2_get_optimal_number_of_taps function is never used. Removing just for
code cleaning up.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  | 78 -------------------
 1 file changed, 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
index 13e057d7ee93..42bba7c9548b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
@@ -369,84 +369,6 @@ void dpp2_set_cursor_attributes(
 	}
 }
 
-#define IDENTITY_RATIO(ratio) (dc_fixpt_u3d19(ratio) == (1 << 19))
-
-bool dpp2_get_optimal_number_of_taps(
-		struct dpp *dpp,
-		struct scaler_data *scl_data,
-		const struct scaling_taps *in_taps)
-{
-	/* Some ASICs does not support  FP16 scaling, so we reject modes require this*/
-	if (scl_data->viewport.width  != scl_data->h_active &&
-		scl_data->viewport.height != scl_data->v_active &&
-		dpp->caps->dscl_data_proc_format == DSCL_DATA_PRCESSING_FIXED_FORMAT &&
-		scl_data->format == PIXEL_FORMAT_FP16)
-		return false;
-
-	if (scl_data->viewport.width > scl_data->h_active &&
-		dpp->ctx->dc->debug.max_downscale_src_width != 0 &&
-		scl_data->viewport.width > dpp->ctx->dc->debug.max_downscale_src_width)
-		return false;
-
-	/* TODO: add lb check */
-
-	/* No support for programming ratio of 8, drop to 7.99999.. */
-	if (scl_data->ratios.horz.value == (8ll << 32))
-		scl_data->ratios.horz.value--;
-	if (scl_data->ratios.vert.value == (8ll << 32))
-		scl_data->ratios.vert.value--;
-	if (scl_data->ratios.horz_c.value == (8ll << 32))
-		scl_data->ratios.horz_c.value--;
-	if (scl_data->ratios.vert_c.value == (8ll << 32))
-		scl_data->ratios.vert_c.value--;
-
-	/* Set default taps if none are provided */
-	if (in_taps->h_taps == 0) {
-		if (dc_fixpt_ceil(scl_data->ratios.horz) > 4)
-			scl_data->taps.h_taps = 8;
-		else
-			scl_data->taps.h_taps = 4;
-	} else
-		scl_data->taps.h_taps = in_taps->h_taps;
-	if (in_taps->v_taps == 0) {
-		if (dc_fixpt_ceil(scl_data->ratios.vert) > 4)
-			scl_data->taps.v_taps = 8;
-		else
-			scl_data->taps.v_taps = 4;
-	} else
-		scl_data->taps.v_taps = in_taps->v_taps;
-	if (in_taps->v_taps_c == 0) {
-		if (dc_fixpt_ceil(scl_data->ratios.vert_c) > 4)
-			scl_data->taps.v_taps_c = 4;
-		else
-			scl_data->taps.v_taps_c = 2;
-	} else
-		scl_data->taps.v_taps_c = in_taps->v_taps_c;
-	if (in_taps->h_taps_c == 0) {
-		if (dc_fixpt_ceil(scl_data->ratios.horz_c) > 4)
-			scl_data->taps.h_taps_c = 4;
-		else
-			scl_data->taps.h_taps_c = 2;
-	} else if ((in_taps->h_taps_c % 2) != 0 && in_taps->h_taps_c != 1)
-		/* Only 1 and even h_taps_c are supported by hw */
-		scl_data->taps.h_taps_c = in_taps->h_taps_c - 1;
-	else
-		scl_data->taps.h_taps_c = in_taps->h_taps_c;
-
-	if (!dpp->ctx->dc->debug.always_scale) {
-		if (IDENTITY_RATIO(scl_data->ratios.horz))
-			scl_data->taps.h_taps = 1;
-		if (IDENTITY_RATIO(scl_data->ratios.vert))
-			scl_data->taps.v_taps = 1;
-		if (IDENTITY_RATIO(scl_data->ratios.horz_c))
-			scl_data->taps.h_taps_c = 1;
-		if (IDENTITY_RATIO(scl_data->ratios.vert_c))
-			scl_data->taps.v_taps_c = 1;
-	}
-
-	return true;
-}
-
 void oppn20_dummy_program_regamma_pwl(
 		struct dpp *dpp,
 		const struct pwl_params *params,
-- 
2.25.1

