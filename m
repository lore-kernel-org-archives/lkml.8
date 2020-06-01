Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0321CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBB82076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULsalHO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgFAIGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgFAIGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:06:14 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB67C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 01:06:14 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id n123so4744829ybf.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 01:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d59FlMXkZZoVBeLzdnN0v1/ojzLIURQn/Bd884+qmDQ=;
        b=ULsalHO0uqDfPINCiy70pX46VaQZMMn8knrqTo9BoOv/xI/f43NGcatb6Ws+r3H7eu
         q1e5LA33Z4AEnxa/PwE80tZXRegVVz9JQSHlXa8JVIpFHq1JnqaIu2AqyWv96EKtfUpu
         1Zb6fkwZVkRgSkZoqY9DCF7wHzpjtL35M/KFjaaaCfMxBP3CbZnl3shLUQqsXwOmDYxV
         FQfRZ5++bxd3SpgnKZaTpvl4hZQzcZWW7GobRBfNqf5wdwVzRHkBBYkrlSCelae3tnGX
         JAoqVVASWYqY6f/AnihnyKwVPjspfyUDwGQqTTiqaRUttyCQN0FRpgN/pVOXChIxyMWM
         PYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d59FlMXkZZoVBeLzdnN0v1/ojzLIURQn/Bd884+qmDQ=;
        b=fPKaMEA/fYyxxwFoH7aJkXf2OQItiHFgQhWUPNyNVt0gVC+t9dFhUNg3lLlJ1lhy4s
         qfGseERe1yrqOIOokFaUXu9ULKg+jVHo11E6DTa27DY+g7zPRaSVbaOpdTeuXSedqI2F
         nrABYpZ7aKNRuJUaazoTZld0MNSVP0J11F+R1wA9h9Tc7nm5k7yN5ck1cY2k72c5ucwW
         wWpR1kYwNvixWs4FBsy7wkwUrRZdR45mH5lij/7149yplufl3naPen+0IACev37oUjOO
         pcHTQUKLjFrmLUbsWCx43Ufwob1HhU9Yx6tMnSDXpauNVBegntX18zGPqXjJYQMYMx95
         O+0A==
X-Gm-Message-State: AOAM530nIsOIJEk8iJITp6EvaG5ktkd8pLR1XJ1snoMwe72TnZkAYBC7
        A8mvKP3VrgwOHhsiMj0Fwbra7tsH5+7Wm0KyQxsDGNxi
X-Google-Smtp-Source: ABdhPJwgZvW04nPk4Jca7z69BxIY/ygIogrqLw2npBLnkocgPKpWir9r+zbAsL9C9DPHUFbnbmZEQLDozCp4sZQ4awI=
X-Received: by 2002:a5b:ec1:: with SMTP id a1mr7817315ybs.41.1590998773488;
 Mon, 01 Jun 2020 01:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200524224219.234847-1-jolsa@kernel.org> <20200524224219.234847-15-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-15-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 1 Jun 2020 01:06:01 -0700
Message-ID: <CAP-5=fWz9=RhSmWgv1cH4MPXcq49xrqx=9A2P=NK80qvjgn6TA@mail.gmail.com>
Subject: Re: [PATCH 14/14] perf tests: Add parse metric test for frontend metric
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 3:43 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new metri test for frontend metric. It's stolen

s/metri/metric/

> from x86 pmu events.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/parse-metric.c | 46 +++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 3005d27c5c48..38f20850bba3 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -15,6 +15,11 @@ static struct pmu_event pme_test[] = {
>         .metric_expr    = "inst_retired.any / cpu_clk_unhalted.thread",
>         .metric_name    = "IPC",
>  },
> +{
> +       .metric_expr    = "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * "
> +                         "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
> +       .metric_name    = "Frontend_Bound_SMT",
> +},
>  };
>
>  static struct pmu_events_map map = {
> @@ -110,8 +115,49 @@ static int test_ipc(void)
>         return 0;
>  }
>
> +static int test_frontend(void)
> +{
> +       double ratio;
> +       struct rblist metric_events = { 0 };
> +       struct evlist *evlist;
> +       struct evsel *evsel;
> +       struct value vals[] = {
> +               { .event = "idq_uops_not_delivered.core",        .val = 300 },
> +               { .event = "cpu_clk_unhalted.thread",            .val = 200 },
> +               { .event = "cpu_clk_unhalted.one_thread_active", .val = 400 },
> +               { .event = "cpu_clk_unhalted.ref_xclk",          .val = 600 },
> +               { 0 },
> +       };
> +       struct runtime_stat st;
> +       int err;
> +
> +       evlist = evlist__new();
> +       if (!evlist)
> +               return -1;
> +
> +       err = metricgroup__parse_groups_test(evlist, &map,
> +                                            "Frontend_Bound_SMT",
> +                                            false, false,
> +                                            &metric_events);
> +
> +       TEST_ASSERT_VAL("failed to parse metrics", err == 0);
> +
> +       runtime_stat__init(&st);
> +       load_runtime_stat(&st, evlist, vals);
> +
> +       evsel = evlist__first(evlist);
> +       ratio = compute_single(&metric_events, evsel, &st);
> +
> +       TEST_ASSERT_VAL("Frontend_Bound_SMT failed, wrong ratio", ratio == 0.45);
> +
> +       runtime_stat__exit(&st);
> +       evlist__delete(evlist);
> +       return 0;
> +}
> +
>  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>         TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
> +       TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
>         return 0;
>  }
> --
> 2.25.4
>
