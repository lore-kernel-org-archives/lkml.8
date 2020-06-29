Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C49C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0A92073E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKJ9UEl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390248AbgF2VEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731120AbgF2TMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:45 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A2C030F2C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:44:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so2883291ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1ZouKwkA6OTn94EhFg+HzBGtNxozDTOKD9+zn9cXGk=;
        b=pKJ9UEl9YW6klCcaX2H9le5Wxf+le5pbrXq73l9SdmWUOnpuT8/IOV1JLmFazjhbMo
         4l9KjDPBB1mpMTXsVeNWQ4LchMq5Rgb7gkAQmsd2+IzeuneMCE26vVvSgnZ/Q2Jvu+FM
         8JXKXwEyofd1vO8XYbIIbb1usQTJ/f9PapEiLqZ9hguc2OStJMeXr/f9LKLuIgUedLv7
         AOBnxndVCPIrMRusUptiQdUMtqV42zIHpFwrjoE2ROBTg484kSZUBgxHP6Kd6J3V7WE9
         OPnOlPS5v21DyhZvPVY0wyCz/Bns6fZHzCb3KrYfovBR0U4nnQBGbI1UO5e33F2Xabgn
         tENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1ZouKwkA6OTn94EhFg+HzBGtNxozDTOKD9+zn9cXGk=;
        b=Wel/jbmYCSi82WhB4C/p+Y41JuoCPdh1iM3FKCnhhdeJfuw1i889QbfARcD5gFYwbx
         8cOhDqlhE+RijC8MJ6jY9srXf4vHBc/ivHmWRg9995yBPQS4tzYtTFOPQfLUwHCblt/1
         gkCWDxIRE26k62PZ+DXJjG1ZJm6oLzekVEYoBNwBhCefkrHyLi6MhkmaquD0G6mR7NL0
         aBdFE/wN8bbYo+kZgM9EX4teeE4qBAzwl0Z8QwStlkZW7Fxm6zFRJQwZaflXQCxMDOmx
         nIRJtMlDEqYSUybWy2jhAnGqI7qwgAp2rx/z2MUyZoE6MSvMArfLfPdQeg5onTac3rqN
         3msA==
X-Gm-Message-State: AOAM533mIA4RjgTsDJIn3yxFCiraPIXtLUmSEVPzezxIOjCc8G6HKb7h
        as6Hzqj7s+Rqwt6mW21HsoO3xlic2sNqBg1wscr2pA==
X-Google-Smtp-Source: ABdhPJyVt1EGdnwkzxBgZ1Lb7Jh/y1siTOx7bpCl5+h7hx97eolZc796gqE0Hs9aBqGZKYUJbc7UcVFScYhIXJb9EZM=
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr2272980ljc.141.1593449064684;
 Mon, 29 Jun 2020 09:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185247.13269-1-posk@posk.io>
In-Reply-To: <20200624185247.13269-1-posk@posk.io>
From:   Peter Oskolkov <posk@google.com>
Date:   Mon, 29 Jun 2020 09:44:13 -0700
Message-ID: <CAPNVh5doRy04x_yRA+5sFNOaMnV0pjeBz7MJBjKp8uqH9U5-yg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3 v3] futex/sched: introduce FUTEX_SWAP operation
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Peter Oskolkov <posk@posk.io>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrei Vagin <avagin@google.com>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>, Aaron Lu <aaron.lwe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Ingo!

Do you have any comments/suggestions/objections here? FUTEX_SWAP seems
to be quite useful for fast task context switching, and several teams
at Google would like to see this capability upstreamed.

Thanks,
Peter

On Wed, Jun 24, 2020 at 11:53 AM Peter Oskolkov <posk@posk.io> wrote:
>
> From: Peter Oskolkov <posk@google.com>
>
> This is an RFC!
>
> As Paul Turner presented at LPC in 2013 ...
> - pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf
> - video: https://www.youtube.com/watch?v=KXuZi9aeGTw
>
> ... Google has developed an M:N userspace threading subsystem backed
> by Google-private SwitchTo Linux Kernel API (page 17 in the pdf referenced
> above). This subsystem provides latency-sensitive services at Google with
> fine-grained user-space control/scheduling over what is running when,
> and this subsystem is used widely internally (called schedulers or fibers).
>
> This RFC patchset is the first step to open-source this work. As explained
> in the linked pdf and video, SwitchTo API has three core operations: wait,
> resume, and swap (=switch). So this patchset adds a FUTEX_SWAP operation
> that, in addition to FUTEX_WAIT and FUTEX_WAKE, will provide a foundation
> on top of which user-space threading libraries can be built.
>
> Another common use case for FUTEX_SWAP is message passing a-la RPC
> between tasks: task/thread T1 prepares a message,
> wakes T2 to work on it, and waits for the results; when T2 is done, it
> wakes T1 and waits for more work to arrive. Currently the simplest
> way to implement this is
>
> a. T1: futex-wake T2, futex-wait
> b. T2: wakes, does what it has been woken to do
> c. T2: futex-wake T1, futex-wait
>
> With FUTEX_SWAP, steps a and c above can be reduced to one futex operation
> that runs 5-10 times faster.
>
> Patches in this patchset:
>
> Patch 1: introduce FUTEX_SWAP futex operation that,
>          internally, does wake + wait. The purpose of this patch is
>          to work out the API.
> Patch 2: a first rough attempt to make FUTEX_SWAP faster than
>          what wake + wait can do.
> Patch 3: a selftest that can also be used to benchmark FUTEX_SWAP vs
>          FUTEX_WAKE + FUTEX_WAIT.
>
> v2: fix undefined symbol error ifndef CONFIG_SMP.
> v3: rebased onto the latest tip/locking/core.
>
> Peter Oskolkov (3):
>   futex: introduce FUTEX_SWAP operation
>   futex/sched: add wake_up_process_prefer_current_cpu, use in FUTEX_SWAP
>   selftests/futex: add futex_swap selftest
>
>  include/linux/sched.h                         |   1 +
>  include/uapi/linux/futex.h                    |   2 +
>  kernel/futex.c                                |  96 ++++++--
>  kernel/sched/core.c                           |   5 +
>  kernel/sched/fair.c                           |   3 +
>  kernel/sched/sched.h                          |   1 +
>  .../selftests/futex/functional/.gitignore     |   1 +
>  .../selftests/futex/functional/Makefile       |   1 +
>  .../selftests/futex/functional/futex_swap.c   | 209 ++++++++++++++++++
>  .../selftests/futex/include/futextest.h       |  19 ++
>  10 files changed, 322 insertions(+), 16 deletions(-)
>  create mode 100644 tools/testing/selftests/futex/functional/futex_swap.c
>
> --
> 2.25.1
>
