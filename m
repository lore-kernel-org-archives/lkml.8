Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7656CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538432064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJya455B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgGOREh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGOREh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:04:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34CEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:04:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so3398347wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ljeW+fwCYJkj5PP4KJ8WHN1ZOFRAHwVv/b1xKlVN6k=;
        b=ZJya455BxgcVZNeM5bfWcisd0EW0sKwbvKPnF6boT6dAWRQMltcgqHJGxhPdiOWMEE
         utyMoxt8f2WGgmTb7YnF5TOwIM/G+/A5yvgF1ipiDBwcWoTv5OtoeSyz+Tq2/QvaADzN
         WEnKEz4PCpvROEg0CdqMATyOd/YRzw0yW9u6pkPRHryBFtk8VYDt3xCVqajCZq17Uz/f
         RcsH59SsgxtLy8KhKjtbrGg9VsEX0csj8TO6R1RuAZl8VY/92jLY2iG76Gy9kMcX8zor
         4gsYHb1zF3RUQ1Q1bWk+k3OxYZUVWokl64LGMWgKGWSfzFCVvy4ojzSiGmzGBZt0EdkJ
         V/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ljeW+fwCYJkj5PP4KJ8WHN1ZOFRAHwVv/b1xKlVN6k=;
        b=Lywr8xllbizBj5TuIkyOfeXte62OpgHxtopBSQAaPcqvgYwsRxECc0M/xAkCv/WqcO
         m9DivJjYTO5nkv3CnLuuQ/lcxixiQ5K2caEZTgMrbEP0zHa+DpaQ+WLOajYFTlPT1h1K
         9mUPWJJFgNuK8gn3hiFB1xTas71xQiKSYIc3HZXZnn7RI+97gggwZw2CUiqOOdMUOQZh
         jaj8wTEQbeJHFK5gsoOmnPsHPkvvK7QmrcXafXAMxrEvDXqVo0A/2JkpkbNWsfVPfSBw
         waTyaDJDDlzzdQfdIV1ql61KYY+wNkC9xQ/+7G1sSPWAWu9vGGQHp5hwfv0jxqIYnxDm
         sK9g==
X-Gm-Message-State: AOAM530e6F+vGxPk8Q6maCKNh13zz2KVeslH8pODBHYugmNWAdWjbd8V
        8yBYTh9Y0ymQFmB1SKiPJJiuvq/XFkeVyBWjw3Q/Kw==
X-Google-Smtp-Source: ABdhPJzzMp+0gRKZz5xCu1zzYMCWx7iQVwvBa/ur2bzSNUU4WEn7GZ4G38jJTBi20gyI/7zCE8CxEBH5cDhr8Y/FfDY=
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr329665wrm.282.1594832675313;
 Wed, 15 Jul 2020 10:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-15-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-15-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jul 2020 10:04:24 -0700
Message-ID: <CAP-5=fV5gT8KO30cMosTBEgX4ooGyeyoStTD+rF+dt+tO9Qn9Q@mail.gmail.com>
Subject: Re: [PATCH 14/18] perf metric: Add cache_miss_cycles to metric parse test
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

On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that compute metric with other metrics in it.
>
>   cache_miss_cycles = metric:dcache_miss_cpi + metric:icache_miss_cycles
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/parse-metric.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 8c48251425e1..28f33893338b 100644
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
> +       .metric_expr    = "(dcache_miss_cpi + icache_miss_cycles)",
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
