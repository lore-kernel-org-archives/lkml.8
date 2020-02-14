Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3A4C3B1AB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7122168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701030;
	bh=/U5JltyEb1Fb0bMb6W9s0AGoY9F2uBjpcwC4EVYcpWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fcp3DrbVR2FUUAcXqNLcHMPfbnnkEIWgvAEhLp0FzgRn24/1/kCvrwHIMfTXLa7uK
	 o+Qy6ox3zxRDhqOCxX9suZX0ekwPcFQ40c88ACZbdB4mZ2YOJKhIpLKQcAgOrM4Oz1
	 0qQ9Jpy8vzM/h+t/BXCN8Dyk0ORYgLMH6FLXf9Vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391445AbgBNRXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391256AbgBNQJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8F1222C2;
        Fri, 14 Feb 2020 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696562;
        bh=/U5JltyEb1Fb0bMb6W9s0AGoY9F2uBjpcwC4EVYcpWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9F2zsUl3tGC44yVIVj7jZgDSy27XASVd7k5o+FWZwQjZgj5ifzZHVeNLVFCUIThv
         BDASRXizI8Ymj/pPBOanGTJR+AVarL7u01kAWjrFPDDI310uLINPxFeVfZiU+u70GY
         CZfJDInNnIWmUOrNzGVTRR0G54wwsTtcADkw3cwU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 353/459] pwm: omap-dmtimer: Remove PWM chip in .remove before making it unfunctional
Date:   Fri, 14 Feb 2020 11:00:03 -0500
Message-Id: <20200214160149.11681-353-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 43efdc8f0e6d7088ec61bd55a73bf853f002d043 ]

In the old code (e.g.) mutex_destroy() was called before
pwmchip_remove(). Between these two calls it is possible that a PWM
callback is used which tries to grab the mutex.

Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-omap-dmtimer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 6cfeb0e1cc679..e36fcad668a68 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -361,6 +361,11 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
 {
 	struct pwm_omap_dmtimer_chip *omap = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&omap->chip);
+	if (ret)
+		return ret;
 
 	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
 		omap->pdata->stop(omap->dm_timer);
@@ -369,7 +374,7 @@ static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
 
 	mutex_destroy(&omap->mutex);
 
-	return pwmchip_remove(&omap->chip);
+	return 0;
 }
 
 static const struct of_device_id pwm_omap_dmtimer_of_match[] = {
-- 
2.20.1

