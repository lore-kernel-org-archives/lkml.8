Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E5CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E6B207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eHOUnkOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgFZRof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:44:35 -0400
Received: from mail.efficios.com ([167.114.26.124]:44032 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgFZRoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:44:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5E0922D4ED3;
        Fri, 26 Jun 2020 13:44:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xDKNqrlfs4F6; Fri, 26 Jun 2020 13:44:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EDF402D5145;
        Fri, 26 Jun 2020 13:44:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EDF402D5145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593193472;
        bh=xtzPnGF0nvWeB/ZnXTy3391IUZEWpsiGMcBXDW7mJxA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=eHOUnkOpNqMN3Vnka8s//GcWYBRLi8iOHh9d3KCQUv92T6FJYwpcLHG1XgmYfj58v
         Q0by+eF1RbLvfGmLwR8ulcqI5a27dssFbi2gGK0D9M8hJ2cfrBM/qfs31gyADtqzng
         i9MLC3H2/yLwScKYiyA5JcmNQqsL6W7gWUfcFhd4DjIO93tZCdL7SQ/3UnnLDARKMo
         Qs47+IFvhyBZG92cM3ved0oyT5HOUZNL+VcriNAsiblrXlwquH7oF8Lhv3yl6gaBHo
         u4wu9u/0Z+040kdXq62uFLanhucalHQbRGjVTtHezVjjtCKUrkXXrOJl04ODM85ufp
         861HlUG7b4RpQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sxkOcMOt7u6w; Fri, 26 Jun 2020 13:44:32 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DC56A2D5144;
        Fri, 26 Jun 2020 13:44:32 -0400 (EDT)
Date:   Fri, 26 Jun 2020 13:44:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        paulmck <paulmck@kernel.org>, Julien Desfossez <ju@klipix.org>
Message-ID: <1794998208.14478.1593193472804.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200626160017.GJ4817@hirez.programming.kicks-ass.net>
References: <20200619202516.7109-1-mathieu.desnoyers@efficios.com> <20200624121136.GF4800@hirez.programming.kicks-ass.net> <269292405.11607.1593023493676.JavaMail.zimbra@efficios.com> <20200624195030.GG4800@hirez.programming.kicks-ass.net> <1115572712.12427.1593096995446.JavaMail.zimbra@efficios.com> <20200626160017.GJ4817@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH v2] sched_pair_cpu: Introduce scheduler task pairing
 system call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: sched_pair_cpu: Introduce scheduler task pairing system call
Thread-Index: Fm8n8tbdMk/jQ0KkT42aSKX2CqDQfQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 26, 2020, at 12:00 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Jun 25, 2020 at 10:56:35AM -0400, Mathieu Desnoyers wrote:
>> ----- On Jun 24, 2020, at 3:50 PM, Peter Zijlstra peterz@infradead.org wrote:
> 
> I'll try and read the earlier bit later, I can't think today.
> 
>> > That's exactly what that signal would do. It would send SIGIO when the
>> > state changes.
>> > 
>> > So you want to access CPU-n's data, you open that file, register a
>> > signal and read it's state, if offline, you good, do the rseq. If it
>> > suddenly decides to come back online, you're guaranteed that SIGIO
>> > before it reaches userspace.
>> >
>> > The nice thing is that it's all R/O so available to normal users, you
>> > don't have to write to the file.
>> 
>> So let's say you have two threads trying to access (offline) CPU-n's data
>> with that algorithm concurrently. How are they serialized with each other ?
> 
> Also implement F_SETLK or something :-)

I don't see this being available to non-root users.

> 
>> >> We do not want to override the affinity restricted by cgroups because
>> >> we don't want to hurt performance characteristics of another partition
>> >> of the system.
>> >> 
>> >> The sched_pair_cpu approach has the benefit of allowing us to touch
>> >> per-cpu data of a given CPU without requiring to run on that CPU, which
>> >> ensures that we do not thrash the cpu cache of cpus on which a thread
>> >> is not allowed to run. It takes care of issues caused by both cgroup
>> >> cpusets and cpu hotplug.
>> > 
>> > But now I worry that your thing allows escaping the cgroup contraints,
>> > you can perturb random CPUs you're not allowed on. That's a really bad
>> > 'feature'.
>> > 
>> > Offline cpus are okay, because you don't actually need to do anything as
>> > long as they're offline, but restricted CPUs we really should not be
>> > touching, not even a little.
>> 
>> With sched_pair_cpu, the paired task never needs to run on the target CPU.
>> The kworker thread runs on the target CPU in the same way other existing
>> worker threads run today, e.g. the ones handling RCU callbacks. AFAIK the
>> priority of those threads can be configured by a system administrator.
> 
> Ah, but the critical difference is that all those are only ever ran if
> the initial work was initialized on _that_ CPU to begin with. Consider
> an isolated CPU that's spinning in userspace, it would _never_ get any
> kthreads running.
> 
> Except now you can, and you even want this system call to be unpriv.
> 
> It utterly and completely wrecks NOHZ_FULL.
> 
>> Are there additional steps we should take to minimize the impact of this
>> worker thread ? In the same way "no rcu callbacks" CPU can be configured
>> at boot time, we could have "no sched pair cpu" configured at boot, which
>> would prevent sched_pair_cpu system calls from targeting that CPU entirely,
>> and not spawn any kworker on that cpu.
> 
> No, no, no! "at boot time" is an utter trainwreck. I've been trying to
> get NOHZ_FULL runtime configurable. This means that your cpuset can
> change at runtime and the CPU you tought you had now is a NOHZ_FULL CPU.
> 
> We must not allow pears on it.

One possibility is to simply treat NOHZ_FULL cpus as offline from the
perspective of sched_pair_cpu: no kworker thread on those, and the
queuing is handled elsewhere. As long as rseq is not be used on NOHZ_FULL
cpus concurrently with sched_pair_cpu targeting those CPUs, it would work.

> I'm thinking that the best option might be to treat CPUs outside of your
> cpuset the same as offline CPUs. That more-or-less requires that tasks
> outside of your cpuset partition don't have access to your shared
> memory, but that isn't an entirely insane assumption.
> 
> If you want to share memory across cpuset partitions, you get to keep
> the pieces.

The main issue is that cpuset partitions are changed dynamically at runtime
by external "manager" processes (e.g. Android). To make things even more
interesting, cpusets support both "process" and "threaded" domain types.

There are quite a few scenarios which worry me with this approach, e.g.:

A) rseq and sched_pair_cpu are used by a memory allocator within a process,
   and specific threads of that process eventually have their cpuset changed
   to exclude some cpus (with cpusets applied per-thread rather than per-process).
   Now the memory allocator needs to touch the per-cpu data of specific cpus to
   which it does not have access from a given thread while other threads within
   the process still use it concurrently.

B) A tracer ring buffer works on per-cpu data in shared memory across processes
   with rseq and sched_pair_cpu, and races on per-cpu data because an external
   manager process concurrently applies different cpusets (with process domain)
   to processes interacting over that shared memory.

> And the nice thing about offline, is that you don't actually need to run
> anything. You only need some exclusion thing (and using a spin-loop on a
> random other CPU for that is bloody insane).

Indeed, for the offline case, the kworker really does not need to keep burning
CPU time. I should eventually have it sleep for a while instead, or have the work
queues for all offline cpus handled by a single kworker for the entire system.

So treating NOHZ_FULL cpus as offline, I'm all good with that. Treating cpus which
are not in the cpuset as offline, not so much.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
