Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ED9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AED8207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="JRnP8V8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgFOR3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOR3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:29:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B727C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:29:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id h185so8111341pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=oHS/ZWDmFWNspiTGg9ZwIPVjqiFxBzS/s0peQrsQBeU=;
        b=JRnP8V8dgG9MpfUlXhsVakjVsVLk59lkgN9gQ0VuOBGYpCn9p6oRGc890J0HHkh5wb
         D8R+eZpCpVzfrXh6VyWQb36thUxbPAICaII9/dy4sJDiyOi2AU8UJyfpcFPlgdoP+j8U
         UUe/xEkqNNPTBc5SFtveeDa7/ZMIqFPz583i8pFt3RGnBk+nzCGlop6Dwnb3Vv+fIhrF
         E2U4+kGMw3q7GP1xVh4V+nkBv7vC6B27qlcQEf8Li2wmANRubTxmxDeh2JATPMccjKzZ
         9Gm/p7Lke41jB4lb/4eDKUYWFDrHBcQ6RUQuZ2MnA/dyyRUARqowDaHwZavfQXZKQp8N
         xAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=oHS/ZWDmFWNspiTGg9ZwIPVjqiFxBzS/s0peQrsQBeU=;
        b=dHAHeICrpnbDwuo8yeWN3qoUi68Fh/w75QPWtsNUCOv0hNpG4t80wpA+TChOKNfWzK
         IohJXLIURiA43U/STA47qHBXq18RrfNCsSllK7M5AlhYUI4VASv3ynI+UUfns1Mo97w3
         oFl3120+CBecHIi98P5MtzVWXZpHcnot8c2Kvoac0uXICuau9ixdJ2/6xdTknC54qWXi
         sUUZEOci7TyQuxhdWkZ4u/DrIJhBEUF5K86dr2FpwYMQu5aUmIdhqRIUoeUKecq4bNpu
         U6ZNSPzuaPeIxVyqfrnLGjlWGLk8F96+vR1/+pltY+IEfhK0Pk8sPJ4fE5gutAmxr8xz
         1Pkw==
X-Gm-Message-State: AOAM533yxYDhDfBxq0ZiPcHbXDuFHQSCc9EKVIdRGb9PIHG8+zV+1Bnn
        CGzhMn6pnmCowngUShFCtAb+D92EFV+9KSb4
X-Google-Smtp-Source: ABdhPJx4eTYpdp1MDmW6F1hMl5r/1YcCX3MBUkwEcoPVSkq3tCFHyMnoBMviOcI7FZhWL+abft7PqA==
X-Received: by 2002:a05:6a00:2b0:: with SMTP id q16mr24084381pfs.104.1592242177682;
        Mon, 15 Jun 2020 10:29:37 -0700 (PDT)
Received: from posk-x1c (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id q11sm116437pjq.52.2020.06.15.10.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:29:37 -0700 (PDT)
Message-ID: <414e292195d720c780fab2781c749df3be6566aa.camel@posk.io>
Subject: [RFC PATCH 0/3] futex/sched: introduce FUTEX_SWAP operation
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Date:   Mon, 15 Jun 2020 10:29:36 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 42709b7f82d38c573fc1ff5f5aa7d0065ee54b82 Mon Sep 17 00:00:00 2001
From: Peter Oskolkov <posk@google.com>
Date: Mon, 15 Jun 2020 10:17:36 -0700
Subject: [RFC PATCH 0/3] futex/sched: introduce FUTEX_SWAP operation

As Paul Turner presented at LPC in 2013 ...
- pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf
- video: https://www.youtube.com/watch?v=KXuZi9aeGTw

... Google has developed an M:N userspace threading subsystem backed
by Google-private SwitchTo Linux Kernel API (page 17 in the pdf referenced
above). This subsystem provides latency-sensitive services at Google with
fine-grained user-space control/scheduling over what is running when,
and this subsystem is used widely internally (called schedulers or fibers).

This RFC patchset is the first step to open-source this work. As explained
in the linked pdf and video, SwitchTo API has three core operations: wait,
resume, and swap (=switch). So this patchset adds a FUTEX_SWAP operation
that, in addition to FUTEX_WAIT and FUTEX_WAKE, will provide a foundation
on top of which user-space threading libraries can be built.

Another common use case for FUTEX_SWAP is message passing a-la RPC
between tasks: task/thread T1 prepares a message,
wakes T2 to work on it, and waits for the results; when T2 is done, it
wakes T1 and waits for more work to arrive. Currently the simplest
way to implement this is

a. T1: futex-wake T2, futex-wait
b. T2: wakes, does what it has been woken to do
c. T2: futex-wake T1, futex-wait

With FUTEX_SWAP, steps a and c above can be reduced to one futex operation
that runs 5-10 times faster.

Patches in this patchset:

Patch 1: introduce FUTEX_SWAP futex operation that,
         internally, does wake + wait. The purpose of this patch is
         to work out the API.
Patch 2: a first rough attempt to make FUTEX_SWAP faster than
         what wake + wait can do.
Patch 3: a selftest that can also be used to benchmark FUTEX_SWAP vs
         FUTEX_WAKE + FUTEX_WAIT.

Tested: see patch 3 in this patchset.


Note: patches in this patchset have been built on top of tip/locking/core.

Peter Oskolkov (3):
  futex: introduce FUTEX_SWAP operation
  futex, sched: add wake_up_swap, use in FUTEX_SWAP
  selftests/futex: add futex_swap selftest

 include/linux/sched.h                         |   1 +
 include/uapi/linux/futex.h                    |   2 +
 kernel/futex.c                                |  92 ++++++--
 kernel/sched/core.c                           |   5 +
 kernel/sched/fair.c                           |   3 +
 kernel/sched/sched.h                          |   3 +-
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   1 +
 .../selftests/futex/functional/futex_swap.c   | 209 ++++++++++++++++++
 .../selftests/futex/include/futextest.h       |  19 ++
 10 files changed, 319 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_swap.c

--
2.25.1


