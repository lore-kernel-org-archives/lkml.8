Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC40C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010FB206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="GBlQgBqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgDMM10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:27:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52970 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbgDMMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586780128; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZJbd7KDW2Gck5NN0k5YXIWfV4Rx4iYsgUeNGIDPTx0=;
        b=GBlQgBqVsXzIHPSnhLr3Ep9G1a0NykoRKERZ12ulPd8eLVfo7jd6k2sGvJIMWWRyn7cKv7
        YlKKfyrMA8sBbfRosZeVYtMNjVRWcpLcWRDiNHQ9UdU8BrCMviWepigV5HMPXYSV+ZNoSL
        OYs+yFOnC6I4bG6zE8+eeSE1kU7UNtk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] pwm: jz4740: Make PWM start with the active part
Date:   Mon, 13 Apr 2020 14:14:44 +0200
Message-Id: <20200413121445.72996-2-paul@crapouillou.net>
In-Reply-To: <20200413121445.72996-1-paul@crapouillou.net>
References: <20200413121445.72996-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM would previously always start with the inactive part.
To counter that, the common trick is to use an inverted duty as the
real duty (as in, 'period - duty'), and invert the polarity when the
PWM is enabled.

However, for some reason the driver was already configuring the hardware
for an inverted duty, so inverting it again means we do configure the
hardware with the actual duty value.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 3cd5c054ad9a..f566f9d248d6 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -6,7 +6,6 @@
  * Limitations:
  * - The .apply callback doesn't complete the currently running period before
  *   reconfiguring the hardware.
- * - Each period starts with the inactive part.
  */
 
 #include <linux/clk.h>
@@ -163,7 +162,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Calculate duty value */
 	tmp = (unsigned long long)period * state->duty_cycle;
 	do_div(tmp, state->period);
-	duty = period - tmp;
+	duty = (unsigned long)tmp;
 
 	if (duty >= period)
 		duty = period - 1;
@@ -190,17 +189,13 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
 
 	/* Set polarity */
-	switch (state->polarity) {
-	case PWM_POLARITY_NORMAL:
+	if ((state->polarity != PWM_POLARITY_INVERSED) ^ state->enabled)
 		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 				   TCU_TCSR_PWM_INITL_HIGH, 0);
-		break;
-	case PWM_POLARITY_INVERSED:
+	else
 		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 				   TCU_TCSR_PWM_INITL_HIGH,
 				   TCU_TCSR_PWM_INITL_HIGH);
-		break;
-	}
 
 	if (state->enabled)
 		jz4740_pwm_enable(chip, pwm);
-- 
2.25.1

