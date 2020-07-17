Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6FAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF6520768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OnhsRGNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGQXUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgGQXUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:20:05 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6DEC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:20:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so12558116ejq.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IVJhKu+Gp3LFHGjQOw8PatWF56LYveANRBsfi3RUZ5Q=;
        b=OnhsRGNmVZDhGNNrNKkJ3qUL/Z4HPDbWsDxx1SWXQzR0Adyl8HZKMHTorIIGW9B+NP
         GdFUuANZ60TLcSe9p19DsazMK4Ni1GrYFMOzG36v/rMXPO5xErDoodh2uKDk56EXPbOF
         Cu9zDXABX/VVZxE2IOk+Wllt3voMXXqKHXhXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IVJhKu+Gp3LFHGjQOw8PatWF56LYveANRBsfi3RUZ5Q=;
        b=dNWGOF3SiTvhu0t7hIcYkaSZ2ykVtFZcPmHOd9AWp93HAbqDHxhz9n9Jz7P169iLPW
         qsnnaFY9nJlohALmcM0MqdiK6hcfNPAlYCQgv8XRiIxqaI1qBy/rTXZJE/CORmaQsF5h
         FxW6cdNjRZFNn6KV8Q42CE9toPNDBOeRHYTQZJQvIW3rNDGpdBW6gKVV/3VMjahMikSN
         HBqOIQpMed9UXO7YfK+yUetIHALRKyKmq1/Cntgt1/qFOYbqFbKfBbQLynmvH31WAd7j
         wk9qj2uw1den4/ikbTUCX82Q+pXSo3n5gLkka2CwRPaWg49Sll8/+errgvUXRfJhVToS
         z/LA==
X-Gm-Message-State: AOAM532IBOxrCwXSYSgv4kL+fvSOn2CTRmoHJLqugS2vm/NvIZbbC64q
        1chdu5GuxLnTIv9WZR0CHYKX8A==
X-Google-Smtp-Source: ABdhPJwdBaBHYKfugz8zuvk0G6zHnB4TwuV69YU6wyOAEVVWulh+am5y0KaMTj8EfN6DKOnSFcXEDQ==
X-Received: by 2002:a17:906:fcba:: with SMTP id qw26mr10599993ejb.112.1595028003947;
        Fri, 17 Jul 2020 16:20:03 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v11sm9074093eja.113.2020.07.17.16.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 16:20:03 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v3] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Fri, 17 Jul 2020 16:19:54 -0700
Message-Id: <20200717231954.11695-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Handle clk_get_rate() returning 0 to avoid possible division by zero.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-off-by: Ray Jui <ray.jui@broadcom.com>

---
Changes from v2: update commit message to remove <= condition
as clk_get_rate only returns value >= 0
---
 drivers/pwm/pwm-bcm-iproc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee7..d392a828fc49 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -85,8 +85,6 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 tmp, multi, rate;
 	u32 value, prescale;
 
-	rate = clk_get_rate(ip->clk);
-
 	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
 
 	if (value & BIT(IPROC_PWM_CTRL_EN_SHIFT(pwm->hwpwm)))
@@ -99,6 +97,13 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		state->polarity = PWM_POLARITY_INVERSED;
 
+	rate = clk_get_rate(ip->clk);
+	if (rate == 0) {
+		state->period = 0;
+		state->duty_cycle = 0;
+		return;
+	}
+
 	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
 	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
 	prescale &= IPROC_PWM_PRESCALE_MAX;
-- 
2.17.1

