Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D05C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1A920885
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2IlTYMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgFLTbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgFLTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:31:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730CDC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:31:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t7so4580500pgt.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/GfnNC8pXVMnpUdumvg6vaJ4jiyTtawkJau7ukqTZo=;
        b=G2IlTYMXhCkQR4ELMO19WmWfDfP34LAIVdX40D7bNRrYfyXYvFKHC7Cdn77RuP82R4
         2ji01psEasSHfT1/aQ/yTtES/Sj6YmBf669RUbjoQtq2VMdbkNQgsRnJr3n07tbZ+BsE
         0QYNW/8dm940Jgz8VVbIfmRORs8S/oDxamvWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/GfnNC8pXVMnpUdumvg6vaJ4jiyTtawkJau7ukqTZo=;
        b=B5/kO5vIBfcXg+lqNkkSgcLWoBZw1tvTZsVwCml78i7op5R74/v7dSq7FZ7faGv2vj
         ZOghEW7QzLEvkm+t3UPuOG6taM4OIX11vCle0z8qB/skEScK/I5dm1WxR3H6l8L0rc7W
         EoVik200FWHSkdj9NULoBNVBakrI5qmLybMco0hzjSh+w/dkbYQeRml21MlsFwSaCI4k
         6UCib8jYnPQfZfvEfMi2qqfIRgDFqMIRJ0VDTi8gXi8A3LAu+JTjiyhkSIuFzoKnuJcX
         s8p9e0uz50GtM2WQS9oDigsdqdWgrv1ESLCVoXWIqIiqVP/+Y/V7jLAn1BH25ty5DEqA
         /rNw==
X-Gm-Message-State: AOAM531Z6fqznzr+LcxEBQc2KgiUNGI5g6UpvajSf1UYpcAIKIF8L7Oh
        j/nT2Moys6RkBe0Kl4fbCNtLdg==
X-Google-Smtp-Source: ABdhPJyfydS6pnh63FC5FkWpfhhla7sdsI5aEnFHl7FPTKIrMMSQFO2xsBGnY2nj7D6x9bPXeGIkKQ==
X-Received: by 2002:aa7:9052:: with SMTP id n18mr13776479pfo.319.1591990260998;
        Fri, 12 Jun 2020 12:31:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n69sm6966934pjc.25.2020.06.12.12.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:31:00 -0700 (PDT)
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
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] drm/bridge: ti-sn65dsi86: Fix kernel-doc typo ln_polr => ln_polrs
Date:   Fri, 12 Jun 2020 12:30:49 -0700
Message-Id: <20200612123003.v2.3.Ib616e311c48cc64b2cef11bd54d4a9cedc874bb1@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
References: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a kernel doc warning due to a typo:
  warning: Function parameter or member 'ln_polrs' not described in 'ti_sn_bridge'

Fixes: 5bebaeadb30e ("drm/bridge: ti-sn65dsi86: Implement lane reordering + polarity")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v2: None

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index fca7c2a0bcf9..1080e4f9df96 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -122,7 +122,7 @@
  * @supplies:     Data for bulk enabling/disabling our regulators.
  * @dp_lanes:     Count of dp_lanes we're using.
  * @ln_assign:    Value to program to the LN_ASSIGN register.
- * @ln_polr:      Value for the 4-bit LN_POLRS field of SN_ENH_FRAME_REG.
+ * @ln_polrs:     Value for the 4-bit LN_POLRS field of SN_ENH_FRAME_REG.
  *
  * @gchip:        If we expose our GPIOs, this is used.
  * @gchip_output: A cache of whether we've set GPIOs to output.  This
-- 
2.27.0.290.gba653c62da-goog

