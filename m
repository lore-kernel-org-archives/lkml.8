Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C8BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949E02088E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgFZS6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFZS6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:58:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F152053B;
        Fri, 26 Jun 2020 18:58:21 +0000 (UTC)
Date:   Fri, 26 Jun 2020 14:58:19 -0400
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
Message-ID: <20200626145819.0d3cae3c@oasis.local.home>
In-Reply-To: <304619857.14491.1593195230002.JavaMail.zimbra@efficios.com>
References: <20200625094454.732790f7@oasis.local.home>
        <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
        <20200625143525.2f3a2902@oasis.local.home>
        <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com>
        <20200625223611.1dbb3b35@oasis.local.home>
        <20200625233552.2c8a0d1e@oasis.local.home>
        <20200626095801.14cfa8a3@oasis.local.home>
        <304619857.14491.1593195230002.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 14:13:50 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > 
> > static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
> > {
> >	unsigned long top, bottom;
> > 
> >	top = local_read(&t->top);
> >	bottom = local_read(&t->bottom);
> > 
> >	*cnt = rb_time_cnt(top);
> > 
> >	if (*cnt != rb_time_cnt(bottom))
> >		return false;
> > 
> >	*ret = rb_time_val(top, bottom);
> >	return true;
> > }  

BTW, I've decided to include this in my final patch series which I'm
finishing up now.

> 
> If __rb_time_read or rb_time_cmpxchg are used in an interrupt over
> rb_time_set (between setting top and bottom), those will never succeed.
> 
> How is this case handled ?
> 

The three places using cmpxchg:

In the discard code (which is only called when nesting already happened
as it uses per_cpu buffers first, as they are faster), thus this
requires a double nest:


	if (bpage->page == (void *)addr && rb_page_write(bpage) == old_index) {
		unsigned long write_mask =
			local_read(&bpage->write) & ~RB_WRITE_MASK;
		unsigned long event_length = rb_event_length(event);

		/* Something came in, can't discard */
		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
				     write_stamp, write_stamp - delta))
			return 0;


It fails to do the discard and fills the buffer with "padding".

Second usage:

		/* SLOW PATH - Interrupted between A and C */
		a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
		ts = rb_time_stamp(cpu_buffer->buffer);
		barrier();
 /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
		    a_ok && after < ts) {
			/* Nothing came after this event between C and E */
			info->delta = ts - after;
			(void)rb_time_cmpxchg(&cpu_buffer->write_stamp, after, info->ts);
			info->ts = ts;
		} else {
			info->delta = 0;

Not only did this event interrupt something, but something interrupt
this event. Punt and just use the delta zero.

Third usage:

		if (unlikely(info->ts != save_before)) {
			/* SLOW PATH - Interrupted between C and E */

			a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
			RB_WARN_ON(cpu_buffer, !a_ok);

			/* Write stamp must only go forward */
			if (save_before > after) {
				/*
				 * We do not care about the result, only that
				 * it gets updated atomically.
				 */
				(void)rb_time_cmpxchg(&cpu_buffer->write_stamp, after, save_before);
			}
		}

It's where we want to update the write stamp to the latest, and which
it already wrote to the write_stamp. Notice there's even a warning that
will cause the ring buffer to crash (fail) if it's not OK. Which I
triggered when I forgot to handle the case where reading could get
corrupted by being interrupted, which I fixed soon after ;-)

As for the save_before. This event writes to the before after reading
it, so the before_stamp had better be ok (and there's a warning there
too).

Here's the read locations:

In the discard as well. If it can't read it, it will just fill with padding.

	if (!rb_time_read(&cpu_buffer->write_stamp, &write_stamp))
		return 0;


On reserving the event:

	barrier();
	b_ok = rb_time_read(&cpu_buffer->before_stamp, &before);
	a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
	barrier();

[..]
	if (unlikely(!a_ok || !b_ok || (before != after && w)))
		info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;

It treats these failed reads as interrupting the event and uses the
full time stamp.  Thanks to your suggestion about combining the the
case where I went back to the delta, I don't need these values anymore.

	/* See if we shot pass the end of this buffer page */
	if (unlikely(write > BUF_PAGE_SIZE)) {
		if (tail != w) {
			/* before and after may now different, fix it up*/
			b_ok = rb_time_read(&cpu_buffer->before_stamp, &before);
			a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
			if (a_ok && b_ok && before != after)
				(void)rb_time_cmpxchg(&cpu_buffer->before_stamp, before, after);
		}
		return rb_move_tail(cpu_buffer, tail, info);
	}

This is when we overrun the sub buffer. This is more of a clean up.
because I found that because we always write to before_stamp, and then
go back to the page, it triggered it as being different. The only
reason we want them to be the same is to prevent a unnecessary time
stamp at the beginning of the page, which already stores a full time
stamp.

 /*E*/		s_ok = rb_time_read(&cpu_buffer->before_stamp, &save_before);
		RB_WARN_ON(cpu_buffer, !s_ok);

As mentioned, this before_stamp was written to by this event, and is
now used to know if it was interrupted since.

I think I hit all the locations, and that is how it handles not being
able to read it. The important thing is, it must be able to read it if
it was written by itself or an event that interrupted it. And it must
be able to know if it is invalid, and that can only happen if the event
interrupted the writing of it.

Cheers!

-- Steve
