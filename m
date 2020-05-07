Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D24C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA462075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUEGfrAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgEGIpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:45:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35524 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588841101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/umoOuyurZvbQ0tpeh5y84hH029f3a+NjnlYx1uMWkA=;
        b=eUEGfrAcdaSntotvnXK+Ln7bBw9+1JsG6RXhnF7oTHvC2NhH01mLYleX0+HokzKlW+d3zk
        1P/GHoObUJMeEYKv5VRNmkdurO2LRjokBdFVssKxnibWTQQbOdRQJTto4cq1znUld1RS8D
        wO2+RzZ2DiRlSye/K+CLyRWPXTxcXHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-Pd0YO6rwPNSV-eDMcx6OgA-1; Thu, 07 May 2020 04:44:59 -0400
X-MC-Unique: Pd0YO6rwPNSV-eDMcx6OgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D970545F;
        Thu,  7 May 2020 08:44:56 +0000 (UTC)
Received: from krava (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6C79707AE;
        Thu,  7 May 2020 08:44:48 +0000 (UTC)
Date:   Thu, 7 May 2020 10:44:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 00/12] perf metric fixes and test
Message-ID: <20200507084445.GA2447905@krava>
References: <20200501173333.227162-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:33:21AM -0700, Ian Rogers wrote:
> Add a test that all perf metrics (for your architecture) are parsable
> with the simple expression parser. Attempt to parse all events in
> metrics but only fail if the metric is for the current CPU. Fix bugs
> in the expr parser, x86 and powerpc metrics. Improve debug messages
> around add PMU config term failures.
> 
> v4 rebases after Kajol Jain's patches and fixes an asprintf warning.
> v3 adds parse event testing of ids and improves debug messages for add
>   PMU. These messages are paticular visible with 'perf test 10
>   -vvv'. It moves the testing logic from tests/expr.c to
>   tests/pmu-events.c as suggested by John Garry
>   <john.garry@huawei.com>.  
> v2 adds Fixes tags to commit messages for when broken metrics were
>   first added. Adds a debug warning for division by zero in expr, and
>   adds a workaround for id values in the expr test necessary for
>   powerpc. It also fixes broken power8 and power9 metrics.
> 
> Ian Rogers (12):
>   perf expr: unlimited escaped characters in a symbol
>   perf metrics: fix parse errors in cascade lake metrics
>   perf metrics: fix parse errors in skylake metrics
>   perf expr: allow ',' to be an other token
>   perf expr: increase max other
>   perf expr: parse numbers as doubles
>   perf expr: debug lex if debugging yacc
>   perf metrics: fix parse errors in power8 metrics
>   perf metrics: fix parse errors in power9 metrics
>   perf expr: print a debug message for division by zero

heya,
could we please get the 1st 10 patches in? they are important,
and let's not block them with new versions for patches 11/12

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>   perf parse-events: expand add PMU error/verbose messages
>   perf test: improve pmu event metric testing
> 
>  tools/perf/arch/x86/util/intel-pt.c           |  32 ++--
>  .../arch/powerpc/power8/metrics.json          |   2 +-
>  .../arch/powerpc/power9/metrics.json          |   2 +-
>  .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
>  .../arch/x86/skylakex/skx-metrics.json        |   4 +-
>  tools/perf/tests/builtin-test.c               |   5 +
>  tools/perf/tests/expr.c                       |   1 +
>  tools/perf/tests/pmu-events.c                 | 156 +++++++++++++++++-
>  tools/perf/tests/pmu.c                        |   4 +-
>  tools/perf/tests/tests.h                      |   2 +
>  tools/perf/util/expr.c                        |   1 +
>  tools/perf/util/expr.h                        |   2 +-
>  tools/perf/util/expr.l                        |  16 +-
>  tools/perf/util/expr.y                        |  16 +-
>  tools/perf/util/parse-events.c                |  29 +++-
>  tools/perf/util/pmu.c                         |  33 ++--
>  tools/perf/util/pmu.h                         |   2 +-
>  17 files changed, 262 insertions(+), 55 deletions(-)
> 
> -- 
> 2.26.2.526.g744177e7f7-goog
> 

