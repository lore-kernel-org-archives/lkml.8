Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA89C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E7D2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMnbr0CX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436622AbgAPSYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:24:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43895 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395566AbgAPSXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so20183644wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6GzX84NfDDLTeIA6gc1l7fXC6tihOLThsT86UiBLkGc=;
        b=PMnbr0CXM4L39OIkLBv9NNcZmMeCur9LJbC9xdfDIFRLBFdhoummuP6RcyD97FN+xy
         +rqcfydCyWRKx7GGU+vH52bQtqHrg80kf/PY1Xykkjz/DrtM/AJWGKoIfKYOZtWrWd2r
         xZnJXDmoeqRcI93oSanvn1TnmsZtk67I5J0ZNiwTx+Xq/VDHx7HYduR5GQO+Zz+CQgW0
         c/CvIfAYTU63cAEodPi6ZgY4VbBUL7vokyBTotbHy4dtNaU7Dtf8kh7dOzMrTUFwKJP2
         7wChtsPoT9zdaeczEsys5XhEZ2meyBzgExwZoJr7C4FjL+HEnzstlAo396Dq9eAHSJXk
         Xvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6GzX84NfDDLTeIA6gc1l7fXC6tihOLThsT86UiBLkGc=;
        b=o4VcS6IYni/jtD4oV71gqRix3NQjcLuxytZ8GnBQ1k697WBQ8CpxYP8CkMdmsXOtwE
         sRnBMQMAJkVpugO3VvXjAgCjIfqmHmBkfZHo3Zm0Jbjl/kNPBP2/CrUZdNHiBdzc9Vph
         f/WdMsoV1ybXuJFttBwGq62T/lEZOraFnQ4+RXWR9tPGJeuc1gHM2c4rIt//1rj9U5VL
         oBNK5hzj6CtUOLP4PT6ByMVXPDj24FWHV3ncExUNDNnnE9Jfcsy+NyyozMlIObhwSfOH
         bITznS5YWcUqjQrYs18XqHFPDHOtELP1B/wO40QyeOXrZaCSM/kNnRUv9EiByJ2vewZn
         v6iQ==
X-Gm-Message-State: APjAAAVm/f5b/BhFVfS7lQtcVPCcHmJ5ogjpxhrVsnYFJdbH+0OqbKeG
        ILWqFDLABWZ4WDowYwQh6ykA/vVKGPUgpw==
X-Google-Smtp-Source: APXvYqwauPPd4aLhBDp5MlnHSV754ZND+e0We5OC6l83FAVvtluvfuHGtG9xSa6ZuKF4/wTrB5V3vg==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr4510386wro.209.1579199018983;
        Thu, 16 Jan 2020 10:23:38 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:38 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 12/17] clocksource/drivers/timer-ti-dm: Switch to platform_get_irq
Date:   Thu, 16 Jan 2020 19:22:59 +0100
Message-Id: <20200116182304.4926-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

platform_get_resource(pdev, IORESOURCE_IRQ) is not recommended for
requesting IRQ's resources, as they can be not ready yet. Using
platform_get_irq() instead is preferred for getting IRQ even if it
was not retrieved earlier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191221173027.30716-5-tiny.windzz@gmail.com
---
 drivers/clocksource/timer-ti-dm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index aa2ede266edf..bd16efb2740b 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -780,7 +780,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
 	struct omap_dm_timer *timer;
-	struct resource *irq;
 	struct device *dev = &pdev->dev;
 	const struct dmtimer_platform_data *pdata;
 	int ret;
@@ -796,11 +795,9 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(!irq)) {
-		dev_err(dev, "%s: no IRQ resource.\n", __func__);
-		return -ENODEV;
-	}
+	timer->irq = platform_get_irq(pdev, 0);
+	if (timer->irq < 0)
+		return timer->irq;
 
 	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
 	if (!timer)
@@ -830,7 +827,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	if (pdata)
 		timer->errata = pdata->timer_errata;
 
-	timer->irq = irq->start;
 	timer->pdev = pdev;
 
 	pm_runtime_enable(dev);
-- 
2.17.1

