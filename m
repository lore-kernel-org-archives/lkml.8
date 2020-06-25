Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5937EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301CE2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405288AbgFYSf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405208AbgFYSf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:35:29 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D426520789;
        Thu, 25 Jun 2020 18:35:26 +0000 (UTC)
Date:   Thu, 25 Jun 2020 14:35:25 -0400
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
Message-ID: <20200625143525.2f3a2902@oasis.local.home>
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
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote

> > Here's the design of this solution:
> > 
> > All this is per cpu, and only needs to worry about nested events (not
> > parallel events).
> > 
> > The players:
> > 
> > write_tail: The index in the buffer where new events can be written to.
> >     It is incremented via local_add() to reserve space for a new event.
> > 
> > before_stamp: A time stamp set by all events before reserving space.
> > 
> > write_stamp: A time stamp updated by events after it has successfully
> >     reserved space.  
> 
> What are the types used for before_stamp and write_stamp ? If those
> are 64-bit integers, how does sharing them between nested contexts
> work on 32-bit architectures ?

Well, write_stamp is updated via local64, which I believe handles this
for us. I probably should make before_stamp handle it as well.

> 
> > 
> > next_write: A copy of "write_tail" used to help with races.
> > 
> >	/* Save the current position of write */
> > [A]	w = local_read(write_tail);
> >	barrier();
> >	/* Read both before and write stamps before touching
> >	anything */ before = READ_ONCE(before_stamp);
> >	after = local_read(write_stamp);
> >	barrier();
> > 
> >	/*
> >	 * If before and after are the same, then this event is not
> >	 * preempting a time update. If it is, then reserve space
> >	for adding  
> 
> You should use the term "interrupt" rather than "preempting", because
> as you stated yourself, this algorithm only works with nested
> interrupts, not with preemption.

The two terms are basically interchangeable here, but for consistency,
I will update it. Thanks.


> 
> >	 * a full time stamp (this can turn into a time extend which
> >	is
> >	 * just an extended time delta but fill up the extra space).
> >	 */
> >	if (after != before)
> >		abs = true;
> > 
> >	ts = clock();
> > 
> >	/* Now update the before_stamp (everyone does this!) */
> > [B]	WRITE_ONCE(before_stamp, ts);
> > 
> >	/* Read the current next_write and update it to what we want
> >	write
> >	 * to be after we reserve space. */
> > 	next = READ_ONCE(next_write);
> >	WRITE_ONCE(next_write, w + len);
> > 
> >	/* Now reserve space on the buffer */
> > [C]	write = local_add_return(len, write_tail);  
> 
> So the reservation is not "just" an add instruction, it's actually an
> xadd on x86. Is that really faster than a cmpxchg ?

I believe the answer is still yes. But I can run some benchmarks to
make sure.

> 
> > 
> >	/* Set tail to be were this event's data is */
> >	tail = write - len;
> > 
> > 	if (w == tail) {
> > 
> >		/* Nothing preempted this between A and C */
> > [D]		local_set(write_stamp, ts);
> >		barrier();
> > [E]		save_before = READ_ONCE(before_stamp);
> > 
> > 		if (!abs) {
> >			/* This did not preempt a time update */
> >			delta = ts - a;  
> 
> What does "a" refer to ? What triggers its update ?

Oops, When I first wrote this, I used "a" and "b" for "after" and
"before" and had "after" and "before" be "after_stamp" and
"before_stamp". I missed this update. Nice catch.


> 
> >		} else {
> >			/* slow path */
> >			if (w == next) {  
> 
> If it's a slow path, why try to play games with a delta timestamp ?
> Space should not be an issue for a slow path like this. It would be
> simpler to just use the full timestamp here.

Hmm, you may be right. Previous iterations of this code had a distinct
difference here, but after restructuring it, I don't think that
distinction is valid anymore. If anything, having this at least lets me
validate that it's doing what I believe it should be doing (as I added
a ton of trace_printk()s into this).

> 
> >				/* This event preempted the previous
> >	event
> >				 * just after it reserved its
> >	buffer.  
> 
> You mean nesting after [C] but before [D].

Yes. I can add that for clarity, but perhaps I don't need that if I
merge the two.

> 
> >				 * It's timestamp should be
> >	"before_stamp" */  
> 
> It's -> Its

;-)

My email client messed up your formatting of the rest of the email, so
I'll send a separate reply.

-- Steve
