Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302E5C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0B12076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXJS2Shz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCRRmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44856 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgCRRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id y2so16027767wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f15f74ppT2riuw2oQxxbxtXEiKKBOa/p7uG21adrcxA=;
        b=XXJS2ShzmjXsJivWn9bj5g4jBm4X7ktoDPO5+jLIGyehUbBbJIdNNU180AQAWTEzhQ
         JXK/07q827hqZScxSeCL6lgNvUgpovOBGsCBCm8wkHMlRsK0fWB35tm88+rkerNkD2WM
         jdXL/OTAyKuh8Y+RwugQpVj3uzjxkzMa7USuWlD7ChR6BZllxEp1XaulHO65tS7GeprE
         tA1tXi9Y/r6mpo97fX4zfAeb/9weZlJ8R841vvrRyS3yQ27caQ0OItHO+VszhRzy20pV
         JkU111VO0NRCB47QrykGY50pQ9kScKTB8zVm88yEVIOesdM/TzPczTo3KyWq0tp+wtPU
         dsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f15f74ppT2riuw2oQxxbxtXEiKKBOa/p7uG21adrcxA=;
        b=qOqH/sAfvY+mdFqTUIxdKVN7TKXooPCr/L8j8IWUEgdL1x3/jmKdox65UzasOrRnIA
         /YKW1jHAGpozKVrnkr+ewBStcIiZg26JhGNszBJLTEFY4g/Pvbgw7Z6OUc1hezmnUSkB
         +ibbZVGCxgdrve8y3iIbo7ALdc/vGYq/JPtwW/KKG4DQkFftxroayFXaR3OS8b/CKvuo
         79GNaBEsy/PUxTW+TqFs1AP/3QuPY7I9yAEKpeHiCicQ31Q+7Ckyjd4u04FdhlcAjzle
         tHSksVOd8COatjqJ4bez/ZZStNQJjbJC8B6t1YBnd0iG3OF/ftOeK13AKfEnfJfpOTMp
         emNA==
X-Gm-Message-State: ANhLgQ0YwzYT66r1qrYdH9ul8Yo0d02jSKNPSb0WSxxiLNE4u2Q7V1tv
        GbnW8+znUthTjf5woUH3vLZJs/u0j6c=
X-Google-Smtp-Source: ADFU+vvb7l9m2SU8dH5i3a9GXPWS8qQJQPZaAqIvAMxo7bs9mWP8zyQbhIgly/ph0vNXGIZkzD9DLg==
X-Received: by 2002:adf:bbcd:: with SMTP id z13mr6677074wrg.389.1584553364567;
        Wed, 18 Mar 2020 10:42:44 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH 11/21] clocksource/drivers/timer-cs5535: Request irq with non-NULL dev_id
Date:   Wed, 18 Mar 2020 18:41:21 +0100
Message-Id: <20200318174131.20582-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: afzal mohammed <afzal.mohd.ma@gmail.com>

Recently all usages of setup_irq() was replaced by request_irq().
request_irq() does a few sanity checks that were not done in
setup_irq(), if they fail irq registration will fail. One of the check
is to ensure that non-NULL dev_id is passed in the case of shared irq.

Fix it by passing non-NULL dev_id while registering the shared irq.

Fixes: cc2550b421aa ("clocksource: Replace setup_irq() by request_irq()")
Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200312064817.19000-1-afzal.mohd.ma@gmail.com
---
 drivers/clocksource/timer-cs5535.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-cs5535.c b/drivers/clocksource/timer-cs5535.c
index 51ea0509fb25..d47acfe848ae 100644
--- a/drivers/clocksource/timer-cs5535.c
+++ b/drivers/clocksource/timer-cs5535.c
@@ -133,6 +133,7 @@ static irqreturn_t mfgpt_tick(int irq, void *dev_id)
 
 static int __init cs5535_mfgpt_init(void)
 {
+	unsigned long flags = IRQF_NOBALANCING | IRQF_TIMER | IRQF_SHARED;
 	struct cs5535_mfgpt_timer *timer;
 	int ret;
 	uint16_t val;
@@ -152,9 +153,7 @@ static int __init cs5535_mfgpt_init(void)
 	}
 
 	/* And register it with the kernel */
-	ret = request_irq(timer_irq, mfgpt_tick,
-			  IRQF_NOBALANCING | IRQF_TIMER | IRQF_SHARED,
-			  DRV_NAME, NULL);
+	ret = request_irq(timer_irq, mfgpt_tick, flags, DRV_NAME, timer);
 	if (ret) {
 		printk(KERN_ERR DRV_NAME ": Unable to set up the interrupt.\n");
 		goto err_irq;
-- 
2.17.1

