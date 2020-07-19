Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCC2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2F82177B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChKxTZja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgGSWl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSWl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:41:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CEDC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:41:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so23401452wmf.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxLrNPglbF9ncB8sc8qthtbpXbbVljTEGzUXDQggf7U=;
        b=ChKxTZjaqei0REZFZ4Axj/G5mIwXDNhB1JF3DPC6IZC1d3KvYyxnQd/NcwC7ZH/6Tu
         DinqFfjhjDhadtAzoLIWDbIhZiQkcIab139S4A60rhCgZPBmAW6i/jetC2EKXlQ3Xgk/
         emUPxryINuySyKF07LDzKM2rx7tOCxR80nd29yRSdSpMEo2I/N12xPJmOYd6cntJttvX
         r70Q5VkC0EVBHXIPwxRvs1Yr9TdBCzW0WRmQG4DJASq0r4Gr53dxYd3sbIlie0RnFYgu
         LaqFDZilWfyBFaNukMoQalobMCQKrDeoRom5wJ3nh99Foz3yxUSmZO1LOKptncK/kuab
         Q8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxLrNPglbF9ncB8sc8qthtbpXbbVljTEGzUXDQggf7U=;
        b=CGG4BzUcfFLwvXh6EzfLNh4Dws2XOojqDBcjPp6EBZ7KkOPciH8rT4sr9ERlzQZ1QY
         0jtKNedga7LiTtkUR4Lbo+vH36/rZMkkqXMXl1c7yw+8LT3rMOpLZKIMvpQkVSan969U
         t00hrQhJZfZmyTQdFrqIdJWEL3WP0omZheKBL2glBEIoRy6oDcqSIxn11pbvf7IgQhQk
         z12xpw0oXH+q6QJ3BrB/gcMSS9nSKNA3rayRmM0flE+6CxmHdjKniWZRFFBOYfIJPQ6k
         AgbBRH4fA4Lhfzk3eiF91PSkxIJoNO6YpfqOx8uoDeeU6OJvHisWpKDb7klj83VqskGe
         nlHQ==
X-Gm-Message-State: AOAM533DA54YVAsvhrcEADD7RaT32PFatgX62+UseKWK4QjM3wjTK3DY
        dgDGrdpN8PBaApfNCJ4AC0XrPStPAMYt3/13Wi63DA==
X-Google-Smtp-Source: ABdhPJyzyjJnV9Vn6Hv/ivhglamob4TAIGejshKTLTYYdkX7/HfrjA6aHf3QmP7VU2ptMdyYKNg2/3UXTFqmTbVmA8g=
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr19606936wmh.77.1595198486224;
 Sun, 19 Jul 2020 15:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200719181320.785305-1-jolsa@kernel.org> <20200719181320.785305-18-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-18-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 19 Jul 2020 15:41:14 -0700
Message-ID: <CAP-5=fWmm5pvH-hwkaAKV=__7Ocbc-4Qj8OCJWz_xi4pc65A=Q@mail.gmail.com>
Subject: Re: [PATCH 17/19] perf metric: Add metric group test
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

On Sun, Jul 19, 2020 at 11:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test for metric group plus compute_metric_group
> function to get metrics values within the group.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/parse-metric.c | 48 +++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 5ac32f80f8ea..f2ba5b2c5557 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -18,6 +18,7 @@ static struct pmu_event pme_test[] = {
>  {
>         .metric_expr    = "inst_retired.any / cpu_clk_unhalted.thread",
>         .metric_name    = "IPC",
> +       .metric_group   = "group1",
>  },
>  {
>         .metric_expr    = "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * "
> @@ -35,6 +36,7 @@ static struct pmu_event pme_test[] = {
>  {
>         .metric_expr    = "(dcache_miss_cpi + icache_miss_cycles)",
>         .metric_name    = "cache_miss_cycles",
> +       .metric_group   = "group1",
>  },
>  {
>         .metric_expr    = "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
> @@ -127,7 +129,9 @@ static double compute_single(struct rblist *metric_events, struct evlist *evlist
>         return 0.;
>  }
>
> -static int compute_metric(const char *name, struct value *vals, double *ratio)
> +static int __compute_metric(const char *name, struct value *vals,
> +                           const char *name1, double *ratio1,
> +                           const char *name2, double *ratio2)
>  {
>         struct rblist metric_events = {
>                 .nr_entries = 0,
> @@ -166,7 +170,10 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
>         load_runtime_stat(&st, evlist, vals);
>
>         /* And execute the metric */
> -       *ratio = compute_single(&metric_events, evlist, &st, name);
> +       if (name1 && ratio1)
> +               *ratio1 = compute_single(&metric_events, evlist, &st, name1);
> +       if (name2 && ratio2)
> +               *ratio2 = compute_single(&metric_events, evlist, &st, name2);
>
>         /* ... clenup. */
>         metricgroup__rblist_exit(&metric_events);
> @@ -177,6 +184,18 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
>         return 0;
>  }
>
> +static int compute_metric(const char *name, struct value *vals, double *ratio)
> +{
> +       return __compute_metric(name, vals, name, ratio, NULL, NULL);
> +}
> +
> +static int compute_metric_group(const char *name, struct value *vals,
> +                               const char *name1, double *ratio1,
> +                               const char *name2, double *ratio2)
> +{
> +       return __compute_metric(name, vals, name1, ratio1, name2, ratio2);
> +}
> +
>  static int test_ipc(void)
>  {
>         double ratio;
> @@ -297,6 +316,30 @@ static int test_recursion_fail(void)
>         return 0;
>  }
>
> +static int test_metric_group(void)
> +{
> +       double ratio1, ratio2;
> +       struct value vals[] = {
> +               { .event = "cpu_clk_unhalted.thread", .val = 200 },
> +               { .event = "l1d-loads-misses",        .val = 300 },
> +               { .event = "l1i-loads-misses",        .val = 200 },
> +               { .event = "inst_retired.any",        .val = 400 },
> +               { 0 },
> +       };
> +
> +       TEST_ASSERT_VAL("failed to find recursion",
> +                       compute_metric_group("group1", vals,
> +                                            "IPC", &ratio1,
> +                                            "cache_miss_cycles", &ratio2) == 0);
> +
> +       TEST_ASSERT_VAL("group IPC failed, wrong ratio",
> +                       ratio1 == 2.0);
> +
> +       TEST_ASSERT_VAL("group cache_miss_cycles failed, wrong ratio",
> +                       ratio2 == 1.25);
> +       return 0;
> +}
> +
>  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>         TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
> @@ -304,5 +347,6 @@ int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unu
>         TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
>         TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
>         TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
> +       TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
>         return 0;
>  }
> --
> 2.25.4
>
