Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB28CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F042098B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944471;
	bh=XtFeMb8kGk3fuqPFWEzobBSlX/FA3bh16zbM1mW+u2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yfx/gsS+WuWYoIFPi49xk4uXJR4+CwHOhWCAFesewzruB/GbpBIHepqcS8IskXSWs
	 YegDYFoLXJq9sj3ohNwl49tTgkKWxkXwvgQ60QZndkyOpV9MLzvyMz/3laE0xpQkv4
	 ShwSK26wMeayWKGcgFoINUdTNTCuy4/RHkYXtEbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391542AbgFWUe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391508AbgFWUeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:34:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4661A206C3;
        Tue, 23 Jun 2020 20:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944454;
        bh=XtFeMb8kGk3fuqPFWEzobBSlX/FA3bh16zbM1mW+u2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lon8or8hv8Gdn3auoQvG3lYDdhknOWiBzkn2V8qqetY0F9xT6Sz0/MnacXjBrCArd
         1ksWmwuQbyH3+TozvKdoj127B46rM7cVpHYa9SVoflbaCckX3Eb/g/BUICmRqQLVYt
         XlbzMBGGwkFnZ7rrVHxgH+Nelp3+y7nLQx6WXbE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 5.4 312/314] pwm: jz4740: Enhance precision in calculation of duty cycle
Date:   Tue, 23 Jun 2020 21:58:27 +0200
Message-Id: <20200623195353.884541761@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit 9017dc4fbd59c09463019ce494cfe36d654495a8 upstream.

Calculating the hardware value for the duty from the hardware value of
the period resulted in a precision loss versus calculating it from the
clock rate directly.

(Also remove a cast that doesn't really need to be here)

Fixes: f6b8a5700057 ("pwm: Add Ingenic JZ4740 support")
Cc: <stable@vger.kernel.org>
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
[ukl: backport to v5.4.y and adapt commit log accordingly]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pwm/pwm-jz4740.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -108,8 +108,8 @@ static int jz4740_pwm_apply(struct pwm_c
 	if (prescaler == 6)
 		return -EINVAL;
 
-	tmp = (unsigned long long)period * state->duty_cycle;
-	do_div(tmp, state->period);
+	tmp = (unsigned long long)rate * state->duty_cycle;
+	do_div(tmp, NSEC_PER_SEC);
 	duty = period - tmp;
 
 	if (duty >= period)


