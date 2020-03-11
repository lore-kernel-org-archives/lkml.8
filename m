Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2314CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2953215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="quq+3ext"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgCKAhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 20:37:43 -0400
Received: from mail.efficios.com ([167.114.26.124]:59034 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCKAhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:37:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E7596274CD6;
        Tue, 10 Mar 2020 20:37:41 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mJln51YZFwyu; Tue, 10 Mar 2020 20:37:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9825F274CD5;
        Tue, 10 Mar 2020 20:37:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9825F274CD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583887061;
        bh=U7LALiVWnzC6Qqk8on30unANb+95Awa8y5B50fzooEw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=quq+3extVd1A47yffX1wsAG3fOcc5745ii4EGJDOwqVXggQnIG6DPa/lgcO8dtg4E
         gIEHrpjlWFTtkqD4ZQQewWAY/0fQPeG4RfbU195kEUXLNB4MnW0B1y+XLZQr9RAKCK
         UReuqrFBrfI3seiptMl3l5e5hsn4D6H1CQNxEGjrj4d2mz43/216H5d5T/kaDjwpEz
         jjf97Pp0Je94eXw9YKRahysJkEyR/Cs/M+bbfMT3M/+rYsPvDQG7juDeTVnkm2JMwd
         onMpmkOkCX5xmZV+3YWmhRZkXx2QAtXOBkzmxTsBPrXoIZp0fP5tkjw3a2Khnm9yku
         TuFBz91uXJKXQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R9pO-4JRyErH; Tue, 10 Mar 2020 20:37:41 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 8626E275011;
        Tue, 10 Mar 2020 20:37:41 -0400 (EDT)
Date:   Tue, 10 Mar 2020 20:37:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Message-ID: <831351096.24668.1583887061530.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200311091815.fce458348bb7641b60f600d9@kernel.org>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <87fteh73sp.fsf@nanos.tec.linutronix.de> <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org> <87pndk5tb4.fsf@nanos.tec.linutronix.de> <450878559.23455.1583854311078.JavaMail.zimbra@efficios.com> <20200310114657.099122fd@gandalf.local.home> <1760242532.23694.1583857291763.JavaMail.zimbra@efficios.com> <20200311091815.fce458348bb7641b60f600d9@kernel.org>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: hz+zwspBrcoLTdRQIpEDllLfCMkCTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 10, 2020, at 8:18 PM, Masami Hiramatsu mhiramat@kernel.org wrote:
[...]
 
>> An approach where the "in_tracer" flag is tested and set by the instrumentation
>> (function tracer, kprobes, tracepoints) would work here. Let's say the beginning
>> of the int3 ISR is part of the code which is invisible to instrumentation, and
>> before we issue rcu_nmi_enter(), we handle the in_tracer flag:
>> 
>> rcu_nmi_enter();
>>  <int3>
>>     (recursion_ctx->in_tracer == false)
>>     set recursion_ctx->in_tracer = true
>>     do_int3() {
>>        rcu_nmi_enter();
>>          <int3>
>>             if (recursion_ctx->in_tracer == true)
>>                 iret
>> 
>> We can change "in_tracer" for "in_breakpoint", "in_tracepoint" and
>> "in_function_trace" if we ever want to allow different types of instrumentation
>> to nest. I'm not sure whether this is useful or not through.
> 
> Kprobes already has its own "in_kprobe" flag, and the recursion path is
> not so simple. Since the int3 replaces the original instruction, we have to
> execute the original instruction with single-step and fixup.
> 
> This means it involves do_debug() too. Thus, we can not do iret directly
> from do_int3 like above, but if recursion happens, we have no way to
> recover to origonal execution path (and call BUG()).

I think that all the code involved when hitting a breakpoint which would
be the minimal subset required to act as if the kprobe was not there in the
first place (single-step, fixup) should be hidden from kprobes
instrumentation. I suspect this is the current intent today with noprobe
annotations, but Thomas' proposal brings this a step further.

However, any other kprobe code (and tracer callbacks) beyond that
minimalistic "effect-less" kprobe could be protected by a
per-recursion-context in_kprobe flag.

> As my previous email, I showed a patch which is something like
> "bust_kprobes()" for oops path. That is not safe but no other way to escape
> from this recursion hell. (Maybe we can try to call it instead of calling
> BUG() so that the kernel can continue to run, but I'm not sure we can
> safely make the pagetable to readonly again.)

As long as we provide a minimalistic "effect-less" kprobe implementation
in a non-instrumentable section which can be used whenever we are in a
recursion scenario, I think we could achieve something recursion-free without
requiring a bust_kprobes() work-around.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
