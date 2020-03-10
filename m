Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C20CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4803215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCJPrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCJPrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:47:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2874C20866;
        Tue, 10 Mar 2020 15:46:59 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:46:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: Instrumentation and RCU
Message-ID: <20200310114657.099122fd@gandalf.local.home>
In-Reply-To: <450878559.23455.1583854311078.JavaMail.zimbra@efficios.com>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
        <20200309141546.5b574908@gandalf.local.home>
        <87fteh73sp.fsf@nanos.tec.linutronix.de>
        <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
        <87pndk5tb4.fsf@nanos.tec.linutronix.de>
        <450878559.23455.1583854311078.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 11:31:51 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I think there are two distinct problems we are trying to solve here,
> and it would be good to spell them out to see which pieces of technical
> solution apply to which.
> 
> Problem #1) Tracer invoked from partially initialized kernel context
> 
>   - Moving the early/late entry/exit points into sections invisible from
>     instrumentation seems to make tons of sense for this.
> 
> Problem #2) Tracer recursion
> 
>   - I'm much less convinced that hiding entry points from instrumentation
>     works for this. As an example, with the isntr_begin/end() approach you
>     propose above, as soon as you have a tracer recursing into itself because
>     something below do_stuff() has been instrumented, having hidden the entry
>     point did not help at all.
> 
> So I would be tempted to use the "hide entry/exit points" with explicit
> instr begin/end annotation to solve Problem #1, but I'm still thinking there
> is value in the per recursion context "in_tracing" flag to prevent tracer
> recursion.

The only recursion issue that I've seen discussed is breakpoints. And
that's outside of the tracer infrastructure. Basically, if someone added a
breakpoint for a kprobe on something that gets called in the int3 code
before kprobes is called we have (let's say rcu_nmi_enter()):


 rcu_nmi_enter();
  <int3>
     do_int3() {
        rcu_nmi_enter();
          <int3>
             do_int3();
                [..]

Where would a "in_tracer" flag help here? Perhaps a "in_breakpoint" could?

-- Steve
