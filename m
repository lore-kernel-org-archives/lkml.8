Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D024C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D471206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YjVS/wJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgFHRtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbgFHRs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:48:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB76C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 10:48:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so6949316plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDREJdIeqVVNUFKbTRjN9h4pzjh8nAC/rSJIcVHTPvI=;
        b=YjVS/wJMDLTWoyw/MsK1Tuoq6+gBFrFSlynfEopbBcduF6pOpl8ZIFp6syxK7jadgP
         SnS5iQoGnbiSlE52dB4TPYH0ijiObajjXDXXytMm4k3DNgb2u247r+rvsDyfsIeeAW2w
         Qs4FXhdcsKjWCadLsOOJI8zMKrfIQY8x11DfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDREJdIeqVVNUFKbTRjN9h4pzjh8nAC/rSJIcVHTPvI=;
        b=RSgIXbIWe8DaqKbppqFjw55TgYMLllswUm58BE8DgnR5IJvHcaRJ3rTJ5rkpjtKJ5T
         jJPZuPhBw4hbPi+5jFk8WBEYDAgY5dSxZP7MMpbwRxF2eRL2LHZYcd0CbGkrJg8UoDsj
         aOn+psqoECz5cFENI7cHse1it65J1v20ssWNddH64cobq+8C5T024bpClOyWdqXSyuB7
         2sGemeQisw75THqH2TvUfxSdfB8ZP8Bbcaor2wOaj6HFYM2eSt/D6un37EqD90luMbjz
         9PqGBshoAyxd7XztuwQVErhG1iTI+0pLKmka0Wmydw3bfxypQ6NVibatuldJN3lYAD/6
         12vw==
X-Gm-Message-State: AOAM533fYky5vY4Z5fDChpahSrGXYVLd28l3jtZo/56rNbg1f6jnXq54
        F5Dolf3DRr0ld0KKfSf28ynnvA==
X-Google-Smtp-Source: ABdhPJzXgMGLzrQbBansRBa6+m6CHlci9mkI2ZDTaVy/m4IurD1PdamJfY6lX9gd88k7K4l+QTJrvA==
X-Received: by 2002:a17:90a:1546:: with SMTP id y6mr490880pja.92.1591638537595;
        Mon, 08 Jun 2020 10:48:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n7sm162682pjq.22.2020.06.08.10.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:48:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com, sam@ravnborg.org
Cc:     robdclark@chromium.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, spanda@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/bridge: ti-sn65dsi86: Don't use kernel-doc comment for local array
Date:   Mon,  8 Jun 2020 10:48:33 -0700
Message-Id: <20200608104832.2.If3807e4ebf7f0440f64c3069edcfac9a70171940@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
References: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
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
---

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
2.27.0.278.ge193c7cf3a9-goog

