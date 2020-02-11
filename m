Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FD9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1C420714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Q5z+L6vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgBKQCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:02:10 -0500
Received: from mail.efficios.com ([167.114.26.124]:36628 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgBKQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:02:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3F48524D69A;
        Tue, 11 Feb 2020 11:02:09 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id T8OAKR1ylkjU; Tue, 11 Feb 2020 11:02:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 995AA24D4F5;
        Tue, 11 Feb 2020 11:02:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 995AA24D4F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581436928;
        bh=UBGZ5NVAzCw97arQcWK1xBle8ZgjTgjoIcSJqIvqu8Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Q5z+L6vkoD1bOxJvSHh9GT7j+6sgTndiWpJWWnGP1BYPc+WHMFo0scLXmG/IY4IMy
         ZYkeB/RIapF/071TtYq1KOj8VsHZx56MoWEkN0Y+9Pc+ztr3Ip/IfOqrgEcPukOETz
         YqEi7QW5S2HYj6zYyXkU29xNuxaDwtBgUGeVllvHw6HvR2X2MczyHyMmVd33geIGOJ
         tpFvpwXC+qHlJjfsOMdGjGx55LmuAsIE9ndGSBYwco2wHUb4DiQZsRIYtzM73BWHqU
         UYGlTrbnX5jZYpVBScJp/rveg9D0lz/Uy8qSfGZqwF5fYjP6aFPt7wA5b2LRVY/WuO
         L+NqdwXWYq8hA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O-gmXuE6OJrE; Tue, 11 Feb 2020 11:02:08 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 80FE024D552;
        Tue, 11 Feb 2020 11:02:08 -0500 (EST)
Date:   Tue, 11 Feb 2020 11:02:08 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <201671415.617691.1581436928433.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200211154645.GX14914@hirez.programming.kicks-ass.net>
References: <20200211095047.58ddf750@gandalf.local.home> <504801580.617591.1581435278202.JavaMail.zimbra@efficios.com> <20200211154645.GX14914@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracing/perf: Move rcu_irq_enter/exit_irqson() to perf trace point hook
Thread-Index: SybNcrD6xSrh8h168VBKdcHDeZfA6A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 11, 2020, at 10:46 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Feb 11, 2020 at 10:34:38AM -0500, Mathieu Desnoyers wrote:
>> 
>> I'm puzzled by this function. It does:
>> 
>> perf_tp_event(...)
>> {
>>      hlist_for_each_entry_rcu(event, head, hlist_entry) {
>>          ...
>>      }
>>      if (task && task != current) {
>>          rcu_read_lock();
>>          ... = rcu_dereference();
>>          list_for_each_entry_rcu(...) {
>>              ....
>>          }
>>          rcu_read_unlock();
>>      }
>> }
>> 
>> What is the purpose of the rcu_read_lock/unlock within the if (),
>> considering that there is already an hlist rcu iteration just before ?
>> It seems to assume that a RCU read-side of some kind of already
>> ongoing.
> 
> IIRC the hlist_for_each_entry_rcu() uses the RCU stuff from the
> tracepoint API, while the stuff inside the if() uses regular RCU.
> 
> Them were note the same one -- tracepoints used rcu-sched, perf used
> rcu.

Indeed, there is a call to tracepoint_synchronize_unregister() within
perf_trace_event_unreg(), which provides the required grace period
before freeing the perf event.

That tracepoint_synchronize_unregister() was initially doing a synchronize_sched()
as you point out. It then moved to synchronize_rcu() with the RCU flavors
consolidation, and we've added the synchronize_srcu(&tracepoint_srcu) as well,
which handles the rcuidle cases.

Adding a comment in perf_tp_event() detailing how each RCU use is synchronized
might help readability, e.g.:

At top of function:

/*
 * Synchronization of the perf event RCU hlist is performed by the tracepoint API.
 * Synchronization of the perf event context and perf event context event list
 * is performed through explicit use of RCU.
 */

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
