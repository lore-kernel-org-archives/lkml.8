Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02381C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F9E2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="BeiGqq3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgEEWOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:14:31 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33596 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgEEWOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1588716826; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49TZ6g2i5CGAe/qfp6pIQ2iCtA1I7YAZm5sbETkeU/Y=;
        b=BeiGqq3rT0nS2OAPvVXF2JtlI58OBOWM4p7g46asjVtsWGXuot2B1vGZMV10wtx531KUMp
        yZRzz6qH9VJ5gEw0DvrOjf6jZZ3wMCJuSO0rQ+Ub01ldAYhQtH9DDd0wzKrPW8JK2CFPVN
        nMayC5RpXrJAizkhSSWMbJkQ5DYcWXs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     od@zcrc.me, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 7/7] rtc: ingenic: Reset regulator register in probe
Date:   Wed,  6 May 2020 00:13:36 +0200
Message-Id: <20200505221336.222313-7-paul@crapouillou.net>
In-Reply-To: <20200505221336.222313-1-paul@crapouillou.net>
References: <20200505221336.222313-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator register specifies how many input clock cycles (minus one)
are contained in one tick of the 1 Hz clock.

Since this register can contain bogus values after the system boots, it
needs to be reset in the probe register, otherwise the RTC may count way
to slow or way too fast.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/rtc-jz4740.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 65e130726fc6..9607e6b6e0b3 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -372,6 +372,9 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	rate = clk_get_rate(clk);
 	jz4740_rtc_set_wakeup_params(rtc, np, rate);
 
+	/* Each 1 Hz pulse should happen after (rate) ticks */
+	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_REGULATOR, rate - 1);
+
 	ret = rtc_register_device(rtc->rtc);
 	if (ret)
 		return ret;
-- 
2.26.2

