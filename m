Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7E5C5ACD8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D13D20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxyZXQhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgCRRmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36925 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCRRmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id d1so2803884wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qsR7gCPerLFj/rwuR5af6ygkPhYgchFJ6z6vr/ZLsBs=;
        b=PxyZXQhzcjOOqa8CKNmnioxbv4c/etoPBUZyaaMTj4/AFkwo3sM/PtmaLKjp+mPtvg
         z1tqrxzB4JvRh2rOSbp/c/tMLpl/rW3dfZcYrNcRFm4tvLcXZl3k0MLxhgxNt8Mdn/Dk
         QbzIhiGAHqGsk98xtnJBJdbKcway1UxrNK6PuMy+S+OmMgznuv4XZtgaqyrfi3fUDg6R
         rD6wu6aYZ5hUgtxFSttJPT6SA6wg7H6etMvlyuBjIN5iR3BceznlcjfDRLIecU602ALi
         4yw8VM6ixqiDxBdoH1VZFwIke2Ec51/7s5nuniUK1CbfFb4OR6qeH717qpHavMy5Q2S4
         dHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qsR7gCPerLFj/rwuR5af6ygkPhYgchFJ6z6vr/ZLsBs=;
        b=XZrz2jTqPMxX9yKDMiveQ7utNQ63lBILHaw++NfXZNqbl9MB8YQrTjJmx/+M1LPsxj
         pDapJytlxdeCn0VCOgq7+tgOTddXs7RZxixDcjaq6i31CFd1MdtP3pTwuSyNTdgt7exr
         2sDK8bExK5LyXjhR9YIHpyUghLoX/uYDjoGvRihYc6RHydZObl/1JQ/aiNmFZaPtfbzj
         esnFRVWUz3mDEPVZt+8OE7GDV2Hiq4KGhil0XUvi0rp0kCPGGf6BvBwQo2kyosPVOFLo
         ipH3Kern019Tzt0ji8BszopYYPAnop21UMpyddOW7BG9cek/cSWjv7ZPdHv15VNKGqgi
         hrOw==
X-Gm-Message-State: ANhLgQ2rJ3p9Plz7X7H+U7fxbempENu1RBaIINLT8zyjc/C/XEKqu+xp
        R24kzV2E++Cny0AyggPXiJyxOg==
X-Google-Smtp-Source: ADFU+vtot4Gh01+VjYTQdsCBVHbKcBElcIQOsnWsa/9/9eQ4rTIJEHiTKDmZcYFen7sjE+Yt/FIgkA==
X-Received: by 2002:a1c:3585:: with SMTP id c127mr6282038wma.124.1584553351192;
        Wed, 18 Mar 2020 10:42:31 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 07/21] clocksource/drivers/timer-ti-dm: Drop bogus omap_dm_timer_of_set_source()
Date:   Wed, 18 Mar 2020 18:41:17 +0100
Message-Id: <20200318174131.20582-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The function omap_dm_timer_of_set_source() was originally added in
commit 31a7448f4fa8a ("ARM: OMAP: dmtimer: Add clock source from DT"),
and is designed to set a clock source from DT using the clocks property
of a timer node. This design choice is okay for clk provider nodes but
otherwise is a bad design as typically the clocks property is used to
specify the functional clocks for a device, and not its parents.

The timer nodes now all define a timer functional clock after the
conversion to ti-sysc and the new clkctrl layout, and this results
in an attempt to set the same functional clock as its parent when a
consumer driver attempts to acquire any of these timers in the
omap_dm_timer_prepare() function. This was masked and worked around
in commit 983a5a43ec25 ("clocksource: timer-ti-dm: Fix pwm dmtimer
usage of fck reparenting"). Fix all of this by simply dropping the
entire function.

Any DT configuration of clock sources should be achieved using
assigned-clocks and assigned-clock-parents properties provided
by the Common Clock Framework.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200213053504.22638-1-s-anna@ti.com
---
 drivers/clocksource/timer-ti-dm.c | 33 +------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index acc93600d351..6a0adb7104b3 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -138,35 +138,6 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	return 0;
 }
 
-static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
-{
-	int ret;
-	struct clk *parent;
-
-	/*
-	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
-	 * do not call clk_get() for these devices.
-	 */
-	if (!timer->fclk)
-		return -ENODEV;
-
-	parent = clk_get(&timer->pdev->dev, NULL);
-	if (IS_ERR(parent))
-		return -ENODEV;
-
-	/* Bail out if both clocks point to fck */
-	if (clk_is_match(parent, timer->fclk))
-		return 0;
-
-	ret = clk_set_parent(timer->fclk, parent);
-	if (ret < 0)
-		pr_err("%s: failed to set parent\n", __func__);
-
-	clk_put(parent);
-
-	return ret;
-}
-
 static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret;
@@ -276,9 +247,7 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	__omap_dm_timer_enable_posted(timer);
 	omap_dm_timer_disable(timer);
 
-	rc = omap_dm_timer_of_set_source(timer);
-	if (rc == -ENODEV)
-		return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+	rc = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
 	return rc;
 }
-- 
2.17.1

