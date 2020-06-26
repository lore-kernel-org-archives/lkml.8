Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619F0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A51E20706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HDIeMPi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgFZPQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:16:20 -0400
Received: from mail.efficios.com ([167.114.26.124]:57282 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFZPQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:16:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0B78C2D3D7A;
        Fri, 26 Jun 2020 11:16:18 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZtjsFf0AcEaI; Fri, 26 Jun 2020 11:16:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B3AD32D40C3;
        Fri, 26 Jun 2020 11:16:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B3AD32D40C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593184577;
        bh=OQJyW6TWzOU0Tmk203u3MR9Phj14x7iuStwSwfORDbc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HDIeMPi0YW4/NJ783nqlEL4+TdP2jr6FY19yIMtbOZ16ZhWPxKZE73FFn0sV3fQA4
         9BAVByx2yVNwEpapu5HnnHBRlLfr80YFJeAvufDgUocECZjJk6X0ICsW9qLOlqgyBz
         AHy8w6Tu/eoVE9AyI6r4azr21EErBL9G9fa+CkXXYb4tQMRcHRwszJWcYITeDmoeB6
         kshXrQ19jk3ooCeSl5OexKn8TZRB+qhJiJe7Jho3ptpEW7zrfubdsK5n5iJyIQyF/u
         /Rx0vFMyAY/e97xPBPSzEEktGswEfWU4g93ssxID0ws0bhJGfKbW+sONXcn5Su7peh
         3S0naTcQT9ORg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PphEmKz9cEQF; Fri, 26 Jun 2020 11:16:17 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A22A62D4229;
        Fri, 26 Jun 2020 11:16:17 -0400 (EDT)
Date:   Fri, 26 Jun 2020 11:16:17 -0400 (EDT)
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
Message-ID: <1747476740.14310.1593184577574.JavaMail.zimbra@efficios.com>
In-Reply-To: <489418873.12472.1593102891027.JavaMail.zimbra@efficios.com>
References: <20200619202516.7109-1-mathieu.desnoyers@efficios.com> <20200624121136.GF4800@hirez.programming.kicks-ass.net> <269292405.11607.1593023493676.JavaMail.zimbra@efficios.com> <20200624195030.GG4800@hirez.programming.kicks-ass.net> <1115572712.12427.1593096995446.JavaMail.zimbra@efficios.com> <489418873.12472.1593102891027.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH v2] sched_pair_cpu: Introduce scheduler task pairing
 system call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: sched_pair_cpu: Introduce scheduler task pairing system call
Thread-Index: KKF2EJ/UOyY4CnhVA6NZtcIQEi8jPD1z4gT9UfinMbY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 25, 2020, at 12:34 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jun 25, 2020, at 10:56 AM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On Jun 24, 2020, at 3:50 PM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>>> On Wed, Jun 24, 2020 at 02:31:33PM -0400, Mathieu Desnoyers wrote:
>>> 
>> [...]
>>> The other alternative is using a preempt_notifier for the worker I
>>> suppose.
>> 
> [...]
>>> 
>>> preempt_notifier could work here too I suppose, install it on yourself
>>> when you do the pear syscall and take it away again when you're finished
>>> with it.
> 
> The issue I currently have with preempt notifiers is that I need to
> send an IPI from a sched_out notifier, which has interrupts off and
> hold the rq lock. smp_call_function_single() warns due to irq off, and
> indeed it triggers deadlocks.
> 
> Before using preempt notifiers, I was touching the "prev" task after
> irqs were reenabled and rq lock was released, which allowed me to
> send an IPI from that context.
> 
> Any thoughts on how to best solve this ?

I think I may have found a way out of this: I may not need to use
smp_call_function_single() at all.

When preempting a paired task, I think we can rely on memory barrier at the
beginning of scheduling of the paired task to match the memory barrier at
the end of scheduling of the kworker thread to provide memory ordering. Therefore,
the IPI is not needed at all in this case.

When preempting the kworker thread, things are a bit trickier. AFAIU I can simply
queue task work on the paired task directly without an IPI, and then use
kick_process() on the paired task.

The remaining concern is whether kick_process() (and thus smp_send_reschedule())
is sufficient to guarantee a memory barrier before smp_send_reschedule returns ?
I suspect not, because it only raises the IPI, and does not appear to wait for
its handler to complete. In that case I need a release on the paired task and
an acquire in sched_out of the kworker. The memory barrier at the end of schedule
fulfills the acquire, but I don't see how the acquire is done on the paired task,
because execution of its scheduler does not necessarily happen immediately when
the IPI is raised.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
