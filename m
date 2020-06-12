Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30505C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD6D2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WzECtsn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFLTbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFLTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:31:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63355C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:30:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so4045865pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGMzjkhMjOHffrm0MUbn2WAGnae39l2+rYHo11+y6eM=;
        b=WzECtsn5cH0OoinAmzjjiwAaORsCILg5BjcE2ScC3ercyJwv5IqLLyN+nSVp3brQOl
         KJmIA9SVjkYNpI1ACF38HqARcQKD1PUgmbK1dFdFm1SFZDjT4vfQAVMQoQ9yKTb54ukO
         l8pJ8POvMkV9L7YxvMLwGk1P/1/eR3yj2X9ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGMzjkhMjOHffrm0MUbn2WAGnae39l2+rYHo11+y6eM=;
        b=jvsC9x1KqOGF0xrdf712o0NJOShhRoI8f6qik0TzDWgrJuDd/nZFYZjLyfiARw8ARU
         V068hrCR83Fx9iY64GJO+mYXbMO0LMkumSVAn/VZ3jhYitBsMgS9qT8K0dE615TJYfk6
         vRBMi4K4fHJzIQAl1N7oi5O4qm+8mrkRrdkPxu88RYb/0RP+97PdjqpSqNRUaibt+htM
         j0mSVTTbIKT3y95rNSDOkyKMUbbf5adCb9r9TJfoj+x/PNsVzF/c7pyLjiw3a5zbnP+h
         mr35lT1yFZbYEXgu91lWmOYAp3d6I2u8TKkMS9qT8ZMyL4Lu/M25ywEw4bIQiQEvr+ew
         SzsQ==
X-Gm-Message-State: AOAM5320XyF6iOa2SqM7pkPipYCD1IJBcCIAxW4nYTToPrXuUSj/A8QT
        Y4d1JY5gib0iOubxjgiephFP+Q==
X-Google-Smtp-Source: ABdhPJxQdLqwY7OobVFFXwfOjXMluaqP9V1tFz7TRtrtpqculJa7afZWCLVRCtERdeCqb/8V9M2KtA==
X-Received: by 2002:a17:90a:6483:: with SMTP id h3mr390383pjj.229.1591990258822;
        Fri, 12 Jun 2020 12:30:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n69sm6966934pjc.25.2020.06.12.12.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:30:58 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com, sam@ravnborg.org
Cc:     swboyd@chromium.org, spanda@codeaurora.org,
        bjorn.andersson@linaro.org, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] drm/bridge: ti-sn65dsi86: Don't compile GPIO bits if not CONFIG_OF_GPIO
Date:   Fri, 12 Jun 2020 12:30:47 -0700
Message-Id: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot noted that if "OF" is defined (which is needed
to select DRM_TI_SN65DSI86 at all) but not OF_GPIO that we'd get
compile failures because some of the members that we access in "struct
gpio_chip" are only defined "#if defined(CONFIG_OF_GPIO)".

All the GPIO bits in the driver are all nicely separated out.  We'll
guard them with the same "#if defined" that the header has and add a
little stub function if OF_GPIO is not defined.

Fixes: 27ed2b3f22ed ("drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v2: None

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 2240e9973178..6fa7e10b31af 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -151,8 +151,10 @@ struct ti_sn_bridge {
 	u8				ln_assign;
 	u8				ln_polrs;
 
+#if defined(CONFIG_OF_GPIO)
 	struct gpio_chip		gchip;
 	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
+#endif
 };
 
 static const struct regmap_range ti_sn_bridge_volatile_ranges[] = {
@@ -925,6 +927,8 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_sn_bridge *pdata)
 	return 0;
 }
 
+#if defined(CONFIG_OF_GPIO)
+
 static int tn_sn_bridge_of_xlate(struct gpio_chip *chip,
 				 const struct of_phandle_args *gpiospec,
 				 u32 *flags)
@@ -1092,6 +1096,15 @@ static int ti_sn_setup_gpio_controller(struct ti_sn_bridge *pdata)
 	return ret;
 }
 
+#else
+
+static inline int ti_sn_setup_gpio_controller(struct ti_sn_bridge *pdata)
+{
+	return 0;
+}
+
+#endif
+
 static void ti_sn_bridge_parse_lanes(struct ti_sn_bridge *pdata,
 				     struct device_node *np)
 {
-- 
2.27.0.290.gba653c62da-goog

