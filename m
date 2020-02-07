Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A5BC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11835222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgBGPWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:22:43 -0500
Received: from foss.arm.com ([217.140.110.172]:41074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGPWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:22:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 466C21FB;
        Fri,  7 Feb 2020 07:22:42 -0800 (PST)
Received: from e121896.default (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D51F73F6CF;
        Fri,  7 Feb 2020 07:22:38 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     jolsa@redhat.com, liwei391@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 0/4] perf tools: Add support for some spe events and precise ip
Date:   Fri,  7 Feb 2020 15:21:38 +0000
Message-Id: <20200207152142.28662-1-james.clark@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127123108.GC1114818@krava>
References: <20200127123108.GC1114818@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

Thanks for the feedback. I've made the following changes:

Removed the arm_spe_synth_opts struct and added the new types into
itrace_synth_opts. I could re-use branch but the other ones are new.
And the --trace argument documentation has been updated accordingly.

I've removed the processing of the evlist from perf_evlist__splice_list_tail
and put it in a weak function "auxtrace__preprocess_evlist" that is
only built on Arm.

For the 2 patches about the hang on termination, I have removed them
because I haven't been able to reproduce it and everything is working
ok for me. @Wei Li, are you able to post steps required to reproduce?

Thanks
James

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>

Tan Xiaojun (4):
  perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
  perf tools: Add support for "report" for some spe events
  perf report: Add SPE options to --itrace argument
  perf tools: Support "branch-misses:pp" on arm64

 tools/perf/Documentation/itrace.txt           |   5 +-
 tools/perf/arch/arm/util/auxtrace.c           |  38 +
 tools/perf/builtin-record.c                   |   5 +
 tools/perf/util/Build                         |   2 +-
 tools/perf/util/arm-spe-decoder/Build         |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 225 ++++++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  66 ++
 .../arm-spe-pkt-decoder.c                     |   0
 .../arm-spe-pkt-decoder.h                     |   2 +
 tools/perf/util/arm-spe.c                     | 756 +++++++++++++++++-
 tools/perf/util/arm-spe.h                     |   3 +
 tools/perf/util/auxtrace.c                    |  13 +
 tools/perf/util/auxtrace.h                    |  14 +-
 tools/perf/util/evlist.c                      |   1 +
 tools/perf/util/evsel.h                       |   1 -
 15 files changed, 1090 insertions(+), 42 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (96%)

-- 
2.17.1

