Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3535AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 15:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB1020707
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 15:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPedVaZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgE3PPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 11:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3PP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 11:15:29 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BF0C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 08:15:29 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y5so2439733iob.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjhCy3dzl7uMAG97DCsNveeTG3jweI9Ib3pkGdm0uRc=;
        b=WPedVaZDeoLIuCz1xE8LX9G2S5Bi6rUPFmcC+vhq1VBMeqHWl7TlZGtP8A+l+saHKT
         NN2wEO42IGysWQL3oZSUiUo6aXofJ+yuvYVeA9wCvSxRxcBmu3GuFvPDKveQToRIiDLR
         wvLbdXyO7kQDcBq7KbUXLxskGu/wBrkSPmIRtvdJVxf0QWU7mHbBZt8lBfkHsBavIQyH
         WjLx/N49seovEmptWIa31TdJPYXyQgxjnjJrRQCGmUqcd9ZtwcqYJgIg1t1uOK5SoeNR
         Dmi/ArjcSq+/zQ13shwrlBEXqYaA+MxQ/06LIU0Q4Rozx9icO1+i38IODH3ua/yXW6Ab
         tDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjhCy3dzl7uMAG97DCsNveeTG3jweI9Ib3pkGdm0uRc=;
        b=esrHcBxVOTMkncz/udWvmy1aVLpMLx3V6dXLVLL0Cbg4pz1rQ6bFokzwWjAtTKuMWg
         nbhgozDqOj/6WHcQ7O8g/TvWtArwYrharxF5UOVcwMaAK3xAldhB0smUOBd1IwVwmm3u
         s+PjdrznB8elFc/cAT/uLPjvwOdS9BF+rmms4dyNfBuUsOFDonyYaLQHWfiio1C4RpKd
         BXDuT/qapp0SibkVHkvG7GTgocU70cJ7GxLi3AsFxVjpX+DJ0eOZM6mv+78Yh4ihIBWo
         s5CTmpQLOfTA7FUjNvAhYqsUeFLM6IvK9AjtHfzXcSbyhKQnM+VEBV1Z5FHBubsMkhHQ
         mMbg==
X-Gm-Message-State: AOAM5322/aCbPfskZWCcdMct3xn8Oz1NcSOuwjh7SOGo/fnUuwpiolYx
        mhokHZgYg6LMsh+fXnHTwMV/H7MH324gu8IR9qY=
X-Google-Smtp-Source: ABdhPJw2QID8Kf1Gek0KJ8JV82aasGrDTyGVt6FpxeVAkeui/bXIIhZ7LoqKFnu9IwU5Nu6dtvWmHxDwtG5uIYhNG/U=
X-Received: by 2002:a5e:a61a:: with SMTP id q26mr11221859ioi.207.1590851728527;
 Sat, 30 May 2020 08:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200529212728.795169701@infradead.org> <20200529213320.840953950@infradead.org>
 <582d9136-8f8b-fa07-862e-9ea5d440c09f@citrix.com>
In-Reply-To: <582d9136-8f8b-fa07-862e-9ea5d440c09f@citrix.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Sat, 30 May 2020 23:15:17 +0800
Message-ID: <CAJhGHyC=ThjZEDsC48NiBWq8on089VstP57ocG5OTp3LYahykg@mail.gmail.com>
Subject: Re: [PATCH 02/14] x86/hw_breakpoint: Prevent data breakpoints on
 direct GDT
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        a.darwish@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 8:48 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 29/05/2020 22:27, Peter Zijlstra wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > A data breakpoint on the GDT is terrifying and should be avoided.
> > The GDT on CPU entry area is already protected. The direct GDT
> > should be also protected, although it is seldom used and only
> > used for short time.
>
> While I agree with the sentiment...
>
> >
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20200526014221.2119-3-laijs@linux.alibaba.com
> > ---
> >  arch/x86/kernel/hw_breakpoint.c |   30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> >
> > --- a/arch/x86/kernel/hw_breakpoint.c
> > +++ b/arch/x86/kernel/hw_breakpoint.c
> > @@ -32,6 +32,7 @@
> >  #include <asm/processor.h>
> >  #include <asm/debugreg.h>
> >  #include <asm/user.h>
> > +#include <asm/desc.h>
> >
> >  /* Per cpu debug control register value */
> >  DEFINE_PER_CPU(unsigned long, cpu_dr7);
> > @@ -237,13 +238,26 @@ static inline bool within_area(unsigned
> >  }
> >
> >  /*
> > - * Checks whether the range from addr to end, inclusive, overlaps the CPU
> > - * entry area range.
> > + * Checks whether the range from addr to end, inclusive, overlaps the fixed
> > + * mapped CPU entry area range or other ranges used for CPU entry.
> >   */
> > -static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
> > +static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
> >  {
> > -     return within_area(addr, end, CPU_ENTRY_AREA_BASE,
> > -                        CPU_ENTRY_AREA_TOTAL_SIZE);
> > +     int cpu;
> > +
> > +     /* CPU entry erea is always used for CPU entry */
> > +     if (within_area(addr, end, CPU_ENTRY_AREA_BASE,
> > +                     CPU_ENTRY_AREA_TOTAL_SIZE))
> > +             return true;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             /* The original rw GDT is being used after load_direct_gdt() */
> > +             if (within_area(addr, end, (unsigned long)get_cpu_gdt_rw(cpu),
> > +                             GDT_SIZE))
>
> ... why the O(n) loop over the system?
>
> It is only GDTs which might ever be active on this local CPU(/thread)
> which are a problem, because the breakpoint registers are similarly local.
>
> Nothing is going to go wrong If I put a breakpoint on someone else's
> live GDT, because they wont interact in the "fun" ways we're trying to
> avoid.

Hello

It can help to find the bugs that some cpus may access
to the the wrong GDTs as your suggestion and avoids the
O(nr_cpus) loop.

However, it needs to refactor the hw_breakpoint.c to some
extend:
Some breakpoints are allowed when they are being installed,
but they will be filtered out on some CPUs without causing
any confusion in the general hw_breakpoint.c and perf event
and the handlers need to know they may lost some events in
some cases.

But current code doesn't have such framework yet, we have to
block them directly IMHO.

Thanks
Lai
