Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93001C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA9C206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgEOBcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 21:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgEOBcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:32:35 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58C9B20671;
        Fri, 15 May 2020 01:32:32 +0000 (UTC)
Date:   Thu, 14 May 2020 21:32:30 -0400
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V5 03/38] nmi, tracing: Provide nmi_enter/exit_notrace()
Message-ID: <20200514213230.02c13bd2@oasis.local.home>
In-Reply-To: <20200512213809.678944067@linutronix.de>
References: <20200512210059.056244513@linutronix.de>
        <20200512213809.678944067@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 23:01:02 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> To fully isolate #DB and #BP from instrumentable code it's necessary to
> avoid invoking the hardware latency tracer on nmi_enter/exit().
> 
> Provide nmi_enter/exit() variants which are not invoking the hardware
> latency tracer. That allows to put calls explicitely into the call sites
> outside of the kprobe handling.

The only thing the hardware latency tracer is using this for is to
denote that something happened while it was timing "nothing" happening.

It's accounting only. Now it does use a per-cpu variable (which I see
in other patches can be an issue) and calls time_get().

Now if per-cpu nor time_get() can not be called in noinstr, then I'm
perfectly fine with this patch. But if they are allowed, I don't think
that this patch is necessary, and we could perhaps mark the hardware
latency hook as noinstr instead?

-- Steve


> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V5: New patch
> ---
>  include/linux/hardirq.h |   18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -77,28 +77,38 @@ extern void irq_exit(void);
>  /*
>   * nmi_enter() can nest up to 15 times; see NMI_BITS.
>   */
> -#define nmi_enter()						\
> +#define nmi_enter_notrace()					\
>  	do {							\
>  		arch_nmi_enter();				\
>  		printk_nmi_enter();				\
>  		lockdep_off();					\
> -		ftrace_nmi_enter();				\
>  		BUG_ON(in_nmi() == NMI_MASK);			\
>  		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
>  		rcu_nmi_enter();				\
>  		lockdep_hardirq_enter();			\
>  	} while (0)
>  
> -#define nmi_exit()						\
> +#define nmi_enter()						\
> +	do {							\
> +		nmi_enter_notrace();				\
> +		ftrace_nmi_enter();				\
> +	} while (0)
> +
> +#define nmi_exit_notrace()					\
>  	do {							\
>  		lockdep_hardirq_exit();				\
>  		rcu_nmi_exit();					\
>  		BUG_ON(!in_nmi());				\
>  		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
> -		ftrace_nmi_exit();				\
>  		lockdep_on();					\
>  		printk_nmi_exit();				\
>  		arch_nmi_exit();				\
>  	} while (0)
>  
> +#define nmi_exit()						\
> +	do {							\
> +		ftrace_nmi_exit();				\
> +		nmi_exit_notrace();				\
> +	} while (0)
> +
>  #endif /* LINUX_HARDIRQ_H */

