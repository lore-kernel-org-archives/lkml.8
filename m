Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DC0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7914C208E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpjpQ183"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbgDBPoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:44:04 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:47087 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389406AbgDBPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:44:03 -0400
Received: by mail-yb1-f202.google.com with SMTP id w2so4771422ybs.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PEj2SoLtIBIPJsyo0FA9xsoHE/gV16M6OsZLhlT2sTo=;
        b=JpjpQ183wAD5rxCPvMIWu21NdcQRzrWzLNy9v/EQUez8k/gTd9dofYnrvh0ayhUHDS
         p9SB7a3KI+u/I0A2Sa2eMC9W3R/H0M8K9Fm3dP8KWn6rEbhV3Kltqc9SfS0r1OrVZ9MI
         9rMpQ8f6gPvXcrFxY+cgCJMPhfJv8zWjhyjguDIikP94GkMOIFrFeLwOgyw/idBvTtCr
         9SIAAQd+LXXhHW5ohcU1jA/srC7BipOHVEKcrsvZt547dyyPI1E6V/0HgQ6K09b0WlSY
         QQ45+Z+yqk2TwxbhfP0qAl7jDGykOenUh+8Tt3HVvWw5ulsVS5f/UY780Lo1fvOBfewg
         ILJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PEj2SoLtIBIPJsyo0FA9xsoHE/gV16M6OsZLhlT2sTo=;
        b=fRFJno2IijNsttuSrNbQo0MV3pfEXmGnWAQInrMUqimPtdSq0I+fJ/0rcM9MoU2MG+
         c/hbhuooKyXfos4I6ynz2pjdV0Z6tLkXzVvF+z8kKUOM9rMeLcfy7mEojwy6umQzyvDx
         LCZyEDrzHc1qwg4ru0bVW2t47eG89D19TkKjsNGgR2XzJksajL0hUne0P45JKBFvyk80
         WRrcVm84oe/rctiedzzIJxbRzlZmrn3bHYo8SBQ/XY95I5WMrdK6YURn7SgF9vsUymir
         bsRVK8SlqCmYmbi8tML0zZ41HZZM0oFrUQZrmZL7qU6ZDWKm1h43kBwmXC5mnnk1fzoZ
         mebw==
X-Gm-Message-State: AGi0PuZgeICyDl8iqMn1cSJ5Zx+vbRpL+yj1pVelL7ongfrcxBOPOav0
        JWeQ+pTHw0Ra0gIHLsqAHG07wAre5EPf
X-Google-Smtp-Source: APiQypJ9FfJfiYCUtHzmEMBN1Cawne5av8EOwvTFcw6T/rLH8SXcTDps1rzmMJy6ltoERMLVzcNsIY6pe3HJ
X-Received: by 2002:a25:5f07:: with SMTP id t7mr6458820ybb.411.1585842242499;
 Thu, 02 Apr 2020 08:44:02 -0700 (PDT)
Date:   Thu,  2 Apr 2020 08:43:52 -0700
Message-Id: <20200402154357.107873-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 0/5] Benchmark and improve event synthesis performance
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

Event synthesis is performance critical in common tasks using perf. For
example, when perf record starts in system wide mode the /proc file
system is scanned with events synthesized for each process and all
executable mmaps. With large machines and lots of processes, we have seen
O(seconds) of wall clock time while synthesis is occurring.

This patch set adds a benchmark for synthesis performance in a new
benchmark collection called 'internals'. The benchmark uses the
machine__synthesize_threads function, single threaded on the perf process
with a 'tool' that just drops the events, to measure how long synthesis
takes.

By profiling this benchmark 2 performance bottlenecks were identified,
hugetlbfs_mountpoint and stdio. The impact of theses changes are:

Before:
Average synthesis took: 167.616800 usec
Average data synthesis took: 208.655600 usec

After hugetlbfs_mountpoint scalability fix:
Average synthesis took: 120.195100 usec
Average data synthesis took: 156.582300 usec

After removal of stdio in /proc/pid/maps code:
Average synthesis took: 67.189100 usec
Average data synthesis took: 102.451600 usec

Time was measured on an Intel Xeon 6154 compiling with Debian gcc 9.2.1.

v2 of this patch set adds the new benchmark to the perf-bench man page
and addresses review comments from Jiri Olsa, thanks!

Two patches in the set were sent to LKML previously but are included
here for context around the benchmark performance impact:
https://lore.kernel.org/lkml/20200327172914.28603-1-irogers@google.com/T/#u
https://lore.kernel.org/lkml/20200328014221.168130-1-irogers@google.com/T/#u

A future area of improvement could be to add the perf top
num-thread-synthesize option more widely to other perf commands, and
also to benchmark its effectiveness.

Ian Rogers (4):
  perf bench: add event synthesis benchmark
  perf synthetic-events: save 4kb from 2 stack frames
  tools api: add a lightweight buffered reading api
  perf synthetic events: Remove use of sscanf from /proc reading

Stephane Eranian (1):
  tools api fs: make xxx__mountpoint() more scalable

 tools/lib/api/fs/fs.c                   |  17 +++
 tools/lib/api/fs/fs.h                   |  12 ++
 tools/lib/api/io.h                      | 107 ++++++++++++++
 tools/perf/Documentation/perf-bench.txt |   8 ++
 tools/perf/bench/Build                  |   2 +-
 tools/perf/bench/bench.h                |   2 +-
 tools/perf/bench/synthesize.c           | 101 ++++++++++++++
 tools/perf/builtin-bench.c              |   6 +
 tools/perf/util/synthetic-events.c      | 177 +++++++++++++++---------
 9 files changed, 367 insertions(+), 65 deletions(-)
 create mode 100644 tools/lib/api/io.h
 create mode 100644 tools/perf/bench/synthesize.c

-- 
2.26.0.rc2.310.g2932bb562d-goog

