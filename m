Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C03C2D0E8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 05:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF408206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 05:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/FnXHfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDEFiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 01:38:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45090 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgDEFiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 01:38:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id o26so5840437pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 22:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0jF9pWSlPaYD2ziUF6nhbSGdT6OrmVhlRN/nJQLR7yg=;
        b=O/FnXHfmFd7Y76aERNuCdYP50qox8r/7AmaQg/6NAGF15KAtLfoYnIJ9HG+/cCxPCx
         MvEEhAShBjFQHwvL04kP9EPuawOO3vqF7JL+bykfIF10tKdgo0XpuWDqKzCCt1/W2FBh
         AxFkqGyQk0rOhijemgyiBvH7a8UFKLWewEM+ifAY4bfWHN9xAVdywWY7pau9fNtKz9Po
         elx0g9Cpui5z/Orjj97vsDJ/RpkTK0tFh3bzqfccafsybhrdKfMadFmaeFB6h2ChVebu
         yAWeRKfQuHLlrPdhLzZUJFyWycrkUzXsfx0Lw8fGsLPE9c2G8EJvZc7rCLXqN98recMz
         Z0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0jF9pWSlPaYD2ziUF6nhbSGdT6OrmVhlRN/nJQLR7yg=;
        b=a2E6rz9qvNZXezRJy692XAhOwNNrANIsMkhWEezOVJbV/FB8cBqPIxewMwEFo+KQAE
         r1Su/NfHdbaewPIQeCBvqUzAQaEHT620xqkF2ppQkO2nYmf3Cr5FdJHeyjxFlB99x9nJ
         XObCqcj6cbQnWtYaXO+Yud33HlCALC9a5UQ4vJKFXnQi6iixrtsgwdc69j8JMTfLlBcz
         1H1kROhN2+/wiIZ5t2RnxSF9SAw2IJBNdHEQb6/NtAae6a/76HnPrQItqnGeuA9/KM16
         87iWeZopf1F7wCEw60mnrntbmmboPp72obRrbEvMRgRNHM7ea6QUsxsjJ4BM4NoooYWs
         bs0g==
X-Gm-Message-State: AGi0PuajPkgXvEU5U8fE6xcBQ6rtvYPv27I5tJKBVotLPNnewLs+vaR0
        QfC8/bMMpnHhGkrI+5oBf34=
X-Google-Smtp-Source: APiQypJHl1JHTNi4KksI7t0wqA8F9ee3ecGYciGKKpidiT6PK7CBoaGYo6/oBTSJbDLrjlqUuyY3pg==
X-Received: by 2002:a63:f54d:: with SMTP id e13mr15170163pgk.157.1586065129988;
        Sat, 04 Apr 2020 22:38:49 -0700 (PDT)
Received: from localhost ([183.82.183.216])
        by smtp.gmail.com with ESMTPSA id q8sm8935676pjq.28.2020.04.04.22.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Apr 2020 22:38:49 -0700 (PDT)
Date:   Sun, 5 Apr 2020 11:08:47 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/timer-vf-pit: Fix build error
Message-ID: <20200405053847.GA5593@afzalpc>
References: <202003230153.VzOyvdbR%lkp@intel.com>
 <20200323061130.GA6286@afzalpc>
 <5616c931-1c44-d6b5-8baa-24c66f334e28@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5616c931-1c44-d6b5-8baa-24c66f334e28@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Thomas,

On Tue, Mar 31, 2020 at 01:40:36PM +0200, Daniel Lezcano wrote:

> Hi Thomas,
> 
> I was about to send a PR with the revert and this patch. As you picked
> up the revert, do you mind to pick also this one?

Mainline is broken w/o this change for ARM vf610m4_defconfig, Stephen
Rothwell also reported it today, please do the needful so as to let it
reach mainline.

Regards
afzal

> On 23/03/2020 07:11, afzal mohammed wrote:
> > Recently all usages of setup_irq() was replaced by request_irq().
> > The replacement in timer-vf-pit.c missed closing parentheses
> > resulting in build error (vf610m4_defconfig). Fix it.
> >
> > Fixes: cc2550b421aa ("clocksource: Replace setup_irq() by
> > request_irq()") Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com> ---
> > drivers/clocksource/timer-vf-pit.c | 2 +- 1 file changed, 1
> > insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/timer-vf-pit.c
> > b/drivers/clocksource/timer-vf-pit.c index
> > 7ad4a8b008c2..1a86a4e7e344 100644 ---
> > a/drivers/clocksource/timer-vf-pit.c +++
> > b/drivers/clocksource/timer-vf-pit.c @@ -129,7 +129,7 @@ static int
> > __init pit_clockevent_init(unsigned long rate, int irq)
> > __raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
> >
> > BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER |
> > IRQF_IRQPOLL, -			   "VF pit timer", &clockevent_pit); +			   "VF
> > pit timer", &clockevent_pit));
> >
> > clockevent_pit.cpumask = cpumask_of(0); clockevent_pit.irq = irq;
> >
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
