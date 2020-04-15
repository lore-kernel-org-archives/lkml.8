Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AD7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D57206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJShrpOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393362AbgDOFlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389664AbgDOFk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:40:58 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EB3C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:40:56 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w130so1994351pfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vbva7wmKop3qsgg/G27uczDCyunOQv183QvsP9NNcIQ=;
        b=XJShrpOyRL5ML806TDKI4+8hxD7btNPYYJCAiEYOI5kRC0C3T4qxUGZqN22E1hUWHh
         svDfHGSylhBp4cMfaK4WqJ9UvPAI3Dovbh7N56b0Bl6pOOPFSqNEtZtyp89Gh0AlVKE9
         Qra6f5Zeihklf+Q+AMjjl80regjXg/1EhYtpylTuG4aV6CQW6DSDyGnKRfH/GFwKoSX/
         RE49kzPrpQCNbBnSVeaxd1sjxNoJ32S0ailqx5/zwo4fEFLm+mLGhNmBs1ajGFuBuaX4
         FBAOiNbJUSH7aPdD4lWZolq/Z0kQPhsnkiYLEdmHMafqx8f7n1+7JyEAN+GbzPRnOnMr
         GQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vbva7wmKop3qsgg/G27uczDCyunOQv183QvsP9NNcIQ=;
        b=EtaS6l8+JPL+5sUKQFnYrtQD0XseYLbu7J73CJOGLSD49Ja6xvMpyJ3Hm+IQtAq5iu
         eednqGHDThXvcwAEcO5fTUvJII8Gxuzo6Yib0blKbK3U0FYZGCCNbCOfNSfp6y3TQt+I
         gFfWj/+Iy5zO03ePGlpa3x8de5cFMtx4S0USQ7kzk/BB75ttWPqWr9gRpBXRDt3yMC/O
         6klwucoP47twYFbzbkHYdwyrez5nrMdQro10GaAjyf8VzgD+o21mLlQRGxF+dyp4FiBV
         LjLYg8MWpXDQqWjxvjiuehqWR8GODGyadLSB+wlhqZCwqQL/lqJYiq3/IDMfi/cJK1Zx
         9q9Q==
X-Gm-Message-State: AGi0PuZFrndpbfMPRMpj+OGqzSz2MY/vyd2OzeeJAXufKS74Ly+PpMkD
        WZdf/c23Q1Uqcp1ZtkxDVq4WIOcsYyne
X-Google-Smtp-Source: APiQypJBSmBXrs+U0t5iqSnD4B+R8SMtv4+bT1PM/VBZtFF/NFPchNr4pP8smr0e5frurkoq31iz6DGK3gu5
X-Received: by 2002:a17:90a:1fcd:: with SMTP id z13mr4135692pjz.151.1586929254726;
 Tue, 14 Apr 2020 22:40:54 -0700 (PDT)
Date:   Tue, 14 Apr 2020 22:40:47 -0700
Message-Id: <20200415054050.31645-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v5 0/3] perf synthetic events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a multi-threaded version of the internals synthesize benchmark. It
attempts to compute a time per event synthesized, but as it is reading
/proc there are issues:
 - permissions if not run as root
 - "random" nature of /proc
 
By default the benchmark is disabled but can be enabled with a
flag. It has been useful in gauging the value of multi-threaded
improvements not included here as their value appears minimal.

The patch set includes 2 patches that improve synthesis performance
and updates the benchmark numbers:
https://lore.kernel.org/lkml/20200411064248.247530-1-irogers@google.com/

v4 added a missing test file
v3 improved documenation, return values and added testing to the io framework
   following feedback from namhyung@kernel.org.
v2 addressed single threaded synthesize benchmark issues from jolsa@redhat.com
https://lore.kernel.org/lkml/20200402154357.107873-1-irogers@google.com/

Ian Rogers (3):
  perf bench: add a multi-threaded synthesize benchmark
  tools api: add a lightweight buffered reading api
  perf synthetic events: Remove use of sscanf from /proc reading

 tools/lib/api/io.h                 | 112 +++++++++++
 tools/perf/bench/synthesize.c      | 211 +++++++++++++++++---
 tools/perf/tests/Build             |   1 +
 tools/perf/tests/api-io.c          | 304 +++++++++++++++++++++++++++++
 tools/perf/tests/builtin-test.c    |   4 +
 tools/perf/tests/tests.h           |   1 +
 tools/perf/util/synthetic-events.c | 157 ++++++++++-----
 7 files changed, 713 insertions(+), 77 deletions(-)
 create mode 100644 tools/lib/api/io.h
 create mode 100644 tools/perf/tests/api-io.c

-- 
2.26.0.110.g2183baf09c-goog

