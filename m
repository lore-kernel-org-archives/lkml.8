Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDADC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E223A20777
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="INDNIB7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCRRmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38742 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgCRRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id l20so451419wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cqDimTF4MiP3bSPi5sXkRQqV83mEyqhMl9X2rYxrKQI=;
        b=INDNIB7zVjveDPPQAxAMegVs0ScUmP1P0LV0/K1wgs7RN+4mqMhQgEZmQatgPWWp9/
         HI6VpddJMxTZo5duzlDQ9b7W9rYpZ4EVPVPD55k68UdX0Tne75g6wY8llBqxVXqjxeQB
         orcDzb3QFSbbpyFqqu9MrxNV+tjCAeAxmtx/4fxEdcGkps7SWKsMWgYpyn5mGtwECFRn
         7hcuBToA/H6jL6mgRgKhkpOgLrPEFNBWx2ZuFfLFZ6PSWDseb/X7GvZwl9dC/bHj4YYQ
         eV/sfdYeOSlNDPwmlssjf0mCOxk0OCy3qdiPE32rKzAnQziUoZS4sIxZHIU4vQu9WSs9
         +M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cqDimTF4MiP3bSPi5sXkRQqV83mEyqhMl9X2rYxrKQI=;
        b=sLeGYHNgUmc9iOCmXDYq0xU0EozdhZ6zepudn/K5gxXDanq0iHrGIBVoSkLsw8rhiq
         6z9qY+8jtCTpkrRJNyr+GAMw7uVoTRmDMl9hJSCAuzkdZoWiW1hAiMDwKTqAucfTBbrl
         c8RvNZCh2qYPmFlta/U4mto5mpERrZMsctz1u/ji9hHOuOBQe3trhFrSb8dwB80w2pLz
         eGrtxacyuHUEH2yWHzUl35OQOu/g3LUelFIpz0lGivKGjoT01OrvkwGayBGk3n/Erg7G
         n5Xy60nTgRkOu0UBrpYZ/OIOqhlJMn1CL/hzaKXgMXNq6gVQnXHwScSsEyJQeZFIU6G+
         OISA==
X-Gm-Message-State: ANhLgQ2ygliKNruc36bGrh4hllneRHxuNpphn8MlYl8y9JUPukN9hE8+
        Nc9lHkwS/xapkl4FOqvQaXC1IA==
X-Google-Smtp-Source: ADFU+vvoEq37l64kfN5brWGhHX3A2NllarsJ/rLjkTWsrZXT4vYiAmfQITyqUvYYEiqqFZtQQlLrLQ==
X-Received: by 2002:a1c:8090:: with SMTP id b138mr6577719wmd.55.1584553349058;
        Wed, 18 Mar 2020 10:42:29 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/21] clocksource/drivers/timer-ti-dm: Do not update counter on updating the period
Date:   Wed, 18 Mar 2020 18:41:16 +0100
Message-Id: <20200318174131.20582-6-daniel.lezcano@linaro.org>
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

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200224050753.17784-3-lokeshvutla@ti.com
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 269a994d6a99..acc93600d351 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -577,7 +577,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 	/* Save the context */
 	timer->context.tclr = l;
 	timer->context.tldr = load;
-- 
2.17.1

