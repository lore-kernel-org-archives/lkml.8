Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C7C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348E8206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KqeOaddw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgIAV7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgIAV7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:59:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFF8C061249
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 14:59:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so1292547pjr.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyHMLM4ELnE5TBLINkhsx/ZOVL6DEfANxYCpgeB+3ig=;
        b=KqeOaddw0AfZ2GYLkBfVZzt+5xX3DH+bRc8mRKnuHFvU2QprnK/RboHxIyhnRrOFo5
         ze6fnI+TGS5qcwk37ySRDIq9F52AnduHRqbazGPz5qi0XY1RIxerNTytyTZ9LgNJQGwH
         nQHwvSwhZvqL0EWuiF+c1ZhwgHwjOYWt8SwTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyHMLM4ELnE5TBLINkhsx/ZOVL6DEfANxYCpgeB+3ig=;
        b=LRMmxLFaHv2PpJnvUjyTQQYfpQq3dtch7ihDir9C0t7PHsQhtF5uL4cax2nwmwmk1w
         L9SnF8JEKBpMEbVh95rsiNAOmW4nGXD1dWM6RCUh2DY4ZqV6AOp+gvsISrlhUzn5IxXe
         YtWybMOBBDNpJs4GDgbGFKLlrrwqmUbaSMSwmoVjmV/S77RlSdP3QfjjohOvb65Bk/YP
         xBAZvCvSO8LUkA9NIWL+x5wAYIKPuEuOSRYgsY22w8ipMYIgKTmbqOHjC6dVFti65pCv
         RT8HlOzu7XA9NJL/+K7o3i7pwJ58Ot9R/c99T5WoRoaeIG79T5/IenE7wRBboD6Rv+KK
         TTnw==
X-Gm-Message-State: AOAM533g9vVRseIZOjLfx8W8Y4cRxDZ3mQEkI+6XoY76xiB2GK5kUWo6
        ViNYEVxyuYcAeTpreSW5WsUN0A==
X-Google-Smtp-Source: ABdhPJygyY7debsqFH8WtQ3Zg2VOGcIsIKr04QOPYsplwKI/0izan3soYosz9Lol7HtneM2yH/v8rw==
X-Received: by 2002:a17:90b:95:: with SMTP id bb21mr3454393pjb.68.1598997585709;
        Tue, 01 Sep 2020 14:59:45 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id q5sm3044037pfu.16.2020.09.01.14.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 14:59:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 2/2] drm/msm: Drop debug print in _dpu_crtc_setup_lm_bounds()
Date:   Tue,  1 Sep 2020 14:59:42 -0700
Message-Id: <20200901215942.2559119-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200901215942.2559119-1-swboyd@chromium.org>
References: <20200901215942.2559119-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is called quite often if you have a blinking cursor on the
screen, hello page flip. Let's drop this debug print here because it
means enabling the print via the module parameter starts to spam the
debug console.

Cc: Abhinav Kumar <abhinavk@codeaurora.org>
Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Sean Paul <seanpaul@chromium.org>
Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 74294b5ed93f..2966e488bfd0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -421,8 +421,6 @@ static void _dpu_crtc_setup_lm_bounds(struct drm_crtc *crtc,
 
 		trace_dpu_crtc_setup_lm_bounds(DRMID(crtc), i, r);
 	}
-
-	drm_mode_debug_printmodeline(adj_mode);
 }
 
 static void _dpu_crtc_get_pcc_coeff(struct drm_crtc_state *state,
-- 
Sent by a computer, using git, on the internet

