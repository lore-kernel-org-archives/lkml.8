Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD9C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDC820719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAzCG2yY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgCRRnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:43:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42741 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgCRRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:43:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so31572450wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OqW3CJ1L1HRFa1rVLsLUMX/aGt+DTTwrzDyNCjc3LFI=;
        b=xAzCG2yYaPQnw5DH+8P4dC1HRdWz1ZTMhuJT6+ctTjM48tZ/QqppI6XqA8QtOK9B9H
         KI2DD5MfWgT8MCfcEMu5JIINRPBXKLAgGlY/yDprXmEMqcfdWWw+tvi4D7m3t+Ys3m2h
         mfKdfWS7LlgfOGJxaEsrpf/xsdSiOGEzciHj13MHLdbQZ1L5JQsLULkeS1/jgzKttUnP
         7VfSQW7micQ79D/OPWkE7//lmMVOjVUQXjy6rfnHQDuRSud/A5mJftJdShDSVAwyiWUZ
         ShJFm3ewANswq3rZubREa0KTGu90tM1DikgwfANrou3G+C6WD54FtdeuEftNDkQ0zVRt
         LpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OqW3CJ1L1HRFa1rVLsLUMX/aGt+DTTwrzDyNCjc3LFI=;
        b=XDD/vNhap6ZQT4f5qj/uYP+aOhISQHFZI0W+E0j8ur7oBRTBmVbIjdGh0EbICa69jn
         JxcSJ6O17JsZxRWelDoC20qnWYEsLuheZFS9G8qoOTojYJtB0HIbCQp/gbDWPCcR0kcK
         YseulXTJMCB7TiP1yHnWCdYwZa6UH/vybaNYNZZBsOz8rT/ffo4GV40XPWlTRCxv1Xxg
         c6KSXseQjQc6Pc3BsjE4bzSDYqWL7RIwjncX00JvQlz0TcS9yqQRquZmCCls7Ch1VX7O
         ZlaJGuE+n2bL2CXqaLkwYwflloDhZpEPx9W1wdzqWbCQcYGnQrdoP7vfO4AS90aKSCGE
         B5Eg==
X-Gm-Message-State: ANhLgQ0QTjFAQN17fsLAF1Iq+Y4jAkSXx1qeNgiJz9cvI9SRdt1rYPAg
        WF9Ui+5DhwZbBRfk+rJg0T0EVg==
X-Google-Smtp-Source: ADFU+vu5IOfA4T09cebVb8sg5y08Kozg859yP/Go+FB4O3sp1R/bMhyyOiTitqIppVu3LhovXIPJ0A==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr7052443wro.16.1584553379424;
        Wed, 18 Mar 2020 10:42:59 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgen <tony@atomide.com>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>
Subject: [PATCH 17/21] clocksource/drivers/timer-ti-dm: Add support to get pwm current status
Date:   Wed, 18 Mar 2020 18:41:27 +0100
Message-Id: <20200318174131.20582-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

omap_dm_timer_ops provide support to configure the pwm but there is no
support to get the current status. For configuring pwm it is advised to
check the current hw status instead of relying on pwm framework. So
implement a new timer ops to get the current status of pwm.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Tony Lindgen <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200305082715.15861-6-lokeshvutla@ti.com
---
 drivers/clocksource/timer-ti-dm.c          | 15 +++++++++++++++
 include/linux/platform_data/dmtimer-omap.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index b565b8456e5c..73ac73efdef8 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -627,6 +627,20 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	return 0;
 }
 
+static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
+{
+	u32 l;
+
+	if (unlikely(!timer))
+		return -EINVAL;
+
+	omap_dm_timer_enable(timer);
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	omap_dm_timer_disable(timer);
+
+	return l;
+}
+
 static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 					int prescaler)
 {
@@ -927,6 +941,7 @@ static const struct omap_dm_timer_ops dmtimer_ops = {
 	.set_load = omap_dm_timer_set_load,
 	.set_match = omap_dm_timer_set_match,
 	.set_pwm = omap_dm_timer_set_pwm,
+	.get_pwm_status = omap_dm_timer_get_pwm_status,
 	.set_prescaler = omap_dm_timer_set_prescaler,
 	.read_counter = omap_dm_timer_read_counter,
 	.write_counter = omap_dm_timer_write_counter,
diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
index bdaaf537604a..3173b7b6ff6f 100644
--- a/include/linux/platform_data/dmtimer-omap.h
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -36,6 +36,7 @@ struct omap_dm_timer_ops {
 			     unsigned int match);
 	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger);
+	int	(*get_pwm_status)(struct omap_dm_timer *timer);
 	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
 
 	unsigned int (*read_counter)(struct omap_dm_timer *timer);
-- 
2.17.1

