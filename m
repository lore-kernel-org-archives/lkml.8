Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A407AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B6620707
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GGQOrR70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406966AbgFYRzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:55:11 -0400
Received: from mail.efficios.com ([167.114.26.124]:43646 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405512AbgFYRzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:55:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EA3542CC777;
        Thu, 25 Jun 2020 13:55:07 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5ENrKCBFt7lN; Thu, 25 Jun 2020 13:55:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 698E82CC776;
        Thu, 25 Jun 2020 13:55:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 698E82CC776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593107707;
        bh=s716aDp98Dr/SIAE/48mnmzR2fW1La/xStErEctad3c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GGQOrR70XFcsHmyup2g370Hs25QXPh5HN8G3p35tWkZie6Zc/JWvSYsAD4Kooa4If
         WisSZoCz4eIsx30RDvDoFN3KD0HvzkB+7bD9uNeC+xJb7ZTJi0XR43rUV4TwVGH3m5
         s4TkF6pr7KF+GBxdCCCEkTs70rpUN3tp8/IRrs9eyeBz7KVxVLJiU1QOj5N2fK/CNR
         MniQ/i58XjD8osfwgAsY0T41AyJMygzcmkK/1DqEWFq3HzShcmEWVN9OaJ0w0tMw10
         cyz6Ko55VEu/BWtfn95rq3yrR7VxrgY2CMSFfypArsRHkSFFb4ZeTkUK8E2K1uITWH
         ElccimYDHjxTA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QnUDMg0KEsHH; Thu, 25 Jun 2020 13:55:07 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 48FB22CCC1B;
        Thu, 25 Jun 2020 13:55:07 -0400 (EDT)
Date:   Thu, 25 Jun 2020 13:55:07 -0400 (EDT)
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
Message-ID: <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200625094454.732790f7@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: ring-buffer: Have nested events still record running time stamp
Thread-Index: Oi/DYJHJZGU+iSwGlvJ0DWai5d+WPg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 25, 2020, at 9:44 AM, rostedt rostedt@goodmis.org wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
[...]
> Here's the design of this solution:
> 
> All this is per cpu, and only needs to worry about nested events (not
> parallel events).
> 
> The players:
> 
> write_tail: The index in the buffer where new events can be written to.
>     It is incremented via local_add() to reserve space for a new event.
> 
> before_stamp: A time stamp set by all events before reserving space.
> 
> write_stamp: A time stamp updated by events after it has successfully
>     reserved space.

What are the types used for before_stamp and write_stamp ? If those
are 64-bit integers, how does sharing them between nested contexts
work on 32-bit architectures ?

> 
> next_write: A copy of "write_tail" used to help with races.
> 
>	/* Save the current position of write */
> [A]	w = local_read(write_tail);
>	barrier();
>	/* Read both before and write stamps before touching anything */
>	before = READ_ONCE(before_stamp);
>	after = local_read(write_stamp);
>	barrier();
> 
>	/*
>	 * If before and after are the same, then this event is not
>	 * preempting a time update. If it is, then reserve space for adding

You should use the term "interrupt" rather than "preempting", because as you
stated yourself, this algorithm only works with nested interrupts, not with
preemption.

>	 * a full time stamp (this can turn into a time extend which is
>	 * just an extended time delta but fill up the extra space).
>	 */
>	if (after != before)
>		abs = true;
> 
>	ts = clock();
> 
>	/* Now update the before_stamp (everyone does this!) */
> [B]	WRITE_ONCE(before_stamp, ts);
> 
>	/* Read the current next_write and update it to what we want write
>	 * to be after we reserve space. */
> 	next = READ_ONCE(next_write);
>	WRITE_ONCE(next_write, w + len);
> 
>	/* Now reserve space on the buffer */
> [C]	write = local_add_return(len, write_tail);

So the reservation is not "just" an add instruction, it's actually an xadd on
x86. Is that really faster than a cmpxchg ?

> 
>	/* Set tail to be were this event's data is */
>	tail = write - len;
> 
> 	if (w == tail) {
> 
>		/* Nothing preempted this between A and C */
> [D]		local_set(write_stamp, ts);
>		barrier();
> [E]		save_before = READ_ONCE(before_stamp);
> 
> 		if (!abs) {
>			/* This did not preempt a time update */
>			delta = ts - a;

What does "a" refer to ? What triggers its update ?

>		} else {
>			/* slow path */
>			if (w == next) {

If it's a slow path, why try to play games with a delta timestamp ? Space
should not be an issue for a slow path like this. It would be simpler to just
use the full timestamp here.

>				/* This event preempted the previous event
>				 * just after it reserved its buffer.

You mean nesting after [C] but before [D].

>				 * It's timestamp should be "before_stamp" */

It's -> Its

>				delta = ts - before;
>				abs = 0; /* No need for that full time stamp */

What worries me about this "optimization" is what happens in a multi-nesting scenario.
If we just fallback to a full timestamp as soon as nesting is detected, things become
really simple for multiple nesting. However using a delta timestamp adds a lot of
additional states to consider, and those are not discussed here.

More specifically, one scenario I'm concerned about is:

Nesting level 0                      Nesting level 1                      Nesting level 2

[A] w = local_read(write_tail);
    before = READ_ONCE(before_stamp);
[B] WRITE_ONCE(before_stamp, ts);
    WRITE_ONCE(next_write, w + len);
[C] write = local_add_return(len,
    write_tail);
   <interrupted>
                                    [A] w = local_read(write_tail);
                                        before = READ_ONCE(before_stamp);
                                    [B] WRITE_ONCE(before_stamp, ts);
                                    <interrupted>
                                                                          [A] w = local_read(write_tail);
                                                                              before = READ_ONCE(before_stamp);
                                                                          [B] WRITE_ONCE(before_stamp, ts);
                                                                              WRITE_ONCE(next_write, w + len);
                                                                          [C] write = local_add_return(len,
                                                                              write_tail);
                                                                              if (w == tail) { -> true
                                                                                if (!abs) { -> false
                                                                                  if (w == next) { -> true

Nesting level 2 then ends up using the "before_stamp" of nesting level 1 to generate
the time delta, but the delta is really between the event from nesting level 0 and the
event at nesting level 2, because nesting level 1 will only record its event _after_
the event of nesting level 2.

>			} else {
>				delta = ts; /* The full time stamp will be in use */
>			}
>		}
>		if (ts != save_before) {
>			/* slow path - Was preempted between C and E */
>			/* The update to write_stamp could have overwritten the update to
>			 * it by the preempting event,

This sentence is hard to parse.

>                          but before and after should be
>			 * the same for all completed top events */
>			after = local_read(write_stamp);
>			if (save_before > after)
>				local_cmpxchg(write_stamp, after, save_before);

What is the type of write_stamp, and how does it work on 32-bit architectures with
NMIs ?

I'm not entirely sure to understand what this cmpxchg try to accomplish. Moreover,
what happens if right after an interrupt nests between [C] and [E], another interrupt
try to write into the buffer after before that cmpxchg ?

>		}
>	} else {
>		/* slow path - Preempted between A and C */
> 
>		after = local_read(write_stamp);
>		temp_ts = clock();
>		barrier();
> [F]		if (write == local_read(write_tail) && after < temp_ts) {
>			/* This was not preempted since C and F
>			 * The last write_stamp is still valid for the previous event
>			 * in the buffer. */
>			delta = temp_ts - after;
>			/* OK to keep this new time stamp */
>			ts = temp_ts;
>		} else {
>			/* Preempted between C and F
>			 * Well, there's no use to try to know what the time stamp
>			 * is for the previous event. Just set delta to zero and
>			 * be the same time as that event that preempted us before
>			 * the reservation of the buffer. */
> 
>			delta = 0;

If this is a rare case, why not just use a full timestamp instead ?

Thanks,

Mathieu

>		}
>		/* No need to use full timestamps here */
>		abs = 0;
>	}
> -- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
