Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B67C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BF522B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453447;
	bh=mLmHNNYAulsYIvuCLX3SOGim/VZfkqUsFtnN2e6UEk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SEyk9EgeHwUdS2vKcuhyktNa8XQ5acU6EFtbULAEqTGBnW89KSbadCrOouSziSUfU
	 2Ik3VwNvlQ0awjop2nLwBbSPJqEVLbPxrXXt9IjwG0OrFbNcAPS3Z3Cb9Ln9E/SYO3
	 c0SYIPQMMQhbBGZmadZ6UZYSGQojfIylXAfiy0oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgHZOun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbgHZOuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:50:21 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099F9221E2;
        Wed, 26 Aug 2020 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453421;
        bh=mLmHNNYAulsYIvuCLX3SOGim/VZfkqUsFtnN2e6UEk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2tN+CuPDaLD5qDm5Q7BEHLs124HFQ/2J81VX1LnwKl/ANWHd1JTLjgu5oJgFgrQiI
         3vsFRpkyBJWVSu5r1i5yIXYMebESESMyDHoWyghcbH+LxEuV4NnkT21fPVKTvMGcmz
         komlFQndmkPvafLK+a4dkWaLmE0USGNmeKLQif3w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/4] leds: pwm: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:50:11 +0200
Message-Id: <20200826145013.10230-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826145013.10230-1-krzk@kernel.org>
References: <20200826145013.10230-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/leds-pwm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index ef7b91bd2064..e35a97c1d828 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -78,13 +78,10 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		led_data->pwm = devm_fwnode_pwm_get(dev, fwnode, NULL);
 	else
 		led_data->pwm = devm_pwm_get(dev, led->name);
-	if (IS_ERR(led_data->pwm)) {
-		ret = PTR_ERR(led_data->pwm);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "unable to request PWM for %s: %d\n",
-				led->name, ret);
-		return ret;
-	}
+	if (IS_ERR(led_data->pwm))
+		return dev_err_probe(dev, PTR_ERR(led_data->pwm),
+				     "unable to request PWM for %s\n",
+				     led->name);
 
 	led_data->cdev.brightness_set_blocking = led_pwm_set;
 
-- 
2.17.1

