Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D209C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FC820768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="k+xG1V31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406973AbgFYT6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:58:35 -0400
Received: from mail.efficios.com ([167.114.26.124]:54546 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406569AbgFYT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:58:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 82E072CD46C;
        Thu, 25 Jun 2020 15:58:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QDRDgnzIr3eg; Thu, 25 Jun 2020 15:58:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E8A962CDA88;
        Thu, 25 Jun 2020 15:58:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E8A962CDA88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593115113;
        bh=p2A+V3jeu9rXcO+rypaCfabLuTV3yOeVNGhnRer0X6U=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=k+xG1V31yewHR+vTCrq1dWscXrui71rznSCJfqq7vA8NrhPKc04ZUONFkronGl+Lb
         ZQJC/mzfCG6HO0BVuHvFDijCYMzuJx/0UuQZElrUyjnRBMBDABv8SODLhe1Hr3dzj/
         5MnhnJqAXB/y0FsSvCIAdrD7737hkPx3msy9mI6hZxeGZt4f4hLkWNfKKA2wq9SBH9
         Gk2abGON58JNHGF9/pGkicZxwwzCRWIor9w6yejwYy3ldyzd4afhTkqKjbi6vBqaey
         BmVkpCirGZMVMu8PXyWxX2oK6twqzPg2Dxm8mk55j3ZJh+bjYLvBAvs4wQt3qkILPc
         7C2vHz+u7rKYA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ekWUa7l-2mvE; Thu, 25 Jun 2020 15:58:32 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C0A972CD926;
        Thu, 25 Jun 2020 15:58:32 -0400 (EDT)
Date:   Thu, 25 Jun 2020 15:58:32 -0400 (EDT)
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
Message-ID: <1860125983.13444.1593115112644.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200625150459.4a5d7221@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home> <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com> <20200625150459.4a5d7221@oasis.local.home>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: ring-buffer: Have nested events still record running time stamp
Thread-Index: V8osvF8r125kWCD2PRuCk3P2+a6fYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 25, 2020, at 3:04 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 25 Jun 2020 13:55:07 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> 
>> What worries me about this "optimization" is what happens in a multi-nesting
>> scenario.
>> If we just fallback to a full timestamp as soon as nesting is detected, things
>> become
>> really simple for multiple nesting. However using a delta timestamp adds a lot
>> of
>> additional states to consider, and those are not discussed here.
>> 
>> More specifically, one scenario I'm concerned about is:
>> 
>> Nesting level 0                      Nesting level 1
>> Nesting level 2
>> 
>> [A] w = local_read(write_tail);
>>     before = READ_ONCE(before_stamp);
>> [B] WRITE_ONCE(before_stamp, ts);
>>     WRITE_ONCE(next_write, w + len);
>> [C] write = local_add_return(len,
>>     write_tail);
>>    <interrupted>
>>                                     [A] w = local_read(write_tail);
>>                                         before = READ_ONCE(before_stamp);
>>                                     [B] WRITE_ONCE(before_stamp, ts);
>>                                     <interrupted>
>>                                                                           [A] w = local_read(write_tail);
>>                                                                               before = READ_ONCE(before_stamp);
>>                                                                           [B] WRITE_ONCE(before_stamp, ts);
>>                                                                               WRITE_ONCE(next_write, w + len);
>>                                                                           [C] write = local_add_return(len,
>>                                                                               write_tail);
>>                                                                               if (w == tail) { -> true
>>                                                                                 if (!abs) { -> false
>>                                                                                   if (w == next) { -> true
>> 
>> Nesting level 2 then ends up using the "before_stamp" of nesting level 1 to
>> generate
>> the time delta, but the delta is really between the event from nesting level 0
>> and the
>> event at nesting level 2, because nesting level 1 will only record its event
>> _after_
>> the event of nesting level 2.
> 
> You may have a valid point. But if we do your suggestion of just
> punting in this path and use a full timestamp, then there's nothing to
> worry about here. Right?

Yes, this problematic scenario is just there to illustrate my point.

> 
>> 
>> >			} else {
>> >				delta = ts; /* The full time stamp will be in use */
>> >			}
>> >		}
>> >		if (ts != save_before) {
>> >			/* slow path - Was preempted between C and E */
>> >			/* The update to write_stamp could have overwritten the update to
>> >			 * it by the preempting event,
>> 
>> This sentence is hard to parse.
> 
> Ah, that needs better wording: "An interrupt of this event could have
> written to the write_stamp before this interrupt wrote to it.

I would have though the part "before this interrupt wrote to it" would
actually be "before this event wrote to it" (?) Am I confused ?

> Which
> means this event could have made the write_stamp go backwards. Need to
> put back the write stamp using the before stamp, as that can only be
> updated by events that interrupt this current one."
> 
> 
>> 
>> >                          but before and after should be
>> >			 * the same for all completed top events */
>> >			after = local_read(write_stamp);
>> >			if (save_before > after)
>> >				local_cmpxchg(write_stamp, after, save_before);
>> 
>> What is the type of write_stamp, and how does it work on 32-bit architectures
>> with
>> NMIs ?
>> 
> 
> local64_cmpxchg(), I left it out of change log, as this is the
> algorithm not all the details. See the patch for those ;-)

I'm still concerned about local64 on 32-bit, as per my prior email.

> 
>> I'm not entirely sure to understand what this cmpxchg try to
>> accomplish. Moreover, what happens if right after an interrupt nests
>> between [C] and [E], another interrupt try to write into the buffer
>> after before that cmpxchg ?
> 
> We are just fixing up this events write into write_stamp. We only worry
> about being interrupted between C and D, as then we set the write stamp
> backward. But any interrupting event will also update the before time
> stamp. That is, the before_stamp can only be the last time stamp of an
> event that interrupted us here. By doing the cmpxchg, we only update
> the write stamp to the before stamp of the last event to interrupt this
> event and if the cmpxchg fails, that means another event came in and
> updated it to its own time stamp which is what we want it to be!

This seems to assume that before_stamp is always written to in a monotonic
fashion except in this very specific corner-case. But what happens if this
algorithm is interrupted between reading the clock() current time and
writing to before_stamp ? This can happen both for the outer event and
at various nesting levels as well. I'm concerned that this scenario
would also cause before_stamp to go backwards, but would not be handled
correctly.

> 
>> 
>> >		}
>> >	} else {
>> >		/* slow path - Preempted between A and C */
>> > 
>> >		after = local_read(write_stamp);
>> >		temp_ts = clock();
>> >		barrier();
>> > [F]		if (write == local_read(write_tail) && after < temp_ts) {
>> >			/* This was not preempted since C and F
>> >			 * The last write_stamp is still valid for the previous event
>> >			 * in the buffer. */
>> >			delta = temp_ts - after;
>> >			/* OK to keep this new time stamp */
>> >			ts = temp_ts;
>> >		} else {
>> >			/* Preempted between C and F
>> >			 * Well, there's no use to try to know what
>> >	the time stamp
>> >			 * is for the previous event. Just set delta
>> >	to zero and
>> >			 * be the same time as that event that
>> >	preempted us before
>> >			 * the reservation of the buffer. */
>> > 
>> >			delta = 0;
>> 
>> If this is a rare case, why not just use a full timestamp instead ?
> 
> Because the current time stamp is wrong.
> 
> This is what happened:
> 
>	nesting 0							    nesting 1
>	---------							    ---------
>        < start event 1 >
> [A]	w = local_read(write_tail);
>	ts = clock(); [ time 1 ]
> 
> 									< start event 2 >
>									    ts = clock(); [ time 2 ]
>									[C] write = local_add_return();
>									<finish>
> 
> [C]	write = local_add_return();
> 
>									< start event 3 >
>									    ts = clock(); [ time 3]
>									[C] write = local_add_return();
>									<finish>
> 
> 
> [F]	if (write == local_read(write_tail) && after < temp_ts) {
> 
>	} else {
> 
> The recorded time stamps are this:
> 
>   time 1 < time 2 < time 3
> 
> The buffer would look like this:
> 
>  ----+------------------+------------------+------------------+----
>  ... | time 2 : event 2 | time ? : event 1 | time 3 : event 3 | ...
>  ----+------------------+------------------+------------------+----
> 
> 
> What do you put in for event 1's time. It's time stamp is before time
> 2, but the recorded event is after event 2. We can't use event 3 as a
> time.

I solve this by using cmpxchg instead of xadd for [C], and retry space
reservation with a new timestamp. ;-)

> 
> But in this case, it really doesn't matter in practice. Why? because
> what is the time of that middle event? How is that useful information?
> 
> For example, you record a syscall event.
> 
> 
> 
> syscall() {
> 	[...]
> 
> +	trace_syscall() {
> |		< event 1 >
> |			-------------> [interrupt]
> |				 	 < event 2 >
> |					 < time 2 >
> |			<------------
> |		< time 1>
> |			-------------> [interrupt]
> |				 	 < event 3 >
> |					 < time 3 >
> |			<------------
> +	}
> 
>	[...]
> }
> 
> What's the difference if event 1's time stamp is time 2 or time 3?
> The event that it is representing is paused for that entire path.
> 
> It's not really useful to get that "exact" because there's no real
> meaning of what that "exact" is. The vertical line there is the call to
> record a trace event. The event that is being represented by the trace
> event is paused for all three time stamps.

Agreed on the fact that the difference does not matter much in practice.

Can we have this scenario at an extra nesting level ? Basically
we add an outermost event 0 at nesting level 0, and shift events 1, 2, 3
to nesting levels 1, 2 in your scenario ? If it is possible, will the
special-case handling it also trigger ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
