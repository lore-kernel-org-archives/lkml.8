Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D89C3F2D0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCADD222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583885952;
	bh=UcNtWpBPblu9vR73y/1seDmYC7BGlEjFnb+kqdeS3Bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RESrt4nA8G7ua56ueZ5M73oz16H56sI+DDLI1M5MQ5S8yY0TaZ3TGj500mPP9qi7e
	 qb/4VPR6MVBURMnocdHe8m6tuXsOeCZjESUwF33xIKZfcqPaH9Gm7/zvLFT7BSMjDE
	 H59HH7Dn/AFIxixjLAo8fHTRCVZnZiQS5FUJB1zQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgCKASW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 20:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgCKASW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:18:22 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86637222C4;
        Wed, 11 Mar 2020 00:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583885901;
        bh=UcNtWpBPblu9vR73y/1seDmYC7BGlEjFnb+kqdeS3Bk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zkmttxiF36VLz6lg5tyYyttgoIp2YkTtMDmbi+ciIQ/EXhdFDmRQAzjeAkVf9I9gp
         cHJ2iJu1z9A3KSuYWOQYtYFY+R5y6kp+KfCtp77SKI7WMz2RzjVp+KbLCUBN6Cwj1f
         YCIpFEhGYhi1ygDGR/zWxoyr5cx2FyIDleoO6X00=
Date:   Wed, 11 Mar 2020 09:18:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: Instrumentation and RCU
Message-Id: <20200311091815.fce458348bb7641b60f600d9@kernel.org>
In-Reply-To: <1760242532.23694.1583857291763.JavaMail.zimbra@efficios.com>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
        <20200309141546.5b574908@gandalf.local.home>
        <87fteh73sp.fsf@nanos.tec.linutronix.de>
        <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
        <87pndk5tb4.fsf@nanos.tec.linutronix.de>
        <450878559.23455.1583854311078.JavaMail.zimbra@efficios.com>
        <20200310114657.099122fd@gandalf.local.home>
        <1760242532.23694.1583857291763.JavaMail.zimbra@efficios.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Tue, 10 Mar 2020 12:21:31 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Mar 10, 2020, at 11:46 AM, rostedt rostedt@goodmis.org wrote:
> 
> > On Tue, 10 Mar 2020 11:31:51 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> >> I think there are two distinct problems we are trying to solve here,
> >> and it would be good to spell them out to see which pieces of technical
> >> solution apply to which.
> >> 
> >> Problem #1) Tracer invoked from partially initialized kernel context
> >> 
> >>   - Moving the early/late entry/exit points into sections invisible from
> >>     instrumentation seems to make tons of sense for this.
> >> 
> >> Problem #2) Tracer recursion
> >> 
> >>   - I'm much less convinced that hiding entry points from instrumentation
> >>     works for this. As an example, with the isntr_begin/end() approach you
> >>     propose above, as soon as you have a tracer recursing into itself because
> >>     something below do_stuff() has been instrumented, having hidden the entry
> >>     point did not help at all.
> >> 
> >> So I would be tempted to use the "hide entry/exit points" with explicit
> >> instr begin/end annotation to solve Problem #1, but I'm still thinking there
> >> is value in the per recursion context "in_tracing" flag to prevent tracer
> >> recursion.
> > 
> > The only recursion issue that I've seen discussed is breakpoints. And
> > that's outside of the tracer infrastructure. Basically, if someone added a
> > breakpoint for a kprobe on something that gets called in the int3 code
> > before kprobes is called we have (let's say rcu_nmi_enter()):
> > 
> > 
> > rcu_nmi_enter();
> >  <int3>
> >     do_int3() {
> >        rcu_nmi_enter();
> >          <int3>
> >             do_int3();
> >                [..]
> > 
> > Where would a "in_tracer" flag help here? Perhaps a "in_breakpoint" could?
> 
> An approach where the "in_tracer" flag is tested and set by the instrumentation
> (function tracer, kprobes, tracepoints) would work here. Let's say the beginning
> of the int3 ISR is part of the code which is invisible to instrumentation, and
> before we issue rcu_nmi_enter(), we handle the in_tracer flag:
> 
> rcu_nmi_enter();
>  <int3>
>     (recursion_ctx->in_tracer == false)
>     set recursion_ctx->in_tracer = true
>     do_int3() {
>        rcu_nmi_enter();
>          <int3>
>             if (recursion_ctx->in_tracer == true)
>                 iret
> 
> We can change "in_tracer" for "in_breakpoint", "in_tracepoint" and
> "in_function_trace" if we ever want to allow different types of instrumentation
> to nest. I'm not sure whether this is useful or not through.

Kprobes already has its own "in_kprobe" flag, and the recursion path is
not so simple. Since the int3 replaces the original instruction, we have to
execute the original instruction with single-step and fixup.

This means it involves do_debug() too. Thus, we can not do iret directly
from do_int3 like above, but if recursion happens, we have no way to
recover to origonal execution path (and call BUG()).

As my previous email, I showed a patch which is something like
"bust_kprobes()" for oops path. That is not safe but no other way to escape
from this recursion hell. (Maybe we can try to call it instead of calling
BUG() so that the kernel can continue to run, but I'm not sure we can
safely make the pagetable to readonly again.)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
