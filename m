Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54390C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A0F2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6mjuYtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390680AbgDCLBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:01:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58325 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727898AbgDCLBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585911711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n79zGas0SaLptEoTMx3TcpeIj3gYY6jEkiMCB4RNkJU=;
        b=I6mjuYtL9IR3Y6/rELMQ+MLuQRYBAsz9Ok4RQEzq3zvVAYXPapYvnkoOBS+JV6CNhmIsZv
        HwNPWRWz+oqzILwdCicpqL9xoVBKda1TApJApXuh6LF4K/KIaIs3NSES3fO/ddbMcK8pub
        MZDhPnrayuUJojQS5g2rl0SdLNHdxx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-FQ1mfZlgN9ySZ6y0IDIzOg-1; Fri, 03 Apr 2020 07:01:45 -0400
X-MC-Unique: FQ1mfZlgN9ySZ6y0IDIzOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 261CC107ACC7;
        Fri,  3 Apr 2020 11:01:43 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DECBC60BF3;
        Fri,  3 Apr 2020 11:01:39 +0000 (UTC)
Date:   Fri, 3 Apr 2020 13:01:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 0/5] Benchmark and improve event synthesis performance
Message-ID: <20200403110137.GK2784502@krava>
References: <20200402154357.107873-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402154357.107873-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 08:43:52AM -0700, Ian Rogers wrote:
> Event synthesis is performance critical in common tasks using perf. For
> example, when perf record starts in system wide mode the /proc file
> system is scanned with events synthesized for each process and all
> executable mmaps. With large machines and lots of processes, we have seen
> O(seconds) of wall clock time while synthesis is occurring.
> 
> This patch set adds a benchmark for synthesis performance in a new
> benchmark collection called 'internals'. The benchmark uses the
> machine__synthesize_threads function, single threaded on the perf process
> with a 'tool' that just drops the events, to measure how long synthesis
> takes.
> 
> By profiling this benchmark 2 performance bottlenecks were identified,
> hugetlbfs_mountpoint and stdio. The impact of theses changes are:
> 
> Before:
> Average synthesis took: 167.616800 usec
> Average data synthesis took: 208.655600 usec
> 
> After hugetlbfs_mountpoint scalability fix:
> Average synthesis took: 120.195100 usec
> Average data synthesis took: 156.582300 usec
> 
> After removal of stdio in /proc/pid/maps code:
> Average synthesis took: 67.189100 usec
> Average data synthesis took: 102.451600 usec
> 
> Time was measured on an Intel Xeon 6154 compiling with Debian gcc 9.2.1.
> 
> v2 of this patch set adds the new benchmark to the perf-bench man page
> and addresses review comments from Jiri Olsa, thanks!

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Two patches in the set were sent to LKML previously but are included
> here for context around the benchmark performance impact:
> https://lore.kernel.org/lkml/20200327172914.28603-1-irogers@google.com/T/#u
> https://lore.kernel.org/lkml/20200328014221.168130-1-irogers@google.com/T/#u
> 
> A future area of improvement could be to add the perf top
> num-thread-synthesize option more widely to other perf commands, and
> also to benchmark its effectiveness.
> 
> Ian Rogers (4):
>   perf bench: add event synthesis benchmark
>   perf synthetic-events: save 4kb from 2 stack frames
>   tools api: add a lightweight buffered reading api
>   perf synthetic events: Remove use of sscanf from /proc reading
> 
> Stephane Eranian (1):
>   tools api fs: make xxx__mountpoint() more scalable
> 
>  tools/lib/api/fs/fs.c                   |  17 +++
>  tools/lib/api/fs/fs.h                   |  12 ++
>  tools/lib/api/io.h                      | 107 ++++++++++++++
>  tools/perf/Documentation/perf-bench.txt |   8 ++
>  tools/perf/bench/Build                  |   2 +-
>  tools/perf/bench/bench.h                |   2 +-
>  tools/perf/bench/synthesize.c           | 101 ++++++++++++++
>  tools/perf/builtin-bench.c              |   6 +
>  tools/perf/util/synthetic-events.c      | 177 +++++++++++++++---------
>  9 files changed, 367 insertions(+), 65 deletions(-)
>  create mode 100644 tools/lib/api/io.h
>  create mode 100644 tools/perf/bench/synthesize.c
> 
> -- 
> 2.26.0.rc2.310.g2932bb562d-goog
> 

