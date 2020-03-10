Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA77C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804C821D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583858969;
	bh=aZeeJI4m4VA8ZtSKMjKdiWAG3VUJVrzCbJacfmOigbk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qto4O45Vc8jQk4YVKKX0utqCrDVkAy9gyrLyT9bpHq//YtMtckYFGTmdOM/fAX5+5
	 ZPDhpf6CaQ7hwgABXNcuvTjNFLqYI7G0nknEDNQHz4QqalTX9LU5mkwoJ+yT3r/0c+
	 luSfZVdWcuoXoXQIwUB3toN2e2yNAn19llXMKbVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgCJQt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgCJQt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:49:28 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C1D321927;
        Tue, 10 Mar 2020 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583858967;
        bh=aZeeJI4m4VA8ZtSKMjKdiWAG3VUJVrzCbJacfmOigbk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EN8bsFrHW5CSe5hqSMYnzI6bVJxJrFU1KeDLhy7aWdoO69m+Qh9WglObnp+WfrWbe
         9NegxcjuXjpEdBF0vCmlcMxg5CENvEmjq2kHND9IeSg/1eBSeP3nHHp4W1S5KmPzMQ
         SQIYJvibJM6bn0EGU+a1EwuBcrVaUw37T8s5jJUc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 190C035229CC; Tue, 10 Mar 2020 09:49:27 -0700 (PDT)
Date:   Tue, 10 Mar 2020 09:49:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Instrumentation and RCU
Message-ID: <20200310164927.GD2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
 <20200309204710.GU2935@paulmck-ThinkPad-P72>
 <379743142.23419.1583853207158.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <379743142.23419.1583853207158.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:13:27AM -0400, Mathieu Desnoyers wrote:
> 
> 
> ----- On Mar 9, 2020, at 4:47 PM, paulmck paulmck@kernel.org wrote:
> [...]
> 
> > 
> > Suppose that we had a variant of RCU that had about the same read-side
> > overhead as Preempt-RCU, but which could be used from idle as well as
> > from CPUs in the process of coming online or going offline?  I have not
> > thought through the irq/NMI/exception entry/exit cases, but I don't see
> > why that would be problem.
> > 
> > This would have explicit critical-section entry/exit code, so it would
> > not be any help for trampolines.
> > 
> > Would such a variant of RCU help?
> > 
> > Yeah, I know.  Just what the kernel doesn't need, yet another variant
> > of RCU...
> 
> Hi Paul,
> 
> I think that before introducing yet another RCU flavor, it's important
> to take a step back and look at the tracer requirements first. If those
> end up being covered by currently available RCU flavors, then why add
> another ?

Well, we have BPF requirements as well.

> I can start with a few use-cases I have in mind. Others should feel free
> to pitch in:
> 
> Tracing callsite context:
> 
> 1) Thread context
> 
>    1.1) Preemption enabled
> 
>    One tracepoint in this category is syscall enter/exit. We should introduce
>    a variant of tracepoints relying on SRCU for this use-case so we can take
>    page faults when fetching userspace data.

Agreed, SRCU works fine for the page-fault case, as the read-side memory
barriers are in the noise compared to page-fault overhead.  Back in
the day, there were light-weight system calls.  Are all of these now
converted to VDSO or similar?

>    1.2) Preemption disabled
> 
>    Tree-RCU works fine.
> 
>    1.3) IRQs disabled
> 
>    Tree-RCU works fine.
> 
> 2) IRQ handler context
> 
>    Tree-RCU works fine.
> 
> 3) NMI context
> 
>    Tree-RCU works fine.
> 
> 4) cpuidle context (!rcu_is_watching())
> 
>    - By all means, we should not have tracepoints requiring to temporarily enable
>      RCU in frequent code-paths. It appears that we should be able to remove the few
>      offenders we currently have (e.g. enter from usermode),
>    - For tracepoints which are infrequently called from !rcu_is_watching context, checking
>      whether RCU is watching and only enabling when needed should be fast enough.
> 
> Are there other use-cases am I missing that would justify adding another flavor of RCU ?

BPF programs that might sometimes sleep, but are usually lightweight.

I will be double-checking this, of course.

							Thanx, Paul
