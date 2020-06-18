Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E946422206
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445197;
	bh=/6TaqL/dS4z6Z66mGklGxkbdqDZPZ7/nTUQv+UC+Plc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bzj14ZH//UEJZY4eC53/W9Hfe4o5gKgUreWMkRMuSaB+gsPnaWZ3OdKfOL/6EJT7Z
	 /E5suH2samwBsxh4N5MOyBUan9F+qc9Csy7D6iLTAV5voBQ4oeAVHlo3nSDrQsRBpS
	 4ROwCj1HY5nD+/lPRDM12Er6rxQpO30kQVrgSpkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgFRB0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730926AbgFRBXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:23:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDDC20FC3;
        Thu, 18 Jun 2020 01:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443389;
        bh=/6TaqL/dS4z6Z66mGklGxkbdqDZPZ7/nTUQv+UC+Plc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGBL/XuKDngcFtnGW3xgSzLXGWFwoEDVzylprCq1laz60dhtndPXJLWPB0o+JEaV2
         bW5TnVZPgiZPq9xorkSru9XE0HEtPKspZ/7rXgFC3FPibUwS7WZ+A7/WUhkzGL/c3o
         FwYfNZrY7W54XUgyCmj6VOR0ewcNsdw5BVcKlwxM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 039/172] pwm: img: Call pm_runtime_put() in pm_runtime_get_sync() failed case
Date:   Wed, 17 Jun 2020 21:20:05 -0400
Message-Id: <20200618012218.607130-39-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit ca162ce98110b98e7d97b7157328d34dcfdd40a9 ]

Even in failed case of pm_runtime_get_sync(), the usage_count is
incremented. In order to keep the usage_count with correct value call
appropriate pm_runtime_put().

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-img.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 815f5333bb8f..da72b2866e88 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -132,8 +132,10 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = DIV_ROUND_UP(timebase * duty_ns, period_ns);
 
 	ret = pm_runtime_get_sync(chip->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(chip->dev);
 		return ret;
+	}
 
 	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
 	val &= ~(PWM_CTRL_CFG_DIV_MASK << PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));
@@ -334,8 +336,10 @@ static int img_pwm_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(&pdev->dev);
 		return ret;
+	}
 
 	for (i = 0; i < pwm_chip->chip.npwm; i++) {
 		val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
-- 
2.25.1

