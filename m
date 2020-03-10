Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D2C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC5021927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583861204;
	bh=bDNkvVl2IUXM6TlbwkSJ/orXHQ/JdYR8AwtLVGVWtDk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=y6bITiC/22xqEDUU0tVmFwUQfD0zJeYThO9xO4WHXKsdLEfOy6zpLdPLEerwIVp+m
	 y4r+a60Na7q+RqEXkVOS0Xsfl+J2qCJMQ1OfmDI+nQGdLzyrHZ5Czdq8PtcT6n9sfb
	 kEbEFGb0Dt99n/rxZPAOzET3zraGIOae0amsEvHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCJR0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJR0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:26:43 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC8E2146E;
        Tue, 10 Mar 2020 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583861202;
        bh=bDNkvVl2IUXM6TlbwkSJ/orXHQ/JdYR8AwtLVGVWtDk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fWii4LBOv1kQRuFHgrE2gSUuVI3Gd95dTbma4MU3XqeS7WnRIeefoDeNSH8DVfexJ
         6Alq5QRW2J0Qo5e5UQ6eJwkXwk4gCF80vLdGkbJkTxOW3Q3zFSeMGYsXmMcyisybRh
         IEhJ4zpJnMh8riNiyeKZ8qJ0Wi/dD2B3ptDuKr08=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7381635229CC; Tue, 10 Mar 2020 10:26:42 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:26:42 -0700
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
Message-ID: <20200310172642.GG2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
 <20200309204710.GU2935@paulmck-ThinkPad-P72>
 <379743142.23419.1583853207158.JavaMail.zimbra@efficios.com>
 <20200310164927.GD2935@paulmck-ThinkPad-P72>
 <1800881789.23773.1583860965967.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1800881789.23773.1583860965967.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 01:22:45PM -0400, Mathieu Desnoyers wrote:
> ----- On Mar 10, 2020, at 12:49 PM, paulmck paulmck@kernel.org wrote:
> 
> > On Tue, Mar 10, 2020 at 11:13:27AM -0400, Mathieu Desnoyers wrote:
> >> 
> >> 
> >> ----- On Mar 9, 2020, at 4:47 PM, paulmck paulmck@kernel.org wrote:
> >> [...]
> >> 
> >> > 
> >> > Suppose that we had a variant of RCU that had about the same read-side
> >> > overhead as Preempt-RCU, but which could be used from idle as well as
> >> > from CPUs in the process of coming online or going offline?  I have not
> >> > thought through the irq/NMI/exception entry/exit cases, but I don't see
> >> > why that would be problem.
> >> > 
> >> > This would have explicit critical-section entry/exit code, so it would
> >> > not be any help for trampolines.
> >> > 
> >> > Would such a variant of RCU help?
> >> > 
> >> > Yeah, I know.  Just what the kernel doesn't need, yet another variant
> >> > of RCU...
> >> 
> >> Hi Paul,
> >> 
> >> I think that before introducing yet another RCU flavor, it's important
> >> to take a step back and look at the tracer requirements first. If those
> >> end up being covered by currently available RCU flavors, then why add
> >> another ?
> > 
> > Well, we have BPF requirements as well.
> > 
> >> I can start with a few use-cases I have in mind. Others should feel free
> >> to pitch in:
> >> 
> >> Tracing callsite context:
> >> 
> >> 1) Thread context
> >> 
> >>    1.1) Preemption enabled
> >> 
> >>    One tracepoint in this category is syscall enter/exit. We should introduce
> >>    a variant of tracepoints relying on SRCU for this use-case so we can take
> >>    page faults when fetching userspace data.
> > 
> > Agreed, SRCU works fine for the page-fault case, as the read-side memory
> > barriers are in the noise compared to page-fault overhead.  Back in
> > the day, there were light-weight system calls.  Are all of these now
> > converted to VDSO or similar?
> 
> There is a big difference between allowing page faults to happen, and expecting
> page faults to happen every time. I suspect many use-cases will end up having
> a fast-path which touches user-space data which is in the page cache, but
> may end up triggering page faults in rare occasions.
> 
> Therefore, this might justify an SRCU which has low-overhead read-side.

OK, good to know, thank you!

							Thanx, Paul
