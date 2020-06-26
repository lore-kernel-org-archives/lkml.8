Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01531C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67662088E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0siHl+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgFZVku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZVkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:40:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D42C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:40:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so10801528wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bf2oIM8gzF9kivw/oc3AdRS2cUxG1GhwX0+YkSkUH5k=;
        b=C0siHl+OVTSGPa4s2RBZWxiQqNDD+DzALy6IX6xsvS/mn2fyikHiuX6vrgpKwpFG4f
         Ny9wFBsoqa9wXX/RZ3YFHFc84FAXKE7SnzElLD+ygDl+3amH8+Wb7thVejpGNGyZsGkM
         lL25biBlUa/jSaTSGyDfqA4VgUDgrhCXRmCgv4/x6N3tVx1ng4i4zADbM6yd5xlQLmCs
         C7F5+b1IKdNhTZpR+3ODMa6t+Ixd7mfNDxvX27qZu/8OCzESW2A5N4BLdhQ/wuM4uYy0
         2H5rjslWKH3/QLezUUf2WW02w547iBAtXdmSegfLePYwhHFR1BlQ2FdJkgXoqKFpokmV
         jkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bf2oIM8gzF9kivw/oc3AdRS2cUxG1GhwX0+YkSkUH5k=;
        b=swdMW82Q87iVJvAYL564YCoqNtwDx2h/RS/O3dBLBdZNPP97jUinJkqNNqzKaKW0dj
         4sIxq+HWmEpgzYxZoXSyGqZljd+4UZ5uplMtq71d1npcJbpRh7SQSo4uvVY7KrJGbmhX
         eHDjVj9c/vX1mpXj0CXnVYQ6z3M9Ft8+ddoBAFn5M4PPB+VBHqnQYIV5c1F1MW4WEQTi
         vt4mjyuYne7JdvUaGea2U3FJQQQ8CsWWyHDJ362Yvzn4RmNZgCEsO0zMQY6yVcGXXSAM
         8yLuLbJCtTbhZ5svW5vcBMIV7IHpo1YMv+Xjeh8fOyZPrLbtRyvrN4aSA3qrpE46gfyF
         9bHQ==
X-Gm-Message-State: AOAM5331lovXPB+DUh+jmvPN7udUzCrcycvsVuwovdzy1huoER7PvbPK
        VhleoptE8IvFRv4xKEGR5axI5b0jZP+ZntyJmw5rhw==
X-Google-Smtp-Source: ABdhPJzDpOI9NNCwfig0lV5DGFo3ODuHjMSS7n2nQ94vh5kYq9lqKA2++KiChYAuFh94OHu19n7Uz3w2JVqH5sHCAos=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr6109686wrm.271.1593207645927;
 Fri, 26 Jun 2020 14:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-11-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-11-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jun 2020 14:40:34 -0700
Message-ID: <CAP-5=fXk6ZqWdXqVGtiKemn254wTOKW3m4UuwF1Qum+mZQhYPg@mail.gmail.com>
Subject: Re: [PATCH 10/10] perf tests: Add cache_miss_cycles to metric parse test
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:48 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that compute metric with other metrics in it.
>
>   cache_miss_cycles = metric:dcache_miss_cpi + metric:icache_miss_cycles
>

This is really nice! Do we need to do anything in tests/pmu-events.c?
Presumably if a metric is referencing another metric the call to
expr__parse there will test the other metric is parseable. Just wanted
to sanity check.

Acked-by: Ian Rogers <irogers@google.com>

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/parse-metric.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 8c48251425e1..feb97f7c90c8 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -11,6 +11,8 @@
>  #include "debug.h"
>  #include "expr.h"
>  #include "stat.h"
> +#include <perf/cpumap.h>
> +#include <perf/evlist.h>
>
>  static struct pmu_event pme_test[] = {
>  {
> @@ -22,6 +24,18 @@ static struct pmu_event pme_test[] = {
>                           "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
>         .metric_name    = "Frontend_Bound_SMT",
>  },
> +{
> +       .metric_expr    = "l1d\\-loads\\-misses / inst_retired.any",
> +       .metric_name    = "dcache_miss_cpi",
> +},
> +{
> +       .metric_expr    = "l1i\\-loads\\-misses / inst_retired.any",
> +       .metric_name    = "icache_miss_cycles",
> +},
> +{
> +       .metric_expr    = "(metric:dcache_miss_cpi + metric:icache_miss_cycles)",
> +       .metric_name    = "cache_miss_cycles",
> +},
>  };
>
>  static struct pmu_events_map map = {
> @@ -162,9 +176,28 @@ static int test_frontend(void)
>         return 0;
>  }
>
> +static int test_cache_miss_cycles(void)
> +{
> +       double ratio;
> +       struct value vals[] = {
> +               { .event = "l1d-loads-misses",  .val = 300 },
> +               { .event = "l1i-loads-misses",  .val = 200 },
> +               { .event = "inst_retired.any",  .val = 400 },
> +               { 0 },
> +       };
> +
> +       TEST_ASSERT_VAL("failed to compute metric",
> +                       compute_metric("cache_miss_cycles", vals, &ratio) == 0);
> +
> +       TEST_ASSERT_VAL("cache_miss_cycles failed, wrong ratio",
> +                       ratio == 1.25);
> +       return 0;
> +}
> +
>  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>         TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
>         TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
> +       TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
>         return 0;
>  }
> --
> 2.25.4
>
