Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38821C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161E02051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9WWSq4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436603AbgAPSXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:23:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36532 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436574AbgAPSXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so20192892wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eCk7taMYXig6QizdE0ghBnmwbeYgntkLTmTbCbBGnrs=;
        b=B9WWSq4LTVYf6zF5jzq5uyWVUAK2V3uajkBTuMbS1oN2jzIhmuiXYafd5tzbPIU4TM
         V+3ADCAHaX1n2r5Q11vZ1WczevgqPDKfoO+5mVOxCobqoOe6RzSXLhTmfUcGzFczTiEZ
         GRhPzr7keETxMCzyOTEQ+OA/rleCBkwemUHK9XVVxomPE0q9TQZfJlqihM6fsk7YAgxh
         kE2btgEFuMhHXMvCSA9ke1OJt8+8Da1Yang+wofVehgz+qzUjRV568722abNvpH6z3mk
         t5W/QXnVJVfsSOnDm3KW6E9X5c9wCsROm1cbBnr+NuBfQKw5REHIWMecjYZZiK6UHWC6
         SkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eCk7taMYXig6QizdE0ghBnmwbeYgntkLTmTbCbBGnrs=;
        b=UOuW6LfFAQg1EFZ1K0YkRGa6WjPgcVXLgx+xtoWzv9C2Hv7A0USlYTo8GdrBDTzN4A
         s+RsbAgmzmtL72oGvz5xUpImWLDRWmT0TZ20EYBMdeDl2XDp4dfSGW0V+Eal/Iqat0HH
         X+ZeA9eruK+RcYkGVweNvHE63+r3JV1Ac+NMK7bx/AzkOIGlGzL1KOkQdlxxjcQr4+9w
         amXRvEmdQdt3xP2hQ5uo/bBMmcn8Yr6MqG2x6x6xYDltKXGo5mJRog09HaomSRWJHha8
         EcYw9WJC91PzhXJl9eHbqqXQ3TylK3YIS29mg6g2R84ctXlXTlky7U+1e6Dij8l1R0ms
         C2Kw==
X-Gm-Message-State: APjAAAUw3TCN2yrxEEBn1Ssjl4vL4kF4gVJKlfZY3PfsEaLMwfeygkSU
        FdKZYsoZHiB1pdmlQpaTUYT8+Q==
X-Google-Smtp-Source: APXvYqxifH7932pswP5qEFtVYz5zCbLefcreY49Vr0JANd+tsAuHPXaSc6lQcRTaP1xzh1umz15l0g==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr4468338wrm.24.1579199017651;
        Thu, 16 Jan 2020 10:23:37 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 11/17] clocksource/drivers/timer-ti-dm: Convert to devm_platform_ioremap_resource
Date:   Thu, 16 Jan 2020 19:22:58 +0100
Message-Id: <20200116182304.4926-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use devm_platform_ioremap_resource() to simplify code, which
wraps 'platform_get_resource' and 'devm_ioremap_resource' in a
single helper.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191221173027.30716-4-tiny.windzz@gmail.com
---
 drivers/clocksource/timer-ti-dm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 5394d9dbdfbc..aa2ede266edf 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -780,7 +780,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
 	struct omap_dm_timer *timer;
-	struct resource *mem, *irq;
+	struct resource *irq;
 	struct device *dev = &pdev->dev;
 	const struct dmtimer_platform_data *pdata;
 	int ret;
@@ -802,18 +802,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!mem)) {
-		dev_err(dev, "%s: no memory resource.\n", __func__);
-		return -ENODEV;
-	}
-
 	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
 	if (!timer)
 		return  -ENOMEM;
 
 	timer->fclk = ERR_PTR(-ENODEV);
-	timer->io_base = devm_ioremap_resource(dev, mem);
+	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
 
-- 
2.17.1

