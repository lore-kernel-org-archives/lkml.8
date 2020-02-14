Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BCC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CDE2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698663;
	bh=OjlB9AVcPer6GvN/IsZeDID4gRoeRc0i8+HUSWT00wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZF+3eeRPj5VRr5Fs5FpzshP+X51jzoAD2Q7ecP5u0nFiUWqihb1e7+3e4AVNOzv10
	 8XYWriFt9lfmZkRUbidjy1anBxpZ4aWapeBiMwz1677ImJlZlVQffPvkxSMFHUdkF1
	 mV2TD3TiJLClSJRsiruXmDIdQhUoELIhIn/tSUH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393042AbgBNQVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404796AbgBNQUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:20:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFB282473A;
        Fri, 14 Feb 2020 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697214;
        bh=OjlB9AVcPer6GvN/IsZeDID4gRoeRc0i8+HUSWT00wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwKKq5qeAXoMKrX2OlDi/7/7ZA9VXmbP6GpFNgdUc3DjpRUVUHSpjWOSWiGOwM7P1
         Jsbc07QsxkrtQM0SvHwidiB9UfW1883hukIPgeZ8VQHyvcPS19LDQtiaIgMguXhCc6
         RFsQXEBwqkyLYnt3F3EGmG2b6jzzWzS9jx1QpeDE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 139/186] pwm: omap-dmtimer: Remove PWM chip in .remove before making it unfunctional
Date:   Fri, 14 Feb 2020 11:16:28 -0500
Message-Id: <20200214161715.18113-139-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
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
index 5ad42f33e70c1..2e15acf13893d 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -337,6 +337,11 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
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
@@ -345,7 +350,7 @@ static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
 
 	mutex_destroy(&omap->mutex);
 
-	return pwmchip_remove(&omap->chip);
+	return 0;
 }
 
 static const struct of_device_id pwm_omap_dmtimer_of_match[] = {
-- 
2.20.1

