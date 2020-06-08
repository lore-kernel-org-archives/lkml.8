Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6905BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BA72086A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZL/xMo+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgFHRtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbgFHRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:49:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F8AC08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 10:49:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n2so6923945pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIwI7n7N4VQPufeFuOMvSL/7+RKCUZGC7cYkecAGvXw=;
        b=ZL/xMo+emwIGJJDYKlUTWBSUaZLy53IDoh4ECTHldAYzsEhYULXTfHE17Ihg5yS9s/
         GknxH8a1g7MMdbLIncWs0UnD5Gyu0da/rncun2hoJCW3QuwBCypNjBMBCWjKXEjxQnKY
         1Ua9dWh3ALilAaZBwqBXOw+Ql0STZFO8QKaB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIwI7n7N4VQPufeFuOMvSL/7+RKCUZGC7cYkecAGvXw=;
        b=J2ed5RFfZWlvmx5S1D0WDGEtIdD7ZA57YnMek8wnc5lWYySneC7qRvJsRFgVEbYryT
         g+QxdlPKJHGKgvLjs0aaEcRZwJc6CDXdkvDodLiYZhGHzAKVy8Y1Byd3n9trCtHRyjlA
         Xx3eikisue606JSiauCauLFf34V3Om4FpDdI+D/6oad0GaUsNHgZhLpL0vMLNNOFvaBj
         HAbNSlTrVsumE2UUpZoO4QeUasfgr2hMoKywzPBFmQ/eN0r5Hi5AuYkwI4rpKvwgSMAH
         JYfXxoEpkZZ4h9J9EFH2iFSD3/X89PMRam9ZBLA2RserT9JtfwZ1cirgQdW0WrSAsoyT
         pCxw==
X-Gm-Message-State: AOAM530Ynib2pedDXtCwaj53XMskjXapo+iPD1TsiTkgDkFIO13jQ0Tr
        3OGCzA9mFCLOB+LGfYVcjrBv5A==
X-Google-Smtp-Source: ABdhPJzg/YUFjJB0n58ZSRa8E0eiVaoklc/4+kOj1C57x3OTuyE0OCpKhKcw+Hm/Y+pNC49YSXIRyw==
X-Received: by 2002:a17:90a:9f81:: with SMTP id o1mr431427pjp.139.1591638539924;
        Mon, 08 Jun 2020 10:48:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n7sm162682pjq.22.2020.06.08.10.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:48:59 -0700 (PDT)
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
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/bridge: ti-sn65dsi86: Check the regmap return value when setting a GPIO
Date:   Mon,  8 Jun 2020 10:48:35 -0700
Message-Id: <20200608104832.4.Ia4376fd88cdc6e8f8b43c65548458305f82f1d61@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
References: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
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

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 1080e4f9df96..526add27dc03 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -999,6 +999,9 @@ static void ti_sn_bridge_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	ret = regmap_update_bits(pdata->regmap, SN_GPIO_IO_REG,
 				 BIT(SN_GPIO_OUTPUT_SHIFT + offset),
 				 val << (SN_GPIO_OUTPUT_SHIFT + offset));
+	if (ret)
+		dev_warn(pdata->dev,
+			 "Failed to set bridge GPIO %d: %d\n", offset, ret);
 }
 
 static int ti_sn_bridge_gpio_direction_input(struct gpio_chip *chip,
-- 
2.27.0.278.ge193c7cf3a9-goog

