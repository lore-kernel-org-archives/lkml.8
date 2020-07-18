Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C1FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 04:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE8B2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 04:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bY/0au6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGREqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 00:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgGREqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 00:46:21 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990C8C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 21:46:20 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so12980201eja.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 21:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6XtgaMcVkuKZN6Vqx9za29ZMiqRwMaKdWv8eAb+N9vg=;
        b=bY/0au6WAL+u8vh4fua/qFVLuU47TL1PTMEtiMXHJM49ItyD0NffJ8wZiiwrOGWaTD
         eBswM0qBkTmIt+JunE0pptyKPWhBHOu+L7miR1ny6lkFWsjiMicvX/VTfHfxfO7Afb7r
         b4wYNVuoxS+gyaOXlmDxE90qT2T3znv3d3m14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6XtgaMcVkuKZN6Vqx9za29ZMiqRwMaKdWv8eAb+N9vg=;
        b=rtitRXzYN/CLkAL2f/0VzwX86j7H2c5EKk6I2IZRJF8eJT72AQS/jx+h+E3Za+BxyB
         M13xjK/1c0yWz70umeI1oIWu5i9p8mAebJNGzBDd89MYF6iBmSIN6kq2e/fQyML8+B3F
         QLKdp5b84bYpojI94ylAH7T/d46rhTslwpXDoTyf0Jm+jL0NEuTteABfJSD8zD+SOZPc
         yVCpqd9X7/bPE61wrjV6zlF/QShLSlXQdKmQ1LAgddCboQDFoiNHCAZtlFnfusZzpook
         buCC6qNPy9uVIJFv7PjwkOWWkSBbSsZX4Rl+5hpfK/PGwVTx/lfKS92XhWXNI2eHTHZE
         GqXQ==
X-Gm-Message-State: AOAM533ZPs0bXMCHyQd/bTEXkPtS8yjJln7XYS3UJukc4CaZZcPcn1DX
        tqhxR5ecGniibtctmVKlK2lP4A==
X-Google-Smtp-Source: ABdhPJy1oAFtDdH08tlydsMUGH/N2FrHzxaMP3ualaq1GVbB+RmhdCMIkpJOIZUQjDN/KFBT7tG6vw==
X-Received: by 2002:a17:906:3945:: with SMTP id g5mr12271263eje.549.1595047579113;
        Fri, 17 Jul 2020 21:46:19 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u13sm9680553ejx.3.2020.07.17.21.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 21:46:18 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v4] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Fri, 17 Jul 2020 21:46:06 -0700
Message-Id: <20200718044606.18739-1-scott.branden@broadcom.com>
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
Reviewed-by: Ray Jui <ray.jui@broadcom.com>

---
Changes from v3: fixed typo in commit message: Reviewed-off-by.
Hopefully everything clean now.
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

