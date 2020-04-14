Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF3C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511FD20644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgDNNvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:51:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:41808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732918AbgDNNud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:50:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5A7A8AF21;
        Tue, 14 Apr 2020 13:50:30 +0000 (UTC)
Date:   Tue, 14 Apr 2020 13:50:29 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
In-Reply-To: <20200413163540.GD3772@zn.tnic>
Message-ID: <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
References: <20200326223501.GK11398@zn.tnic> <20200328084858.421444-1-slyfox@gentoo.org> <20200413163540.GD3772@zn.tnic>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 13 Apr 2020, Borislav Petkov wrote:

> > @@ -207,8 +207,11 @@ static int cpu0_logical_apicid;
> >  static int enable_start_cpu0;
> >  /*
> >   * Activate a secondary processor.
> > + *
> > + * Note: 'boot_init_stack_canary' changes canary value. Omit
> > + * stack protection to avoid canary check (and boot) failure.
> >   */
> > -static void notrace start_secondary(void *unused)
> > +static void __no_stack_protector notrace start_secondary(void *unused)
> 
> Hmm, so we did this per-function marking only but that explodes on
> 32-bit, see splat at the end. gcc guys, any ideas?
> 
> The null pointer deref happens this way:
> 
> The __no_stack_protector annotated function start_secondary() calls
> trace_hardirqs_on(). On entry, that function pushes the frame pointer on
> the stack:
> 
> trace_hardirqs_on:
>         pushl   %ebp    #
>         movl    %esp, %ebp      #,
>         subl    $20, %esp       #,
>         movl    %ebx, -12(%ebp) #,
>         movl    %esi, -8(%ebp)  #,
>         movl    %edi, -4(%ebp)  #,
> 
> 
> Singlestepping the whole thing in gdb looks like this:
> 
> Dump of assembler code from 0xc1158610 to 0xc1158624:
> => 0xc1158610 <trace_hardirqs_on+0>:    55      push   %ebp		<---
>    0xc1158611 <trace_hardirqs_on+1>:    89 e5   mov    %esp,%ebp
> 
> and ebp has:
> 
> ...
> ebp            0x0      0x0		<---
> esi            0x200002 2097154
> edi            0x1      1
> eip            0xc1158610
> ...
> 
> Later in the function, it will do __builtin_return_address(n), which
> turns into:
> 
> # kernel/trace/trace_preemptirq.c:26:                   trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
>         movl    0(%ebp), %eax   #, tmp133
> # kernel/trace/trace_preemptirq.c:27:           tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>         movl    4(%eax), %edx   #, tmp130

So this part expects that the caller (!) of trace_hardirqs_on was compiled 
with a frame pointer (in %ebp).  Obviously that's not the case as you 
traced above.  Is start_secondary the immediate caller in the above 
case?

> <--- derefs it here. Boom.
> 
> So, could it be that marking this one function like this:
> 
> static void __attribute__((optimize("-fno-stack-protector"))) __attribute__((no_instrument_function)) start_secondary(void *unused)
> {
> 
> would cause %ebp to be 0 for whatever reason on 32-bit?

Look at it's disassembly.  If it doesn't have the usual push 
%ebp/mov%esp,%ebp prologue it probably doesn't use a frame pointer.  In 
that case I would speculate that having a frame pointer was (before the 
change above) only a side-effect of being compiled with -fstack-protector, 
which got now disabled.  But I was under the impression that the upstream 
kernels build with -fno-omit-frame-pointer, so that sounds unexpected.  
But I have no better explanation at the moment.  If the above speculation 
doesn't make you progress: preprocessed file and a note of what the 
immediate caller of trace_hardirqs_on is in the above case, please.


Ciao,
Michael.
