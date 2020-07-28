Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A6FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B2320729
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="WpkPALAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgG1ABp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG1ABo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 20:01:44 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE88C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 17:01:44 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id h18so5968512uao.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tSlRFIGfb4kvfR5BiSt6EYn7tgMGYbJqHaznUPDCbU=;
        b=WpkPALAf8QFvPE8mWRhL3MKxOzuetCAku3tnLX3TEMsntL7nuaSaN22mnLkI1Zn68H
         3rUCqBP0JiU0gIDZ8Cwf1Q3KN+vxG1fA7CVtB+QdB6XR1sgG0QWPrY1igTPvHzZCCd8K
         yz38sjVyzhBFhSSbeuwCAVjMIyD7owgaZ3U8AE+1dKC/sCw6XTABjU2b9/GYtHBsXVvk
         WaWZfePmBzkbvQne/WHzt8i7cNzwriqhwS7eOEenvYcCh1lmU/Q9bQwRYsgNKQlrBLAU
         oHDhIiucL92TsvRC1obzHv/t+rhRK/aMMB0X3mkcDes29ESpkg57U4aNzzRRtdz0Wk34
         7AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tSlRFIGfb4kvfR5BiSt6EYn7tgMGYbJqHaznUPDCbU=;
        b=t800Ff5ixi4V7NunSxRLekPUhA953tIYgPVKil+kj5CLVh5XJBiiXYyrAcZIY48QYv
         SdgSfjKOmPNaGkQajiipfVkXluOFC/9oRDl7s/PCbT8WT53aKsIPfBUYXQgXI1rcNGrp
         tjFiBGsi+ZxC47poIM5JpHU6TYu6KNTChtISzBOFOFL8CgXqvllGpl9pjRzxXbFZVWzk
         yCvjtjaIOoEADz9KiC/XEbjEpXnatBtqDWDNeZxKrMd5NdoKB0Iz3uXNcscBJ+IOsrUV
         Ea0KIOzpz9T6fLybyFWvM2DA+tv9Q7lxSbcFFe4JHjWOEieNl2LfO4NnU/+OWUgXvhZ6
         9b1A==
X-Gm-Message-State: AOAM531p2Uqsf0VnX78PSirmAg3onUh+om4shC6xIZ1iqZCAb7gdgiB6
        duwXBx28rPBwuG28eIyjwmZqU3RMZqvsoW1YYxzT0vkZrUM=
X-Google-Smtp-Source: ABdhPJzfsHyBwlUOGbPHRWhmRIkIcZwOUU2NeI077/DPOM7Z9zoaoHWey2l7dEkgP/A9QZt1BFGndvlZ/rItECOgDrI=
X-Received: by 2002:ab0:15a4:: with SMTP id i33mr18895120uae.85.1595894503286;
 Mon, 27 Jul 2020 17:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200722234538.166697-1-posk@posk.io> <20200722234538.166697-2-posk@posk.io>
 <20200723112757.GN5523@worktop.programming.kicks-ass.net> <CAFTs51UJhC9TmXkzz8VbDNmkSEyZE29=dRdUi65TDpSYqoK5vw@mail.gmail.com>
 <20200727095110.GG119549@hirez.programming.kicks-ass.net>
In-Reply-To: <20200727095110.GG119549@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@posk.io>
Date:   Mon, 27 Jul 2020 17:01:32 -0700
Message-ID: <CAFTs51XjPnTSOLisuy6pkx5LMPexAd8ig2dKpJCV0vYhgzUTZQ@mail.gmail.com>
Subject: Re: [PATCH for 5.9 1/3] futex: introduce FUTEX_SWAP operation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc BPF maintainers]

I added a lot of details below... Maybe too much? Let me know...

On Mon, Jul 27, 2020 at 2:51 AM <peterz@infradead.org> wrote:
> On Thu, Jul 23, 2020 at 05:25:05PM -0700, Peter Oskolkov wrote:
> > On Thu, Jul 23, 2020 at 4:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > What worries me is how FUTEX_SWAP would interact with the future
> > > FUTEX_LOCK / FUTEX_UNLOCK. When we implement pthread_mutex with those,
> > > there's very few WAIT/WAKE left.
[,,,]
> > FUTEX_LOCK/FUTEX_UNLOCK uses spinning and lock stealing to
> > improve futex wake/wait performance in high contention situations;
>
> The spinning is best for light contention.

Right. But the goal here is to enable fast context switching, not deal
with any kind of contention, light or heavy... See more on that below.

>
> > FUTEX_SWAP is designed to be used for fast context switching with
> > _no_ contention by design: the waker that is going to sleep, and the wakee
> > are using different futexes; the userspace will have a futex per thread/task,
> > and when needed the thread/task will either simply sleep on its futex,
> > or context switch (=FUTEX_SWAP) into a different thread/task.
>
> Right, but how can you tell what the next thing after UNLOCK is going to
> be.. that's going to be tricky.

Yes, but it is somewhat irrelevant here: if task A wants task B to run in
its place, and task B is "cooperating", let them do it... Again, see below
on what we would like to achieve here.

[,,,]

> Correct; however the reason I like LOCK/UNLOCK is that it exposes the
> blocking relations to the kernel -- and that ties into yet another
> unfinished patch-set :-/
>
>   https://lkml.kernel.org/r/20181009092434.26221-1-juri.lelli@redhat.com

Futexes were initially introduced, I believe, as barebone kernel
primitives for the userspace to build various synchronization mechanisms
on top of. Explicitly keeping the kernel agnostic to blocking relations.

While I understand and fully support the desire to have more
sophisticated machinery in the kernel (like the LOCK/UNLOCK work,
and the proxy execution patchset referenced above), FUTEX_SWAP
is more aligned with the initial "keep it simple" approach, i.e.
enable a fast context switch, let the userspace deal with complexity.

Again, see more below.

> > What will be faster: FUTEX_SWAP that does
> >    FUTEX_WAKE (futex A) + FUTEX_WAIT (current, futex B),
> > or FUTEX_SWAP that does
> >    FUTEX_UNLOCK (futex A) + FUTEX_LOCK (current, futex B)?
>
> Well, perhaps both argue against having SWAP but instead having compound
> futex ops. Something I think we're already starting to see with the new
> futex API patches posted here:
>
>   https://lkml.kernel.org/r/20200709175921.211387-1-andrealmeid@collabora.com
>
> sys_futex_waitv() is effectively a whole bunch of WAIT ops combined.

I'm not sure how to build a fast context switch out of multiple related
wait ops...

>
> > As wake+wait will always put the waker to sleep, it means that
> > there will be a true context switch on the same CPU on the fast path;
> > on the other hand, unlock+lock will potentially evade sleeping,
> > so the wakee will often run on a different CPU (with the waker
> > spinning instead of sleeping?), thus not benefitting from cache locality
> > that fast context switching on the same CPU is meant to use...
> >
> > I'll add some of the considerations above to the expanded cover letter
> > (or a commit message).
>
> It's Monday morning, so perhaps I'm making a mess of things, but
> something like the below, where our thread t2 issues synchronous work to
> t1:
>
>
>         t1              t2
>                         LOCK A
>         LOCK B
> 1:      LOCK A
>
>                         ...
>
>
>                         UNLOCK A
>                         LOCK B
>         ...
>
>         UNLOCK B
>         UNLOCK A
>         LOCK B
>         GOTO 1
>                         UNLOCK B
>                         LOCK A
>                         ...
>
> Is an abuse of mutexes, that is, it implements completions using a
> (fair) mutex. A guards the work-queue, B is the 'completion'.
>
> Then, if you teach it that a compound UNLOCK-A + LOCK-B, where
> the lock owner of B is on the wait list of A is a 'SWAP', should get you
> the desired semantics, I think.
>
> You can do SWAP and you get to have an exposed blocking relation.

This will work for two threads. However, if a process has an arbitrary
number of threads (tasks), I'm not sure how to construct something similar
that would allow any task to swap into (= context switch into) any other task
(and have the tasks dynamically come and go).

With FUTEX_SWAP, each task has its own futex, and futexes are locked
(= waited on) only by their owners, so no cross-locking is needed as in above.

> Is this exactly what we want, I don't know. Because I'm not entirely
> sure what problem we're solving. Why would you be setting things up like
> that in the first place. IIRC you're using this to implement coroutines
> in golang, and I'm not sure I have a firm enough grasp of all that to
> make a cogent suggestion one way or the other.

OK, here is the main wall of text in this message... :)

A simplified/idealized use case: imagine a multi-user service application
(e.g. a DBMS) that has to implement the following user CPU quota
policy:
- each user (these are DBMS users, not Linux users) can purchase
  certain amounts of expensive, but guaranteed, low-latency
  CPU quota (as a % of total CPUs available to the service), and a certain
  amount of cheap high-latency CPU quota;
- quotas are enforced per second;
- each user RPC/request to the service can specify whether this is
  a latency-critical request that should use the user's low-latency quota,
  and be immediately rejected if the quota for this second is exhausted;
- requests can be high-latency-tolerant: should only use the high-latency
  quota;
- a request can also be latency-tolerant: it should use the low-latency
  quota if available, or the high-latency quota if the low-latency quota
  is exhausted;
- all "sold" (= allocated) low-latency quotas can go up to, but not exceed,
  70% of all available CPUs (i.e. no over-subscription);
- high-latency quotas are oversubscribed;
- user isolation: misbehaving users should not affect the serving
  latency of users with available low-latency quotas;
- soft deadlines/timeouts: each request/RPC can specify that it must
  be served within a certain deadline (let's say the minimum deadline
  is 10 milliseconds) or dropped if the deadline is exceeded;
- each user request can potentially spawn several processing threads/tasks,
  and do child RPCs to remote services; these threads/tasks should
  also be covered by this quota/policy;
- user requests should be served somewhat in-order: requests that use
  the same quota tiers that arrive earlier should be granted CPU before
  requests that arrive later ("arrival order scheduling").

There are many services at Google that implement a variant of the scheduling
policy outlined above. In reality there are more priorities/quota tiers,
there is service-internal maintenance work that can be either high
or low priority, sometimes FIFO/LIFO/round robin scheduling is used in
addition to arrival order scheduling, etc. (for example, LIFO scheduling
is better at cache-locality in certain scenarios). User isolation within
a process, as well as latency improvements are the main benefits (on top
of the actual ability to implement complex quota/scheduling policies).

What is important is that these scheduling policies are driven by
userspace schedulers built on top of these basic kernel primitives:
- block: block the current thread/task (with a timeout);
- resume: resume some previously blocked task (should commutate
  with block, i.e. racing block/resume pairs should behave
  exactly as if wake arrived after block);
- switch_to: block the current thread, resume some previously
  blocked task (behaves exactly as wake(remote), block(current), but
  optimized to do a fast context switch on the fast path);
- block detection: when a task blocks in the kernel (on a network
  read, for example), the userspace scheduler is notified and
  schedules (resumes or swaps into) a pending task in the newly available
  CPU slot;
- wake detection: when a task wakes from a previously blocking kernel
  operation (e.g. can now process some data on a network socket), the
  userspace scheduler is notified and can now schedule the task to
  run on a CPU when a CPU is available and the task can use it according
  to its scheduling policy.

(Technically, block/wake detection is still experimental and not
used widely: as we control the userspace, we can actually determine
blocking/waking syscalls without kernel support).

Internally we currently use kernel patches that are too "intrusive" to be
included in a general-purpose Linux kernel, so we are exploring ways to
upstream this functionality.

The easiest/least intrusive approach that we have come up with is this:

- block/resume map perfectly to futex wait/wake;
- switch_to thus maps to FUTEX_SWAP;
- block and wake detection can be done either through tracing
  or by introducing new BPF attach points (when a task blocks or wakes,
  a BPF program is triggered that then communicates with the userspace);
- the BPF attach points are per task, and the task needs to "opt in"
  (i.e. all other tasks suffer just an additional pointer comparison
  on block/wake);
- the BPF programs triggered on block/wake should be able to perform
  futex ops (e.g. wake a designated userspace scheduling task) - this
  probably indicates that tracing is not enough, and a new BPF prog type
  is needed.

[+cc BPF maintainers for the above].

> > > Also, why would we commit to an ABI without ever having seen the rest?
> >
> > I'm not completely sure what you mean here. We do not envision any
> > expansion/changes to the ABI proposed here,
>
> Well, you do not, but how can we verify this without having a complete
> picture. Also, IIRC, there's a bunch of scheduler patches that goes on
> top to implement the fast switch.

I hope my wall of text above clarifies things a bit.

> Also, how does this compare to some of the glorious hacks found in
> GNU Pth? You can implement M:N threading using those as well.

It seems GNU Pth tries to emulate kernel scheduling in the userspace,
while we would like to expose basic scheduling building blocks to
the userspace and let it do anything it feels like...
