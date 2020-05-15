Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8062F206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLskbifd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgEOQYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbgEOQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:24:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD8FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:24:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k7so1076321pjs.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sBTKLmt+G7HKE9vsnUyZ/pBjQDTz5mLNOHvgITKgWpw=;
        b=CLskbifdKA1sxChD1enuaKFOQbnss3tOHCsEiZ4/qCeEzKwZUx4Usa/XUEHGpON8xG
         DOdk4sAV+cPkbiUoibLugT7A/zsnG0evWVJ3xwixa22KFvsYOVmOYJLQBYrNSc4rg2yJ
         ljOmyD/lyrXvqp3w03OFmM0LHzDL52UNftl533zCX2DM5vOiDm9eAfzQXYtk6bW8elbZ
         WiNzbu3bqRryeFFPW35r45fSz+0WlbMHykM9Tni46GHymUCG0N7ZdxrAOiP/4Wu9GOA8
         4lOh0eJqUIcZf602d8tzWwp5+wvYSxsnUcyoFlPr+PkIsfylNVpiy1Fv44Nf3tOP1dSR
         EeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sBTKLmt+G7HKE9vsnUyZ/pBjQDTz5mLNOHvgITKgWpw=;
        b=a9cbGiwCHBxAsTzBBAb7wJs+Kt19l47U+etKqoKANjB18eAWDuZVuaBx1tYCyfpFN5
         sNcuujCl1ytSvfTTsFJkAVPyLdw9v+fC4Rkft2ljJ5G7tyf+BwQiEd61OSUGDKl2XY3q
         qaYf8C2uDMpUKjP5kPKxrfxdzR7thiBeUDahw9T7GAga37Z5sRX80/a5BG30cegn9GDt
         t0RwH5OogM+QFpe05CAU8jNrfMC+MvAYMygUM4iine667q1XAnxEkGwrIHQNZdfO7lMT
         EV9R3EwwVRzXpyDNUghXNcVBe0AtWPfwjqhlH2RBNSffqBuKE5MakMN8aRo6uxYp48HX
         eK+Q==
X-Gm-Message-State: AOAM530bPHJsVKM9YwOMCrxErzJZxlkwY7HFAk5AYXPgybr31dLEVRAk
        2awbwSYXg0UEa28DGeUFTYA=
X-Google-Smtp-Source: ABdhPJzx+Wb6AfvgkPn2XQYnDHbXF/JdhBJc3pruDkdEXckBhHQw0i+88iL1U+MzrUekw2Ab0248YA==
X-Received: by 2002:a17:90b:692:: with SMTP id m18mr4389199pjz.39.1589559854562;
        Fri, 15 May 2020 09:24:14 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id j23sm1914714pjz.13.2020.05.15.09.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:24:13 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 16 May 2020 01:24:11 +0900
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200515162411.GG42471@jagdpanzerIV.localdomain>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <20200515134806.5cw4xxnxw7k3223l@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515134806.5cw4xxnxw7k3223l@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/15 14:48), Daniel Thompson wrote:
> On Fri, May 15, 2020 at 07:33:08PM +0900, Sergey Senozhatsky wrote:
> > On (20/05/15 10:50), Petr Mladek wrote:

[..]

> > Is this guaranteed that we never execute this path from NMI?
> 
> Absolutely not.
> 
> The execution context for kdb is pretty much unique...

OK, that was what I expected.

> we are running a debug mode with all CPUs parked in a holding loop with
> interrupts disabled. One CPU is at an unknown exception state and the
> others are either handling an IRQ or NMI depending on architecture[1].

Can a CPU be parked while holding the console driver port lock?

Hmm, a side note - this also means that we cannot handle it from
poll-ing console drivers and need to switch to direct console writes.

> However there are a number of factors that IMHO weigh in favour of
> allowing kdb to intercept here.
> 
> 1. kgdb/kdb are designed to work from NMI, modulo the bugs that are
>    undoubtedly present.
> 
> 2. A synchronous breakpoint (including an implicit breakpoint-on-oops)
>    from any code that executes with irqs disabled will exhibit most of
>    the same problems as an NMI but without waking up all the NMI logic.
> 
> 3. kdb_trap_printk is only set for *very* narrow time intervals by the
>    debug master (the single CPU in the system that is *not* in a
>    holding loop). Thus in all cases the system has already successfully
>    executed kdb_printf() several times before we ever call the printk()
>    interception code.
> 
>    Or put another way, even if we did tickle a bug speculated about in
>    #1, it won't be the call to printk() that triggers it; we'd never
>    get that far!

OK. I would appreciate a more detailed commit message:
- what do we fix, and what risks do we take. Just for the record.

+ a small nit: looking at for_each_console() loop -- not all consoles
can be invoked at any time and not all consoles are enabled at any time.
You _probably_ might want to do what printk does in call_console_drivers()
loop. printk also had problems with console callbacks being placed in
sections that get discarded, but that's way too niche.

	-ss
