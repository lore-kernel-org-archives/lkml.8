Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B035C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F472070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ayqn1vfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgDVHsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725842AbgDVHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:48:14 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17431C03C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:14 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c190so1363197pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9HUq00N6jmzIo0+nRmNO3NIJIF03YhOq9io6sQiHkEA=;
        b=Ayqn1vfEmsn47YwBswhWoVXmXdRP/hQR9tPrzb9dQTfMlPK5PWPROXnwuzjTnrLeqF
         uVOPdSYVquV3+hwARpMVKcvEb1Y9D7P4H/b7RfnpksCrA+wpMtZg7hLNCMkC3IPrgFMv
         rPesoFKWyvLpFvxjdLf/4XTD7A7XNqwLUiM7ifqvcPlWJmHsDMV8hAYjcSUn3zEdHCIQ
         Gg3SzoZ+fs8Xs86EM/9LlxtAtft3U2ZS1TSBciZLJpKlbbwSnIgKTI5BGjoA4UQuYNYg
         X5/+27Lno7soggC2PcGeSO5aR30P204PSdNUlzzbeRL9xjtwpsx7SBdnoZ0J5I4iIdBp
         kLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9HUq00N6jmzIo0+nRmNO3NIJIF03YhOq9io6sQiHkEA=;
        b=OPJaEZiakeYo189A+MnxH2MnBqqowHTjhGN48dM6B6QLj7LYaCJj0AbRlLVFgF2Dwl
         9VeKQYTu3rKOOGKIC9rK1ro7ZxFxYHNTJdGnLw0VKj/hpq/0vSUUofc2ihfiKzr8xmY1
         6HuwwclPqshFsZoKhkZsIwzMxcsOXH5jY/CL1e1Yw6lqfRYwSPxpsSDYeSXbcszIJGaf
         /uMlAfFf243Y63YEcmckMcMOI8iLfQB1kRUJazTmDK10EmnZLmbAAf/zFr0FEIr7yMow
         hy35bBsQv2TjxPF1vl76LI95DKL1+p8NKeGexdyD0+De6L/ZnjjeDea6P4QVYNvPE2a6
         pB4g==
X-Gm-Message-State: AGi0PuYgdKyBIYIg0+Xsza6yREzIl59KLkIY+IvlmcZRQmg5jk0coRNW
        IeoRLPdGxb+G2YSok6b53NDJH+UMIk28
X-Google-Smtp-Source: APiQypJnukvej9k6sd3XOrpco3hQ6FbAtq2B4ko4qEepnvdy7OGC67aq8C+c1CGuV9g+Qx1361EfZcEz0RTD
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr10189197pjs.18.1587541693454;
 Wed, 22 Apr 2020 00:48:13 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:48:01 -0700
Message-Id: <20200422074809.160248-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 0/8] perf metric fixes and test
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
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test that all perf metrics (for your architecture) are
parsable. Fix bugs in the expr parser and in x86 metrics. Untested on
architectures other than x86.

Ian Rogers (8):
  perf expr: unlimited escaped characters in a symbol
  perf metrics: fix parse errors in cascade lake metrics
  perf metrics: fix parse errors in skylake metrics
  perf expr: allow ',' to be an other token
  perf expr: increase max other
  perf expr: parse numbers as doubles
  perf expr: debug lex if debugging yaxx
  perf test: add expr test for pmu metrics

 .../arch/x86/cascadelakex/clx-metrics.json    | 10 +-
 .../arch/x86/skylakex/skx-metrics.json        |  4 +-
 tools/perf/tests/builtin-test.c               |  5 +
 tools/perf/tests/expr.c                       | 91 ++++++++++++++++++-
 tools/perf/tests/tests.h                      |  2 +
 tools/perf/util/expr.c                        |  1 +
 tools/perf/util/expr.h                        |  2 +-
 tools/perf/util/expr.l                        | 16 ++--
 tools/perf/util/expr.y                        |  2 +-
 9 files changed, 115 insertions(+), 18 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

