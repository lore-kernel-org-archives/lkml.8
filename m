Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E19C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC56D2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X6YqLiCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgFLTbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:31:00 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FB6C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:31:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so4149607plr.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4xJr5jHCVeAEcRLOFPcb5oZvkfyMNzLWQX/m/ptM6s=;
        b=X6YqLiCqFgiZc0NhYCB30C7wLDMPbYQ1KFjBFPpBQ0r5OO/xXc4YZgE7MHqjKarp0U
         N7IeiQ6yhOUF/eWk1pWxJP+Ntzl8V3b4Z0XSxXCfNy9nHAWpTzEmPeCuvx+Eb8c077Cn
         0kRaRMRetUI5j6Lk5LSttJVz2vl8Qr+gmey2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4xJr5jHCVeAEcRLOFPcb5oZvkfyMNzLWQX/m/ptM6s=;
        b=EqIqG+rI0wwsFJhkK3tH/MUnE8fQEskcOKniInIqKJGU3/cxErkXN4cpkApmbYkPl5
         R7KgSo9m1+sRI2mW2DjnlZ0H4pUQ+Pdt1taUGKc/TYVGE4PBa2lRlWaLHNWNHysE/JFt
         MVgOrIKMlmvlPnY2jYluRz6cUmBsWABV6uMkNKwb0/g7Wdn1n32vYqG124jD77Ejk8xG
         RbjSphudTuzhK6LlV6bOKhPWDq3c6c8jPkpaU3D56SWO3XCtBshegJpJ/fmWlbeoMdrA
         qUWH4K6a8ufnjyPYePIRb9Ss/goe0l7JXHmc7tIZ6CzKrj7MIE1OEOziNaebrMbBo+Tq
         Cmlw==
X-Gm-Message-State: AOAM530Lf+Mx2cASUYRa17E2D+IpLE6P57rsFtvaJnsyriXS084KwvML
        858eU9oUJmenliWf8u5nKm9ajw==
X-Google-Smtp-Source: ABdhPJxQ5lcbMl7V73ZgbUO6jfK/4rDdndHu4h+o3zCtnTJevCht7YBpu0fJXUZdrdAoteLmZSaYQQ==
X-Received: by 2002:a17:90a:de95:: with SMTP id n21mr458867pjv.100.1591990259869;
        Fri, 12 Jun 2020 12:30:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n69sm6966934pjc.25.2020.06.12.12.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:30:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com, sam@ravnborg.org
Cc:     swboyd@chromium.org, spanda@codeaurora.org,
        bjorn.andersson@linaro.org, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] drm/bridge: ti-sn65dsi86: Don't use kernel-doc comment for local array
Date:   Fri, 12 Jun 2020 12:30:48 -0700
Message-Id: <20200612123003.v2.2.If3807e4ebf7f0440f64c3069edcfac9a70171940@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
References: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building we were getting an error:

  warning: cannot understand function prototype:
    'const unsigned int ti_sn_bridge_dp_rate_lut[] = '

Arrays aren't supposed to be marked with "/**" kerneldoc comments.  Fix.

Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v2: None

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6fa7e10b31af..fca7c2a0bcf9 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -504,7 +504,7 @@ static unsigned int ti_sn_bridge_get_bpp(struct ti_sn_bridge *pdata)
 		return 24;
 }
 
-/**
+/*
  * LUT index corresponds to register value and
  * LUT values corresponds to dp data rate supported
  * by the bridge in Mbps unit.
-- 
2.27.0.290.gba653c62da-goog

