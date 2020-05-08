Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3890C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7C121841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHAXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 20:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEHAXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 20:23:43 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16B6720746;
        Fri,  8 May 2020 00:23:40 +0000 (UTC)
Date:   Thu, 7 May 2020 20:23:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V4 part 1 24/36] lockdep: Prepare for noinstr sections
Message-ID: <20200507202339.0abc360f@oasis.local.home>
In-Reply-To: <20200505134100.484532537@linutronix.de>
References: <20200505131602.633487962@linutronix.de>
        <20200505134100.484532537@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 15:16:26 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3639,9 +3639,6 @@ static void __trace_hardirqs_on_caller(u
>  {
>  	struct task_struct *curr = current;
>  
> -	/* we'll do an OFF -> ON transition: */
> -	curr->hardirqs_enabled = 1;
> -
>  	/*
>  	 * We are going to turn hardirqs on, so set the
>  	 * usage bit for all held locks:
> @@ -3653,16 +3650,13 @@ static void __trace_hardirqs_on_caller(u
>  	 * bit for all held locks. (disabled hardirqs prevented
>  	 * this bit from being set before)
>  	 */
> -	if (curr->softirqs_enabled)
> +	if (curr->softirqs_enabled) {
>  		if (!mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ))
>  			return;

The above can be turned into:

	if (curr->softirqs_enabled)
		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);

No need for the condition or the return.


> -
> -	curr->hardirq_enable_ip = ip;
> -	curr->hardirq_enable_event = ++curr->irq_events;
> -	debug_atomic_inc(hardirqs_on_events);
> +	}
>  }
>  
> -void lockdep_hardirqs_on(unsigned long ip)
> +void lockdep_hardirqs_on_prepare(unsigned long ip)
>  {
>  	if (unlikely(!debug_locks || current->lockdep_recursion))
>  		return;
> @@ -3698,20 +3692,62 @@ void lockdep_hardirqs_on(unsigned long i
>  	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
>  		return;
>  
> +	current->hardirq_chain_key = current->curr_chain_key;
> +
>  	current->lockdep_recursion++;
>  	__trace_hardirqs_on_caller(ip);
>  	lockdep_recursion_finish();
>  }
> -NOKPROBE_SYMBOL(lockdep_hardirqs_on);
> +EXPORT_SYMBOL_GPL(lockdep_hardirqs_on_prepare);
> +
> +void noinstr lockdep_hardirqs_on(unsigned long ip)
> +{

Would be nice to have some kerneldoc explaining the difference between
lockdep_hardirqs_on_prepare() and lockdep_hardirqs_on().

-- Steve
