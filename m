Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565FFC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35907207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJU7Su0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEHIsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgEHIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:48:52 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AE5C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LQBn7XfUQOTrAQG/ud8v5R6R8MD/ARmY8ErIu/IBpIY=; b=SJU7Su0sfWAecqMq3ENUoWdM9/
        5tPn5GRuCnB6BymQgzSWsN6WUM/F45x53mqChGeFd5Bn6tmBzANPMC00hVRw4ey5EiZl3WwILad9w
        JpG5o+XqWvLyhaDbkBkgvz60DEO/+sIPG0uqz23tiJrFagE7fbcIZMyMhLRLsisyBR6Jd2dKXVcHm
        2/rDM2l1cHLHP+3uQmLSzejjEwGHP1mMtzSz1StRYSF/h2VLWACivfIgVHSFyD3TBZAneSNnXpQKZ
        auOqm0Vcu2LngXYBeJL3lVqSehn1Eub9aPnExZqzoZmGKNjORn6txbb2R5AcXEY9jTwGVy2w4Ml9e
        uOMUKLOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWyfz-0004W2-7G; Fri, 08 May 2020 08:48:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79C04301EFB;
        Fri,  8 May 2020 10:48:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 649A82013428F; Fri,  8 May 2020 10:48:09 +0200 (CEST)
Date:   Fri, 8 May 2020 10:48:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
Message-ID: <20200508084809.GS5298@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.957390899@linutronix.de>
 <CALCETrX=Obqn2ms5EYs7HPxTE_UgnVkmt-HoAoGzB4BajuMwLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrX=Obqn2ms5EYs7HPxTE_UgnVkmt-HoAoGzB4BajuMwLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 11:02:09AM -0700, Andy Lutomirski wrote:
> On Tue, May 5, 2020 at 7:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Convert #MC over to using task_work_add(); it will run the same code
> > slightly later, on the return to user path of the same exception.
> 
> I think this patch is correct, but I think it's only one small and not
> that obviously wrong step away from being broken:
> 
> >         if ((m.cs & 3) == 3) {
> >                 /* If this triggers there is no way to recover. Die hard. */
> >                 BUG_ON(!on_thread_stack() || !user_mode(regs));
> > -               local_irq_enable();
> > -               preempt_enable();
> >
> > -               if (kill_it || do_memory_failure(&m))
> > -                       force_sig(SIGBUS);
> > -               preempt_disable();
> > -               local_irq_disable();
> > +               current->mce_addr = m.addr;
> > +               current->mce_status = m.mcgstatus;
> > +               current->mce_kill_me.func = kill_me_maybe;
> > +               if (kill_it)
> > +                       current->mce_kill_me.func = kill_me_now;
> > +               task_work_add(current, &current->mce_kill_me, true);
> 
> This is fine if the source was CPL3, but it's not going to work if CPL
> was 0.  We don't *currently* do this from CPL0, but people keep
> wanting to.  So perhaps there should be a comment like:
> 
> /*
>  * The #MC originated at CPL3, so we know that we will go execute the
> task_work before returning to the offending user code.
>  */
> 
> IOW, if we want to recover from CPL0 #MC, we will need a different mechanism.

See part4-18's IDTRENTRY_NOIST. That will get us a clear CPL3/CPL0
separation.

> I also confess a certain amount of sadness that my beautiful
> haha-not-really-atomic-here mechanism isn't being used anymore. :(

I think we have a subtely different interpretation of 'beautiful' here.
