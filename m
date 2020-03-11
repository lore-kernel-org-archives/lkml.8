Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66C4C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B562D21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583912913;
	bh=h63yO/1roKktV4/aGFgyvBaApa9Kyssf1SJdq2X5Omc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gKaSkcFmIG6pyL41/k1M/xXOUU9U8GJHZ6D3vW9ZCk827Uz0lDyoNdNt1LQRy2tP0
	 HzGCmA7ewcBNj/vhTPbQkFtKt1wsikmzf8SnoE6sNV5TJjRRMShY/tTuQvZEpK3Mzg
	 Iliy0UHdsWR5bY0BtukLUuCSpFm4+fMSnedsUVZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgCKHsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:48:32 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11DAC206B7;
        Wed, 11 Mar 2020 07:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583912911;
        bh=h63yO/1roKktV4/aGFgyvBaApa9Kyssf1SJdq2X5Omc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MPM3l4NWa55jBhrfZOgMq+GGJK3rPcGnuS9FxXMhgvZBXnsJA1EFTx2dTVwovOb5M
         poXUheXyzwgGWPTUxdLBb3P24gEDdrI/dU+3qtF93S+TELZ4DjM6Wf8Fe63JzFpCzW
         5Ffy+wqm1PyyDf+maUwfPDkZchIZAPYp4T/z4Eqg=
Date:   Wed, 11 Mar 2020 16:48:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: Instrumentation and RCU
Message-Id: <20200311164826.0e7eab4bcf7d58b922d59ae9@kernel.org>
In-Reply-To: <831351096.24668.1583887061530.JavaMail.zimbra@efficios.com>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
        <87fteh73sp.fsf@nanos.tec.linutronix.de>
        <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
        <87pndk5tb4.fsf@nanos.tec.linutronix.de>
        <450878559.23455.1583854311078.JavaMail.zimbra@efficios.com>
        <20200310114657.099122fd@gandalf.local.home>
        <1760242532.23694.1583857291763.JavaMail.zimbra@efficios.com>
        <20200311091815.fce458348bb7641b60f600d9@kernel.org>
        <831351096.24668.1583887061530.JavaMail.zimbra@efficios.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 20:37:41 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Mar 10, 2020, at 8:18 PM, Masami Hiramatsu mhiramat@kernel.org wrote:
> [...]
>  
> >> An approach where the "in_tracer" flag is tested and set by the instrumentation
> >> (function tracer, kprobes, tracepoints) would work here. Let's say the beginning
> >> of the int3 ISR is part of the code which is invisible to instrumentation, and
> >> before we issue rcu_nmi_enter(), we handle the in_tracer flag:
> >> 
> >> rcu_nmi_enter();
> >>  <int3>
> >>     (recursion_ctx->in_tracer == false)
> >>     set recursion_ctx->in_tracer = true
> >>     do_int3() {
> >>        rcu_nmi_enter();
> >>          <int3>
> >>             if (recursion_ctx->in_tracer == true)
> >>                 iret
> >> 
> >> We can change "in_tracer" for "in_breakpoint", "in_tracepoint" and
> >> "in_function_trace" if we ever want to allow different types of instrumentation
> >> to nest. I'm not sure whether this is useful or not through.
> > 
> > Kprobes already has its own "in_kprobe" flag, and the recursion path is
> > not so simple. Since the int3 replaces the original instruction, we have to
> > execute the original instruction with single-step and fixup.
> > 
> > This means it involves do_debug() too. Thus, we can not do iret directly
> > from do_int3 like above, but if recursion happens, we have no way to
> > recover to origonal execution path (and call BUG()).
> 
> I think that all the code involved when hitting a breakpoint which would
> be the minimal subset required to act as if the kprobe was not there in the
> first place (single-step, fixup) should be hidden from kprobes
> instrumentation. I suspect this is the current intent today with noprobe
> annotations, but Thomas' proposal brings this a step further.
> 
> However, any other kprobe code (and tracer callbacks) beyond that
> minimalistic "effect-less" kprobe could be protected by a
> per-recursion-context in_kprobe flag.

Would you mean "in_kprobe" flag will prevent recursive execution of
kprobes but not prevent other tracer like tracepoint? If so, it is
already done I think. As I pointed, kprobe itself has in_kprobe like
flag for checking re-entrance. Thus the kprobe handler can call the
function which has a tracepoint safely.

Anyway, I agree with you to port all kprobe int3/debug handling parts
to the effect-less (offlimit) area, except for its pre/post handlers.

> > As my previous email, I showed a patch which is something like
> > "bust_kprobes()" for oops path. That is not safe but no other way to escape
> > from this recursion hell. (Maybe we can try to call it instead of calling
> > BUG() so that the kernel can continue to run, but I'm not sure we can
> > safely make the pagetable to readonly again.)
> 
> As long as we provide a minimalistic "effect-less" kprobe implementation
> in a non-instrumentable section which can be used whenever we are in a
> recursion scenario, I think we could achieve something recursion-free without
> requiring a bust_kprobes() work-around.

Yeah, I hope so. The bust_kprobes() is something like an emergency escape
hammer which everyone hopes never be used :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
