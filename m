Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B28C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD5C20707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="hKFrUgYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgFPRWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFPRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:22:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE36C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:22:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m2so1903936pjv.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Sg/l1Ul6wGSxeQbBBb5/INh9eMgEt3ykLkKdZi4iJn4=;
        b=hKFrUgYByjkxKwed0H1PGi1+PXeo2r91NOJD7FCaYMI0Qr679cw9MWOYpGeNcQgLUg
         dBDJG/iQpqsKeo/aCqMJI/b3//FUjvyiWDc2vi181M0V8e+/qltScG24hFufbGS4SvzA
         MoCOfOhJSp+DrnL2OPFac7sNyYmZgQ7NR6MmBq4mNjClREeQrFFl33aNl9TLE3SldnF/
         WmWKZBVM3sd7PM9cYG18g4tiOxY8L+e2ss3IxapEJKSdd76rVQ1x7AUX4rGAtYqIuTOA
         HECb//9NFwdVBEou4z7TaPjhABgC0JPUtxBjkA0fW5kGOEBP1b5UcNuEO02CDxW56FbE
         QGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Sg/l1Ul6wGSxeQbBBb5/INh9eMgEt3ykLkKdZi4iJn4=;
        b=jJvXfG9lBpti+Nq2haQli9l1T4qQBPFALhyC7h26TpgSGGGHGFVp4NdR+/as7TIjhU
         Vjnemy2Wuya8kU91zVwGvsgaKQ9kVkUBy6tNHHgEcRgU82b2PhCNDdthPz2IoKrWJURr
         jDKw3TCmvNfDSlJR8SRx5gxerOR2gEuD1DjoOvxBCIjyI155SYvsqZlt8w5xnXn1zjkX
         Z0NZkvVgQ1zSIwiMCpn4ZL3arekmNBRWfTotANNi6yALfXe/BssqbH0YB/lddQq2soLJ
         XjH0ePTLv2H7ls0jCwWq5sZD+8S/3jT6hZ8m4gG5cgRZ3XIhzw/c6lh/5lfqgFgVXoax
         6Ayw==
X-Gm-Message-State: AOAM532h3IpPVqNNYetdib7YlZsXM3Yu1wErsZSRS07GvLdWrITB3bus
        FSi96X7j8onhl9PBAiPpS3zV/r6u5Jy8mg==
X-Google-Smtp-Source: ABdhPJxIuP/+EH5l+UbxW8yn3CflnN/U3twgipvpqkJzJjNSCTrH9bNIUXaYrwO87SGHYMwdhBp9lQ==
X-Received: by 2002:a17:902:b690:: with SMTP id c16mr2632726pls.273.1592328133143;
        Tue, 16 Jun 2020 10:22:13 -0700 (PDT)
Received: from posk-x1c (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id z140sm18375179pfc.135.2020.06.16.10.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:22:12 -0700 (PDT)
Message-ID: <f2997cb9e52d0c2b88e6c5d3818a9331ba45ea5c.camel@posk.io>
Subject: [RFC PATCH 0/3 v2] futex: introduce FUTEX_SWAP operation
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Date:   Tue, 16 Jun 2020 10:22:11 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 7b091e46de4f9227b5a943e6d78283564e8c1c72 Mon Sep 17 00:00:00 2001
From: Peter Oskolkov <posk@google.com>
Date: Tue, 16 Jun 2020 10:13:58 -0700
Subject: [RFC PATCH 0/3 v2] futex: introduce FUTEX_SWAP operation

This is an RFC!

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

v2: fix undefined symbol error ifndef CONFIG_SMP.

Peter Oskolkov (3):
  futex: introduce FUTEX_SWAP operation
  futex, sched: add wake_up_swap, use in FUTEX_SWAP
  selftests/futex: add futex_swap selftest

 include/linux/sched.h                         |   1 +
 include/uapi/linux/futex.h                    |   2 +
 kernel/futex.c                                |  96 ++++++--
 kernel/sched/core.c                           |   5 +
 kernel/sched/fair.c                           |   3 +
 kernel/sched/sched.h                          |   3 +-
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   1 +
 .../selftests/futex/functional/futex_swap.c   | 209 ++++++++++++++++++
 .../selftests/futex/include/futextest.h       |  19 ++
 10 files changed, 323 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_swap.c

--
2.25.1


