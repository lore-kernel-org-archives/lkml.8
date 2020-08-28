Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08825C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D554F207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598648181;
	bh=AGUHeQdWnMkTwj8VvQNHgKUAFnJgCIlpsvPgnGy2aFw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ojvSPmYCUQNFpgAmCEzmunIE3AR5CnL40iDFO50gVd9EEAt9uvvipPNyKeRhiyiMw
	 jhIU4U30a3SQdM66hC/om5uhP9gQ0/L/bugS1G8JCOez028WUrgEw36y2g/sdPrcad
	 /laqTLDNCIfyLPpEiLpdUgusCIc3ggPT9mivHS0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgH1U4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:56:20 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41041 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1U4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:19 -0400
Received: by mail-il1-f194.google.com with SMTP id q14so1817147ilj.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1Mx+TiIbFQBD6+Eo3MKRD45/rV7OXTdg2qDcEVOXVw=;
        b=BymonRgOArEvLReK2ttUMYNwo0FfySPo7tUyqrVb3R+wQr6SzMCaSRkdLPaccRnBzP
         ptk/cmLbxtlsixokrYpyN6I/5jco3jKVxpWYV8ibh0ck3EpevIPnELg47YJWjX+5ADOc
         akhyn7rAhGN5DpFFUziYB6jaJ+cTdF5Cl+daM7eA+ztXxYz4x06EZJeuOUS5zaSyavPD
         2lk281Gf7P+IV5cudHtSorF/uIU7WNU8hRQfhTLHYGJ0N+OW29bXRzwoSQrqGsDor0Lo
         xFCp8QsJEi5HeVYebZl07LTQPPId63O333BeUKixqVulYV4xQ3C/Suh7tz3EMxBRGTy5
         Ht0A==
X-Gm-Message-State: AOAM530FdSBZSJq1aBU/BiHkKKgmfuVkuTOLjMhP0CcDKHX1CEwr3Al4
        IHSdYqPeQrkVqPsGDYY3ZQ==
X-Google-Smtp-Source: ABdhPJx1ae+PEkLseU9nEtbZGjRkTh54EfXW/X/4i1D4j+qMthGX9ZUkYWJrwLjehxcxIlUGzl2p3g==
X-Received: by 2002:a92:9996:: with SMTP id t22mr602189ilk.216.1598648178321;
        Fri, 28 Aug 2020 13:56:18 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id l203sm147089ioa.31.2020.08.28.13.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:56:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v2 0/9] libperf and arm64 userspace counter access support
Date:   Fri, 28 Aug 2020 14:56:05 -0600
Message-Id: <20200828205614.3391252-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is resurrecting Raphael's series[1] to enable userspace counter
access on arm64. My previous version is here[2].

New in this version is adding userspace read support into libperf rather
than adding yet another copy of the read loop. Details are in patch 5.


The following changes to the arm64 support have been made compared to
Raphael's last version:

The major change is support for heterogeneous systems with some
restrictions. Specifically, userspace must pin itself to like CPUs, open
a specific PMU by type, and use h/w specific events. The tests have been
reworked to demonstrate this.

Chained events are not supported. The problem with supporting chained
events was there's no way to distinguish between a chained event and a
native 64-bit counter. We could add some flag, but do self monitoring
processes really need that? Native 64-bit counters are supported if the
PMU h/w has support. As there's already an explicit ABI to request 64-bit
counters, userspace can request 64-bit counters and if user
access is not enabled, then it must retry with 32-bit counters.

Prior versions broke the build on arm32 (surprisingly never caught by
0-day). As a result, event_mapped and event_unmapped implementations have
been moved into the arm64 code.

There was a bug in that pmc_width was not set in the user page. The tests
now check for this.

The documentation has been converted to rST. I've added sections on
chained events and heterogeneous.

The tests have been expanded to test the cycle counter access.

Rob

[1] https://lore.kernel.org/linux-arm-kernel/20190822144220.27860-1-raphael.gault@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20200707205333.624938-1-robh@kernel.org/

Raphael Gault (4):
  arm64: pmu: Add hook to handle pmu-related undefined instructions
  arm64: pmu: Add function implementation to update event index in
    userpage
  arm64: perf: Enable pmu counter direct access for perf event on armv8
  Documentation: arm64: Document PMU counters access from userspace

Rob Herring (5):
  tools/include: Add an initial math64.h
  libperf: Add support for user space counter access
  libperf: Add arm64 support to perf_mmap__read_self()
  perf: arm64: Add test for userspace counter access on heterogeneous
    systems
  perf: Remove x86 specific rdpmc test

 Documentation/arm64/index.rst                 |   1 +
 .../arm64/perf_counter_user_access.rst        |  56 ++++++
 arch/arm64/include/asm/mmu.h                  |   5 +
 arch/arm64/include/asm/mmu_context.h          |   2 +
 arch/arm64/include/asm/perf_event.h           |  14 ++
 arch/arm64/kernel/cpufeature.c                |   4 +-
 arch/arm64/kernel/perf_event.c                | 116 +++++++++++
 include/linux/perf/arm_pmu.h                  |   2 +
 tools/include/linux/math64.h                  |  75 +++++++
 tools/lib/perf/Documentation/libperf.txt      |   1 +
 tools/lib/perf/evsel.c                        |  33 +++
 tools/lib/perf/include/internal/evsel.h       |   2 +
 tools/lib/perf/include/internal/mmap.h        |   3 +
 tools/lib/perf/include/perf/evsel.h           |   1 +
 tools/lib/perf/libperf.map                    |   1 +
 tools/lib/perf/mmap.c                         | 188 ++++++++++++++++++
 tools/lib/perf/tests/test-evsel.c             |  64 ++++++
 tools/perf/arch/arm64/include/arch-tests.h    |   7 +
 tools/perf/arch/arm64/tests/Build             |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
 tools/perf/arch/arm64/tests/user-events.c     | 170 ++++++++++++++++
 tools/perf/arch/x86/include/arch-tests.h      |   1 -
 tools/perf/arch/x86/tests/Build               |   1 -
 tools/perf/arch/x86/tests/arch-tests.c        |   4 -
 tools/perf/arch/x86/tests/rdpmc.c             | 182 -----------------
 25 files changed, 748 insertions(+), 190 deletions(-)
 create mode 100644 Documentation/arm64/perf_counter_user_access.rst
 create mode 100644 tools/include/linux/math64.h
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c
 delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c

--
2.25.1
