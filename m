Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B5AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423C320773
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NpvKk4KC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgFZPY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:24:57 -0400
Received: from mail.efficios.com ([167.114.26.124]:59664 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFZPY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:24:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 192E52D42AC;
        Fri, 26 Jun 2020 11:24:55 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id grby5fTKR4lp; Fri, 26 Jun 2020 11:24:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BECF82D4167;
        Fri, 26 Jun 2020 11:24:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BECF82D4167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593185094;
        bh=ILoOKMJ0HLWoZQ0SlDq/HWBiD80XSi4+j4ffedAs92M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NpvKk4KCrbtpG5U23+PYLC6Mfj3U7b8gmzFxtFG8tXQSu2OdmGw79BlUh1RVl4zP0
         SelHLW7x0a8D8iZNwYqxlWeymC0BBOQBnWDb1M/S4+xWmpZZtDxAS/x3oDbEZBjxso
         PUz0gUW+YZnYIpqwCScH9nGQ3Dy4/fohf601Gt9Z33BfRAE+0bsKUJVkFI96jLR5yM
         wH6a6U1nTt6upaQNvMNFU708jAAr650A688KEeN56TJr/rQgna3CEQe4lSY+nJOXWS
         FJcULNn2R02SMj5fIYMy5ur43hNN7xu2zoiLfTVpB/f7Lk/gG9+mrLWbxmK53KdnSd
         sVQX36M1WRymg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xx9DgTLid4es; Fri, 26 Jun 2020 11:24:54 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A955D2D415E;
        Fri, 26 Jun 2020 11:24:54 -0400 (EDT)
Date:   Fri, 26 Jun 2020 11:24:54 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        paulmck <paulmck@kernel.org>, Julien Desfossez <ju@klipix.org>
Message-ID: <150431492.14312.1593185094592.JavaMail.zimbra@efficios.com>
In-Reply-To: <1747476740.14310.1593184577574.JavaMail.zimbra@efficios.com>
References: <20200619202516.7109-1-mathieu.desnoyers@efficios.com> <20200624121136.GF4800@hirez.programming.kicks-ass.net> <269292405.11607.1593023493676.JavaMail.zimbra@efficios.com> <20200624195030.GG4800@hirez.programming.kicks-ass.net> <1115572712.12427.1593096995446.JavaMail.zimbra@efficios.com> <489418873.12472.1593102891027.JavaMail.zimbra@efficios.com> <1747476740.14310.1593184577574.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH v2] sched_pair_cpu: Introduce scheduler task pairing
 system call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: sched_pair_cpu: Introduce scheduler task pairing system call
Thread-Index: KKF2EJ/UOyY4CnhVA6NZtcIQEi8jPD1z4gT9UfinMbYU+XsliA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Jun 26, 2020, at 11:16 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jun 25, 2020, at 12:34 PM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On Jun 25, 2020, at 10:56 AM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>>> ----- On Jun 24, 2020, at 3:50 PM, Peter Zijlstra peterz@infradead.org wrote:
>>> 
>>>> On Wed, Jun 24, 2020 at 02:31:33PM -0400, Mathieu Desnoyers wrote:
>>>> 
>>> [...]
>>>> The other alternative is using a preempt_notifier for the worker I
>>>> suppose.
>>> 
>> [...]
>>>> 
>>>> preempt_notifier could work here too I suppose, install it on yourself
>>>> when you do the pear syscall and take it away again when you're finished
>>>> with it.
>> 
>> The issue I currently have with preempt notifiers is that I need to
>> send an IPI from a sched_out notifier, which has interrupts off and
>> hold the rq lock. smp_call_function_single() warns due to irq off, and
>> indeed it triggers deadlocks.
>> 
>> Before using preempt notifiers, I was touching the "prev" task after
>> irqs were reenabled and rq lock was released, which allowed me to
>> send an IPI from that context.
>> 
>> Any thoughts on how to best solve this ?
> 
> I think I may have found a way out of this: I may not need to use
> smp_call_function_single() at all.
> 
> When preempting a paired task, I think we can rely on memory barrier at the
> beginning of scheduling of the paired task to match the memory barrier at
> the end of scheduling of the kworker thread to provide memory ordering.
> Therefore,
> the IPI is not needed at all in this case.
> 
> When preempting the kworker thread, things are a bit trickier. AFAIU I can
> simply
> queue task work on the paired task directly without an IPI, and then use
> kick_process() on the paired task.
> 
> The remaining concern is whether kick_process() (and thus smp_send_reschedule())
> is sufficient to guarantee a memory barrier before smp_send_reschedule returns ?
> I suspect not, because it only raises the IPI, and does not appear to wait for
> its handler to complete. In that case I need a release on the paired task and
> an acquire in sched_out of the kworker. The memory barrier at the end of
> schedule
> fulfills the acquire, but I don't see how the acquire is done on the paired
> task,
> because execution of its scheduler does not necessarily happen immediately when
> the IPI is raised.

Hrm, smp_cond_load_acquire(&running_task->on_cpu, !VAL); is probably all I need
after that kick_process.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
