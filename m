Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2468AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DF5206E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="Q/PA8j0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGXAZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgGXAZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:25:17 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F8C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:25:16 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id n4so2420518uae.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCYAm0cXhlKGumLX7lGB7J67gQ6nGdBWRNsstnRRJKg=;
        b=Q/PA8j0irj/Go/IJbrKbECwGxNLKdOb1eB6VUasRjMghpx6SIs+l4WyzA+iAGgBXcJ
         XLiwMTRQ28QoxhKA8otzwG7Zb/g58C9sMufsWEshd0uyUsuRBZUfGsLEcQWFT7kYayNI
         uVI3+HuiA40NmhciTRm4JmQyaFHHOLej9HJNSlhZRACXC9C1URvoF8USzoTNgfKUW6d9
         rV1qka8ORBgSWU/yiT6UrBHnPhJHZjd/WYTezWRAyA1L1jmGq4GGEoCWdqkxXcoQDA9V
         ViewoS0sIPBTlMPW6R/EPTyc0l6kOTNiHHDoK16t5QMeVmz11bTTfm1Sg7nPG67wm9H1
         V/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCYAm0cXhlKGumLX7lGB7J67gQ6nGdBWRNsstnRRJKg=;
        b=muHCCQK2PF/hWEEcmOYi+uRUXhJUMHg3GoU2OCubRksGc0du66iYVpWA3jKP6pQYX9
         62pn5z2k+IJ+gB/G/hzgktQu44iWsYZsVDQciXryT8rXwxxvdyGkaNhuY6wUeU6qoVYE
         XMB8cGyFl2xKvpfLl2qNRjr1XPR6UnTNk4Rb42i7G0x6fFwdDVCOl/RJ1PqEgEL4Qwtw
         xJ6QRUF1o3jRktpBjh/qmyQKbWxJUJm53TE0kobowvM2Zp7iklk/wWBJ/7VVYGkT1Np4
         GTu7pPY/QLYu5HdEbGfoIvw/OGlLo8+BuyzNbM22IxuD2RFfijMrb71RT6wwflLj4cro
         tpZw==
X-Gm-Message-State: AOAM531cd60bvR83i60ODH+4LOfvaly1anvwTDLlNJOl8s2tXZYdr1Sa
        Kj8Nb8108AMWtuT60qQXKimKkJTHOdMQIMpwU5Wt+A==
X-Google-Smtp-Source: ABdhPJx3yILoCwHS93lBlhghb3NpzBK2ZF3fjV2PcD1VqDyXXZVmycjNeJMcFKPrhtaKknJm6pzeuhNV/ED+BFR2ueM=
X-Received: by 2002:ab0:3b2:: with SMTP id 47mr6354662uau.139.1595550315810;
 Thu, 23 Jul 2020 17:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200722234538.166697-1-posk@posk.io> <20200722234538.166697-2-posk@posk.io>
 <20200723112757.GN5523@worktop.programming.kicks-ass.net>
In-Reply-To: <20200723112757.GN5523@worktop.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@posk.io>
Date:   Thu, 23 Jul 2020 17:25:05 -0700
Message-ID: <CAFTs51UJhC9TmXkzz8VbDNmkSEyZE29=dRdUi65TDpSYqoK5vw@mail.gmail.com>
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
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 4:28 AM Peter Zijlstra <peterz@infradead.org> wrote:

Thanks a lot for your comments, Peter! My answers below.

>
> On Wed, Jul 22, 2020 at 04:45:36PM -0700, Peter Oskolkov wrote:
> > This patchset is the first step to open-source this work. As explained
> > in the linked pdf and video, SwitchTo API has three core operations: wait,
> > resume, and swap (=switch). So this patchset adds a FUTEX_SWAP operation
> > that, in addition to FUTEX_WAIT and FUTEX_WAKE, will provide a foundation
> > on top of which user-space threading libraries can be built.
>
> The PDF and video can go pound sand; you get to fully explain things
> here.

Will do. Should I expand the cover letter or the commit message? (I'll probably
split the first patch into two in the latter case).

>
> What worries me is how FUTEX_SWAP would interact with the future
> FUTEX_LOCK / FUTEX_UNLOCK. When we implement pthread_mutex with those,
> there's very few WAIT/WAKE left.

[+cc Waiman Long]

I've looked through the latest FUTEX_LOCK patchset I could find (
https://lore.kernel.org/patchwork/cover/772643/ and related), and it seems
that FUTEX_SWAP and FUTEX_LOCK/FUTEX_UNLOCK patchsets
address the same issue (slow wakeups) but for different use cases:

FUTEX_LOCK/FUTEX_UNLOCK uses spinning and lock stealing to
improve futex wake/wait performance in high contention situations;
FUTEX_SWAP is designed to be used for fast context switching with
_no_ contention by design: the waker that is going to sleep, and the wakee
are using different futexes; the userspace will have a futex per thread/task,
and when needed the thread/task will either simply sleep on its futex,
or context switch (=FUTEX_SWAP) into a different thread/task.

I can also imagine that instead of combining WAIT/WAKE for
fast context switching, a variant of FUTEX_SWAP can use LOCK/UNLOCK
operations in the future, when these are available; but again, I fully
expect that
a single "FUTEX_LOCK the current task on futex A, FUTEX_UNLOCK futex B,
context switch into the wakee" futex op will be much faster than doing
the same thing
in two syscalls, as FUTEX_LOCK/FUTEX_UNLOCK does not seem to be concerned
with fast waking of a sleeping task, but more with minimizing sleeping
in the first place.

What will be faster: FUTEX_SWAP that does
   FUTEX_WAKE (futex A) + FUTEX_WAIT (current, futex B),
or FUTEX_SWAP that does
   FUTEX_UNLOCK (futex A) + FUTEX_LOCK (current, futex B)?

As wake+wait will always put the waker to sleep, it means that
there will be a true context switch on the same CPU on the fast path;
on the other hand, unlock+lock will potentially evade sleeping,
so the wakee will often run on a different CPU (with the waker
spinning instead of sleeping?), thus not benefitting from cache locality
that fast context switching on the same CPU is meant to use...

I'll add some of the considerations above to the expanded cover letter
(or a commit message).

>
> Also, why would we commit to an ABI without ever having seen the rest?

I'm not completely sure what you mean here. We do not envision any
expansion/changes to the ABI proposed here, only further performance
improvements. On these, we currently think that marking the wakee
as the preferred next task to run on the current CPU (by storing
"struct task_struct *preferred_next_tast" either in a per-CPU pointer,
or in the current task_struct) and then having schedule() determine
whether to follow the hint or ignore it would be the simplest way to speed up
the context switch.

>
> On another note: wake_up_process_prefer_current_cpu() is a horrific
> function name :/ That's half to a third of the line limit.

I fully agree. I considered wake_up_on_current_cpu() first, but this name
does not indicate that the wakeup is a "strong wish", but "current
cpu" is a weak
one... Do you have any suggestions? Maybe

wake_up_on_cpu(struct task_struct *next, int cpu_hint)?

But this seems too broad in scope, as we are interested here in only
migrating the task to the current CPU...

Thanks again for your comments!
