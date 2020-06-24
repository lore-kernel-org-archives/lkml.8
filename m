Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9FDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F27A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="C3QK6nZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406145AbgFXSxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405119AbgFXSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:53:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA84C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:53:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so1849209pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BCiaaWmbk0Di+X9fHfl+8hsyQQjpSBo2pUzuO1oJ7No=;
        b=C3QK6nZKBLTG/bnyb3NAzjC/gCmktk9N5OR9gZftUZ3RRiLe+PGS/TpxWSEzWrvZyO
         3QDc9rbWp7GXDdyY2i5JyPN7UKVlztdcXv1eqWcgdY8xwB9V0x7DNJGpWRMPjSsrwT86
         KSH+p52yKY1Hwh7ynviW6TziZa+WrM/cGNPknXZixodfa1Sgk2HDUH3K923pPUCkQ2N9
         rLnTOaVWjHBhzMqxjHCrNmmRLWliyS0FexmMd1pA/NZOigACCRQSpwqYkvbpx59ZLfXm
         33lBYA0hlF9Q7i94G2GxH0A4Hev06hIC2WSmC6WlPRFehmKnH8HRrQFNnsAqrAQaeqcY
         QqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BCiaaWmbk0Di+X9fHfl+8hsyQQjpSBo2pUzuO1oJ7No=;
        b=tUO/+5cqW3bGFSwzE04Vm5op3njv57HUgnw/CweEW3aY/T74/txgfarzG8ar+tS4rs
         CbownGaJGb9WuqgyUyVivBo+PkNbuj0qXgfdSOOQsZmJ2NScMC0uoCKet60LvJW3jm7w
         IVfXznphl4C/0a8RAbpIw6C230e1McOZoKn3LINI5J2gocDxpXFoeRdPcFTTWyORClGz
         z5uuUWWM4dYXO1qtjRElP3JSXiOcZhcEM1ndrc2Hj9kVi7aTVb3/d5ZU5gXyeudpPisZ
         n5lpnC69xr96RKpblyqZUla/TK1iXZs3Lym4m9xRpFaLjW8IW8cWxZ8MlvRluMmZ8Xos
         eHyA==
X-Gm-Message-State: AOAM532zAqp/dPPIPcYxrazAXc59aDGHI6LJaSWw3fTCYBxQEintlg24
        Z4SCmujb9hxOF2j7TSMiOo2LsotwvTRWEr53
X-Google-Smtp-Source: ABdhPJxkWWefM7+gjZezIaln2RS5sdI3X7hGhPTO2SHE/WKClVh3PeCxxCRkmOLzTZ8CL2ItGXVq0A==
X-Received: by 2002:a63:f903:: with SMTP id h3mr23700047pgi.437.1593024792283;
        Wed, 24 Jun 2020 11:53:12 -0700 (PDT)
Received: from posk-x1c.lan (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id q10sm22295815pfk.86.2020.06.24.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 11:53:11 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, Andrei Vagin <avagin@google.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Aaron Lu <aaron.lwe@gmail.com>
Subject: [RFC PATCH 0/3 v3] futex/sched: introduce FUTEX_SWAP operation
Date:   Wed, 24 Jun 2020 11:52:44 -0700
Message-Id: <20200624185247.13269-1-posk@posk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

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
v3: rebased onto the latest tip/locking/core.

Peter Oskolkov (3):
  futex: introduce FUTEX_SWAP operation
  futex/sched: add wake_up_process_prefer_current_cpu, use in FUTEX_SWAP
  selftests/futex: add futex_swap selftest

 include/linux/sched.h                         |   1 +
 include/uapi/linux/futex.h                    |   2 +
 kernel/futex.c                                |  96 ++++++--
 kernel/sched/core.c                           |   5 +
 kernel/sched/fair.c                           |   3 +
 kernel/sched/sched.h                          |   1 +
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   1 +
 .../selftests/futex/functional/futex_swap.c   | 209 ++++++++++++++++++
 .../selftests/futex/include/futextest.h       |  19 ++
 10 files changed, 322 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_swap.c

--
2.25.1

