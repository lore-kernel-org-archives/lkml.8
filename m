Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B34D206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NXzPbPlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgFLTbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFLTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:31:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BFCC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:31:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ga6so4045913pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/JLcL+eXskupadvzRPr0KYY4jNSs8dr6KFn31X50BKA=;
        b=NXzPbPlf441w11iFHGJ9W+Y5ontYOUwpkp86hqoqbgJR2zRFsLy6IrP6O+bPWiagdK
         qiSa5hgegSw3yVsSvyzmUrpNdQUnheUeuSEjk17lEob7A95e3T0oJdW1NpS0aaPSyQzE
         Qox/wJm24EvNxtf14X0Upc72JOgNWu4E4/u/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JLcL+eXskupadvzRPr0KYY4jNSs8dr6KFn31X50BKA=;
        b=IgEU88U2dgjYc6qM9o/hmoMTIvfCnoo8369yOlq16fsIsrN+6KpQ0I11vbd0Uvp/NC
         S688d4Dqr2RMGWEBvrh4cOyRqEAHB+A+bTrESiMlw3SRnw8M01TwD6M4CXiB21wZZgPa
         Hb0S3DCxiUmX1WUycXx2t230g6NO8++xQqGbS2xv8O1W4t0yW7LSkcITfmDinLMqmtnM
         C0Z+c1SW7mpqyPUeaHf/f62tYbidUDKAgw7pAqGUZDQH8f8eVgA3ZRk9O4zHUQPh/dJD
         yeCdZOoNInjLcjtdXRrRJfocezC3bwL9M8T+VJBj9wvAo8mTwHoGEsR2c3tnpGQ5vKkr
         YUMA==
X-Gm-Message-State: AOAM531nAuswtSwxREUv9U549d8WqTPbrbcB7/byWriYJx1SKJYxNy8E
        C5XiCZbyZIr/z3NdvRCNHNB5fg==
X-Google-Smtp-Source: ABdhPJzOVu00ZU0TwmAIoVI0f6eQMllaYaWPr850VAglM8s0JUILuRPjAG0K84Sfcu8Qs1SEo2VMNA==
X-Received: by 2002:a17:902:507:: with SMTP id 7mr12495042plf.115.1591990262080;
        Fri, 12 Jun 2020 12:31:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n69sm6966934pjc.25.2020.06.12.12.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:31:01 -0700 (PDT)
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
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/bridge: ti-sn65dsi86: Check the regmap return value when setting a GPIO
Date:   Fri, 12 Jun 2020 12:30:50 -0700
Message-Id: <20200612123003.v2.4.Ia4376fd88cdc6e8f8b43c65548458305f82f1d61@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
References: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti_sn_bridge_gpio_set() got the return value of
regmap_update_bits() but didn't check it.  The function can't return
an error value, but we should at least print a warning if it didn't
work.

This fixes a compiler warning about setting "ret" but not using it.

Fixes: 27ed2b3f22ed ("drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- GPIO %u because it's unsigned.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 1080e4f9df96..bd3eb0a09732 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -999,6 +999,9 @@ static void ti_sn_bridge_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	ret = regmap_update_bits(pdata->regmap, SN_GPIO_IO_REG,
 				 BIT(SN_GPIO_OUTPUT_SHIFT + offset),
 				 val << (SN_GPIO_OUTPUT_SHIFT + offset));
+	if (ret)
+		dev_warn(pdata->dev,
+			 "Failed to set bridge GPIO %u: %d\n", offset, ret);
 }
 
 static int ti_sn_bridge_gpio_direction_input(struct gpio_chip *chip,
-- 
2.27.0.290.gba653c62da-goog

