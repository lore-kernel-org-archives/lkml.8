Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D674C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE8E2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9ZKtEP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgEARdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728495AbgEARdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C02FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h185so12978228ybg.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OGOp2WSR2ye+L4wVhXBoOe2en7Nt7zt/W0fkN6xJwSQ=;
        b=A9ZKtEP+4qGq17E3oDaKewIGhJnpruqOJve9IAukmtnyXd0m3IcW4VL7PMRxBOcV2V
         Nhe/MOLgWvcbvxotaAV3v2IfwZqLJNsb4oLOsFStPtZ+SaDBxcUzls3taIUmN+j1LyeY
         Dj4mMTXeYUg+RZ9wkMZJ4AjDccC+3iuFTQG8ZKBy/egS9QMSG9xImglmRqJYeXvri5ME
         IT3gLRjnqIpNXVpUI89FKqB2NJvMfH7IdQ/69eK6MGLzUkMrkOzlwM82eJvdB27sn+wy
         f4kcWOs9SxZm0Sz3aGDyfjSw+Al2Q3z6hls+3T14FvCqZxgf08Cti8iOnnRQZdfa9xZj
         DRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OGOp2WSR2ye+L4wVhXBoOe2en7Nt7zt/W0fkN6xJwSQ=;
        b=PjmBxZvbPC9oxF5jGUucoyN9kSmWzC3sh/vMWUqEGwTYzFyxtOuwDjU7vCQTTLLcX9
         Gm8Dxj5G9W+TcbtEEAHsEcmGlySF+W2tirF6SP8bCuqDdEuIXX1xNqpuElKSpMtgRrdT
         DaDhIey1BvQj7/oqhhqcZJUAzWIQavYZSRuXXMwd8B5wiVp43WeCRMlF7LxBw+LOOBZN
         Ef6zJMevgfi/cCJTF6s67mU31XHjZCQmJTVtI0MjA+2ubPAukflRiNYmjx38z1nnVc7v
         crBeuA2RHTvAzsL/TreTj/T1mgnr/xDb/9aDrMndH/sHhswyHT3Yvs9Wu0suVjq3X71f
         Jl2g==
X-Gm-Message-State: AGi0PuaMAsEsoes0bgX3UnjPo1rc2jZvY9N2+Hi/rS+D2jRYQJfm1Dni
        RGq1/yCIcTVtUmauLaQHhBSrevAfb7IJ
X-Google-Smtp-Source: APiQypLYBTx08v8+PHa6VSkaUJ8g2skdqb+SMC4ncSDZh0CcCYrq+ss7T+qHrhtY7oeK+t+j+ZNWtRJYSo7z
X-Received: by 2002:a25:f413:: with SMTP id q19mr8330362ybd.178.1588354416467;
 Fri, 01 May 2020 10:33:36 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:21 -0700
Message-Id: <20200501173333.227162-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 00/12] perf metric fixes and test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test that all perf metrics (for your architecture) are parsable
with the simple expression parser. Attempt to parse all events in
metrics but only fail if the metric is for the current CPU. Fix bugs
in the expr parser, x86 and powerpc metrics. Improve debug messages
around add PMU config term failures.

v4 rebases after Kajol Jain's patches and fixes an asprintf warning.
v3 adds parse event testing of ids and improves debug messages for add
  PMU. These messages are paticular visible with 'perf test 10
  -vvv'. It moves the testing logic from tests/expr.c to
  tests/pmu-events.c as suggested by John Garry
  <john.garry@huawei.com>.  
v2 adds Fixes tags to commit messages for when broken metrics were
  first added. Adds a debug warning for division by zero in expr, and
  adds a workaround for id values in the expr test necessary for
  powerpc. It also fixes broken power8 and power9 metrics.

Ian Rogers (12):
  perf expr: unlimited escaped characters in a symbol
  perf metrics: fix parse errors in cascade lake metrics
  perf metrics: fix parse errors in skylake metrics
  perf expr: allow ',' to be an other token
  perf expr: increase max other
  perf expr: parse numbers as doubles
  perf expr: debug lex if debugging yacc
  perf metrics: fix parse errors in power8 metrics
  perf metrics: fix parse errors in power9 metrics
  perf expr: print a debug message for division by zero
  perf parse-events: expand add PMU error/verbose messages
  perf test: improve pmu event metric testing

 tools/perf/arch/x86/util/intel-pt.c           |  32 ++--
 .../arch/powerpc/power8/metrics.json          |   2 +-
 .../arch/powerpc/power9/metrics.json          |   2 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
 .../arch/x86/skylakex/skx-metrics.json        |   4 +-
 tools/perf/tests/builtin-test.c               |   5 +
 tools/perf/tests/expr.c                       |   1 +
 tools/perf/tests/pmu-events.c                 | 156 +++++++++++++++++-
 tools/perf/tests/pmu.c                        |   4 +-
 tools/perf/tests/tests.h                      |   2 +
 tools/perf/util/expr.c                        |   1 +
 tools/perf/util/expr.h                        |   2 +-
 tools/perf/util/expr.l                        |  16 +-
 tools/perf/util/expr.y                        |  16 +-
 tools/perf/util/parse-events.c                |  29 +++-
 tools/perf/util/pmu.c                         |  33 ++--
 tools/perf/util/pmu.h                         |   2 +-
 17 files changed, 262 insertions(+), 55 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

