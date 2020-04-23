Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA92C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A471520736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8wbWr1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgDWL2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:28:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52720 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727930AbgDWL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587641318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+o5Xf5Zr0MPuItCGPV5ONvYCthrg1zZObMgsqdr57c=;
        b=Q8wbWr1+qB8MfnPKipDXQdc0X87tdJWuZs3JwasmlbLLo5A+ZuskiReK+amH+BPcsuTCjZ
        dpcNKxcVH340VWAyYQVH7QycxriKzYE6QSltzOOsrrObKZQy9canC6r5HsvRNlfWqCfNrN
        Zm4Oxmt/A8CWhwzqOUUWREsQusUu0aM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-_iuOB4X5PxWGFqTrXcl16A-1; Thu, 23 Apr 2020 07:28:35 -0400
X-MC-Unique: _iuOB4X5PxWGFqTrXcl16A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E3271005510;
        Thu, 23 Apr 2020 11:28:32 +0000 (UTC)
Received: from krava (unknown [10.40.196.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E956760605;
        Thu, 23 Apr 2020 11:28:27 +0000 (UTC)
Date:   Thu, 23 Apr 2020 13:28:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 00/11] perf metric fixes and test
Message-ID: <20200423112825.GD1136647@krava>
References: <20200422220430.254014-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:04:19PM -0700, Ian Rogers wrote:
> Add a test that all perf metrics (for your architecture) are
> parsable. Fix bugs in the expr parser and in x86 metrics. Untested on
> architectures other than x86.
> 
> v2 adds Fixes tags to commit messages for when broken metrics were
>   first added. Adds a debug warning for division by zero in expr, and
>   adds a workaround for id values in the expr test necessary for
>   powerpc. It also fixes broken power8 and power9 metrics.

looks good to me

Jin Yao, is there a metric that's not working for you with this patchset
applied?

thanks,
jirka

> 
> Ian Rogers (11):
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
>   perf test: add expr test for pmu metrics
> 
>  .../arch/powerpc/power8/metrics.json          |  4 +-
>  .../arch/powerpc/power9/metrics.json          |  2 +-
>  .../arch/x86/cascadelakex/clx-metrics.json    | 10 +-
>  .../arch/x86/skylakex/skx-metrics.json        |  4 +-
>  tools/perf/tests/builtin-test.c               |  5 +
>  tools/perf/tests/expr.c                       | 96 ++++++++++++++++++-
>  tools/perf/tests/tests.h                      |  2 +
>  tools/perf/util/expr.c                        |  1 +
>  tools/perf/util/expr.h                        |  2 +-
>  tools/perf/util/expr.l                        | 16 ++--
>  tools/perf/util/expr.y                        | 16 +++-
>  11 files changed, 135 insertions(+), 23 deletions(-)
> 
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

