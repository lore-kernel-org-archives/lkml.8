Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2708CC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044C02186A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMbf8o9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgD3Hvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgD3Hvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:51:48 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F450C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:48 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d15so5615918qkl.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9OwgdvEfhsCbFqnDEdjW0Ti5xbuBjioOr0R4GwYGZZw=;
        b=WMbf8o9c3FDm/q0yV3Gj92n114bbh7YLtk/Mqx6WToyZenYjjK9itHnDPKlsTklt9E
         0BwRJDletcXVKgUrj5EpJIWhaxo0tXTVfv18lx93qPVEmfN6J66U6rG7ysNmgq8MoDw4
         HgTkv0pnQJ+WmhtLSpxCfPnnyZs9cl8FBMgVz4lXHungRpXENRp4L+mERu8Sz6Cwv2WM
         dvOQU1wZ4m1GhU069Jos6OmfQhsILmQvnX/uslnxKhTvZBjMIuXEn5BL/Uz3FA2MGWlW
         A6QuxS70mtUP7a7XMpo0WCiGcpeqmU3v4eu99qYSKRvg0RWzj70m1SOgv6iSnbTcaiHn
         Vl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9OwgdvEfhsCbFqnDEdjW0Ti5xbuBjioOr0R4GwYGZZw=;
        b=Q9OIzDSK9lEa0zr2xyfEdlV4y+iDXnqcSTFcxcVytsRh2GqHcpWrsewZIMescZPdtc
         BXmfmC/WX9acD1FF7DpgDXIGmaIGXr7BiBqofwwjGUP60g6mieITT+O+P3WqUmsQRjEz
         Too2kopvs6/lYqw3E6SzfWFX0tT/bDagf4MsP4HWO20dB4HSs9Pc+qMGyuz8Hp18F1vq
         g3F95NPeWWT8rz7MWY+pPekFHqoIOhtSvrljdW9lzY1Zj8JSRqu5LO0dt1E8imyjc29k
         oghp1AqQXfCHJ/8BshXwH1GyYYsURoTXJgVgsehoarhovYsaMSJ5bLcNZ0AnaLLl7fp8
         rubw==
X-Gm-Message-State: AGi0PuYVUMTngUbf7xwk0M1Idld7qc6/1A+nUDf1uAc2sft9nXAIdClN
        2QhrEhtCHc0WKrHzlalH5ZLYQ2mHDeUO
X-Google-Smtp-Source: APiQypLBwbMxIP2dtcIY9/VrL7NAp88bThCmzeQd40TfTZLY//PuhAeQQTd8gSzB9T4u8la63OivLM1CBz6k
X-Received: by 2002:a0c:e781:: with SMTP id x1mr1800161qvn.4.1588233107524;
 Thu, 30 Apr 2020 00:51:47 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:32 -0700
Message-Id: <20200430075144.132716-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 00/12] perf metric fixes and test
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
 tools/perf/util/pmu.c                         |  32 ++--
 tools/perf/util/pmu.h                         |   2 +-
 17 files changed, 261 insertions(+), 55 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

