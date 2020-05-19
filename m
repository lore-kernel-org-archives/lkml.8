Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08F6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDEE207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgESV0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgESV0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:26:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A0D207E8;
        Tue, 19 May 2020 21:26:28 +0000 (UTC)
Date:   Tue, 19 May 2020 17:26:27 -0400
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
Subject: Re: [patch V6 01/37] tracing/hwlat: Use ktime_get_mono_fast_ns()
Message-ID: <20200519172627.7e65669e@gandalf.local.home>
In-Reply-To: <20200515235124.466962628@linutronix.de>
References: <20200515234547.710474468@linutronix.de>
        <20200515235124.466962628@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 May 2020 01:45:48 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Timestamping in the hardware latency detector uses sched_clock() underneath
> and depends on CONFIG_GENERIC_SCHED_CLOCK=n because sched clocks from that
> subsystem are not NMI safe.
> 
> ktime_get_mono_fast_ns() is NMI safe and available on all architectures.
> 
> Replace the time getter, get rid of the CONFIG_GENERIC_SCHED_CLOCK=n
> dependency and cleanup the horrible macro maze which encapsulates u64 math
> in u64 macros.

Good riddance. That macro maze was due to supporting the same code upstream
as we had in RHEL RT, where the math and time keeping functions available
between the two kernels were different.

That's been dealt with, but the macros never got cleaned up.

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/trace/trace_hwlat.c |   59 +++++++++++++++++++--------------------------
>  1 file changed, 25 insertions(+), 34 deletions(-)
> 
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -131,29 +131,19 @@ static void trace_hwlat_sample(struct hw
>  		trace_buffer_unlock_commit_nostack(buffer, event);
>  }
>  
> -/* Macros to encapsulate the time capturing infrastructure */
> -#define time_type	u64
> -#define time_get()	trace_clock_local()
> -#define time_to_us(x)	div_u64(x, 1000)
> -#define time_sub(a, b)	((a) - (b))
> -#define init_time(a, b)	(a = b)
> -#define time_u64(a)	a
> -
> +/*
> + * Timestamping uses ktime_get_mono_fast(), the NMI safe access to
> + * CLOCK_MONOTONIC.
> + */
>  void trace_hwlat_callback(bool enter)
>  {
>  	if (smp_processor_id() != nmi_cpu)
>  		return;
>  
> -	/*
> -	 * Currently trace_clock_local() calls sched_clock() and the
> -	 * generic version is not NMI safe.
> -	 */
> -	if (!IS_ENABLED(CONFIG_GENERIC_SCHED_CLOCK)) {
> -		if (enter)
> -			nmi_ts_start = time_get();
> -		else
> -			nmi_total_ts += time_get() - nmi_ts_start;
> -	}
> +	if (enter)
> +		nmi_ts_start = ktime_get_mono_fast_ns();
> +	else
> +		nmi_total_ts += ktime_get_mono_fast_ns() - nmi_ts_start;
>  
>  	if (enter)
>  		nmi_count++;
> @@ -165,20 +155,22 @@ void trace_hwlat_callback(bool enter)
>   * Used to repeatedly capture the CPU TSC (or similar), looking for potential
>   * hardware-induced latency. Called with interrupts disabled and with
>   * hwlat_data.lock held.
> + *
> + * Use ktime_get_mono_fast() here as well because it does not wait on the
> + * timekeeping seqcount like ktime_get_mono().

When doing a "git grep ktime_get_mono" I only find
ktime_get_mono_fast_ns() (and this comment), so I don't know what to compare
that to. Did you mean another function?

The rest looks fine (although, I see other things I need to clean up in
this code ;-)

-- Steve


>   */
>  static int get_sample(void)
>  {
>  	struct trace_array *tr = hwlat_trace;
>  	struct hwlat_sample s;
> -	time_type start, t1, t2, last_t2;
> +	u64 start, t1, t2, last_t2, thresh;
>  	s64 diff, outer_diff, total, last_total = 0;
>  	u64 sample = 0;
> -	u64 thresh = tracing_thresh;
>  	u64 outer_sample = 0;
>  	int ret = -1;
>  	unsigned int count = 0;
>  
