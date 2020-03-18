Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DDDC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0771020767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoxHXlT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgCRRnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:43:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37001 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgCRRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id d1so2805355wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qIDW1cylZCsAYZeisrBT6Enwm2WJxHqS9ciAkjAmdYw=;
        b=eoxHXlT7Qz5/ZUVQw3dq9Hp2yFj7lrVdRicu1bNCFsoE+JagwiZS038pnoY3p4+2Gg
         LBOs8640KLH0L4JyqOzmtGv0XgpVwOvOhjaCyIBvBIluaAg707bJ023Dh7XuSEIuayZL
         32sEwxHJdNXSMNKty7icLgtW8py6dINOkXAEG44IBoGUSfojlZW/MtaXw3HKsbHiLVmR
         58CTtaD/qS8pIfz4vUgXqg+tM5RZoimkp9t4JgBEQWYD4NcvujImookNJK+VcLQxsAei
         3uJF214pZ3w9aLAUkHwUX93zM3njM1YsSi/FC8guin0hUxOudxBFJXSbZKUqatZCi+7F
         VbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qIDW1cylZCsAYZeisrBT6Enwm2WJxHqS9ciAkjAmdYw=;
        b=psx6vSm4E3xgdzSOPNxvySU/3BQsBr/AIKxWhX0EbSVgCoFLo2WXHt1se2K7NTONxL
         huE+hCtl83tDfsNXbQv8QO5Rxb4XAutOcC1TwrLIRHsipTJXg/53lIdbDjFkeWqQXALu
         xNOgzERD0JYxuI73KThECVn6ZztV70nH/ltepFZSqkejfwtW2CsHQ9pRRDNcLyyovLNO
         jkpr+NQXJh+LKWr/x4g0TGVMoUxHvSAWzHPZ9U7DumQvvIA9myg9c9nN2vOjVYHidqOt
         epFEzVush2d8+yrD5uN+uS4h/Z/smmirMsDWEYMK58wXO3UyHWrIV/vx8mK3TRASNqoA
         RIzw==
X-Gm-Message-State: ANhLgQ3kRXNP/0jNh6bJ/5fvsg4M8OcSXK4Uht3SnOIYN2Hubb/6TbJ8
        1rPa1zZHDqis3N0KXvxKkq/QVw==
X-Google-Smtp-Source: ADFU+vthHL7r3PocFFMqtQtngIRwXzaf3ihoen2W5Er8/0YcbeSfV/eqREiRZ3RcDXyNGpRq78OCIw==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr6121454wmc.38.1584553376320;
        Wed, 18 Mar 2020 10:42:56 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/21] clocksource/drivers/timer-ti-dm: Do not update counter on updating the period
Date:   Wed, 18 Mar 2020 18:41:26 +0100
Message-Id: <20200318174131.20582-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Write to trigger register(OMAP_TIMER_TRIGGER_REG) will load the value
in Load register(OMAP_TIMER_LOAD_REG) into Counter register
(OMAP_TIMER_COUNTER_REG).

omap_dm_timer_set_load() writes into trigger register every time load
register is updated. When timer is configured in pwm mode, this causes
disruption in current pwm cycle, which is not expected especially when
pwm is used as PPS signal for synchronized PTP clocks. So do not write
into trigger register on updating the period.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200305082715.15861-5-lokeshvutla@ti.com
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 1d1bea79cbf1..b565b8456e5c 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -579,7 +579,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 	omap_dm_timer_disable(timer);
 	return 0;
 }
-- 
2.17.1

