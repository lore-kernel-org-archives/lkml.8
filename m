Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B11C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 16:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A062078D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 16:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgF1QnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 12:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgF1QnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 12:43:15 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F2E12076C;
        Sun, 28 Jun 2020 16:43:13 +0000 (UTC)
Date:   Sun, 28 Jun 2020 12:43:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH 1/3] ring-buffer: Have nested events still record
 running time stamp
Message-ID: <20200628124311.047fb1a2@oasis.local.home>
In-Reply-To: <20200629012323.2db839ccff81021b7b28af9f@kernel.org>
References: <20200627010041.517736087@goodmis.org>
        <20200627011349.653601969@goodmis.org>
        <20200629012323.2db839ccff81021b7b28af9f@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 01:23:23 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > Here's the design of this solution:
> > 
> >  All this is per cpu, and only needs to worry about nested events (not
> >  parallel events).
> >  
> 
> This looks basically good to me, but I have some comments below.
> (just a clean up)

Thanks Masami!

>  
> > The players:
> > 
> >  write_tail: The index in the buffer where new events can be written to.
> >      It is incremented via local_add() to reserve space for a new event.
> > 
> >  before_stamp: A time stamp set by all events before reserving space.
> > 
> >  write_stamp: A time stamp updated by events after it has successfully
> >      reserved space.  
> 
> So these stamps works like a seq-lock to detect interruption (from both
> interrupted process and interrpting process)

Yes.

> 
> > 
> >  next_write: A copy of "write_tail" used to help with races.  
> 
> It seems this player does nothing.

Bah, you're right. With removing the one path that Mathieu suggested,
took this player out of the game. Will remove in v2. Thanks for
pointing this out.

> 
> > 
> > 	/* Save the current position of write */
> >  [A]	w = local_read(write_tail);
> > 	barrier();
> > 	/* Read both before and write stamps before touching anything */
> > 	before = READ_ONCE(before_stamp);
> > 	after = local_read(write_stamp);  
> 
> Are there any reason to use READ_ONCE() and local_read()?
> (In the code, both are local64_read())

Thanks for pointing this out. before_stamp was originally just a normal
variable, but in discussions with Mathieu, it became apparent that it
needed to be atomic as well.

I'll update the change log in v2.


> 
> > 	barrier();
> > 
> > 	/*
> > 	 * If before and after are the same, then this event is not
> > 	 * interrupting a time update. If it is, then reserve space for adding
> > 	 * a full time stamp (this can turn into a time extend which is
> > 	 * just an extended time delta but fill up the extra space).
> > 	 */
> > 	if (after != before)
> > 		abs = true;
> > 
> > 	ts = clock();
> > 
> > 	/* Now update the before_stamp (everyone does this!) */
> >  [B]	WRITE_ONCE(before_stamp, ts);
> > 
> > 	/* Read the current next_write and update it to what we want write
> > 	 * to be after we reserve space. */
> >  	next = READ_ONCE(next_write);
> > 	WRITE_ONCE(next_write, w + len);  
> 
> This seems meaningless, because neither "next" nor "next_write"
> are not refered.

and they are now meaningless, but wasn't in the RFC. I'll remove it.

> 
> > 
> > 	/* Now reserve space on the buffer */
> >  [C]	write = local_add_return(len, write_tail);
> > 
> > 	/* Set tail to be were this event's data is */
> > 	tail = write - len;

[...]

> >  
> > -	/* Don't let the compiler play games with cpu_buffer->tail_page */
> > -	tail_page = info->tail_page = READ_ONCE(cpu_buffer->tail_page);
> > -	write = local_add_return(info->length, &tail_page->write);
> > +	next = READ_ONCE(cpu_buffer->next_write);
> > +	WRITE_ONCE(cpu_buffer->next_write, w + info->length);  
> 
> So, this next may have no effect.

And I'll remove them.

Thanks for reviewing!

-- Steve
