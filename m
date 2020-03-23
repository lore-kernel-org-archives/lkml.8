Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8243C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CBE20769
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KY4NTm1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCWJYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:24:49 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39885 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgCWJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:24:48 -0400
Received: by mail-pj1-f66.google.com with SMTP id ck23so5817599pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C3DogahGC9+RykrmX70/1+RE3NkN/OINb0pWKE0oiy4=;
        b=KY4NTm1xU1uLWsixTz3NKCGR6EPu+Z2kNC/ShiFbEjkV+4fQIuniGYnVYTbdlyeB0U
         BRsww8PZH723mNWmelL0ybE4OPO5GnTtHGYMXxwKr41x9UaPBcttTER9W7dzwxYUr0Ma
         HByNd0+RMg8Gk/1IBidHXMtwssmwRJT4EhhT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C3DogahGC9+RykrmX70/1+RE3NkN/OINb0pWKE0oiy4=;
        b=qeGEe+ihAzLLe9Rmw4/b7JGULy16HvPfOxkkPNSyl/81KkSVZuif80+FT5mF7vT2ij
         EdxjbWqGs19Pc37JpQDamZFCWxsfVhBkYyb0yEciIsqR9K+kxgmK/hMnWpYBH4JMaA99
         LurIjycwNuQoDzGGvqlH+cSYrbjHtX05ZZM1OHBx8KxX+cmymhWIg0iobQ7gHq0jJGfJ
         Xd27EDDihVDNKzhYGO5Hjs7Dl6Yd8ILnXsULiKYHlyVX6DE7QM6sF/MT+KdTsdom2Gyn
         EJfZnBVFyezHgedPDCcIqqolSeBjnWy7IRwk4RE46KkO3Axbr7XuMNvBcJEt65DKl7HS
         xINg==
X-Gm-Message-State: ANhLgQ1uRJMwSka1wf9BWN4BV8HRxS8ubyZxNBJI4iJcfFrpIqsQbVwh
        NRBpIrudV5lOBVUPdE6g8mgSBA==
X-Google-Smtp-Source: ADFU+vu3dwbnOc73Ub2kUbNVRr9hWwQpUgSWBw+ncuy5m5W1glqsH76QRsrnl5u0v4Ym8D/QV0KS2A==
X-Received: by 2002:a17:90a:9742:: with SMTP id i2mr2863545pjw.194.1584955488035;
        Mon, 23 Mar 2020 02:24:48 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t186sm1093068pgd.43.2020.03.23.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 02:24:47 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 1/2] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Mon, 23 Mar 2020 14:54:23 +0530
Message-Id: <20200323092424.22664-2-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
References: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle clk_get_rate() returning <= 0 condition to avoid
possible division by zero.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/pwm/pwm-bcm-iproc.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee7..8bbd2a04fead 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -99,19 +99,25 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		state->polarity = PWM_POLARITY_INVERSED;
 
-	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
-	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
-	prescale &= IPROC_PWM_PRESCALE_MAX;
-
-	multi = NSEC_PER_SEC * (prescale + 1);
-
-	value = readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
-	tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
-	state->period = div64_u64(tmp, rate);
-
-	value = readl(ip->base + IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
-	tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
-	state->duty_cycle = div64_u64(tmp, rate);
+	if (rate == 0) {
+		state->period = 0;
+		state->duty_cycle = 0;
+	} else {
+		value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
+		prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
+		prescale &= IPROC_PWM_PRESCALE_MAX;
+
+		multi = NSEC_PER_SEC * (prescale + 1);
+
+		value = readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
+		tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
+		state->period = div64_u64(tmp, rate);
+
+		value = readl(ip->base +
+			      IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
+		tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
+		state->duty_cycle = div64_u64(tmp, rate);
+	}
 }
 
 static int iproc_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.17.1

