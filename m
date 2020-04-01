Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854EFC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50451206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsKOm7/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbgDAXkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:40:25 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:57277 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732797AbgDAXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:40:24 -0400
Received: by mail-vk1-f201.google.com with SMTP id e186so603172vkh.23
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rbS4a510PkE5rIpwG7gAA/2Zla37CiAh9XVnNXxajJs=;
        b=GsKOm7/dAe7WN3G39+RnnQ3lDjNMjlHrVkfqaKysA29xNUXC7VuYpRj6BHHl2r1DCl
         GxZmG/BjxLqBkGjVk3V5rZ6I7zE+CBHfE4RKpuIU++c1kbl8fPUiko1D60NkZzd7JItP
         kPo9jc4BCo5eGtSjw8pCrJyGKY0REHtYTSxZ8JgyK7snLsPY5G5jO/NqW5PDXwEsNhlb
         bnzMihGywiE6CY+hpk+UE1wuIfM2vGwIJDKK2HEJjqTNkCdGmTUC/ZDe8qhPPvDPrEUg
         0GZBGWP86mj61a8Fj+1iBeakr06MgAHvHVUrJQWWi3oNFdseUo9RvnrXDt99x1cNssBb
         7FwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rbS4a510PkE5rIpwG7gAA/2Zla37CiAh9XVnNXxajJs=;
        b=P0wg/REAWoj7rkBk3M6iR9f59SYJH0l/qMdz8LhXsnQ0ZLpnque1eCl8Q3pmmcuOht
         WX5zdiDwYDiRVMQb2Zw8IhxcZMJEVMkPcJToPZ0kDI0p2XN6IPxYA1ZljHYKvdDrwHop
         E3WVBg0ZwrWAxCAtUm4O/p0UjvbmUgXh7N/09vDcityNcTdgS8zrL/4nW/QSM3Xp4QD6
         ajTvrbLwcKLZWfdZSEfo5+4DtZeM0CsT29F5NMNcfvsI0mEYvOmJmzXtyx53t7/0TluI
         hQ4DX2vHYtR+B/SRv6+s/Q9ag/a7yO1ZDNHlb6LwKrmsDvo0B6L4Yd5k/VHCduhcVvaH
         6r/Q==
X-Gm-Message-State: AGi0PuZM9XpzZv2Aki0h3xAmIaB6ZiBDYLO+bSX89prQfnXJj2geVqrF
        wHvlfOPSWpG+8kqOgiT/wZ9bYS8r+ISr
X-Google-Smtp-Source: APiQypLwmFGXB8AWyKPDICalopSWiKutlFLSxqEz67wI1w1HrH4IdMxozKYH04Hl0kEAv1hWyLn+LRmmpZ+C
X-Received: by 2002:a9f:3b08:: with SMTP id i8mr740392uah.68.1585784423446;
 Wed, 01 Apr 2020 16:40:23 -0700 (PDT)
Date:   Wed,  1 Apr 2020 16:39:40 -0700
Message-Id: <20200401233945.133550-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH 0/5] Benchmark and improve event synthesis performance
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

 tools/lib/api/fs/fs.c              |  17 +++
 tools/lib/api/fs/fs.h              |  12 ++
 tools/lib/api/io.h                 | 103 +++++++++++++++++
 tools/perf/bench/Build             |   2 +-
 tools/perf/bench/bench.h           |   2 +-
 tools/perf/bench/synthesize.c      | 101 ++++++++++++++++
 tools/perf/builtin-bench.c         |   6 +
 tools/perf/util/synthetic-events.c | 177 +++++++++++++++++++----------
 8 files changed, 355 insertions(+), 65 deletions(-)
 create mode 100644 tools/lib/api/io.h
 create mode 100644 tools/perf/bench/synthesize.c

-- 
2.26.0.rc2.310.g2932bb562d-goog

