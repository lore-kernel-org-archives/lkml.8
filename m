Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788FDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8425D20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="XP73RqLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgHCWPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCWPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:15:17 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7B2C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 15:15:17 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z22so4051995oid.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IX7q0vd+M1fbfeE603suFhlt8Ub4fxN4z74W25pxVPE=;
        b=XP73RqLPNn5a0K1wsl3cje0nmEf7wAUhrQ3jDVrCuO7nWIl/w/t8uNvA/9sk/uN6+p
         VSIoc5qxaj/Szxw3hhatDiZEwD9RRKFfVQmfJbqJ3HmXfReYtQtIGUKJIfQrku1FoGWh
         2DkILFrz6HyHkn26iJ0up93qzeOjP+FRvRIZxmMi9yIl97LTf7Q2hbhEfXXY60hyhcWc
         Pb+VeN0mMn8E5efvzmZmTq00WEbFmdUTUPdhIOanUxO0nw0FAbJrZVwFySWTLWl0djYG
         JvJtvvrbA/HcSzNEhNXEriH+j1QCKTor8m9dSMoQ+rp0rB4n0PXYhejv/Vme5ySVYAYH
         DmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IX7q0vd+M1fbfeE603suFhlt8Ub4fxN4z74W25pxVPE=;
        b=Ll3g1VZ0/z/dzG1JvaUqQhRfjyUO0ze59apiqkyArprCDwd/FitvRfX2E7y1Xm/54m
         kq7lVPJl0T+kxlX6r342caJ6O4YYRM2vSFbAVlTRz6+QWWPn9G+idKEy85ZFTBnPmxc0
         9lC5P7V74RRe3tUgMTthderGrBc0M+17P+Bv+WmtbcY3rkqokkToGWQAQAK4LlHdIiNS
         XzjTimRQ0rFOWQAXvprrhvpkLyIVVXc+6z2ez8eoOdHJd3XA9b7ZbIYsxPEYAGDj1SVK
         +MmRJgpUR2LcRh2lkPVtj+nxuwvl+FOaoV3OllN0wECuVaxjfNBUYinmxr+AsJNqzYKA
         oJxQ==
X-Gm-Message-State: AOAM5310KBdpNH3keVqebWPNRMt6wMgHtw3o+iaF9K89V1eR0T7Qudus
        DfOWGXwX33BhZ6r6Usa45pORLHnrTkI=
X-Google-Smtp-Source: ABdhPJwS7YVXVn2jwoEHYnh5FWP4axEID0BKHa/GFDVZMc55iwkh5cWRtVgoxoMPN4CUVCGo/2SFCg==
X-Received: by 2002:aca:cdc4:: with SMTP id d187mr1202861oig.69.1596492916091;
        Mon, 03 Aug 2020 15:15:16 -0700 (PDT)
Received: from posk-x1c.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id m8sm3026624ote.55.2020.08.03.15.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 15:15:15 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, Andrei Vagin <avagin@google.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Aaron Lu <aaron.lwe@gmail.com>
Subject: [PATCH for 5.9 v2 1/4] futex: introduce FUTEX_SWAP operation
Date:   Mon,  3 Aug 2020 15:15:07 -0700
Message-Id: <20200803221510.170674-2-posk@posk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803221510.170674-1-posk@posk.io>
References: <20200803221510.170674-1-posk@posk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

As Paul Turner presented at LPC in 2003, Google has developed
an M:N userspace threading subsystem backed by Google-private
SwitchTo Linux Kernel API. This subsystem provides latency-sensitive
services at Google withfine-grained user-space control/scheduling
over what is running when, and this subsystem is used widely
internally (called schedulers or fibers).

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

In addition to the above, another common use case for FUTEX_SWAP is
message passing a-la RPC between tasks: task/thread T1 prepares a message,
wakes T2 to work on it, and waits for the results; when T2 is done, it
wakes T1 and waits for more work to arrive. Currently the simplest
way to implement this is

a. T1: futex-wake T2, futex-wait
b. T2: wakes, does what it has been woken to do
c. T2: futex-wake T1, futex-wait

With FUTEX_SWAP, steps a and c above can be reduced to one futex operation
that runs 5-10 times faster.

Patches in this patchset:

Patch 1: (this patch) add FUTEX_SWAP #defines, as well as the overall
         reasoning behind the patchset.
Patch 2: implement FUTEX_SWAP futex operation that, internally, does
         wake + wait.
Patch 3: the main speed-up of FUTEX_SWAP: migrate the wakee to the
         waker's CPU.
Patch 4: a selftest that can also be used to benchmark FUTEX_SWAP vs
         FUTEX_WAKE + FUTEX_WAIT.

Tested: see patch 4 in this patchset.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/uapi/linux/futex.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index a89eb0accd5e..c1d151d97dea 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -21,6 +21,7 @@
 #define FUTEX_WAKE_BITSET	10
 #define FUTEX_WAIT_REQUEUE_PI	11
 #define FUTEX_CMP_REQUEUE_PI	12
+#define FUTEX_SWAP		13
 
 #define FUTEX_PRIVATE_FLAG	128
 #define FUTEX_CLOCK_REALTIME	256
@@ -40,6 +41,7 @@
 					 FUTEX_PRIVATE_FLAG)
 #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
+#define FUTEX_SWAP_PRIVATE		(FUTEX_SWAP | FUTEX_PRIVATE_FLAG)
 
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
-- 
2.25.1

