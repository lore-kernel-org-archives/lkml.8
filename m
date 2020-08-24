Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6C9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C945E206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ve2GIfUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHXLFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHXLFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:05:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA05EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zhwpULV7sbo9c+kR118DE6xGLTOEKy7x9DA1lEdSc4Y=; b=Ve2GIfUB3B3dnL4bE2EFuZ4uvn
        jQLOVRM0fr2Nyt/FWeIKUAcj91h2WMHI3kajD4KGmiEApbH/k4gScwnUnFmss2W7fqWn6Bm+RpLUw
        VPya4stIu67JESmkPldqFeIGuWyNLhB2vyoUCt087XBA+G4MkEs3W1mw+v9ZMb2oDSravteRvr0pq
        3a+tFhoYMm4Tn3o2bNP766pAzBskXuCyptUVOciyyZZFnbEl59zkb82feIVN6bkxbUKza8M14hEga
        q7YcTdFevmelnTUufa51FgHuvrlDqEyXS0yvGheMUb46cuPvFcrejh0ACbIdAUodb0DEvp6UAiN/0
        7meCiNqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAAHf-0007bc-Ev; Mon, 24 Aug 2020 11:05:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98FAA30015A;
        Mon, 24 Aug 2020 13:05:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72F5C2BEC485E; Mon, 24 Aug 2020 13:05:01 +0200 (CEST)
Date:   Mon, 24 Aug 2020 13:05:01 +0200
From:   peterz@infradead.org
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 5/8] x86/debug: Simplify #DB signal code
Message-ID: <20200824110501.GT1362448@hirez.programming.kicks-ass.net>
References: <20200821093912.815135402@infradead.org>
 <20200821102053.034965283@infradead.org>
 <CALCETrVBB3YNCqCQ6bFBrSM10OTe354zyh=WbPFaEBxK1_Sa7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVBB3YNCqCQ6bFBrSM10OTe354zyh=WbPFaEBxK1_Sa7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 04:09:42PM -0700, Andy Lutomirski wrote:
> On Fri, Aug 21, 2020 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Get rid of the two variables, avoid computing si_code when not needed
> > and be consistent about which dr6 value is used.
> >
> 
> > -       if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
> > -               send_sigtrap(regs, 0, si_code);
> > +       /*
> > +        * If dr6 has no reason to give us about the origin of this trap,
> > +        * then it's very likely the result of an icebp/int01 trap.
> > +        * User wants a sigtrap for that.
> > +        */
> > +       if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
> > +               send_sigtrap(regs, 0, get_si_code(dr6));
> 
> The old condition was ... || (actual DR6 value) and the new condition
> was ... || (stupid notifier-modified DR6 value).  I think the old code
> was more correct.

Hurmph.. /me goes re-read the SDM.

INT1 is a trap,
instruction breakpoint is a fault

So if you have:

	INT1
1:	some-instr

and set an X breakpoint on 1, we'll loose the INT1, right?

And because INT1 is a trap, we can't easily decode the instruction
stream either :-(

Now, OTOH, I suppose you're right in that looking at DR6 early (before
we let people muck about with it) is more reliable for detecting INT1.
Esp since the hw_breakpoint crud can consume all bits.

So I'll go fix that. What a giant pain in the ass all this is.

> The right fix is to get rid of the notifier garbage.  Want to pick up
> these two changes into your series:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/entry&id=b695a5adfdd661a10eead1eebd4002d08400e7ef
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/entry&id=40ca016606bd39a465feaf5802a8dc3e937aaa06
> 
> And then there is no code left that modifies ->debugreg6 out from under you.

I'm not convinced. Even with those patches applied we have to use
debugreg6, and that code very much relies on clearing DR_TRAP_BITS
early, and then having ptrace_triggered() re-set bits in it.

This is so that hw_breakpoint handlers can use breakpoints in userspace
without causing send_sigtrap() on them.

So while I hate notifiers as much as the next person, I'm not sure those
patches actually help anything at all in this particular case.

We can't actually remove the notifier, we can't remove debugreg6 and
debugreg6 will still get modified.


