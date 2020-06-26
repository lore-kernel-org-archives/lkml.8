Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657B0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A581207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgFZTjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFZTjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:39:14 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EADC8206C0;
        Fri, 26 Jun 2020 19:39:11 +0000 (UTC)
Date:   Fri, 26 Jun 2020 15:39:10 -0400
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
Message-ID: <20200626153910.7b3d7e16@oasis.local.home>
In-Reply-To: <20200626145819.0d3cae3c@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home>
        <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
        <20200625143525.2f3a2902@oasis.local.home>
        <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com>
        <20200625223611.1dbb3b35@oasis.local.home>
        <20200625233552.2c8a0d1e@oasis.local.home>
        <20200626095801.14cfa8a3@oasis.local.home>
        <304619857.14491.1593195230002.JavaMail.zimbra@efficios.com>
        <20200626145819.0d3cae3c@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 14:58:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Second usage:
> 
> 		/* SLOW PATH - Interrupted between A and C */
> 		a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
> 		ts = rb_time_stamp(cpu_buffer->buffer);
> 		barrier();
>  /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
> 		    a_ok && after < ts) {
> 			/* Nothing came after this event between C and E */
> 			info->delta = ts - after;
> 			(void)rb_time_cmpxchg(&cpu_buffer->write_stamp, after, info->ts);
> 			info->ts = ts;
> 		} else {
> 			info->delta = 0;

Actually, I don't think a_ok can every be false here. An uninterrupted
event will leave with both before_stamp and write_stamp valid. As an
uninterrupted event will write to both (and a rb_time_t is only invalid
from reading an interrupted event).

To get to this path we have:

	w = local_read(write_tail);

	<--- Interrupt event (makes write_stamp valid!)

	write = local_add_return(write_tail, length);

	w != write - length;


	[..]

	a_ok = rb_time_read(write_stamp);

Must always be valid!

-- Steve
