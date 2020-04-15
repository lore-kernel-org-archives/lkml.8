Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7475CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F642076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408899AbgDOOxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:53:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:54986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407940AbgDOOxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:53:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 53B93AB3D;
        Wed, 15 Apr 2020 14:53:45 +0000 (UTC)
Date:   Wed, 15 Apr 2020 14:53:45 +0000 (UTC)
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
In-Reply-To: <20200415074842.GA31016@zn.tnic>
Message-ID: <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
References: <20200326223501.GK11398@zn.tnic> <20200328084858.421444-1-slyfox@gentoo.org> <20200413163540.GD3772@zn.tnic> <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de> <20200415074842.GA31016@zn.tnic>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 15 Apr 2020, Borislav Petkov wrote:

> On Tue, Apr 14, 2020 at 01:50:29PM +0000, Michael Matz wrote:
> > So this part expects that the caller (!) of trace_hardirqs_on was compiled
> > with a frame pointer (in %ebp).
> 
> /me looks at the .s file...
> 
> options passed comment at the top has -fno-omit-frame-pointer
> 
> > Obviously that's not the case as you traced above. Is start_secondary
> > the immediate caller in the above case?
> 
> Yes, start_secondary() is the function which is marked as
> __attribute__((optimize("-fno-stack-protector"))) and it does:
> 
> # arch/x86/kernel/smpboot.c:264:        local_irq_enable();
>         call    trace_hardirqs_on       #
> 
> (the local_irq_enable() is a macro which has the call to
> trace_hardirqs_on().
> 
> > Look at it's disassembly.  If it doesn't have the usual push
> > %ebp/mov%esp,%ebp prologue it probably doesn't use a frame pointer.
> 
> Here's the preamble:
> 
>         .text
>         .p2align 4
>         .type   start_secondary, @function
> start_secondary:
>         pushl   %esi    #
>         pushl   %ebx    #

Right.  So meanwhile it became clear: the optimize function attribute 
doesn't work cumulative but rather replaces all cmdline args (the 
optimization ones, but that roughly translates to -fxxx options).  In this 
case an 'optimize("-fno-stack-protector")' also disables the crucial 
-fno-omit-frame-pointer, reverting to the compilers default, which, 
depending on version, is also to omit the frame pointer on 32bit.  You 
could fix that by adding ',-fno-omit-frame-pointer' to the attribute 
string.  But that quickly gets out of hand, considering all the options 
you carefully need to set in Makefiles to get the right behaviour.  (Note 
that e.g. the optimization level is reset to -O0 as well!).

(I'll admit that I was somewhat surprised by this behaviour, even though 
it makes sense in the abstract; resetting to a clean slate and 
everything).

I think in its current form the optimize attribute is not useful for the 
purposes you need, and you're better off to disable the stack protector 
for the whole compilation unit from the Makefile.

(That attribute is also documented as "not suitable in production code", 
so go figure ;-) )

I think it will be possible to make that attribute a bit more useful 
in the future, but for the time being I think you'll just want to live 
without it.


Ciao,
Michael.
