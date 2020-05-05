Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4549DC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDF5206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="btGoVaOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgEEEcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 00:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgEEEci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:32:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CECC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 21:32:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fu13so465082pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 21:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGLmPxsShIHn4CHHbn8Pe8eVKKsfBl2KpXHBFAlksI8=;
        b=btGoVaOqEwDh281RyzGWWpVCibotYTf5Q5OZiRkLjKUSde0ATaySojqpvzC60y/oCY
         LJyDkuQcisPIKzP+b1dgIQe8h/fyUo5uDW32lSNQSGFw/rvCwQ28Kh1Daiv/5BaDtQgG
         BXISZfHmzwspCJZ+ZsuW6xjf5lZyTP06U8EVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGLmPxsShIHn4CHHbn8Pe8eVKKsfBl2KpXHBFAlksI8=;
        b=AKETZ1NWiDl9/Ca6nxMuFrTCe75ke1aPWjM4heY6dF/1GyF1a1lu+hDW4apTEo55tn
         IwXWDpBhj5ABSOzpeHrPh7vKvoBUCGS7ur3QtcAQH0EEAF8E5uDmweGDdAH0ghEANuYe
         NOjlkbaAA8ySKibic1+au/9zVaeTVRPepxaaAXUpMSogCRbVprvVCPfGamYtxwMJAE44
         QVZbpU2NiVLdPDkc1A9FLbMRCSG6cKrtv9Gcn0pIEcCRW/61Wz4gxr58wwMKqIvOHjhc
         R/7lNw9mZj56K7tk6f1wLd9wv0qjTx3QkF0CvafxXMlOPy5cq6snnFc+5DSkLqPQOvUA
         k5pw==
X-Gm-Message-State: AGi0Puamk7AsNOY6SoQJXH9zXDBektdgDye0BS/OqrQATQm44DLjWTxE
        /b4gkrZOldwNMry0R6mCQssqnA==
X-Google-Smtp-Source: APiQypJRhfyblghgHdLN4pfxYjK2JQv0NLCq3d5jMQ6MWWmHOgq57l9LIwfyXHf0s/iviGLG8+DN3A==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id iq14mr608631pjb.146.1588653158036;
        Mon, 04 May 2020 21:32:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id w11sm545075pjy.11.2020.05.04.21.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 21:32:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-arm-msm@vger.kernel.org, seanpaul@chromium.org,
        robdclark@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sandeep Panda <spanda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Fix off-by-one error in clock choice
Date:   Mon,  4 May 2020 21:32:29 -0700
Message-Id: <20200504213225.1.I21646c7c37ff63f52ae6cdccc9bc829fbc3d9424@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the rate in our table is _equal_ to the rate we want then it's OK
to pick it.  It doesn't need to be greater than the one we want.

Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6ad688b320ae..be000b0ca56b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -475,7 +475,7 @@ static int ti_sn_bridge_calc_min_dp_rate_idx(struct ti_sn_bridge *pdata)
 				   1000 * pdata->dp_lanes * DP_CLK_FUDGE_DEN);
 
 	for (i = 1; i < ARRAY_SIZE(ti_sn_bridge_dp_rate_lut) - 1; i++)
-		if (ti_sn_bridge_dp_rate_lut[i] > dp_rate_mhz)
+		if (ti_sn_bridge_dp_rate_lut[i] >= dp_rate_mhz)
 			break;
 
 	return i;
-- 
2.26.2.526.g744177e7f7-goog

