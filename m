Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD98C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5ED22D02
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PhnkoGYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgHTPwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgHTPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:52:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E7CC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SjTmJ9XwsS/HKzjcdQ/ubxMW0x/y/rl3M8LO4B6tTQE=; b=PhnkoGYstN9oYVI933xixhJIxY
        rDByQzHQRIeoMFGefAk7eV2VUp+/ICyHHU1lpO6louXO57rw8wO/Cj6rS1QWnDfIVrM9jAELM6sEh
        A0F4/Z9o4HZgHYagJGUoqFP4hXRU6Bl6tHm6a2PjVpqsNsrSKYjO0oJUb/fvh0F5G6bGS1w73Thie
        aycn78pa3168nMPTZ+FI3nnj/w+xBQvXujzreRyAUfjehOKdMPLHKS+RVIEHtKjXRXEQRY1iLqXJK
        pc+lGt3ccVMC2LdkNATSrWLMvfq4RNRUSBOU6pr3gSh4+ddZsjGuKSNe6mUNwvcoHURhDEY1Dp1Mj
        VdtHegkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8mqm-0007uF-1g; Thu, 20 Aug 2020 15:51:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11F2B303271;
        Thu, 20 Aug 2020 17:51:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0E6E2C37D878; Thu, 20 Aug 2020 17:51:34 +0200 (CEST)
Date:   Thu, 20 Aug 2020 17:51:34 +0200
From:   peterz@infradead.org
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
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
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Message-ID: <20200820155134.GD1362448@hirez.programming.kicks-ass.net>
References: <20200820103832.486877479@infradead.org>
 <20200820104905.294802764@infradead.org>
 <20200820152828.tvluka3lvmzof5xt@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820152828.tvluka3lvmzof5xt@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 04:28:28PM +0100, Daniel Thompson wrote:
> On Thu, Aug 20, 2020 at 12:38:36PM +0200, Peter Zijlstra wrote:
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kernel/traps.c |   24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -820,18 +820,6 @@ static void handle_debug(struct pt_regs
> >  		goto out;
> >  	}
> >  
> > -	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
> > -		/*
> > -		 * Historical junk that used to handle SYSENTER single-stepping.
> > -		 * This should be unreachable now.  If we survive for a while
> > -		 * without anyone hitting this warning, we'll turn this into
> > -		 * an oops.
> > -		 */
> > -		tsk->thread.debugreg6 &= ~DR_STEP;
> > -		set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
> > -		regs->flags &= ~X86_EFLAGS_TF;
> > -	}
> > -
> >  	si_code = get_si_code(tsk->thread.debugreg6);
> >  	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
> >  		send_sigtrap(regs, 0, si_code);
> > @@ -874,6 +862,18 @@ static __always_inline void exc_debug_ke
> >  	if (kprobe_debug_handler(regs))
> >  		goto out;
> >  
> > +	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
> > +		/*
> > +		 * Historical junk that used to handle SYSENTER single-stepping.
> > +		 * This should be unreachable now.  If we survive for a while
> > +		 * without anyone hitting this warning, we'll turn this into
> > +		 * an oops.
> > +		 */
> > +		dr6 &= ~DR_STEP;
> > +		set_thread_flag(TIF_SINGLESTEP);
> > +		regs->flags &= ~X86_EFLAGS_TF;
> > +	}
> > +
> 
> I was hoping just to share a Tested-by: on the patchset but
> unfortunately it wasn't to be. After a quick bisect this patch comes
> back as causing kdb single stepping to fail.

Yeah, Josh just asked me about this:

  https://lkml.kernel.org/r/20200820152111.GC1362448@hirez.programming.kicks-ass.net

How's this on top of the lot?

---

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -828,25 +828,24 @@ static __always_inline void exc_debug_ke
 	if (kprobe_debug_handler(regs))
 		goto out;
 
-	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
-		/*
-		 * Historical junk that used to handle SYSENTER single-stepping.
-		 * This should be unreachable now.  If we survive for a while
-		 * without anyone hitting this warning, we'll turn this into
-		 * an oops.
-		 */
-		dr6 &= ~DR_STEP;
-		set_thread_flag(TIF_SINGLESTEP);
-		regs->flags &= ~X86_EFLAGS_TF;
-	}
-
 	/*
 	 * The kernel doesn't use INT1
 	 */
 	if (!dr6)
 		goto out;
 
-	notify_debug(regs, dr6);
+	if (notify_debug(regs, dr6))
+		goto out;
+
+	/*
+	 * The kernel doesn't use TF single-step outside of:
+	 *
+	 *  - Kprobes, consumed through kprobe_debug_handler()
+	 *  - KGDB, consumed through notify_debug()
+	 *
+	 * So if we get here with DR_STEP set, something is wonky.
+	 */
+	BUG_ON(current->thread.debugreg6 & DR_STEP);
 
 out:
 	instrumentation_end();
