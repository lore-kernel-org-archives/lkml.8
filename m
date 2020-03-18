Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E954C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BF920719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bV1afJRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCRRnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:43:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36919 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCRRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:43:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so2690845wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RPBluncXQIWPnGBdRS69VNGN+mjRz62XX0FwdIVRJGo=;
        b=bV1afJRfEWBAvDKHHIdzCg08humn2A9QyEQzaN2a4oJwuDlU843EAB5c/RMISTT8ET
         hZNaWdcjXV97b+BIVKntlcVaezRiy1Bdgp2MF40U1KpvAb/musUg+5w8BAs+8qV+bvEj
         2UGy/qrquLtc7S6qm2z3U5mz/n6jA27U7Zn6yAnv4JsNM8AzkEsc/x0TmzFMts9RiwQS
         qadd8Q/7iZ/MK2IEcC4D+GvRaMiPwwEkuBB7lChznHHK5sj5Y08Tkw3dDohWT8uBwkFv
         vyKqzkUXT4TpBnhbL2/O8Uc/G+HE8pOT7G7VgrGqm/nfU26Py+U7mFTsrwypUvEin1Vd
         M4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RPBluncXQIWPnGBdRS69VNGN+mjRz62XX0FwdIVRJGo=;
        b=gzotR51N+M6L1c3lhtcVoIk/Pj29RNauDrCeNqMCc3weB6pgDgdRbQ/AaSnvji1WPX
         /hKYBTQa4yQ0QRzhTsUTuoTCfXBZYQKw7Tqq/wUCaVxYE+RMCiBYqx7eRciKdGfXoaXn
         OysDqfDa3FoPiZNtUcyYZUxSXA1KIuo5zYigJDfVwhg3mtpC+5BhaRFrjQRSH1afAWWh
         yBBpQ0+ZoUejg3SsDmxYwth3OJKf3cno4MZD+d77TFvFBwuo7ZuVn95Q3Lc406dZuGMX
         QLMhD7eTTi0c+y9hklfxLf6TKT53ra5dWgC1CzfWr1BSQRUlPj1k+tXawoDAdSmE5/q1
         ZTmw==
X-Gm-Message-State: ANhLgQ25RF/T56rzATu/TKkpBTEQzthzw4ipYhkIvRGxxYmLXfutHq8u
        dNHBcnrEEkfjIlAI7PsFa/ElyvFXkYc=
X-Google-Smtp-Source: ADFU+vtcfU8Nol30ROsV9ESTyFqrWAIN6mFjf6+KKzJslwwXJLZG4CcBLD6QUv7rhzp2n64REES+Ng==
X-Received: by 2002:adf:fc8c:: with SMTP id g12mr7014813wrr.277.1584553382956;
        Wed, 18 Mar 2020 10:43:02 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:43:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM)
Subject: [PATCH 18/21] clocksource/drivers/timer-ti-dm: Enable autoreload in set_pwm
Date:   Wed, 18 Mar 2020 18:41:28 +0100
Message-Id: <20200318174131.20582-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

dm timer ops set_load() api allows to configure the load value and to
set the auto reload feature. But auto reload feature is independent of
load value and should be part of configuring pwm. This way pwm can be
disabled by disabling auto reload feature using set_pwm() so that the
current pwm cycle will be completed. Else pwm disabling causes the
cycle to be stopped abruptly.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200305082715.15861-7-lokeshvutla@ti.com
---
 drivers/clocksource/timer-ti-dm.c          | 16 +++++-----------
 drivers/pwm/pwm-omap-dmtimer.c             |  8 +++++---
 include/linux/platform_data/dmtimer-omap.h |  5 ++---
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 73ac73efdef8..f5c73ebfe4ca 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -562,21 +562,13 @@ static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 	return 0;
 }
 
-static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
+static int omap_dm_timer_set_load(struct omap_dm_timer *timer,
 				  unsigned int load)
 {
-	u32 l;
-
 	if (unlikely(!timer))
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (autoreload)
-		l |= OMAP_TIMER_CTRL_AR;
-	else
-		l &= ~OMAP_TIMER_CTRL_AR;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
 	omap_dm_timer_disable(timer);
@@ -605,7 +597,7 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 }
 
 static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
-				 int toggle, int trigger)
+				 int toggle, int trigger, int autoreload)
 {
 	u32 l;
 
@@ -615,12 +607,14 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
-	       OMAP_TIMER_CTRL_PT | (0x03 << 10));
+	       OMAP_TIMER_CTRL_PT | (0x03 << 10) | OMAP_TIMER_CTRL_AR);
 	if (def_on)
 		l |= OMAP_TIMER_CTRL_SCPWM;
 	if (toggle)
 		l |= OMAP_TIMER_CTRL_PT;
 	l |= trigger << 10;
+	if (autoreload)
+		l |= OMAP_TIMER_CTRL_AR;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
 	omap_dm_timer_disable(timer);
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 88a3c5690fea..9e4378dc6897 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -183,7 +183,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	if (timer_active)
 		omap->pdata->stop(omap->dm_timer);
 
-	omap->pdata->set_load(omap->dm_timer, true, load_value);
+	omap->pdata->set_load(omap->dm_timer, load_value);
 	omap->pdata->set_match(omap->dm_timer, true, match_value);
 
 	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
@@ -192,7 +192,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	omap->pdata->set_pwm(omap->dm_timer,
 			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
 			      true,
-			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			      true);
 
 	/* If config was called while timer was running it must be reenabled. */
 	if (timer_active)
@@ -222,7 +223,8 @@ static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
 	omap->pdata->set_pwm(omap->dm_timer,
 			      polarity == PWM_POLARITY_INVERSED,
 			      true,
-			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			      true);
 	mutex_unlock(&omap->mutex);
 
 	return 0;
diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
index 3173b7b6ff6f..95d852aef130 100644
--- a/include/linux/platform_data/dmtimer-omap.h
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -30,12 +30,11 @@ struct omap_dm_timer_ops {
 	int	(*stop)(struct omap_dm_timer *timer);
 	int	(*set_source)(struct omap_dm_timer *timer, int source);
 
-	int	(*set_load)(struct omap_dm_timer *timer, int autoreload,
-			    unsigned int value);
+	int	(*set_load)(struct omap_dm_timer *timer, unsigned int value);
 	int	(*set_match)(struct omap_dm_timer *timer, int enable,
 			     unsigned int match);
 	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
-			   int toggle, int trigger);
+			   int toggle, int trigger, int autoreload);
 	int	(*get_pwm_status)(struct omap_dm_timer *timer);
 	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
 
-- 
2.17.1

