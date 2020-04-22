Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41C2C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF8C2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrYF5+Fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDVWEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVWEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:36 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96995C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:34 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j21so2920290pgh.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DS4nO2RcZHgVqAM7Or5SHSuF67Tyxr1samkiogrvdDE=;
        b=GrYF5+Fe44e7TtDj+lfnRL78Afido3TJ904/mlIboaw7b0PZBqdWAo9WRvh1q4TLop
         Ddsg/gRZlEo3Q5sbV7BrpCKkfJ5HJHqIasSgJmBcv2mBzIL3mPnsYTB7dSrnt7S+bYew
         8pccmjwl1RK+Hb3QLgluybXo0m/fqA355tVEH3+wA5KOyTPs3ZtyRdaX50NlwJSefc9r
         9DvRr1CRJUPnKSox4JXbgFvucBSCWY3PDtaDuR7Dc+gK9GRyrwfpNnfH6qPnyuQJyGOC
         kyteRBmxsm8pdiwtnIxtKXB04ng8Hcbw348nqQ7vJR6588+0i4SzHRP+7TjDxh1YXUMi
         +TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DS4nO2RcZHgVqAM7Or5SHSuF67Tyxr1samkiogrvdDE=;
        b=awjTfPYCkBgdDbJJi/xVq9WvwD7HtiKFhNfc6zk/6M4ydVmukbdEC/RpmEWlpOfwQo
         hZ0v4TfFT7khtOv9MoVefgXAMYFD2l3RApJuBV5GuLQp2Jriya6R/mZDgeiY5tTkERyv
         z7RKEUIEIobw+w3TI4NbCA7fPS/JlwRTJ+HLwbydlA7G0I73152FjgBBiovL2xJA6YsZ
         ji12NQMaM6YJQyvg5D+a1zdi1GpjnquZm0g/kXjPNoBc9sL0vfP/ZXhlEikdxsTo5KV3
         vavQ7EhWgS+kIgPZ0DmXhq9GLODMAHwpJf2WY9EGwV1Oir7MBaj7A75le0TxqgV4S7u4
         0ssw==
X-Gm-Message-State: AGi0PuZpfprBDSlCgE0YgTp7v2SMXCL07QeBc/b0yx7xKVKbXYsoqCJB
        D5/a3n9hTiuZMzK3Zz2und5IJV5B0hCN
X-Google-Smtp-Source: APiQypJgueVKJeucaF30lv9HfCRVWRMOFvDFOj1Qu41vPhu3f4g9Bjcm5GnAYOZXC+On4QtRsY45fbJMDCSE
X-Received: by 2002:a63:ea42:: with SMTP id l2mr1086309pgk.193.1587593073820;
 Wed, 22 Apr 2020 15:04:33 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:19 -0700
Message-Id: <20200422220430.254014-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 00/11] perf metric fixes and test
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
        linux-perf-users@vger.kernel.org
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

v2 adds Fixes tags to commit messages for when broken metrics were
  first added. Adds a debug warning for division by zero in expr, and
  adds a workaround for id values in the expr test necessary for
  powerpc. It also fixes broken power8 and power9 metrics.

Ian Rogers (11):
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
  perf test: add expr test for pmu metrics

 .../arch/powerpc/power8/metrics.json          |  4 +-
 .../arch/powerpc/power9/metrics.json          |  2 +-
 .../arch/x86/cascadelakex/clx-metrics.json    | 10 +-
 .../arch/x86/skylakex/skx-metrics.json        |  4 +-
 tools/perf/tests/builtin-test.c               |  5 +
 tools/perf/tests/expr.c                       | 96 ++++++++++++++++++-
 tools/perf/tests/tests.h                      |  2 +
 tools/perf/util/expr.c                        |  1 +
 tools/perf/util/expr.h                        |  2 +-
 tools/perf/util/expr.l                        | 16 ++--
 tools/perf/util/expr.y                        | 16 +++-
 11 files changed, 135 insertions(+), 23 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

