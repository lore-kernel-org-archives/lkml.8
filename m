Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345A7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C672073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="pmmWCcQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390688AbgEYM5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:57:51 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47060 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388757AbgEYM5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1590411461; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d0n3xdeyCqBIqQVgP1vctXBoMaY/ngJ3knFoGUAcvvs=;
        b=pmmWCcQ1yIV9u4qxmK3Vr63FISbv8xAeKpiiIw/yRVSyQ3KYSv0GoxDr+F7EG/WVUxxZuF
        WgrPD3vKYA/KHLo2zKDL4xV1k33CXRWV17w1nwbNgrFGO8PtfoLffedyBrRHWeLY7kpt6E
        WrjBXfDdZ0VQLjUbu0A8PiYuAeUA0TM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/4] pwm: jz4740: Enhance precision in calculation of duty cycle
Date:   Mon, 25 May 2020 14:57:20 +0200
Message-Id: <20200525125722.36447-2-paul@crapouillou.net>
In-Reply-To: <20200525125722.36447-1-paul@crapouillou.net>
References: <20200525125722.36447-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculating the hardware value for the duty from the hardware value of
the period resulted in a precision loss versus calculating it from the
clock rate directly.

(Also remove a cast that doesn't really need to be here)

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch. I don't consider this a fix but an enhancement, since the old
    	behaviour was in place since the driver was born in ~2010, so no Fixes tag.

 drivers/pwm/pwm-jz4740.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 3cd5c054ad9a..4fe9d99ac9a9 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -158,11 +158,11 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Calculate period value */
 	tmp = (unsigned long long)rate * state->period;
 	do_div(tmp, NSEC_PER_SEC);
-	period = (unsigned long)tmp;
+	period = tmp;
 
 	/* Calculate duty value */
-	tmp = (unsigned long long)period * state->duty_cycle;
-	do_div(tmp, state->period);
+	tmp = (unsigned long long)rate * state->duty_cycle;
+	do_div(tmp, NSEC_PER_SEC);
 	duty = period - tmp;
 
 	if (duty >= period)
-- 
2.26.2

