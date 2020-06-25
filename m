Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4AEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9399D20768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407002AbgFYT6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406701AbgFYT6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:58:54 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28AA206A5;
        Thu, 25 Jun 2020 19:58:51 +0000 (UTC)
Date:   Thu, 25 Jun 2020 15:58:50 -0400
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
Message-ID: <20200625155850.13be7bfa@oasis.local.home>
In-Reply-To: <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com>
References: <20200625094454.732790f7@oasis.local.home>
        <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
        <20200625143525.2f3a2902@oasis.local.home>
        <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 15:35:02 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > 
> > Well, write_stamp is updated via local64, which I believe handles this
> > for us. I probably should make before_stamp handle it as well.  
> 
> By looking at local64 headers, it appears that 32-bit rely on atomic64,
> which on x86 is implemented with LOCK; cmpxchg8b for 586+ (which is AFAIK
> painfully slow) and with cli/sti for 386/486 (which is not nmi-safe).
> 
> For all other 32-bit architectures, the generic atomic64.h implements 64-bit
> atomics using spinlocks with irqs off, which seems to also bring considerable
> overhead, in addition to be non-reentrant with respect to NMI-like interrupts,
> e.g. FIQ on ARM32.
> 
> That seems at odds with the performance constraints of ftrace's ring buffer.
> 
> Those performance and reentrancy concerns are why I always stick to local_t
> (long), and never use a full 64-bit type for anything that has to
> do with concurrent store/load between execution contexts in lttng.

If this is an issue, I'm sure I can make my own wrappers for
"time_local()", and implement something that you probably do. Because,
we only need to worry about wrapping the 32 bit lower number, as that
only happens every 4 seconds. But that is an implementation detail, it
doesn't affect the overall design correctness.

But it is something I should definitely look in to.

> 
> > 
> >   
> >>   
> >> >	 * a full time stamp (this can turn into a time extend which
> >> >	is
> >> >	 * just an extended time delta but fill up the extra space).
> >> >	 */
> >> >	if (after != before)
> >> >		abs = true;
> >> > 
> >> >	ts = clock();
> >> > 
> >> >	/* Now update the before_stamp (everyone does this!) */
> >> > [B]	WRITE_ONCE(before_stamp, ts);
> >> > 
> >> >	/* Read the current next_write and update it to what we want
> >> >	write
> >> >	 * to be after we reserve space. */
> >> > 	next = READ_ONCE(next_write);
> >> >	WRITE_ONCE(next_write, w + len);
> >> > 
> >> >	/* Now reserve space on the buffer */
> >> > [C]	write = local_add_return(len, write_tail);  
> >> 
> >> So the reservation is not "just" an add instruction, it's actually an
> >> xadd on x86. Is that really faster than a cmpxchg ?  
> > 
> > I believe the answer is still yes. But I can run some benchmarks to
> > make sure.  
> 
> This would be interesting to see, because if xadd and cmpxchg have
> similar overhead, then going for a cmpxchg-loop for the space
> reservation could vastly decrease the overall complexity of this
> timestamp+space reservation algorithm.

It would most likely cause userspace breakage, and that would be a show
stopper.

But still good to see.

Thanks for the review.

-- Steve
