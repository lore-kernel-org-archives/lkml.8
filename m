Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D317C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF2D206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp9J/w0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgBLIFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:05:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45992 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgBLIFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:05:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so649506pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kq2WhCwr7jfZotAo5gF9snLf2LQrQrOPcoUeZRf16vE=;
        b=Cp9J/w0DE+CEWsDi7e2nrISfjjs2uN3pHcebDiicPXElGgKNjfHxe3Y84fZwh7YiC8
         U+ZIIlxUKD4sd6wbrcvljfkGNPGVpX2GwfSZfm0acm2pf1LEQJUALLJdGuufYUYsMj4+
         jKh7zIksuLEA+4FFq/LN37N6USTiDjBYWx8Aheafar7Fe3stNLO7Zpejw4cVoUtiTAFD
         aTi9BqUbeeHpY/nsm3LxbWErrc3TC0A0258YVRSkH9czR/SQEQ4+NncjA2h3jVdBWQuR
         CKqXXo97yptBHkmKLAzbkQUyz5KLhNZousu5Yd06P7cWcxQfJMU6w7DoevzYzYOpFFwz
         79Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kq2WhCwr7jfZotAo5gF9snLf2LQrQrOPcoUeZRf16vE=;
        b=f03HIDz6O5gbojgloU2mJABGEcXxGQLv+qVazoC40fGghO2rUAOTE2jzMOQMMgFYVz
         s/0HInWKqUofUCyE8PfMfX5ae2iVh7J8mPdGaRCCI/RSbxoZQS7MCbRQ80WDHDtUWDZH
         16eWBTH6WuAHHgA0cDbfIEBhSGuX39+QNwklCAhEcfrvTN/5/SSb139sZZszESHMVhyj
         eJap12fU++uo6PvcyTbZWDV4SQv8QHGNXjiwJ5NDdkjhSCrfwWiPsPTw5FPyQ3n0XS8+
         Ky9i/DiZHTVWO9x/+ND950ep9m8JxnEnHFCXRMs0GCtgE7N3a7+JIX3vveFvSn38NkdJ
         9OuA==
X-Gm-Message-State: APjAAAW2dFY5U3ivYTs1EKAbhEMvZ9zCKAzecBIrmrfLICQyPM7nCRQy
        q0dtokNc0VT62j8EUzuStU3jzeR6yY8=
X-Google-Smtp-Source: APXvYqy1RK6ALV8ljmAemVYKpuoz8wmy4xpJDBUqRbXDLue8OWhiRlRIOjpr93TUq6KQ7StuVdLxTA==
X-Received: by 2002:a63:5848:: with SMTP id i8mr10877081pgm.438.1581494702892;
        Wed, 12 Feb 2020 00:05:02 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id x26sm7342047pfq.55.2020.02.12.00.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:05:02 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:35:00 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guan Xuetao <gxt@pku.edu.cn>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 13/18] unicore32: replace setup_irq() by request_irq()
Message-ID: <ee227282a3a8cddb037891bb70fd2264d682fe4f.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 arch/unicore32/kernel/time.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/unicore32/kernel/time.c b/arch/unicore32/kernel/time.c
index 8b217a761bf0..6f29c3ae95ff 100644
--- a/arch/unicore32/kernel/time.c
+++ b/arch/unicore32/kernel/time.c
@@ -72,13 +72,6 @@ static struct clocksource cksrc_puv3_oscr = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static struct irqaction puv3_timer_irq = {
-	.name		= "ost0",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= puv3_ost0_interrupt,
-	.dev_id		= &ckevt_puv3_osmr0,
-};
-
 void __init time_init(void)
 {
 	writel(0, OST_OIER);		/* disable any timer interrupts */
@@ -94,7 +87,9 @@ void __init time_init(void)
 	ckevt_puv3_osmr0.min_delta_ticks = MIN_OSCR_DELTA * 2;
 	ckevt_puv3_osmr0.cpumask = cpumask_of(0);
 
-	setup_irq(IRQ_TIMER0, &puv3_timer_irq);
+	if (request_irq(IRQ_TIMER0, puv3_ost0_interrupt,
+			IRQF_TIMER | IRQF_IRQPOLL, "ost0", &ckevt_puv3_osmr0))
+		pr_err("request_irq() on %s failed\n", "ost0");
 
 	clocksource_register_hz(&cksrc_puv3_oscr, CLOCK_TICK_RATE);
 	clockevents_register_device(&ckevt_puv3_osmr0);
-- 
2.24.1

