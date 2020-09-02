Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAB9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F88E20773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3yNcFch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgIBNkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgIBNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:31:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FBCC061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:21:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so5227978wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XZEfogzRpgCv9d/7XYID16SU6ICZPv6xVqL1vYFO3Tc=;
        b=M3yNcFchCRn+amiZRIxVhI/m1a4StXppeLIzXd9A0CaEudpAr94t4g/UKh0GzWbyi6
         2KiQoYBsNwDfMf8ZJ3jWSF/OfOFnM9C+y7F3xR7D5wA0q1LC36Etlv8cCDzvUDvDVWkW
         GxIypWMCm5EMmYYy0rNv1MnGIpSv0qnhWGJzzY3u7FTv3KOeTs1VS43VjJB5uzsvc5Oc
         qBZOxWSEz3gKB6dWjdQRpshnmH9LwTA42fab2LiVNoPPFZ4/bvyGUukpFA/Aw/mq4LJs
         hs8fssTsCH9MncGSODGZwffdDuYLjuufLKqvTqP35j/6tz93K5wGoFPXTghAZvvmv5hR
         h1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XZEfogzRpgCv9d/7XYID16SU6ICZPv6xVqL1vYFO3Tc=;
        b=QExP81fUtxRbOwLUMJ3Dz3VX6x4mJcCCASwc5NxyrBa/yWZzkU35Vr/H77Ck+Qsmyb
         rEtNqbMYyU+jM0k8GooMycLmhcO7+DP9XRMm4xGfAfEDTV6i6Shm/nTl7L9uSEAIT+jM
         q9Wg9sfReRkayLYRHgP3w/JhG8UmHGG0otaDlHulIChTFqsPntQl2pTfl7j/o5KgsGKy
         Ygg+Rglx/gPqAPKR6Z3nZhlUi4wcsELXaYwsrfUy1ObdX6/Z4zT/WFkBgd395A9rm3k6
         lZrDRHqENAP1rJNWyPfYsfKuCNbth2CoJ5Zu/tV/b3e3lJb491qTqWq3DAySTmWg0nH1
         HySg==
X-Gm-Message-State: AOAM5318WiQLDNcq4lWbbVFppIGU0xRm8ptcPUSYbFhgPSI2wFtyhpuP
        /67qeTIV2kDtVguywp7RhGRdxg==
X-Google-Smtp-Source: ABdhPJyvesWhfkjmOOGpBBJhN/yTcWagUaLz+fSVDWZHqSZgIJyhDOy2wigZyKaWVreGNRGll9MxRw==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr6552172wro.178.1599052905847;
        Wed, 02 Sep 2020 06:21:45 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q4sm2520403wru.65.2020.09.02.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 06:21:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Wei Li <liwei391@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/6] Perf tool: Support TSC for Arm64
Date:   Wed,  2 Sep 2020 14:21:25 +0100
Message-Id: <20200902132131.36304-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to refactor the changes for the old patch set 'Perf
tool: Enable Arm arch timer counter and arm-spe's timestamp' [1].

After reviewed the old patch sets (thanks Wei Li and Al Grant), we
think it's right way to consolidate TSC code and extend the TSC
implementation to common code which can support both x86 and Arm64;
so far, for x86 it needs to support cap_user_time_zero and for Arm64
it needs to support cap_user_time_short.  For architecture specific
code, every arch only needs to implement its own rdtsc() to read out
timer's counter.

This patch set is to refactor TSC implementation and move TSC code from
x86 folder to util/tsc.c, this allows all archs to reuse the code.  And
alse move the TSC testing from x86 folder to tests so can work as a
common testing.

This patch set has been tested on Arm64 (DB410c) and x86_64.  Both can
pass the testing:

  $ perf test list
    [...]
    68: Convert perf time to TSC
    [...]

  $ perf test 68 -v
    68: Convert perf time to TSC
    --- start ---
    test child forked, pid 10961
    mmap size 528384B
    1st event perf time 35715036563417 tsc 686221770989
    rdtsc          time 35715036649719 tsc 686221772647
    2nd event perf time 35715036660448 tsc 686221772852
    test child finished with 0
    ---- end ----
    Convert perf time to TSC: Ok

Changes from v2:
* Refactored patch set to move TSC common code to util/tsc.c (Wei/Al);
* Moved TSC testing to perf/tests (Wei);
* Dropped Arm SPE timestamp patch so can have clear purpose and easier
  reviewing; will send Arm SPE timestamp as separate patch.

[1] https://lore.kernel.org/patchwork/cover/1285130/

Leo Yan (6):
  perf tsc: Move out common functions from x86
  perf tsc: Add rdtsc() for Arm64
  perf tsc: Calculate timestamp with cap_user_time_short
  perf tsc: Support cap_user_time_short for event TIME_CONV
  perf tests tsc: Make tsc testing as a common testing
  perf tests tsc: Add checking helper is_supported()

 tools/lib/perf/include/perf/event.h           |  4 +
 tools/perf/arch/arm64/util/Build              |  1 +
 tools/perf/arch/arm64/util/tsc.c              | 14 ++++
 tools/perf/arch/x86/include/arch-tests.h      |  1 -
 tools/perf/arch/x86/tests/Build               |  1 -
 tools/perf/arch/x86/tests/arch-tests.c        |  4 -
 tools/perf/arch/x86/util/tsc.c                | 73 +----------------
 tools/perf/tests/Build                        |  1 +
 tools/perf/tests/builtin-test.c               |  5 ++
 .../{arch/x86 => }/tests/perf-time-to-tsc.c   | 13 +++
 tools/perf/tests/tests.h                      |  2 +
 tools/perf/util/jitdump.c                     | 14 ++--
 tools/perf/util/synthetic-events.c            |  8 --
 tools/perf/util/tsc.c                         | 81 +++++++++++++++++++
 tools/perf/util/tsc.h                         |  5 ++
 15 files changed, 136 insertions(+), 91 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/tsc.c
 rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (93%)

-- 
2.17.1

