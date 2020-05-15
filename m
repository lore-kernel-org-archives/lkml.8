Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A03C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D578206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/YXznYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgEOG4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 02:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgEOG4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:56:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C06C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:56:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y7so1574455ybj.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a2lbgY6+l2XCN87y1SfDgu1WwO4AsIVPUD49ghQtedw=;
        b=U/YXznYxlq6k8WbFkCuQ91LVvT4CBcEDGtperbGv2gkTQM/4rdAB2GSl2j9BJN24ya
         5SBh9P9tQIipeTWrM0GDTfMjAeM80RzYbwdYkTyJog2Nu2pRz+xUVxACwxRRKSNMnvMR
         FDXP9M5r9YMA4p/wgavHwun3lKObGCEUR/kKW5xe8XGfUD8l6LAoHXabe3eSZUWJtyZA
         GNNTxVyNOnMMEM5dWDYeuA+1ycDcenqxjkRjmCeM6wHjN8g3nJI/+35ixFh9YUEADX0r
         utSXa/Doim0uvR1wt0fss/zVAimvPEIK2XXWk3L32vptRVgv1GlVFHLFgKzDVXBNVIUI
         8vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a2lbgY6+l2XCN87y1SfDgu1WwO4AsIVPUD49ghQtedw=;
        b=ulIhtFEts+hzx8zKU4XQZF1qf7fqZl8HkDp4rIB3yTk0HVaYlII9ENETYMLZGYV1am
         pD3aMzqxUUTuxNYjXtpq/RHEPh8AV5B56o98bE5epIzB/zLgPJY28tvtPd7wPdFhLWtj
         YjIkOhiWz2L7Dte2hhdFkYiL0GJyOcA1LtTEmwqmaXmCZYr3efW9YocSbT467YekGqn+
         jOUDEdNjNM+Ly+wXAiDYAovJbX/Wcn4+vO9Vk3VXRwqN3KDmBgqrPaBLsGJJO/KsfRPC
         xzAZlPMGiURwJcMCnyJIwyVdPsX30gwZeOUIkDCxQE8w0UDkITG/FthgsiDu3xN7O58I
         rjiA==
X-Gm-Message-State: AOAM530J4YrH/0vDswZ2SDbVpph8LO1KlE5mt52JsUzqPe+9LuUhQaAM
        ijLgrrvIKk0ShLApxB4eVsKnV0koktst
X-Google-Smtp-Source: ABdhPJwn2n35tY1jUXo/CJLHCoijbc0JgiLKNPL0+cnzNihTaaRWYL06vxO31zyvBBYptNnibAuGjSyC48QS
X-Received: by 2002:a25:6cd6:: with SMTP id h205mr3211731ybc.404.1589525790276;
 Thu, 14 May 2020 23:56:30 -0700 (PDT)
Date:   Thu, 14 May 2020 23:56:16 -0700
Message-Id: <20200515065624.21658-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 0/8] Copy hashmap to libapi, use in perf expr
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf's expr code currently builds an array of strings then removes
duplicates. The array is larger than necessary and has recently been
increased in size. When this was done it was commented that a hashmap
would be preferable.

libbpf has a hashmap but libbpf isn't currently required to build
perf. To satisfy various concerns this change copies libbpf's hashmap
into libapi, it then adds a check in perf that the two are in sync.

Andrii's patch to hashmap from bpf-next is brought into this set to
fix issues with hashmap__clear.

Three minor changes to libbpf's hashmap are made that remove an unused
dependency, fix a compiler warning and make sure the hashmap isn't
part of the symbols in a static build of libbpf (dsos are handled by
the existing version script).

Two perf test are also brought in as they need refactoring to account
for the expr API change and it is expected they will land aheadof
this.
https://lore.kernel.org/lkml/20200513062236.854-2-irogers@google.com/

Tested with 'perf test' and make -C tools/perf build-test.

The hashmap change was originally part of an RFC:
https://lore.kernel.org/lkml/20200508053629.210324-1-irogers@google.com/

Andrii Nakryiko (1):
  libbpf: Fix memory leak and possible double-free in hashmap__clear

Ian Rogers (7):
  libbpf hashmap: Remove unused #include
  libbpf hashmap: Fix signedness warnings
  libbpf hashmap: Localize static hashmap__* symbols
  tools lib/api: Copy libbpf hashmap to libapi
  perf test: Provide a subtest callback to ask for the reason for
    skipping a subtest
  perf test: Improve pmu event metric testing
  perf expr: Migrate expr ids table to a hashmap

 tools/lib/api/Build             |   1 +
 tools/lib/api/hashmap.c         | 238 ++++++++++++++++++++++++++++++++
 tools/lib/api/hashmap.h         | 177 ++++++++++++++++++++++++
 tools/lib/bpf/Makefile          |   2 +
 tools/lib/bpf/hashmap.c         |  10 +-
 tools/lib/bpf/hashmap.h         |   1 -
 tools/perf/check-headers.sh     |   4 +
 tools/perf/tests/builtin-test.c |  18 ++-
 tools/perf/tests/expr.c         |  40 +++---
 tools/perf/tests/pmu-events.c   | 169 ++++++++++++++++++++++-
 tools/perf/tests/tests.h        |   4 +
 tools/perf/util/expr.c          | 129 +++++++++--------
 tools/perf/util/expr.h          |  22 ++-
 tools/perf/util/expr.y          |  22 +--
 tools/perf/util/metricgroup.c   |  87 ++++++------
 tools/perf/util/stat-shadow.c   |  49 ++++---
 16 files changed, 793 insertions(+), 180 deletions(-)
 create mode 100644 tools/lib/api/hashmap.c
 create mode 100644 tools/lib/api/hashmap.h

-- 
2.26.2.761.g0e0b3e54be-goog

