Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6439CC38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CAB21D82
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587218974;
	bh=pee3zUleh4ZtCgWyYYLwuFN+JFW53m0iamtGFVqoGCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2HevWB6+CQUw4GbLS+hrm1r/oTX1d6A0lIr15SPdy1HfrPoLqmWzZ9RTDPxPT18H8
	 2ztpquLPiKKQoF1alxRPm74OvhvX/tz6RWSDySop9dj4zko0zIekXulCGf8cedvndO
	 N8XX8VqHawaW2UZ9Pbi3Ofvsg3NpNHZOlRjcPG2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDROJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgDROJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC53A22251;
        Sat, 18 Apr 2020 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218968;
        bh=pee3zUleh4ZtCgWyYYLwuFN+JFW53m0iamtGFVqoGCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jj7ZW4D7XXqWqbLwvO2khoBM21y/WOKXPwyYUeYbdaq7OGlKT8WAkhxzY0DUQEy2
         qidfm27GfxrnDlRVRsl9hrPjO79iZWdqKzh8x0EoCsGYjYcErb5AFKo6i02ZMcEmMB
         6H04mYy1RQJw1g7kHHa5GKSH/60Tnsu74TxAQI5o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 15/75] pwm: rcar: Fix late Runtime PM enablement
Date:   Sat, 18 Apr 2020 10:08:10 -0400
Message-Id: <20200418140910.8280-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 1451a3eed24b5fd6a604683f0b6995e0e7e16c79 ]

Runtime PM should be enabled before calling pwmchip_add(), as PWM users
can appear immediately after the PWM chip has been added.
Likewise, Runtime PM should be disabled after the removal of the PWM
chip.

Fixes: ed6c1476bf7f16d5 ("pwm: Add support for R-Car PWM Timer")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-rcar.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 852eb2347954d..b98ec8847b488 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -228,24 +228,28 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 	rcar_pwm->chip.base = -1;
 	rcar_pwm->chip.npwm = 1;
 
+	pm_runtime_enable(&pdev->dev);
+
 	ret = pwmchip_add(&rcar_pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
+		pm_runtime_disable(&pdev->dev);
 		return ret;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-
 	return 0;
 }
 
 static int rcar_pwm_remove(struct platform_device *pdev)
 {
 	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&rcar_pwm->chip);
 
 	pm_runtime_disable(&pdev->dev);
 
-	return pwmchip_remove(&rcar_pwm->chip);
+	return ret;
 }
 
 static const struct of_device_id rcar_pwm_of_table[] = {
-- 
2.20.1

