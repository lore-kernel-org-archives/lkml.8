Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EECC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1B520716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI5JZEk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgC0QKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:10:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39114 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0QKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:10:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id b22so4786456pgb.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RRZMftXcxMjfGIn/jefNpJoaxUEahFI1OKDxY1BN4IA=;
        b=WI5JZEk5f08r9Ae9aGeMFQViCXXVYhgq72UdkbGkvFk9bzN85JK1k5ees3MMHvSP0u
         fMclc0AzeSng2rEXHu54GlRW8cxSv6cvHY3tKj+4RMb4iZJJhM2bqqUpTxZXmXHjbOE0
         uBG1Q9QuA9+DzDiIZZPokutq1gWFYMUJiGTdB/zDq9WYrzaLq2Zum0BerIqb13bw28i8
         K/XiaYnwRkvX5dDcamTCYhowxvuDV7axb+Lubfc+rWbrIYkypwCwZJD4rQRPCMdn3h/x
         PgpwtK9h/cmjiAu0z0LmpJxe6c9HqgBRIOc3Oo2SPLwK2dhtcz6+EHpOrj8Z6u3tJVUh
         oYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRZMftXcxMjfGIn/jefNpJoaxUEahFI1OKDxY1BN4IA=;
        b=mK1NdMblU/wbG2fhwPbEcXAgsCYKDgg7Ykg7/20pX8vQBD5/tR2NjCZpt/l+oVmqvs
         ZOGBPS4k5zV4pVzjNMow5yPWQA5UQWyIF2j4bQFfBYpmrPHU9zewmFBWwSGz+Ly471Qd
         jblDBR4fANRCN9AbXR/4ghWjmbbe/537gOzEkHEnabrscaFrdXWgmUt3e8+LKg/k/KJX
         B45YmbgiFZec1SB1dy+xl6aVIpLVzXnSm7TEc5NCaCq93wbhbOy7CIloTihONeO1N44P
         +2AbZUwKInK2Xw/v4vzuno3Sf+AqQuqJRGwPdUm0TvL45WSDe8njliOFqFxT3UOS29xr
         aBEw==
X-Gm-Message-State: ANhLgQ1T5OOfI1IeITsvBmid2dDwxiapWF5zfw3eFtSKCE9tu5C1ockl
        RgL6/bO0m6ibrVn+uXUzPWFxZRLm
X-Google-Smtp-Source: ADFU+vvDkHbVeKyMYiW4BR5DDKjHh9a5a588eJJ9BB+YdnBGP9qQ7mXBSkRXlnnb86j57sLyyuaMdA==
X-Received: by 2002:aa7:8bdc:: with SMTP id s28mr16126509pfd.110.1585325446926;
        Fri, 27 Mar 2020 09:10:46 -0700 (PDT)
Received: from localhost ([49.207.55.57])
        by smtp.gmail.com with ESMTPSA id d23sm4393280pfq.210.2020.03.27.09.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 09:10:46 -0700 (PDT)
Date:   Fri, 27 Mar 2020 21:40:44 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guan Xuetao <gxt@pku.edu.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] unicore32: replace setup_irq() by request_irq()
Message-ID: <82667ae23520611b2a9d8db77e1d8aeb982f08e5.1585320721.git.afzal.mohd.ma@gmail.com>
References: <20200321174303.GA7930@afzalpc>
 <cover.1585320721.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585320721.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Link to v3, v2 & v1,
[v3] https://lkml.kernel.org/r/20200304005137.5523-1-afzal.mohd.ma@gmail.com
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v5:
 * No change
v4:
 * Non-existent
v3:
 * Split out from tree wide series, as Thomas suggested to get it thr'
	respective maintainers
 * Modify pr_err displayed in case of error
 * Re-arrange code & choose pr_err args as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/unicore32/kernel/time.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/unicore32/kernel/time.c b/arch/unicore32/kernel/time.c
index 8b217a761bf0..c3a37edf4d40 100644
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
+		pr_err("Failed to register ost0 interrupt\n");
 
 	clocksource_register_hz(&cksrc_puv3_oscr, CLOCK_TICK_RATE);
 	clockevents_register_device(&ckevt_puv3_osmr0);
-- 
2.25.1

