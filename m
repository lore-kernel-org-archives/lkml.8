Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A69DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125CB2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wXl8oHUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgHVUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgHVUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:22:42 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C88C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:22:41 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k4so4169814ilr.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7wZdIaE0onpIemQjxXUCkgW61pWCFWrOyPSaP9VrK4=;
        b=wXl8oHUwfpgpiE+u1wtuDYaEzqm9fWOAiLRWb6ABXFxnxVtVhfd0WLaISpoC22XUp2
         AVEm9u9+vAhY6UAY+LyHV9lr3aHfWuxRGab8SOUDMwr77NSQMCpDUSdij2JYV7ONBE0b
         SWo2wKLmNxd8RM6Rq0vCWNGvml/gMJybANups=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7wZdIaE0onpIemQjxXUCkgW61pWCFWrOyPSaP9VrK4=;
        b=Vv016C4vY5xWpNjSqu7n2Y912QXIAD1I4/CeQVOeRgntbGtyhHKuvXNxlEXHKq/ZTh
         3ZVPV3wvbFNo/Ick75431F6LvMNqRu6kjuDxFa0JdHGZ6D/wml4v0/6OMczck1+RLOGR
         DX9DyPHcTmqJlBjBnxyjCGK+onts7AUTN8Yev3271MT/WE1oW8gKw8Hhk5PeRDQrJpcz
         77pSkX6Ag4fltp+VAzZ9quNxlx3N718fG8N4Gw5+RCzUbvm8F8NsA1yB57VECvkIigTs
         tLT8wuU2pXcpVverlyEFW1uSHMsS60lt1nziaBYQfqbePn7zcZbVuJw5qc4/mcqFmBct
         MgEA==
X-Gm-Message-State: AOAM5330wO3AUiZj2XZv3lqNrfo/hlJzTBg9KbUKqMGQz7dXM4cRSdFN
        No16Av9erQXElhvbWv6GdJYMHIw/+PLGp/n0sGOxFHn9jx1wBd0h
X-Google-Smtp-Source: ABdhPJz8ujdJlrIPDu+wJay5OVYu5b5gg4fJpNpHkCcRWHLTS1Nmaqmn/xVRRbLTwv1khUTWaFIhVEmeC6+XaSJzW3I=
X-Received: by 2002:a92:660e:: with SMTP id a14mr7536816ilc.262.1598127760755;
 Sat, 22 Aug 2020 13:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200815031908.1015049-1-joel@joelfernandes.org>
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 22 Aug 2020 16:22:27 -0400
Message-ID: <CAEXW_YTzX98eRihcvHW-8Vwp_=CHehO6FM_J69YEFzMcW2yyOg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] Core-sched v6+: kernel protection and hotplug fixes
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 11:19 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Hello!
>
> This series is continuation of main core-sched v6 series [1] and adds support
> for syscall and IRQ isolation from usermode processes and guests. It is key to
> safely entering kernel mode in an HT while the other HT is in use by a user or
> guest. The series also fixes CPU hotplug issues arising because of the
> cpu_smt_mask changing while the next task is being picked. These hotplug fixes
> are needed also for kernel protection to work correctly.
>
> The series is based on Thomas's x86/entry tree.
>
> [1]  https://lwn.net/Articles/824918/

Hello,
Just wanted to mention that we are talking about this series during
the refereed talk on Monday at 16:00 UTC :
https://linuxplumbersconf.org/event/7/contributions/648/

The slides are here with some nice pictures showing the kernel protection stuff:
https://docs.google.com/presentation/d/1VzeQo3AyGTN35DJ3LKoPWBfiZHZJiF8q0NrX9eVYG70/edit?usp=sharing

And Julien has some promising data to share which he just collected
with this series (and will add them to the slides).

Looking forward to possibly seeing you there and your participation
for these topics both during the refereed talk and the scheduler MC,
thanks!

 - Joel


>
> Background:
>
> Core-scheduling prevents hyperthreads in usermode from attacking each
> other, but it does not do anything about one of the hyperthreads
> entering the kernel for any reason. This leaves the door open for MDS
> and L1TF attacks with concurrent execution sequences between
> hyperthreads.
>
> This series adds support for protecting all syscall and IRQ kernel mode entries
> by cleverly tracking when any sibling in a core enter the kernel, and when all
> the siblings exit the kernel. IPIs are sent to force siblings into the kernel.
>
> Care is taken to avoid waiting in IRQ-disabled sections as Thomas suggested
> thus avoiding stop_machine deadlocks. Every attempt is made to avoid
> unnecessary IPIs.
>
> Performance tests:
> sysbench is used to test the performance of the patch series. Used a 8 cpu/4
> Core VM and ran 2 sysbench tests in parallel. Each sysbench test runs 4 tasks:
> sysbench --test=cpu --cpu-max-prime=100000 --num-threads=4 run
>
> Compared the performance results for various combinations as below.
> The metric below is 'events per second':
>
> 1. Coresched disabled
>     sysbench-1/sysbench-2 => 175.7/175.6
>
> 2. Coreched enabled, both sysbench tagged
>   sysbench-1/sysbench-2 => 168.8/165.6
>
> 3. Coresched enabled, sysbench-1 tagged and sysbench-2 untagged
>     sysbench-1/sysbench-2 => 96.4/176.9
>
> 4. smt off
>     sysbench-1/sysbench-2 => 97.9/98.8
>
> When both sysbench-es are tagged, there is a perf drop of ~4%. With a
> tagged/untagged case, the tagged one suffers because it always gets
> stalled when the sibiling enters kernel. But this is no worse than smtoff.
>
> Also a modified rcutorture was used to heavily stress the kernel to make sure
> there is not crash or instability.
>
> Joel Fernandes (Google) (5):
> irq_work: Add support to detect if work is pending
> entry/idle: Add a common function for activites during idle entry/exit
> arch/x86: Add a new TIF flag for untrusted tasks
> kernel/entry: Add support for core-wide protection of kernel-mode
> entry/idle: Enter and exit kernel protection during idle entry and
> exit
>
> Vineeth Pillai (7):
> entry/kvm: Protect the kernel when entering from guest
> bitops: Introduce find_next_or_bit
> cpumask: Introduce a new iterator for_each_cpu_wrap_or
> sched/coresched: Use for_each_cpu(_wrap)_or for pick_next_task
> sched/coresched: Make core_pick_seq per run-queue
> sched/coresched: Check for dynamic changes in smt_mask
> sched/coresched: rq->core should be set only if not previously set
>
> arch/x86/include/asm/thread_info.h |   2 +
> arch/x86/kvm/x86.c                 |   3 +
> include/asm-generic/bitops/find.h  |  16 ++
> include/linux/cpumask.h            |  42 +++++
> include/linux/entry-common.h       |  22 +++
> include/linux/entry-kvm.h          |  12 ++
> include/linux/irq_work.h           |   1 +
> include/linux/sched.h              |  12 ++
> kernel/entry/common.c              |  88 +++++----
> kernel/entry/kvm.c                 |  12 ++
> kernel/irq_work.c                  |  11 ++
> kernel/sched/core.c                | 281 ++++++++++++++++++++++++++---
> kernel/sched/idle.c                |  17 +-
> kernel/sched/sched.h               |  11 +-
> lib/cpumask.c                      |  53 ++++++
> lib/find_bit.c                     |  56 ++++--
> 16 files changed, 564 insertions(+), 75 deletions(-)
>
> --
> 2.28.0.220.ged08abb693-goog
>
