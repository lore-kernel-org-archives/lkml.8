Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5FCC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8502C206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbgDOWTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:19:51 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:46544 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgDOWTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:19:38 -0400
Received: from sf (tunnel547699-pt.tunnel.tserv1.lon2.ipv6.he.net [IPv6:2001:470:1f1c:3e6::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 0D3C834F114;
        Wed, 15 Apr 2020 22:19:33 +0000 (UTC)
Date:   Wed, 15 Apr 2020 23:19:30 +0100
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Michael Matz <matz@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>, Jakub Jelinek <jakub@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200415231930.19755bc7@sf>
In-Reply-To: <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
References: <20200326223501.GK11398@zn.tnic>
        <20200328084858.421444-1-slyfox@gentoo.org>
        <20200413163540.GD3772@zn.tnic>
        <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
        <20200415074842.GA31016@zn.tnic>
        <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 14:53:45 +0000 (UTC)
Michael Matz <matz@suse.de> wrote:

> Hello,
> 
> On Wed, 15 Apr 2020, Borislav Petkov wrote:
> 
> > On Tue, Apr 14, 2020 at 01:50:29PM +0000, Michael Matz wrote:  
> > > So this part expects that the caller (!) of trace_hardirqs_on was compiled
> > > with a frame pointer (in %ebp).  
> > 
> > /me looks at the .s file...
> > 
> > options passed comment at the top has -fno-omit-frame-pointer
> >   
> > > Obviously that's not the case as you traced above. Is start_secondary
> > > the immediate caller in the above case?  
> > 
> > Yes, start_secondary() is the function which is marked as
> > __attribute__((optimize("-fno-stack-protector"))) and it does:
> > 
> > # arch/x86/kernel/smpboot.c:264:        local_irq_enable();
> >         call    trace_hardirqs_on       #
> > 
> > (the local_irq_enable() is a macro which has the call to
> > trace_hardirqs_on().
> >   
> > > Look at it's disassembly.  If it doesn't have the usual push
> > > %ebp/mov%esp,%ebp prologue it probably doesn't use a frame pointer.  
> > 
> > Here's the preamble:
> > 
> >         .text
> >         .p2align 4
> >         .type   start_secondary, @function
> > start_secondary:
> >         pushl   %esi    #
> >         pushl   %ebx    #  
> 
> Right.  So meanwhile it became clear: the optimize function attribute 
> doesn't work cumulative but rather replaces all cmdline args (the 
> optimization ones, but that roughly translates to -fxxx options).  In this 
> case an 'optimize("-fno-stack-protector")' also disables the crucial 
> -fno-omit-frame-pointer, reverting to the compilers default, which, 
> depending on version, is also to omit the frame pointer on 32bit.  You 
> could fix that by adding ',-fno-omit-frame-pointer' to the attribute 
> string.  But that quickly gets out of hand, considering all the options 
> you carefully need to set in Makefiles to get the right behaviour.  (Note 
> that e.g. the optimization level is reset to -O0 as well!).
> 
> (I'll admit that I was somewhat surprised by this behaviour, even though 
> it makes sense in the abstract; resetting to a clean slate and 
> everything).
> 
> I think in its current form the optimize attribute is not useful for the 
> purposes you need, and you're better off to disable the stack protector 
> for the whole compilation unit from the Makefile.
> 
> (That attribute is also documented as "not suitable in production code", 
> so go figure ;-) )
> 
> I think it will be possible to make that attribute a bit more useful 
> in the future, but for the time being I think you'll just want to live 
> without it.

Ah, that makes sense. Borislav, should I send a fix forward against
x86 tree to move -fno-stack-protector as it was in v1 patch?
Or you'll revert v2 and apply v1 ~as is? Or should I send those myself?

-- 

  Sergei
