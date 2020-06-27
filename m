Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDDFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 01:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5209520857
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 01:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgF0BNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 21:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgF0BNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 21:13:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C835C2081A;
        Sat, 27 Jun 2020 01:13:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jozPh-003zWL-KP; Fri, 26 Jun 2020 21:13:49 -0400
Message-ID: <20200627010041.517736087@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Jun 2020 21:00:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [PATCH 0/3] ring-buffer: Restructure ftrace ring buffer time keeping to allow accurate nested timing
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I completed some thorough testing on these patches now, and have injected
trace_printk()s (in a way to allow it to safely recurse) to force various
data races and then examined the trace to make sure that everything it did
was exactly what I expect it to do, or in cases where it did something
surprising, I found that it was still a legitimate case! ;-)

I found a few bugs along the way, but it all still very much matches the
original design. The bugs were more in the implementation. But now that I
feel I have those all straighten out, I'm much more confident in this code
(famous last words!).

Although I did do a lot of custom testing (with all the injecting of
trace_printk()s), I have only run these through my standard smoke tests and
have not yet run these through my main test suite (13 hour run time). But
will do that when I have other non related patches ready to go with it.

But for now, these are very close to my finished product. Feel free to try
to poke holes in this as well.

Special thanks to Mathieu Desnoyers for his annoying critique (and I mean
that in a very positive way!). If it wasn't for his comments, I would have
missed fixing a small design flaw (the switch back to delta time instead of
keeping with the full time stamp). It turned out that that path had other
issues, and without removing that path, I would not have been able to add
the last patch of this series.

Cheers.

-- Steve


Steven Rostedt (VMware) (3):
      ring-buffer: Have nested events still record running time stamp
      ring-buffer: Incorporate absolute timestamp into add_timestamp logic
      ring-buffer: Add rb_time_t 64 bit operations for speeding up 32 bit

----
 kernel/trace/ring_buffer.c | 503 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 406 insertions(+), 97 deletions(-)
