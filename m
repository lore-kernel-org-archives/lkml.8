Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9296C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADB820781
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgF3AVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgF3AVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:21:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50A93206A5;
        Tue, 30 Jun 2020 00:21:48 +0000 (UTC)
Date:   Mon, 29 Jun 2020 20:21:46 -0400
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
        "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
Message-ID: <20200629202146.29520925@oasis.local.home>
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

So I tested this on three different machines to see how it compared. I
applied this patch:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c2c0d25ea004..8a7d62375eb3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3161,7 +3161,19 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
  /*B*/	rb_time_set(&cpu_buffer->before_stamp, info->ts);
 
+#if 0
  /*C*/	write = local_add_return(info->length, &tail_page->write);
+#else
+	{
+		unsigned long expect, result;
+
+		do {
+			expect = local_read(&tail_page->write);
+			write = expect + info->length;
+			result = local_cmpxchg(&tail_page->write, expect, write);
+		} while (expect != result);
+	}
+#endif
 
 	/* set write to only the index of the write */
 	write &= RB_WRITE_MASK;


And tested before and after the results.

To test, I used my fedora 31 kernel config, and enabled
CONFIG_TRACEPOINT_BENCHMARK.

When that trace event is enabled, a kthread is kicked off that runs in
a loop (see kernel/trace/trace_benchmark.c) that basically does:

	local_irq_disable();
	start = trace_clock_local();
	trace_benchmark_event();
	end = trace_clock_local();
	local_irq_enable();

It takes the delta of end - start. As the first time through is cold
cache it records it separately, and after that it creates a string that
lists the delta of the last event recorded (as it can't make the delta
before it records the end time stamp). The first time stamp (the cold
cache one), the max, min, running average. It also records a running
standard deviation. All numbers are in nanoseconds.

The test was simply doing:

 # trace-cmd record -e benchmark:benchmark_event -o trace-tp-bench-{inc|cmpxchg}.dat sleep 3
 # trace-cmd report trace-tp-bench-{inc|cmpxchg}.dat | tail

The reason for the tail, is to let the machine settle, as x86 has all
sorts of crazy optimizations there's a lot of noise in the beginning.

Anyway, here's the results of my three machines, and feel free to test
this out yourself.

Going from my fastest to slowest machines:

Machine 1:

 model name	: Intel(R) Core(TM) i7-3770 CPU @ 3.40GHz
 (4 core / 8 logical)

# trace-cmd report trace-tp-bench-inc.dat |tail 
 event_benchmark-2072  [003]  2234.664661 benchmark_event:      last=92 first=2794 max=11707 min=81 avg=93 std=49 std^2=2469
 event_benchmark-2072  [003]  2234.664662 benchmark_event:      last=92 first=2794 max=11707 min=81 avg=93 std=49 std^2=2469
 event_benchmark-2072  [003]  2234.664662 benchmark_event:      last=88 first=2794 max=11707 min=81 avg=93 std=49 std^2=2469
 event_benchmark-2072  [003]  2234.664663 benchmark_event:      last=85 first=2794 max=11707 min=81 avg=93 std=49 std^2=2469
 event_benchmark-2072  [003]  2234.664663 benchmark_event:      last=89 first=2794 max=11707 min=81 avg=93 std=49 std^2=2469
 event_benchmark-2072  [003]  2234.664664 benchmark_event:      last=86 first=2794 max=11707 min=81 avg=93 std=49 std^2=2469
 event_benchmark-2072  [003]  2234.664664 benchmark_event:      last=88 first=2794 max=11707 min=81 avg=93 std=49 std^2=2469
 event_benchmark-2072  [003]  2234.664665 benchmark_event:      last=171 first=2794 max=11707 min=81 avg=93 std=49 std^2=2469
 event_benchmark-2072  [003]  2234.664665 benchmark_event:      last=88 first=2794 max=11707 min=81 avg=93 std=49 std^2=2469
 event_benchmark-2072  [003]  2234.664666 benchmark_event:      last=87 first=2794 max=11707 min=81 avg=93 std=49 std^2=2469


# trace-cmd report trace-tp-bench-cmpxchg.dat |tail 
 event_benchmark-1924  [000]   499.515711 benchmark_event:      last=309 first=2955 max=10636 min=81 avg=93 std=73 std^2=5367
 event_benchmark-1924  [000]   499.515711 benchmark_event:      last=96 first=2955 max=10636 min=81 avg=93 std=73 std^2=5367
 event_benchmark-1924  [000]   499.515712 benchmark_event:      last=189 first=2955 max=10636 min=81 avg=93 std=73 std^2=5367
 event_benchmark-1924  [000]   499.515713 benchmark_event:      last=134 first=2955 max=10636 min=81 avg=93 std=73 std^2=5367
 event_benchmark-1924  [000]   499.515713 benchmark_event:      last=92 first=2955 max=10636 min=81 avg=93 std=73 std^2=5367
 event_benchmark-1924  [000]   499.515714 benchmark_event:      last=93 first=2955 max=10636 min=81 avg=93 std=73 std^2=5367
 event_benchmark-1924  [000]   499.515714 benchmark_event:      last=92 first=2955 max=10636 min=81 avg=93 std=73 std^2=5367
 event_benchmark-1924  [000]   499.515715 benchmark_event:      last=89 first=2955 max=10636 min=81 avg=93 std=73 std^2=5367
 event_benchmark-1924  [000]   499.515715 benchmark_event:      last=86 first=2955 max=10636 min=81 avg=93 std=73 std^2=5367
 event_benchmark-1924  [000]   499.515716 benchmark_event:      last=107 first=2955 max=10636 min=81 avg=93 std=73 std^2=5367


Machine 2:

model name	: Intel(R) Core(TM) i3-4130 CPU @ 3.40GHz
 (2 core / 4 logical)

# trace-cmd report trace-tp-bench-inc.dat |tail 
 event_benchmark-3179  [001]   606.466907: benchmark_event:      last=132 first=1463 max=1938 min=115 avg=140 std=36 std^2=1341
 event_benchmark-3179  [001]   606.466907: benchmark_event:      last=133 first=1463 max=1938 min=115 avg=140 std=36 std^2=1341
 event_benchmark-3179  [001]   606.466908: benchmark_event:      last=136 first=1463 max=1938 min=115 avg=140 std=36 std^2=1341
 event_benchmark-3179  [001]   606.466909: benchmark_event:      last=135 first=1463 max=1938 min=115 avg=140 std=36 std^2=1341
 event_benchmark-3179  [001]   606.466909: benchmark_event:      last=135 first=1463 max=1938 min=115 avg=140 std=36 std^2=1341
 event_benchmark-3179  [001]   606.466910: benchmark_event:      last=133 first=1463 max=1938 min=115 avg=140 std=36 std^2=1341
 event_benchmark-3179  [001]   606.466911: benchmark_event:      last=131 first=1463 max=1938 min=115 avg=140 std=36 std^2=1341
 event_benchmark-3179  [001]   606.466912: benchmark_event:      last=132 first=1463 max=1938 min=115 avg=140 std=36 std^2=1341
 event_benchmark-3179  [001]   606.466913: benchmark_event:      last=134 first=1463 max=1938 min=115 avg=140 std=36 std^2=1341
 event_benchmark-3179  [001]   606.466913: benchmark_event:      last=223 first=1463 max=1938 min=115 avg=140 std=36 std^2=1341


# trace-cmd report trace-tp-bench-cmpxchg.dat |tail 
 event_benchmark-3169  [001]   477.024485: benchmark_event:      last=102 first=1820 max=12210 min=95 avg=266 std=75 std^2=5768
 event_benchmark-3169  [001]   477.024486: benchmark_event:      last=103 first=1820 max=12210 min=95 avg=266 std=75 std^2=5768
 event_benchmark-3169  [001]   477.024486: benchmark_event:      last=131 first=1820 max=12210 min=95 avg=266 std=75 std^2=5768
 event_benchmark-3169  [001]   477.024487: benchmark_event:      last=104 first=1820 max=12210 min=95 avg=266 std=75 std^2=5768
 event_benchmark-3169  [001]   477.024487: benchmark_event:      last=181 first=1820 max=12210 min=95 avg=266 std=75 std^2=5768
 event_benchmark-3169  [001]   477.024488: benchmark_event:      last=195 first=1820 max=12210 min=95 avg=266 std=75 std^2=5768
 event_benchmark-3169  [001]   477.024489: benchmark_event:      last=155 first=1820 max=12210 min=95 avg=266 std=75 std^2=5768
 event_benchmark-3169  [001]   477.024489: benchmark_event:      last=102 first=1820 max=12210 min=95 avg=266 std=75 std^2=5768
 event_benchmark-3169  [001]   477.024490: benchmark_event:      last=166 first=1820 max=12210 min=95 avg=266 std=75 std^2=5768
 event_benchmark-3169  [001]   477.024490: benchmark_event:      last=256 first=1820 max=12210 min=95 avg=266 std=75 std^2=5768


Machine 3:

model name	: Intel(R) Core(TM)2 Quad  CPU   Q9450  @ 2.66GHz
( 4 cores / no hyperthreading enabled )

# trace-cmd report trace-tp-bench-inc.dat| tail
 event_benchmark-2686  [000]   860.217674: benchmark_event:      last=195 first=2527 max=4571 min=186 avg=264 std=144 std^2=20943
 event_benchmark-2686  [000]   860.217675: benchmark_event:      last=196 first=2527 max=4571 min=186 avg=264 std=144 std^2=20943
 event_benchmark-2686  [000]   860.217676: benchmark_event:      last=196 first=2527 max=4571 min=186 avg=264 std=144 std^2=20943
 event_benchmark-2686  [000]   860.217677: benchmark_event:      last=193 first=2527 max=4571 min=186 avg=264 std=144 std^2=20943
 event_benchmark-2686  [000]   860.217679: benchmark_event:      last=195 first=2527 max=4571 min=186 avg=264 std=144 std^2=20943
 event_benchmark-2686  [000]   860.217680: benchmark_event:      last=195 first=2527 max=4571 min=186 avg=264 std=144 std^2=20943
 event_benchmark-2686  [000]   860.217681: benchmark_event:      last=195 first=2527 max=4571 min=186 avg=264 std=144 std^2=20943
 event_benchmark-2686  [000]   860.217682: benchmark_event:      last=193 first=2527 max=4571 min=186 avg=264 std=144 std^2=20943
 event_benchmark-2686  [000]   860.217683: benchmark_event:      last=196 first=2527 max=4571 min=186 avg=264 std=144 std^2=20943
 event_benchmark-2686  [000]   860.217684: benchmark_event:      last=195 first=2527 max=4571 min=186 avg=264 std=144 std^2=20943


# trace-cmd report trace-tp-bench-cmpxchg.dat| tail
 event_benchmark-2393  [003]   380.342603: benchmark_event:      last=199 first=2707 max=3215 min=189 avg=297 std=163 std^2=26612
 event_benchmark-2393  [003]   380.342604: benchmark_event:      last=196 first=2707 max=3215 min=189 avg=297 std=163 std^2=26612
 event_benchmark-2393  [003]   380.342606: benchmark_event:      last=201 first=2707 max=3215 min=189 avg=297 std=163 std^2=26612
 event_benchmark-2393  [003]   380.342607: benchmark_event:      last=195 first=2707 max=3215 min=189 avg=297 std=163 std^2=26612
 event_benchmark-2393  [003]   380.342608: benchmark_event:      last=195 first=2707 max=3215 min=189 avg=297 std=163 std^2=26612
 event_benchmark-2393  [003]   380.342609: benchmark_event:      last=198 first=2707 max=3215 min=189 avg=297 std=163 std^2=26612
 event_benchmark-2393  [003]   380.342610: benchmark_event:      last=199 first=2707 max=3215 min=189 avg=297 std=163 std^2=26612
 event_benchmark-2393  [003]   380.342611: benchmark_event:      last=196 first=2707 max=3215 min=189 avg=297 std=163 std^2=26612
 event_benchmark-2393  [003]   380.342613: benchmark_event:      last=196 first=2707 max=3215 min=189 avg=297 std=163 std^2=26612
 event_benchmark-2393  [003]   380.342614: benchmark_event:      last=199 first=2707 max=3215 min=189 avg=297 std=163 std^2=26612


Not that big of a difference, but there is a difference. And the
standard deviation appears to be better, which would make sense as an
local_add_return() needs no repeat on collision.

-- Steve
