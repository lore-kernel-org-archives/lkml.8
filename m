Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB38BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF9A2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxGtc584"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHGHQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgHGHQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:16:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2712C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 00:16:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so397549pgh.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TsDcwhSDkXixegWIlP/eHDcWWO1mxw9V9a0qYsa5Ph4=;
        b=mxGtc584TmAWAl9LTLViqUKv20++clWN2otml3J8Vdc3GLbkennmwQISuLnLhzGbLe
         KiUByOHoGTvzqpdc6IucdH94Gw2Z8Myub3tdIy4fTm9AGKvF8ZZTlI2VXe3u5PiF9Fgm
         xvrjeM3oyiYdrWM8HsAuVMi2nKly0qFKTrj8Z9P6zn/UKxkLQxHWeLqOwyvMNE9PG8tu
         l3mzOw5kSEznxUXEHoekgPG7R0MYDSMIaJ9jqTAjwH7+YNAgqcS+Ld0oUqL9cRFgS+zp
         Qi0F5m7IGkmOZ5ldz3lZthD0E64Oq3MG+XtqyTDjV2Qm9k7rei1VjV9FVDwPrAc1F8Zt
         Yt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TsDcwhSDkXixegWIlP/eHDcWWO1mxw9V9a0qYsa5Ph4=;
        b=CoIDO+xIAHudvR2IiedhOytZ2Ms+5vyJojCNLWvC3jmd8kpuNFFsx5Li/FNS9n5TdD
         J0rATZjsWdFZ36Q0CxeIxpH7uf8+ru9XhhIf8nbNiBMON7VB1HYgaM/WewCKencrcJMw
         ageJlBJo7YpXsUFEorAVbz+aJ75z2nL27TrVa8aqfhEzHVvKz52cigkg2LT4cUisoxcu
         lRbYIM9X+l3Erm6lkSnv8bNZeDJwHqWGMpYlO+oZR8EIaaovfNUrenwKMxFSoRi5Fv/j
         Jaqzf5MO/0gmu0I3urIofX0nIY4G750QE8o3r3LohhOITepBu9FZIwPLwJ6eXx251Zkp
         xIbw==
X-Gm-Message-State: AOAM533x2vmnIiTNpZyb/eHpySs71Kd9VHg9TOw1Cd5Hv9OHjpn9Qn1f
        M3nVBixB9X8iRrXjkJQhxNkI1w==
X-Google-Smtp-Source: ABdhPJwXzyMTQakr0CRP2P6/Lp+/flONQvlKw2c1CsPy/Q2Zw26tRghyvUa4yNA8DmoLcEyOhQbhBQ==
X-Received: by 2002:a63:3c08:: with SMTP id j8mr10130119pga.82.1596784593135;
        Fri, 07 Aug 2020 00:16:33 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 5sm1871831pfw.25.2020.08.07.00.16.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 00:16:32 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/4] Perf tool: Enable Arm arch timer counter and arm-spe's timestamp
Date:   Fri,  7 Aug 2020 15:16:16 +0800
Message-Id: <20200807071620.11907-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to enable Arm arch timer counter and Arm SPE is the
first customer to use arch timer counter for its timestamp.

Patches 01 ~ 03 enables Arm arch timer counter in Perf tool; patch 01 is
to retrieve arch timer's parameters from mmaped page; patch 02 provides
APIs for the conversion between arch timer's counter and time; patch 03
adds a test for patches 01 and 02.

As the first customer to use Arm arch timer counter in perf tool, patch
04 is to generate sample's timestamp for ARM SPE AUX trace data.

This patch set has been rebased on perf/core branch with the latest
commit c4735d990268 ("perf evsel: Don't set
sample_regs_intr/sample_regs_user for dummy event").

After changes:

  # perf test 67 -v
    67: Convert perf time to arch timer counter
    --- start ---
    test child forked, pid 5463
    mmap size 528384B
    1st event perf time 2231755083020 arch timer cnt 113097053477
    test time           2231755087460 arch timer cnt 113097053699
    2nd event perf time 2231755090680 arch timer cnt 113097053860
    test child finished with 0
    ---- end ----

  Reports the SPE sample with timestamp:

  $ perf script -F,+time
    dd  6799 [034] 25496.733475:          1              l1d-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733475:          1              tlb-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733479:          1              l1d-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733479:          1              tlb-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733485:          1              l1d-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733485:          1              tlb-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

Changes from v1:
* Rebased on the latest perf/core branch;
* Added a testing for Arm timer counter conversion (Ian Rogers).


Leo Yan (4):
  perf tools: Support Arm arch timer counter
  perf arm_arch_timer: Convert between counter and timestamp
  perf arm_arch_timer: Test conversion between counter and timestamp
  perf arm-spe: Enable timestamp with arch timer counter

 tools/perf/arch/arm64/include/arch-tests.h    |   6 +
 tools/perf/arch/arm64/tests/Build             |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
 .../tests/perf-time-to-arch-timer-counter.c   | 189 ++++++++++++++++++
 tools/perf/arch/arm64/util/Build              |   1 +
 tools/perf/arch/arm64/util/arch_timer.c       |  50 +++++
 tools/perf/arch/arm64/util/arm-spe.c          |  17 ++
 tools/perf/util/Build                         |   1 +
 tools/perf/util/arm-spe.c                     |  16 +-
 tools/perf/util/arm-spe.h                     |   5 +
 tools/perf/util/arm_arch_timer.c              |  28 +++
 tools/perf/util/arm_arch_timer.h              |  23 +++
 12 files changed, 339 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/arch/arm64/tests/perf-time-to-arch-timer-counter.c
 create mode 100644 tools/perf/arch/arm64/util/arch_timer.c
 create mode 100644 tools/perf/util/arm_arch_timer.c
 create mode 100644 tools/perf/util/arm_arch_timer.h

-- 
2.17.1

