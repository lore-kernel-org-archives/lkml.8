Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E6FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4192076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RqF31PC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406654AbgFYTfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:35:05 -0400
Received: from mail.efficios.com ([167.114.26.124]:48118 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406064AbgFYTfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:35:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6245B2CD37F;
        Thu, 25 Jun 2020 15:35:03 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rlgeFdVpRll9; Thu, 25 Jun 2020 15:35:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E2F7F2CD71C;
        Thu, 25 Jun 2020 15:35:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E2F7F2CD71C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593113702;
        bh=rGLebibRUb0WGcM1VpJj5j7ESMFmIEPHt5BGfwPT5fE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RqF31PC/ybvUMi9OR+tuu5pxX7l3PhS1K9e0MeZsBtOx6kxz8MjbaJ/nmeb+ahCkH
         k+7wL/08khjveeGYoeaaI8Zeexk120PnX/S21N930s0KHtx1sJiiHcBoQXRptkQ0cQ
         Ith6/D5/k5JOUJng2PCznFkLPZ7e6iA/BJxmGhRiXB5pyCbbhobZOHn2A0mz5sV7mP
         qmptkM6z8KoCR2K5Jt4KLxPAZqdra18mSXLKgkIuRzni3zDpV16YG3msTVC/B8N/VB
         1OV15XXpxCaaw62ZwS5aLg+z169wOwAAudcf5SL+PjwRLxoOM1KEckSh2xUeZKz5pP
         hUjn+3HcNmlug==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NIhUS8tzhRZc; Thu, 25 Jun 2020 15:35:02 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id CD21C2CD886;
        Thu, 25 Jun 2020 15:35:02 -0400 (EDT)
Date:   Thu, 25 Jun 2020 15:35:02 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Jason Behmer <jbehmer@google.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Clark Williams <williams@redhat.com>,
        bristot <bristot@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Darren Hart <dvhart@vmware.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Message-ID: <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200625143525.2f3a2902@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home> <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com> <20200625143525.2f3a2902@oasis.local.home>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: ring-buffer: Have nested events still record running time stamp
Thread-Index: M8ERmTtGn+FLjsWkAqDlPXzyNM/iVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 25, 2020, at 2:35 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 25 Jun 2020 13:55:07 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote
> 
>> > Here's the design of this solution:
>> > 
>> > All this is per cpu, and only needs to worry about nested events (not
>> > parallel events).
>> > 
>> > The players:
>> > 
>> > write_tail: The index in the buffer where new events can be written to.
>> >     It is incremented via local_add() to reserve space for a new event.
>> > 
>> > before_stamp: A time stamp set by all events before reserving space.
>> > 
>> > write_stamp: A time stamp updated by events after it has successfully
>> >     reserved space.
>> 
>> What are the types used for before_stamp and write_stamp ? If those
>> are 64-bit integers, how does sharing them between nested contexts
>> work on 32-bit architectures ?
> 
> Well, write_stamp is updated via local64, which I believe handles this
> for us. I probably should make before_stamp handle it as well.

By looking at local64 headers, it appears that 32-bit rely on atomic64,
which on x86 is implemented with LOCK; cmpxchg8b for 586+ (which is AFAIK
painfully slow) and with cli/sti for 386/486 (which is not nmi-safe).

For all other 32-bit architectures, the generic atomic64.h implements 64-bit
atomics using spinlocks with irqs off, which seems to also bring considerable
overhead, in addition to be non-reentrant with respect to NMI-like interrupts,
e.g. FIQ on ARM32.

That seems at odds with the performance constraints of ftrace's ring buffer.

Those performance and reentrancy concerns are why I always stick to local_t
(long), and never use a full 64-bit type for anything that has to
do with concurrent store/load between execution contexts in lttng.

> 
> 
>> 
>> >	 * a full time stamp (this can turn into a time extend which
>> >	is
>> >	 * just an extended time delta but fill up the extra space).
>> >	 */
>> >	if (after != before)
>> >		abs = true;
>> > 
>> >	ts = clock();
>> > 
>> >	/* Now update the before_stamp (everyone does this!) */
>> > [B]	WRITE_ONCE(before_stamp, ts);
>> > 
>> >	/* Read the current next_write and update it to what we want
>> >	write
>> >	 * to be after we reserve space. */
>> > 	next = READ_ONCE(next_write);
>> >	WRITE_ONCE(next_write, w + len);
>> > 
>> >	/* Now reserve space on the buffer */
>> > [C]	write = local_add_return(len, write_tail);
>> 
>> So the reservation is not "just" an add instruction, it's actually an
>> xadd on x86. Is that really faster than a cmpxchg ?
> 
> I believe the answer is still yes. But I can run some benchmarks to
> make sure.

This would be interesting to see, because if xadd and cmpxchg have
similar overhead, then going for a cmpxchg-loop for the space
reservation could vastly decrease the overall complexity of this
timestamp+space reservation algorithm.

If we decrease complexity of the fast-paths, we can then reduce the
amount of test+branches which need to be performed and instruction cache
being used, and this can lead to performance improvements. So it's not only
good in making things more easily verifiable, but it also improves
performance.

[...]
> 
> 
>> 
>> >		} else {
>> >			/* slow path */
>> >			if (w == next) {
>> 
>> If it's a slow path, why try to play games with a delta timestamp ?
>> Space should not be an issue for a slow path like this. It would be
>> simpler to just use the full timestamp here.
> 
> Hmm, you may be right. Previous iterations of this code had a distinct
> difference here, but after restructuring it, I don't think that
> distinction is valid anymore. If anything, having this at least lets me
> validate that it's doing what I believe it should be doing (as I added
> a ton of trace_printk()s into this).

Good. Simple is good. :-)

> 
>> 
>> >				/* This event preempted the previous
>> >	event
>> >				 * just after it reserved its
>> >	buffer.
>> 
>> You mean nesting after [C] but before [D].
> 
> Yes. I can add that for clarity, but perhaps I don't need that if I
> merge the two.

OK

> 
>> 
>> >				 * It's timestamp should be
>> >	"before_stamp" */
>> 
>> It's -> Its
> 
> ;-)
> 
> My email client messed up your formatting of the rest of the email, so
> I'll send a separate reply.

OK,

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
