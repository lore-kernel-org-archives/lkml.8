Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9DFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91F420759
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NpK8ZB0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGQSZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGQSZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:25:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99A9C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:25:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so7054864pgv.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gfp8TD0TK5ywr5xVIQqXt4UYUBwsLiLq5aLmh/fWgMc=;
        b=NpK8ZB0bdMbxWzl/pq5VT8a0z5qKaNdaPRH3iPx1izQuG7KZYGuCrOn0OChRrsqiBj
         NkTGh1GSEJ6LAqS6Kc82gI4caz6SMeMYuVQ8L9dOG5PC13mv2aKQCsu8jcR57u5f2VS/
         xm6sLguFQeBqRolXBBSzNxA/YEcTdC6Qv9iUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gfp8TD0TK5ywr5xVIQqXt4UYUBwsLiLq5aLmh/fWgMc=;
        b=R4FkrwHJxP0WhnwqN+RnurtZDAEQgaLGu6wloYiDzJophzZSBI5sUcn2AUY/KISnH5
         azKSqA8t6rg4mi3KrIefj/At8zsveBMqwabWZX/5Fo5NLqJgFlXspSvND/IO6HUcg7mC
         Tx4zFygYE5B2NWumBaUyEZXVsDVPW7SWpGPqFG6cfoUFsjmhvLdWsqunTvgnU6yxR7bh
         JJjYWeRnZV3DDF7oWnuwzRtLGszkDB9jUc0Vt1zCK+6QKNoS9cJHa7TfECZNJCk1rlFE
         Qd4Hst6+jcVJZJgDnAnx4UtQVJVgiTQsK3RkaKlBbcjngarv9IU0feBVcXhfpTI7yAvE
         a5Fg==
X-Gm-Message-State: AOAM5316MqTu6iKs92D1oIAeLZxcSyJlNiV8eFvFbzZWGP8CIuEla48v
        WjzK/TK1bMd2U4phkNvGTDnEoA==
X-Google-Smtp-Source: ABdhPJwZQAZQ+VC4KmggFqf57W1uimgfpchQ5C/usQb8ZksJ+7N3YyoL1HAWPxDbNvBojkwQlzbILQ==
X-Received: by 2002:aa7:9e0e:: with SMTP id y14mr8590826pfq.77.1595010327276;
        Fri, 17 Jul 2020 11:25:27 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x8sm8374708pfn.61.2020.07.17.11.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:25:26 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Fri, 17 Jul 2020 11:25:12 -0700
Message-Id: <20200717182512.26001-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Handle clk_get_rate() returning <= 0 condition to avoid
possible division by zero.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>

---
Changes from v1: ensure  'polarity' and 'enabled' are populated
when clk_get_rate is 0.
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

