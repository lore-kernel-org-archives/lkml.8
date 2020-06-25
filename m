Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E8EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F2F2081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406409AbgFYTFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403781AbgFYTFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:05:04 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D922080C;
        Thu, 25 Jun 2020 19:05:01 +0000 (UTC)
Date:   Thu, 25 Jun 2020 15:04:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
Message-ID: <20200625150459.4a5d7221@oasis.local.home>
In-Reply-To: <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
References: <20200625094454.732790f7@oasis.local.home>
        <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 13:55:07 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:


> What worries me about this "optimization" is what happens in a multi-nesting scenario.
> If we just fallback to a full timestamp as soon as nesting is detected, things become
> really simple for multiple nesting. However using a delta timestamp adds a lot of
> additional states to consider, and those are not discussed here.
> 
> More specifically, one scenario I'm concerned about is:
> 
> Nesting level 0                      Nesting level 1                      Nesting level 2
> 
> [A] w = local_read(write_tail);
>     before = READ_ONCE(before_stamp);
> [B] WRITE_ONCE(before_stamp, ts);
>     WRITE_ONCE(next_write, w + len);
> [C] write = local_add_return(len,
>     write_tail);
>    <interrupted>
>                                     [A] w = local_read(write_tail);
>                                         before = READ_ONCE(before_stamp);
>                                     [B] WRITE_ONCE(before_stamp, ts);
>                                     <interrupted>
>                                                                           [A] w = local_read(write_tail);
>                                                                               before = READ_ONCE(before_stamp);
>                                                                           [B] WRITE_ONCE(before_stamp, ts);
>                                                                               WRITE_ONCE(next_write, w + len);
>                                                                           [C] write = local_add_return(len,
>                                                                               write_tail);
>                                                                               if (w == tail) { -> true
>                                                                                 if (!abs) { -> false
>                                                                                   if (w == next) { -> true
> 
> Nesting level 2 then ends up using the "before_stamp" of nesting level 1 to generate
> the time delta, but the delta is really between the event from nesting level 0 and the
> event at nesting level 2, because nesting level 1 will only record its event _after_
> the event of nesting level 2.

You may have a valid point. But if we do your suggestion of just
punting in this path and use a full timestamp, then there's nothing to
worry about here. Right?

> 
> >			} else {
> >				delta = ts; /* The full time stamp will be in use */
> >			}
> >		}
> >		if (ts != save_before) {
> >			/* slow path - Was preempted between C and E */
> >			/* The update to write_stamp could have overwritten the update to
> >			 * it by the preempting event,  
> 
> This sentence is hard to parse.

Ah, that needs better wording: "An interrupt of this event could have
written to the write_stamp before this interrupt wrote to it. Which
means this event could have made the write_stamp go backwards. Need to
put back the write stamp using the before stamp, as that can only be
updated by events that interrupt this current one."


> 
> >                          but before and after should be
> >			 * the same for all completed top events */
> >			after = local_read(write_stamp);
> >			if (save_before > after)
> >				local_cmpxchg(write_stamp, after, save_before);  
> 
> What is the type of write_stamp, and how does it work on 32-bit architectures with
> NMIs ?
> 

local64_cmpxchg(), I left it out of change log, as this is the
algorithm not all the details. See the patch for those ;-)

> I'm not entirely sure to understand what this cmpxchg try to
> accomplish. Moreover, what happens if right after an interrupt nests
> between [C] and [E], another interrupt try to write into the buffer
> after before that cmpxchg ?

We are just fixing up this events write into write_stamp. We only worry
about being interrupted between C and D, as then we set the write stamp
backward. But any interrupting event will also update the before time
stamp. That is, the before_stamp can only be the last time stamp of an
event that interrupted us here. By doing the cmpxchg, we only update
the write stamp to the before stamp of the last event to interrupt this
event and if the cmpxchg fails, that means another event came in and
updated it to its own time stamp which is what we want it to be!

> 
> >		}
> >	} else {
> >		/* slow path - Preempted between A and C */
> > 
> >		after = local_read(write_stamp);
> >		temp_ts = clock();
> >		barrier();
> > [F]		if (write == local_read(write_tail) && after < temp_ts) {
> >			/* This was not preempted since C and F
> >			 * The last write_stamp is still valid for the previous event
> >			 * in the buffer. */
> >			delta = temp_ts - after;
> >			/* OK to keep this new time stamp */
> >			ts = temp_ts;
> >		} else {
> >			/* Preempted between C and F
> >			 * Well, there's no use to try to know what
> >	the time stamp
> >			 * is for the previous event. Just set delta
> >	to zero and
> >			 * be the same time as that event that
> >	preempted us before
> >			 * the reservation of the buffer. */
> > 
> >			delta = 0;  
> 
> If this is a rare case, why not just use a full timestamp instead ?

Because the current time stamp is wrong.

This is what happened:

	nesting 0							    nesting 1
	---------							    ---------
        < start event 1 >
 [A]	w = local_read(write_tail);
	ts = clock(); [ time 1 ]

 									< start event 2 >
									    ts = clock(); [ time 2 ]
									[C] write = local_add_return();
									<finish>

 [C]	write = local_add_return();

									< start event 3 >
									    ts = clock(); [ time 3]
									[C] write = local_add_return();
									<finish>


 [F]	if (write == local_read(write_tail) && after < temp_ts) {

	} else {

The recorded time stamps are this:

   time 1 < time 2 < time 3

The buffer would look like this:

  ----+------------------+------------------+------------------+----
  ... | time 2 : event 2 | time ? : event 1 | time 3 : event 3 | ...
  ----+------------------+------------------+------------------+----


What do you put in for event 1's time. It's time stamp is before time
2, but the recorded event is after event 2. We can't use event 3 as a
time.

But in this case, it really doesn't matter in practice. Why? because
what is the time of that middle event? How is that useful information?

For example, you record a syscall event.



 syscall() {
 	[...]

 +	trace_syscall() {
 |		< event 1 >
 |			-------------> [interrupt]
 |				 	 < event 2 >
 |					 < time 2 >
 |			<------------
 |		< time 1>
 |			-------------> [interrupt]
 |				 	 < event 3 >
 |					 < time 3 >
 |			<------------
 +	}

	[...]
}

What's the difference if event 1's time stamp is time 2 or time 3?
The event that it is representing is paused for that entire path.

It's not really useful to get that "exact" because there's no real
meaning of what that "exact" is. The vertical line there is the call to
record a trace event. The event that is being represented by the trace
event is paused for all three time stamps.

-- Steve
