Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3206AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3709620675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgEMVKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgEMVKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:10:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007AF20575;
        Wed, 13 May 2020 21:10:48 +0000 (UTC)
Date:   Wed, 13 May 2020 17:10:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
Message-ID: <20200513171047.04c2c10e@gandalf.local.home>
In-Reply-To: <1970736614.19996.1589403401588.JavaMail.zimbra@efficios.com>
References: <20200505131602.633487962@linutronix.de>
        <20200505134058.560059744@linutronix.de>
        <1970736614.19996.1589403401588.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 16:56:41 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:
> 
> > Make sure task_work runs before any kind of userspace -- very much
> > including signals -- is invoked.  
> 
> What is missing from this patch description is: _why_ is this deemed
> useful ?
> 
> Also, color me confused: is "do_signal()" actually running any user-space,
> or just setting up the user-space stack for eventual return to signal handler ?
> 
> Also, it might be OK, but we're changing the order of two things which
> have effects on each other: restartable sequences abort fixup for preemption
> and do_signal(), which also have effects on rseq abort.
> 
> Because those two will cause the abort to trigger, I suspect changing
> the order might be OK, but we really need to think this through.
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Suggested-by: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> > arch/x86/entry/common.c |    8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -156,16 +156,16 @@ static void exit_to_usermode_loop(struct
> > 		if (cached_flags & _TIF_PATCH_PENDING)
> > 			klp_update_patch_state(current);
> > 
> > -		/* deal with pending signal delivery */
> > -		if (cached_flags & _TIF_SIGPENDING)
> > -			do_signal(regs);
> > -
> > 		if (cached_flags & _TIF_NOTIFY_RESUME) {
> > 			clear_thread_flag(TIF_NOTIFY_RESUME);
> > 			tracehook_notify_resume(regs);
> > 			rseq_handle_notify_resume(NULL, regs);
> > 		}
> > 
> > +		/* deal with pending signal delivery */
> > +		if (cached_flags & _TIF_SIGPENDING)
> > +			do_signal(regs);

Looking deeper into this, it appears that do_signal() can freeze or kill the
task.

That is, it wont go back to user space here, but simply schedule out (being
traced) or even exit (killed).

Before the resume hooks would never be called in such cases, and now they
are.

-- Steve


> > +
> > 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
> >  			fire_user_return_notifiers();  
> 

