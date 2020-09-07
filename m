Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74421C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365962080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi64PDyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbgIGRZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgIGNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:41:15 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F6C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:41:12 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id 33so5746153wre.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=06/chDIM1D/CQyVkMXWbiHKfJ0qcUiQ/wlOCjUIfV4g=;
        b=Gi64PDyCJvCp/tt4Z0/hjKNv06G6HgiODtWEhrPq/9718UaxP4j1aMYDXi14PDx4GM
         LqTk2jESKOu67g0eDwANYR/VFP70rFlrilGv5cwaNXAoImiLI9KgqBDdfi4rgpuaWRbE
         3lSqsYubl65SjuLWTAqZCN92vqnoLX4nyGD26p3UeGSBdSNHD30ruAfJ5DebQn+WDZG0
         mz5+7YDvAfM6oL8bGuQc4llyrn0xm57Ntt5SwSkzahoT5PLL94LxKF31f8ekJDjdeEgK
         /t09asBE9p+CmE277jxbz+b5azRphPdc1VO0TlF1ylp/UDv2Aolea0uGa0WlcWO5/oQh
         /DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=06/chDIM1D/CQyVkMXWbiHKfJ0qcUiQ/wlOCjUIfV4g=;
        b=WeTTSBvQEb2HgaEwl50ETF1QUk4sgtCHsquNG7cflhEoy8pJoKEVCnJW2sSred/MRW
         b3KtIniYHnpigT9BCMWVaZyfEPLhRjMKb3ZNF31QjdGAwUyyG8+A1Rr6DQX0H6qeNE/K
         wURhRckySXaXUMQdk6zofALXa3TBp4XySjircM2iAaFkmroyuzm3dByJTDk4vVplvWR+
         bsXAeppkJ9p655ulYBChJWXOhn+6cham517ibZamPkRRnSrD3FYsUs9joX9ADS66z3qn
         n1P40W1oWCrXtrgI8BmIMv+k1p+rAK/GVKBKzm4s2o2PaY1VuMH8URIOA4lokAVRYTK2
         3ohA==
X-Gm-Message-State: AOAM533vs9rrcDHD4avKXIydEcRnQR5Pt5gqoMOmm6rOkpy7OYXecH7p
        5vFDqvXWXZRAKZAzEaORHyNJgQsEPA==
X-Google-Smtp-Source: ABdhPJyA//VxoSplqPrkXv/zugF4TAybenik7vBycKUrpvQnl+gUJlrGweOUts2LFD7+sLTPAyx8DGpKqg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a7b:ce0d:: with SMTP id m13mr22014038wmc.83.1599486069496;
 Mon, 07 Sep 2020 06:41:09 -0700 (PDT)
Date:   Mon,  7 Sep 2020 15:40:45 +0200
Message-Id: <20200907134055.2878499-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH RFC 00/10] KFENCE: A low-overhead sampling-based memory safety
 error detector
From:   Marco Elver <elver@google.com>
To:     elver@google.com, glider@google.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, mark.rutland@arm.com, penberg@kernel.org
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
low-overhead sampling-based memory safety error detector of heap
use-after-free, invalid-free, and out-of-bounds access errors.  This
series enables KFENCE for the x86 and arm64 architectures, and adds
KFENCE hooks to the SLAB and SLUB allocators.

KFENCE is designed to be enabled in production kernels, and has near
zero performance overhead. Compared to KASAN, KFENCE trades performance
for precision. The main motivation behind KFENCE's design, is that with
enough total uptime KFENCE will detect bugs in code paths not typically
exercised by non-production test workloads. One way to quickly achieve a
large enough total uptime is when the tool is deployed across a large
fleet of machines.

KFENCE objects each reside on a dedicated page, at either the left or
right page boundaries. The pages to the left and right of the object
page are "guard pages", whose attributes are changed to a protected
state, and cause page faults on any attempted access to them. Such page
faults are then intercepted by KFENCE, which handles the fault
gracefully by reporting a memory access error.

Guarded allocations are set up based on a sample interval (can be set
via kfence.sample_interval). After expiration of the sample interval, a
guarded allocation from the KFENCE object pool is returned to the main
allocator (SLAB or SLUB). At this point, the timer is reset, and the
next allocation is set up after the expiration of the interval.

To enable/disable a KFENCE allocation through the main allocator's
fast-path without overhead, KFENCE relies on static branches via the
static keys infrastructure. The static branch is toggled to redirect the
allocation to KFENCE.

We have verified by running synthetic benchmarks (sysbench I/O,
hackbench) that a kernel with KFENCE is performance-neutral compared to
a non-KFENCE baseline kernel.

KFENCE is inspired by GWP-ASan [1], a userspace tool with similar
properties. The name "KFENCE" is a homage to the Electric Fence Malloc
Debugger [2].

For more details, see Documentation/dev-tools/kfence.rst added in the
series -- also viewable here:

	https://raw.githubusercontent.com/google/kasan/kfence/Documentation/dev-tools/kfence.rst

[1] http://llvm.org/docs/GwpAsan.html
[2] https://linux.die.net/man/3/efence

Alexander Potapenko (6):
  mm: add Kernel Electric-Fence infrastructure
  x86, kfence: enable KFENCE for x86
  mm, kfence: insert KFENCE hooks for SLAB
  mm, kfence: insert KFENCE hooks for SLUB
  kfence, kasan: make KFENCE compatible with KASAN
  kfence, kmemleak: make KFENCE compatible with KMEMLEAK

Marco Elver (4):
  arm64, kfence: enable KFENCE for ARM64
  kfence, lockdep: make KFENCE compatible with lockdep
  kfence, Documentation: add KFENCE documentation
  kfence: add test suite

 Documentation/dev-tools/index.rst  |   1 +
 Documentation/dev-tools/kfence.rst | 285 +++++++++++
 MAINTAINERS                        |  11 +
 arch/arm64/Kconfig                 |   1 +
 arch/arm64/include/asm/kfence.h    |  39 ++
 arch/arm64/mm/fault.c              |   4 +
 arch/x86/Kconfig                   |   2 +
 arch/x86/include/asm/kfence.h      |  60 +++
 arch/x86/mm/fault.c                |   4 +
 include/linux/kfence.h             | 174 +++++++
 init/main.c                        |   2 +
 kernel/locking/lockdep.c           |   8 +
 lib/Kconfig.debug                  |   1 +
 lib/Kconfig.kfence                 |  70 +++
 mm/Makefile                        |   1 +
 mm/kasan/common.c                  |   7 +
 mm/kfence/Makefile                 |   6 +
 mm/kfence/core.c                   | 730 +++++++++++++++++++++++++++
 mm/kfence/kfence-test.c            | 777 +++++++++++++++++++++++++++++
 mm/kfence/kfence.h                 | 104 ++++
 mm/kfence/report.c                 | 201 ++++++++
 mm/kmemleak.c                      |  11 +
 mm/slab.c                          |  46 +-
 mm/slab_common.c                   |   6 +-
 mm/slub.c                          |  72 ++-
 25 files changed, 2591 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/dev-tools/kfence.rst
 create mode 100644 arch/arm64/include/asm/kfence.h
 create mode 100644 arch/x86/include/asm/kfence.h
 create mode 100644 include/linux/kfence.h
 create mode 100644 lib/Kconfig.kfence
 create mode 100644 mm/kfence/Makefile
 create mode 100644 mm/kfence/core.c
 create mode 100644 mm/kfence/kfence-test.c
 create mode 100644 mm/kfence/kfence.h
 create mode 100644 mm/kfence/report.c

-- 
2.28.0.526.ge36021eeef-goog

