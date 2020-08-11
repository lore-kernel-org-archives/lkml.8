Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02177C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5152206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgHKQF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:05:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:58962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgHKQFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:05:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27400B5EF;
        Tue, 11 Aug 2020 16:06:13 +0000 (UTC)
Date:   Tue, 11 Aug 2020 18:05:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] printk: reimplement LOG_CONT handling
Message-ID: <20200811160551.GC12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blkcanps.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-07-18 16:48:55, John Ogness wrote:
> On 2020-07-17, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Make sure you test the case of "fast concurrent readers". The last
> > time we did things like this, it was a disaster, because a concurrent
> > reader would see and return the _incomplete_ line, and the next entry
> > was still being generated on another CPU.
> >
> > The reader would then decide to return that incomplete line, because
> > it had something.
> >
> > And while in theory this could then be handled properly in user space,
> > in practice it wasn't. So you'd see a lot of logging tools that would
> > then report all those continuations as separate log events.
> >
> > Which is the whole point of LOG_CONT - for that *not* to happen.
> 
> I expect this is handled correctly since the reader is not given any
> parts until a full line is ready, but I will put more focus on testing
> this to make sure. Thanks for the regression and testing tips.

Hmm, the current patchset has different problem. The continuation
pieces are correctly passed as a single lines. But empty line is
printed for each unused sequence number to avoid warnings about
missed messages in journactl. It looks like:

Aug 11 17:08:16 sle15-sp1 kernel: x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
Aug 11 17:08:16 sle15-sp1 kernel: x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
Aug 11 17:08:16 sle15-sp1 kernel: x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
Aug 11 17:08:16 sle15-sp1 kernel: BIOS-provided physical RAM map:
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
[...]
Aug 11 17:08:16 sle15-sp1 kernel: kvm-clock: using sched offset of 85305506196438 cycles
Aug 11 17:08:16 sle15-sp1 kernel: clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 88>
Aug 11 17:08:16 sle15-sp1 kernel: tsc: Detected 2112.000 MHz processor
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Aug 11 17:08:16 sle15-sp1 kernel: last_pfn = 0x180000 max_arch_pfn = 0x400000000
Aug 11 17:08:16 sle15-sp1 kernel: MTRR default type: write-back
Aug 11 17:08:16 sle15-sp1 kernel: MTRR fixed ranges enabled:
[...]
Aug 11 17:08:16 sle15-sp1 kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519>
Aug 11 17:08:16 sle15-sp1 kernel: setup_percpu: NR_CPUS:8192 nr_cpumask_bits:3 nr_cpu_ids:3 nr_node_ids:1
Aug 11 17:08:16 sle15-sp1 kernel: percpu: Embedded 508 pages/cpu s2043904 r8192 d28672 u2097152
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: pcpu-alloc: s2043904 r8192 d28672 u2097152 alloc=1*2097152
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: 
Aug 11 17:08:16 sle15-sp1 kernel: pcpu-alloc: [0] 0 [0] 1 [0] 2 
Aug 11 17:08:16 sle15-sp1 kernel: KVM setup async PF for cpu 0
Aug 11 17:08:16 sle15-sp1 kernel: kvm-stealtime: cpu 0, msr 17f9f2080
Aug 11 17:08:16 sle15-sp1 kernel: Built 1 zonelists, mobility grouping on.  Total pages: 1031901
Aug 11 17:08:16 sle15-sp1 kernel: Policy zone: Normal


> > So this is just a heads-up that I will not pull something that breaks
> > LOG_CONT because it thinks "user space can handle it". No. User space
> > does not handle it, and we need to handle it for the user.

I am afraid that this not acceptable for Linus either because people
will report bugs and complain about regression.

Slightly better solution is to skip the unused sequence numbers. It
looks good in both dmesg/journalctl by default. Note that journalctl
shows the warnings about missing lines "only" with "-a" option.
Sigh, but I am afraid that this is still not acceptable.


Hmm, I can't find any simple or even working solution for maintaining
a monotonic sequence number a lockless way that would be the same
for all stored pieces.

I am afraid that the only working solution is to store all pieces
in a single lockless transaction. I think that John already
proposed using 2nd small lockless buffer for this. The problem
might be how to synchronize flushing the pieces into the final
buffer.

Another solution would be to use separate buffer for each context
and CPU. The problem is a missing final "\n". It might cause
that a buffer is not flushed for a long time until another
message is printed in the same context on the same CPU.

The 2nd small logbuffer looks like a better choice if we
are able to solve the lockless flush.

Best Regards,
Petr
