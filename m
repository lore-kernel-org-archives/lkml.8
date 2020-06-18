Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88663C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6872F20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592504475;
	bh=n37tItBWAGRC74p29xrPPnmeAZ/VdU4SlehHbZr5cPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VZ86S2omXfXqJRCEgNKQQ8DbQ8twzx4hDCzSN0YF2tvotqvgeCq5v103Itt2VWIX5
	 ApRt7Z0nTHsWNXDwr5HZBR1kmyke+pFY2GOHsQsQmycXKWAES0pwtiWNpK6gdcWCnY
	 Y5pe6tInDC+7Acm7PvFb7Xs75ErxxYG9UBV8d9nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgFRSVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgFRSVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:21:13 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3843F208C7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592504472;
        bh=n37tItBWAGRC74p29xrPPnmeAZ/VdU4SlehHbZr5cPk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t729B66iSN1iCOhLMQzk8aEppNyPTBQZCZOshnvCXfbESRiubSCc6cjGVM/+Ihv2J
         +nNWmkg3f2/Bp6UOhaWzz8p0jt/VjSRKVSp576wUtIvwfnCcFrx6E+xExWUSPOZNc3
         D+l3ndIDJwSj9Uan6dp6LezLyY+/o/fj99LFEuBE=
Received: by mail-wm1-f43.google.com with SMTP id t194so6682948wmt.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:21:12 -0700 (PDT)
X-Gm-Message-State: AOAM530A466tIncZQk6CoICCi16c+XRsLW+o81VX6jEUyG9Ul+zGi9tY
        YDQFoKjW/TXt3tDVUUZr4A7XvbqEv0HQ6G28VqJ9cA==
X-Google-Smtp-Source: ABdhPJzUlexIRiLW86cc5O7beowutfjvg3O0HgsHWz+8jlx2NN+oPnNZEbMqFhW6gS7xzckd4mpmuFA4P5Q0pTx0B6M=
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr5304161wmg.176.1592504470731;
 Thu, 18 Jun 2020 11:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de> <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
 <20200616132705.GW2531@hirez.programming.kicks-ass.net> <20200617131742.GD8389@yuki.lan>
In-Reply-To: <20200617131742.GD8389@yuki.lan>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 18 Jun 2020 11:20:59 -0700
X-Gmail-Original-Message-ID: <CALCETrVX=wxRrv0qw-Enbyg5CEQsy5TigbNt7sSs=MDO6uAnMw@mail.gmail.com>
Message-ID: <CALCETrVX=wxRrv0qw-Enbyg5CEQsy5TigbNt7sSs=MDO6uAnMw@mail.gmail.com>
Subject: Re: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 6:17 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > >> FYI, we noticed the following commit (built with gcc-9):
> > > >>
> > > >> commit: 2bbc68f8373c0631ebf137f376fbea00e8086be7 ("x86/entry: Convert Debug exception to IDTENTRY_DB")
> > > >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > >
> > > > Is the head of linux.git exposing the same problem or is this an
> > > > intermittent failure, which only affects bisectability?
> > >
> > > It sure looks deterministic:
> > >
> > > ptrace08.c:62: BROK: Cannot find address of kernel symbol "do_debug"
> >
> > ROFL
>
> It's nice to have a good laugh, however I would really appreciate if any
> of you would help me to fix the test.
>
> The test in question is a regression test for:
>
> commit f67b15037a7a50c57f72e69a6d59941ad90a0f0f
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon Mar 26 15:39:07 2018 -1000
>
>     perf/hwbp: Simplify the perf-hwbp code, fix documentation
>
>     Annoyingly, modify_user_hw_breakpoint() unnecessarily complicates the
>     modification of a breakpoint - simplify it and remove the pointless
>     local variables.
>
> And as far as I can tell it uses ptrace() with PTRACE_POKEUSER in order to
> trigger it. But I'm kind of lost on how exactly we trigger the kernel
> crash.
>
> What is does is to write:
>
>         (void*)1 to u_debugreg[0]
>         (void*)1 to u_debugreg[7]
>         do_debug addr to u_debugreg[0]
>
> Looking at the kernel code the write to register 7 enables the breakpoints and
> what we attempt here is to change an invalid address to a valid one after we
> enabled the breakpoint but that's as far I can go.
>
> So does anyone has an idea how to trigger the bug without the do_debug function
> address? Would any valid kernel function address suffice?
>

do_debug is a bit of a red herring here.  ptrace should not be able to
put a breakpoint on a kernel address, period.  I would just pick a
fixed address that's in the kernel text range or even just in the
pre-KASLR text range and make sure it gets rejected.  Maybe try a few
different addresses for good measure.

--Andy
