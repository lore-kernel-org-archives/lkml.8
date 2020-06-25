Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70068C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9BD2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391140AbgFYUmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390477AbgFYUmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:42:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BBA220767;
        Thu, 25 Jun 2020 20:42:47 +0000 (UTC)
Date:   Thu, 25 Jun 2020 16:42:46 -0400
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
Message-ID: <20200625164246.4b75e157@oasis.local.home>
In-Reply-To: <1860125983.13444.1593115112644.JavaMail.zimbra@efficios.com>
References: <20200625094454.732790f7@oasis.local.home>
        <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
        <20200625150459.4a5d7221@oasis.local.home>
        <1860125983.13444.1593115112644.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 15:58:32 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> >> >		if (ts != save_before) {
> >> >			/* slow path - Was preempted between C and E */
> >> >			/* The update to write_stamp could have overwritten the update to
> >> >			 * it by the preempting event,  
> >> 
> >> This sentence is hard to parse.  
> > 
> > Ah, that needs better wording: "An interrupt of this event could have
> > written to the write_stamp before this interrupt wrote to it.  
> 
> I would have though the part "before this interrupt wrote to it" would
> actually be "before this event wrote to it" (?) Am I confused ?

No, this is what I get for replying while in a meeting ;-)

Yes, it's "before this event".

> 
> > Which
> > means this event could have made the write_stamp go backwards. Need to
> > put back the write stamp using the before stamp, as that can only be
> > updated by events that interrupt this current one."
> > 
> >   
> >>   
> >> >                          but before and after should be
> >> >			 * the same for all completed top events */
> >> >			after = local_read(write_stamp);
> >> >			if (save_before > after)
> >> >				local_cmpxchg(write_stamp, after, save_before);  
> >> 
> >> What is the type of write_stamp, and how does it work on 32-bit architectures
> >> with
> >> NMIs ?
> >>   
> > 
> > local64_cmpxchg(), I left it out of change log, as this is the
> > algorithm not all the details. See the patch for those ;-)  
> 
> I'm still concerned about local64 on 32-bit, as per my prior email.

Yes. And I think we could make a local_time() wrapper of local_t to do
these updates for us. They don't need to be totally atomic, just appear
to be.

> 
> >   
> >> I'm not entirely sure to understand what this cmpxchg try to
> >> accomplish. Moreover, what happens if right after an interrupt nests
> >> between [C] and [E], another interrupt try to write into the buffer
> >> after before that cmpxchg ?  
> > 
> > We are just fixing up this events write into write_stamp. We only worry
> > about being interrupted between C and D, as then we set the write stamp
> > backward. But any interrupting event will also update the before time
> > stamp. That is, the before_stamp can only be the last time stamp of an
> > event that interrupted us here. By doing the cmpxchg, we only update
> > the write stamp to the before stamp of the last event to interrupt this
> > event and if the cmpxchg fails, that means another event came in and
> > updated it to its own time stamp which is what we want it to be!  
> 
> This seems to assume that before_stamp is always written to in a monotonic
> fashion except in this very specific corner-case. But what happens if this
> algorithm is interrupted between reading the clock() current time and
> writing to before_stamp ? This can happen both for the outer event and
> at various nesting levels as well. I'm concerned that this scenario
> would also cause before_stamp to go backwards, but would not be handled
> correctly.

For this version I'm using local64_t for before_stamp. I'll look into
other ways to update it for 32 bit. Sequence updates should be easy to
implement (if it hasn't already).


> > 
> > The buffer would look like this:
> > 
> >  ----+------------------+------------------+------------------+----
> >  ... | time 2 : event 2 | time ? : event 1 | time 3 : event 3 | ...
> >  ----+------------------+------------------+------------------+----
> > 
> > 
> > What do you put in for event 1's time. It's time stamp is before time
> > 2, but the recorded event is after event 2. We can't use event 3 as a
> > time.  
> 
> I solve this by using cmpxchg instead of xadd for [C], and retry space
> reservation with a new timestamp. ;-)

Not if it breaks user space. 10 years ago I may have considered a
change like that, but not today.


> 
> Can we have this scenario at an extra nesting level ? Basically
> we add an outermost event 0 at nesting level 0, and shift events 1, 2, 3
> to nesting levels 1, 2 in your scenario ? If it is possible, will the
> special-case handling it also trigger ?

I'm not sure I understand what you mean. The outer most event only
cares that its timestamp is:

 1) In order between other events in the buffer
 2) Exists between the time the event started recording and the time it
    finished recording. As the caller doesn't care where the timestamp
    lies within that event.

This is true even if this trace happens within a nesting event.

-- Steve
