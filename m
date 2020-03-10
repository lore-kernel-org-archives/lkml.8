Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBF5C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4C421D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mfjjClrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCJRkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:40:06 -0400
Received: from mail.efficios.com ([167.114.26.124]:47352 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgCJRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:40:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 901812718AE;
        Tue, 10 Mar 2020 13:40:04 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7u8iEzcEV_87; Tue, 10 Mar 2020 13:40:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2CBC52717D1;
        Tue, 10 Mar 2020 13:40:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2CBC52717D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583862004;
        bh=iONBCAnNnPUIdJmi3a+nz18hpW44b+1vL2nzHQR+DuQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=mfjjClrcJZA6gu5jXccb1pKaRSypbi4RF+6lz5aZdSN5aW1mOa6UONJljm9SM/aiD
         tH/7QhsfrT4deUqGZlfdwwhUnDiADbP8jPPsoYLxgB6YZIAg47PZ+zxch0f12PjsKY
         vU/ZyN+v6hZT1vyHjjN9L43/TLJUmbuERf+vAXfwf7mLaNsK7GxsnysFXP5++H2Xs7
         chh3RU9aGhmxvGDlnkR7gY0v1SVWlfRg/VGDoF7d689mNyKHxAGnlOlsqJ7CUrx7lq
         ks3OT8/hHAVMEgREzRb61mOLWpM6n+NlgD9F38wsVQvaopONiYPaPT6pjeRCa+259n
         cziePMG5SDqAw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OWi771wHAZwD; Tue, 10 Mar 2020 13:40:04 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 15C3E271929;
        Tue, 10 Mar 2020 13:40:04 -0400 (EDT)
Date:   Tue, 10 Mar 2020 13:40:03 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Message-ID: <1666704263.23816.1583862003925.JavaMail.zimbra@efficios.com>
In-Reply-To: <87imjc5f6a.fsf@nanos.tec.linutronix.de>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com> <871rq171ca.fsf@nanos.tec.linutronix.de> <1489283504.23399.1583852595008.JavaMail.zimbra@efficios.com> <87imjc5f6a.fsf@nanos.tec.linutronix.de>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: 0nTX/RKhF+4jMm6zLS3dy/aLVWymRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 10, 2020, at 12:48 PM, Thomas Gleixner tglx@linutronix.de wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
[...]
> See the entry series I'm working on. Aside of moving all this nonsense
> into C-code it splits lockdep and tracing so it looks like this:
> 
>            lockdep_hardirqs_off();
>            user_exit_irqsoff();
>            __trace_hardirqs_off();
> 
> The latter uses regular RCU and not the scru/rcu_irq dance.
> 

Awesome :)

> 
>>>> If a tracer recurses, or if a tracer attempts to trace another tracer, the
>>>> instrumentation would break the recursion chain by preventing instrumentation
>>>> from firing. If we end up caring about tracers tracing other tracers, we could
>>>> have one distinct flag per tracer and let each tracer break the recursion chain.
>>>>
>>>> Having this flag per kernel stack rather than per CPU or per thread would
>>>> allow tracing of nested interrupt handlers (and NMIs), but would break
>>>> call chains both within the same stack or going through a trap. I think
>>>> it could be a nice complementary safety net to handle mishaps in a non-fatal
>>>> way.
>>> 
>>> That works as long as none of this uses breakpoint based patching to
>>> dynamically disable/enable stuff.
>>
>> I'm clearly missing something here. I was expecting the "in_tracing" flag trick
>> to be able to fix the breakpoint recursion issue. What is the problem I'm
>> missing
>> here ?
> 
> How do you "fix" that when you can't reach the tracepoint because you
> trip over a breakpoint and then while trying to fixup that stuff you hit
> another one?

I may still be missing something, but if the fixup code (AFAIU the code performing
the out-of-line single-stepping of the original instruction) belongs to a section
hidden from instrumentation, it should not be an issue.

The basic idea would be, e.g. pseudo-code for int3:

<int3>  <---- in section which cannot be instrumented
if (recursion_ctx->in_tracer) {
   single-step original instruction
   iret
}
[...] prepare stuff
recursion_ctx->in_tracer = true;
instr_allowed()

call external kernel functions (which can be instrumented)

instr_disallowed()
recursion_ctx->in_tracer = false;
single-step original instruction
iret

The purpose of the "in_tracer" flag is to protect whatever is done within external
kernel functions (which can be instrumented) from triggering tracer recursion. It
needs to be combined with hiding of early/late low-level entry/exit functions from
instrumentation (as you propose) to work.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
