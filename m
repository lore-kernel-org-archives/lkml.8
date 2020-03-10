Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4BCC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C7820848
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Bbt2bdO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCJQVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:21:33 -0400
Received: from mail.efficios.com ([167.114.26.124]:48254 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJQVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:21:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5DD292710DD;
        Tue, 10 Mar 2020 12:21:32 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w9T7RxEtq-x5; Tue, 10 Mar 2020 12:21:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E20782710DA;
        Tue, 10 Mar 2020 12:21:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E20782710DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583857291;
        bh=tWZFnyCczeukzEgel4uS/lmDTXMSun6ygvYNDKKai0M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Bbt2bdO654UEm+wAltRuPhqQv0X5Fc2m6BKHOrapIuwXdsXMmNFbgo3QV8Yn9QkCF
         bvoKQjJsJqGd5/Y7JhRMUE1zaGDvL09gf4x39feIsWOOUyhO2Z6+dyaHT/7Hlne64a
         2/sjwZp1WeY4m5TdbCaFLJytJVDGtLo+KZgA/v0jOWNWvHIhznSZTy/O6Ii1WMm4WA
         OUwq6YSnREy8UNcjKPqiWdc8UCMQ+V6k4mDBQgziXV+iiOGUmsMDNIxXjr9mcb3Igh
         HCvdNVU83r3kR9nG3Q+Dd+fYgZZ4DEAbWH10Ucby4iVUVvVyCOixukv8yKOt4v1rhn
         OzPGfRoEQn5gg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o0hb4Qnavl1U; Tue, 10 Mar 2020 12:21:31 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D382227106E;
        Tue, 10 Mar 2020 12:21:31 -0400 (EDT)
Date:   Tue, 10 Mar 2020 12:21:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Message-ID: <1760242532.23694.1583857291763.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200310114657.099122fd@gandalf.local.home>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <20200309141546.5b574908@gandalf.local.home> <87fteh73sp.fsf@nanos.tec.linutronix.de> <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org> <87pndk5tb4.fsf@nanos.tec.linutronix.de> <450878559.23455.1583854311078.JavaMail.zimbra@efficios.com> <20200310114657.099122fd@gandalf.local.home>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: RTqroigTFUikIe4Q7CnVOH/BWK2GZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 10, 2020, at 11:46 AM, rostedt rostedt@goodmis.org wrote:

> On Tue, 10 Mar 2020 11:31:51 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> I think there are two distinct problems we are trying to solve here,
>> and it would be good to spell them out to see which pieces of technical
>> solution apply to which.
>> 
>> Problem #1) Tracer invoked from partially initialized kernel context
>> 
>>   - Moving the early/late entry/exit points into sections invisible from
>>     instrumentation seems to make tons of sense for this.
>> 
>> Problem #2) Tracer recursion
>> 
>>   - I'm much less convinced that hiding entry points from instrumentation
>>     works for this. As an example, with the isntr_begin/end() approach you
>>     propose above, as soon as you have a tracer recursing into itself because
>>     something below do_stuff() has been instrumented, having hidden the entry
>>     point did not help at all.
>> 
>> So I would be tempted to use the "hide entry/exit points" with explicit
>> instr begin/end annotation to solve Problem #1, but I'm still thinking there
>> is value in the per recursion context "in_tracing" flag to prevent tracer
>> recursion.
> 
> The only recursion issue that I've seen discussed is breakpoints. And
> that's outside of the tracer infrastructure. Basically, if someone added a
> breakpoint for a kprobe on something that gets called in the int3 code
> before kprobes is called we have (let's say rcu_nmi_enter()):
> 
> 
> rcu_nmi_enter();
>  <int3>
>     do_int3() {
>        rcu_nmi_enter();
>          <int3>
>             do_int3();
>                [..]
> 
> Where would a "in_tracer" flag help here? Perhaps a "in_breakpoint" could?

An approach where the "in_tracer" flag is tested and set by the instrumentation
(function tracer, kprobes, tracepoints) would work here. Let's say the beginning
of the int3 ISR is part of the code which is invisible to instrumentation, and
before we issue rcu_nmi_enter(), we handle the in_tracer flag:

rcu_nmi_enter();
 <int3>
    (recursion_ctx->in_tracer == false)
    set recursion_ctx->in_tracer = true
    do_int3() {
       rcu_nmi_enter();
         <int3>
            if (recursion_ctx->in_tracer == true)
                iret

We can change "in_tracer" for "in_breakpoint", "in_tracepoint" and
"in_function_trace" if we ever want to allow different types of instrumentation
to nest. I'm not sure whether this is useful or not through.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
