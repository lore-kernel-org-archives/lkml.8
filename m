Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A248CC38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753F521D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221211;
	bh=gvckD+08zbGS7Exmtd6V1EEAPXF8knBKNzJ+PEUIKx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z6xuRONL8jBQ4FFxmG5w7T4XEn3mrh0QHJB34sbJ1n0qI8k+Ocf4WqRpTvxowEmE1
	 cOgafIkhy8ZFkl+9VeBF+OO7Z6u51RtleS1Hb+pL848lDHFzsJSlsj7RJYxOYEsVoL
	 NVYLp+BEFC3VkCN6lveQTwuB0eBNfYa3u33EFAuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgDROqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbgDROoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:44:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6F521D7E;
        Sat, 18 Apr 2020 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221064;
        bh=gvckD+08zbGS7Exmtd6V1EEAPXF8knBKNzJ+PEUIKx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/eKKVD2zP8DXUGbQ3jo0FAmjBz+HfVDqhDTdyaoitqojKiecTV1gL9qXK4E1qU6m
         73bemNz9Lw2+HRwYY7rJ7ZI8DU/qJBTQm2Hvjg0OAlWkE8pVXzwEOG8Z8HqFG9w+qT
         KsieMVnOMXgPQfihJAvzitvmxiST4WHCrLx6nLKo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 14/23] pwm: renesas-tpu: Fix late Runtime PM enablement
Date:   Sat, 18 Apr 2020 10:43:56 -0400
Message-Id: <20200418144405.10565-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144405.10565-1-sashal@kernel.org>
References: <20200418144405.10565-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit d5a3c7a4536e1329a758e14340efd0e65252bd3d ]

Runtime PM should be enabled before calling pwmchip_add(), as PWM users
can appear immediately after the PWM chip has been added.
Likewise, Runtime PM should always be disabled after the removal of the
PWM chip, even if the latter failed.

Fixes: 99b82abb0a35b073 ("pwm: Add Renesas TPU PWM driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-renesas-tpu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 075c1a764ba29..6247a956cc089 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -423,16 +423,17 @@ static int tpu_probe(struct platform_device *pdev)
 	tpu->chip.base = -1;
 	tpu->chip.npwm = TPU_CHANNEL_MAX;
 
+	pm_runtime_enable(&pdev->dev);
+
 	ret = pwmchip_add(&tpu->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip\n");
+		pm_runtime_disable(&pdev->dev);
 		return ret;
 	}
 
 	dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
 
-	pm_runtime_enable(&pdev->dev);
-
 	return 0;
 }
 
@@ -442,12 +443,10 @@ static int tpu_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pwmchip_remove(&tpu->chip);
-	if (ret)
-		return ret;
 
 	pm_runtime_disable(&pdev->dev);
 
-	return 0;
+	return ret;
 }
 
 #ifdef CONFIG_OF
-- 
2.20.1

