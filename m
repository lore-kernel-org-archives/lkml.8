Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263222073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1/dDxsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407008AbgAPSYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:24:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37216 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394907AbgAPSXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so20222742wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i+nTHuznqMvTI3dGvU5ZxSOz65Ev7Doc/znM40iHcH0=;
        b=W1/dDxsiZUbkeGBjQ7x4HX/hk/Kz2N1bwsRGaJSrX+feVAXRl8qVmfZVzftpuiEXdS
         QIQQqXJAxwTo6duBATHoMzzNliJpJVMr9O9FdiTSntlS/+IcJNFdRjUGVMY2zez/HN9P
         MFYN2HGKSISKbG8EWU2Kfj55v01wdH5FpTwKtRk3q24sXOQACKvGQqd7TxzmJf/wWsnC
         aNlalyu1NvdI0KsedaqyaJlIuq0By8aMRU05WSIJeDGt8xN4qjjkSCvhPOxsVccOeXYF
         VHtz9SeAff6vqfXUn/NknfISHFXVrELuf1jRqhFaaP2gSpfrZkyhvzTM1GLxR4DL4Ljm
         Lq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i+nTHuznqMvTI3dGvU5ZxSOz65Ev7Doc/znM40iHcH0=;
        b=dDJZEvXbwStFbWTYkXPr7fqMr0u/GExDH2pnTCAms6rbNAe//GfDljIHYd+PyVxeCS
         SAfni7CiNnKeRrb/NUbzKcB/10oCdWtyPJnzgn1d8GZq9mpB/J6GciIVCNyw9KSXCbyM
         lz+OrlMPwX0sq9cTTITHwXoozChhhz+kjdFO7x8nRygzd0VC5xfjmPg+in9fXopysXb1
         iTDNlsa0SagOgnku1GwConz/o+bEMbEc86AUE8IDdz+a2KQVJoeCIxcq9i5h0g0wgL52
         VIrpjIuAFPguWw0ewhMaDQ++LwSeuPZgsesnOCjlGRYQyVLbQ7g2Dnfg1Sljbvwi+2hl
         klYw==
X-Gm-Message-State: APjAAAUGqZXRTiojwTI3f4AD/8Yy5+hNAKiT09zhzlWubJ6/LQr7c6Zq
        0JiMf7ecbD0SCfsnTzTS4Ly2j9VVUOVVoA==
X-Google-Smtp-Source: APXvYqwcA71lWUHCO7dpoC4BFPvrltTJoqpL6f6vaEmcN4Xopw1fcLZ5wGWTTC8fzxosiaiLevWJMg==
X-Received: by 2002:adf:9427:: with SMTP id 36mr4691445wrq.166.1579199020417;
        Thu, 16 Jan 2020 10:23:40 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:39 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 13/17] clocksource/drivers/timer-ti-dm: Fix uninitialized pointer access
Date:   Thu, 16 Jan 2020 19:23:00 +0100
Message-Id: <20200116182304.4926-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

Clean-up commit 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to
platform_get_irq") caused a regression where we now try to access
uninitialized data for timer:

drivers/clocksource/timer-ti-dm.c: In function 'omap_dm_timer_probe':
drivers/clocksource/timer-ti-dm.c:798:13: warning: 'timer' may be used
uninitialized in this function [-Wmaybe-uninitialized]

On boot we now get:

Unable to handle kernel NULL pointer dereference at virtual address
00000004
...
(omap_dm_timer_probe) from [<c061ac7c>] (platform_drv_probe+0x48/0x98)
(platform_drv_probe) from [<c0618c04>] (really_probe+0x1dc/0x348)
(really_probe) from [<c0618ef4>] (driver_probe_device+0x5c/0x160)

Let's fix the issue by moving platform_get_irq to happen after timer has
been allocated.

Fixes: bc83caddf17b ("clocksource/drivers/timer-ti-dm: Switch to platform_get_irq")
Cc: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200106203700.21009-1-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index bd16efb2740b..269a994d6a99 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -795,14 +795,14 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	timer->irq = platform_get_irq(pdev, 0);
-	if (timer->irq < 0)
-		return timer->irq;
-
 	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
 	if (!timer)
 		return  -ENOMEM;
 
+	timer->irq = platform_get_irq(pdev, 0);
+	if (timer->irq < 0)
+		return timer->irq;
+
 	timer->fclk = ERR_PTR(-ENODEV);
 	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
-- 
2.17.1

