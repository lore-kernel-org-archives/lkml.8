Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E85C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D156B20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588918812;
	bh=I3X2enS2OqLjtPhgnubWwOb3w5o44g1ByLACf1WhlIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kiH2/VMSh6MY6jZdctUpNI1e+Ia4Cj15+tj370fHWmwRVeMJhTLZUBA9xLPO5AoP6
	 lRK3dLWUPjCVipqh6Kr+96VGurH63ze4mKMKgLft/3eqtHrqOOEK7AT6AhQYTwIHs+
	 va6cQn9l3lGwjAeo3mrQLDTLUVCyJhI2Cs0TRx08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHGTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgEHGTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:19:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 240ED20708;
        Fri,  8 May 2020 06:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588918789;
        bh=I3X2enS2OqLjtPhgnubWwOb3w5o44g1ByLACf1WhlIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YsO4UX1c8zXM/aL4ShYW8RFh9OLHwnW3x5vIG+sRyAgFflcXgoUH9kMgEb2LONKNT
         Avr6AK+zZd6BCfYvV8FqDWKXUZLdJ9VsAQfOTaQYJBZt/QBOL8nztYq70Rhdb63PwZ
         SDHMHj0bDctVaeF7WH7g0Zx4BbL4amt7pg753Ujo=
Date:   Fri, 8 May 2020 15:19:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
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
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 33/36] x86,tracing: Robustify
 ftrace_nmi_enter()
Message-Id: <20200508151942.c6bfdb20ee94858c9d147f07@kernel.org>
In-Reply-To: <20200505134101.340485295@linutronix.de>
References: <20200505131602.633487962@linutronix.de>
        <20200505134101.340485295@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 15:16:35 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
>   ftrace_nmi_enter()
>      trace_hwlat_callback()
>        trace_clock_local()
>          sched_clock()
>            paravirt_sched_clock()
>            native_sched_clock()
> 
> All must not be traced or kprobed, it will be called from do_debug()
> before the kprobe handler.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,


> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/x86/include/asm/paravirt.h |    2 +-
>  arch/x86/kernel/tsc.c           |    4 ++--
>  include/linux/ftrace_irq.h      |    4 ++--
>  kernel/trace/trace_clock.c      |    3 ++-
>  kernel/trace/trace_hwlat.c      |    2 +-
>  5 files changed, 8 insertions(+), 7 deletions(-)
> 
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -17,7 +17,7 @@
>  #include <linux/cpumask.h>
>  #include <asm/frame.h>
>  
> -static inline unsigned long long paravirt_sched_clock(void)
> +static __always_inline unsigned long long paravirt_sched_clock(void)
>  {
>  	return PVOP_CALL0(unsigned long long, time.sched_clock);
>  }
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -207,7 +207,7 @@ static void __init cyc2ns_init_secondary
>  /*
>   * Scheduler clock - returns current time in nanosec units.
>   */
> -u64 native_sched_clock(void)
> +noinstr u64 native_sched_clock(void)
>  {
>  	if (static_branch_likely(&__use_tsc)) {
>  		u64 tsc_now = rdtsc();
> @@ -240,7 +240,7 @@ u64 native_sched_clock_from_tsc(u64 tsc)
>  /* We need to define a real function for sched_clock, to override the
>     weak default version */
>  #ifdef CONFIG_PARAVIRT
> -unsigned long long sched_clock(void)
> +noinstr unsigned long long sched_clock(void)
>  {
>  	return paravirt_sched_clock();
>  }
> --- a/include/linux/ftrace_irq.h
> +++ b/include/linux/ftrace_irq.h
> @@ -7,7 +7,7 @@ extern bool trace_hwlat_callback_enabled
>  extern void trace_hwlat_callback(bool enter);
>  #endif
>  
> -static inline void ftrace_nmi_enter(void)
> +static __always_inline void ftrace_nmi_enter(void)
>  {
>  #ifdef CONFIG_HWLAT_TRACER
>  	if (trace_hwlat_callback_enabled)
> @@ -15,7 +15,7 @@ static inline void ftrace_nmi_enter(void
>  #endif
>  }
>  
> -static inline void ftrace_nmi_exit(void)
> +static __always_inline void ftrace_nmi_exit(void)
>  {
>  #ifdef CONFIG_HWLAT_TRACER
>  	if (trace_hwlat_callback_enabled)
> --- a/kernel/trace/trace_clock.c
> +++ b/kernel/trace/trace_clock.c
> @@ -22,6 +22,7 @@
>  #include <linux/sched/clock.h>
>  #include <linux/ktime.h>
>  #include <linux/trace_clock.h>
> +#include <linux/kprobes.h>
>  
>  /*
>   * trace_clock_local(): the simplest and least coherent tracing clock.
> @@ -29,7 +30,7 @@
>   * Useful for tracing that does not cross to other CPUs nor
>   * does it go through idle events.
>   */
> -u64 notrace trace_clock_local(void)
> +u64 noinstr trace_clock_local(void)
>  {
>  	u64 clock;
>  
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -139,7 +139,7 @@ static void trace_hwlat_sample(struct hw
>  #define init_time(a, b)	(a = b)
>  #define time_u64(a)	a
>  
> -void trace_hwlat_callback(bool enter)
> +noinstr void trace_hwlat_callback(bool enter)
>  {
>  	if (smp_processor_id() != nmi_cpu)
>  		return;
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
