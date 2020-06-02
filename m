Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D222C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6204820734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNjjh3CS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgFBR6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgFBR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:58:46 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D180DC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:58:45 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id k18so3614355ybm.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LT81/qBABssea37iCv4nSCuH2aiuSAvAD7EVsGktCxk=;
        b=qNjjh3CSIfWduS4yTgaffLlAz7qgLLi2ruiuFWUUu7FDvtIJrWHub+yQMIQnyHljj1
         VDh2vdCfgJVx+QxjQz25q5aDQA2FqqfKv40d7+TnuwLZrRCOhOwmNxcmtzoRl+VH99bB
         6u/cmOEPjg5hr9UyotjQOJNjtD5Mkb1zWZ8Y6KDVvO9zwvtEUV2QfedpeqgEU/lnltS8
         bttI5ze1wRkv9hWiBfLiixVOyC+cxbi++AkiHGuFBy4rnsygYs7EhHdN06zSrEabU4LY
         P9aaIQOL7hx8HvqAmKSE22yCct2Q10w2NeS5oZ6BjjzviSJaCGV7EzBCGwXYQT0qfEVP
         0YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LT81/qBABssea37iCv4nSCuH2aiuSAvAD7EVsGktCxk=;
        b=a10dH13Af4vcjN4UjznFLI2+lbv/BL2ENM7KoaLH92mKBNFYh84svBA7/gfkuBOdPL
         H3Qo83/bvr/y/rVpXSJ1bgRe+27iZ7KLjaVEdnBN+bFToDjiMI0MJyefQijz862En1L5
         jd/dF6H58D9PSwtqe4phacaUXLtmyCqBQCT1PNOeudjC3IAvWz0jgthzmmceD89ZqwEL
         cQnR/Hfou8qRZpvGmUIHsx0/1gugs2TUHi5uQz29VQAO/F3l59ea2Ko+PWmYdmfcEqXy
         pCZgY3FEVI3sQL8iGn+HCNbPinwqnGi8j2cFm9VC7us2bIeTqd/1Vi4JS6COI5unn/V7
         uO9Q==
X-Gm-Message-State: AOAM533Zn827EICCif870QIUNogQ/xGcaaOd2K03Sq4Z4Hu82tP+3Yv+
        wg30mRUMhBBadZiqRkv4qN51YAGALKtQB8mk3hBApw==
X-Google-Smtp-Source: ABdhPJxy/GLXjBFYppdvA15E/tUAJGNBUBOqmt763mbz9/bFf43ECVlDoVIFpoQidx5TiyTI2fxprJ/FW+5IJ9fGUtI=
X-Received: by 2002:a25:3782:: with SMTP id e124mr7549309yba.403.1591120723205;
 Tue, 02 Jun 2020 10:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200602115055.1168446-1-jolsa@kernel.org> <20200602115055.1168446-5-jolsa@kernel.org>
In-Reply-To: <20200602115055.1168446-5-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 Jun 2020 10:58:32 -0700
Message-ID: <CAP-5=fXjQ0ZgtrsizH6F7y2VRZ6dnsu54BXRxszyM+mMAvP-cQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] perf tests: Add another metric parsing test
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

On Tue, Jun 2, 2020 at 4:51 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The test goes through all metrics compiled for arch
> within pmu events and try to parse them.
>
> This test is different from 'test_parsing' in that
> we go through all the events in the current arch,
> not just one defined for current CPU model. Using
> 'fake_pmu' to parse events which do not have PMUs
> defined in the system.
>
> Say there's bad change in ivybridge metrics file, like:
>
>   --- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
>   +++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
>   @@ -8,7 +8,7 @@
>   -        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ((
>   +        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / / (4 *
>
> the test fails with (on my kabylake laptop):
>
>   $ perf test 'Parsing of PMU event table metrics with fake PMUs' -v
>   parsing 'idq_uops_not_delivered.core / / (4 * (( ( cpu_clk_unh...
>   syntax error, line 1
>   expr__parse failed
>   test child finished with -1
>   ...

For this example as the problem is the expression, presumably this was
"passing" with test_parsing due to returning TEST_SKIP? I did this
initially so that we could get the test merged and then the metrics
fixed. I'd prefer if test_parsing were returning TEST_FAIL.

> The test also defines its own list of metrics and
> tries to parse them. It's handy for developing.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/pmu-events.c | 117 +++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index f65380d2066f..d3343827eb4d 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -390,7 +390,8 @@ static bool is_number(const char *str)
>         return errno == 0 && end_ptr != str;
>  }
>
> -static int check_parse_id(const char *id, struct parse_events_error *error)
> +static int check_parse_id(const char *id, struct parse_events_error *error,
> +                         bool fake_pmu)
>  {
>         struct evlist *evlist;
>         int ret;
> @@ -403,7 +404,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error)
>         if (!evlist)
>                 return -ENOMEM;
>         memset(error, 0, sizeof(*error));
> -       ret = parse_events(evlist, id, error, false);
> +       ret = parse_events(evlist, id, error, fake_pmu);
>         evlist__delete(evlist);
>         return ret;
>  }
> @@ -412,7 +413,7 @@ static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
>  {
>         struct parse_events_error error;
>
> -       int ret = check_parse_id(id, &error);
> +       int ret = check_parse_id(id, &error, false);
>         if (ret && same_cpu) {
>                 pr_warning("Parse event failed metric '%s' id '%s' expr '%s'\n",
>                         pe->metric_name, id, pe->metric_expr);
> @@ -430,6 +431,18 @@ static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
>         return ret;
>  }
>
> +static int check_parse_fake(const char *id)
> +{
> +       struct parse_events_error error;

nit: this reads funny as it isn't clear, without looking at
check_parse_id, that error is zero initialized.

Thanks,
Ian

> +       int ret = check_parse_id(id, &error, true);
> +
> +       free(error.str);
> +       free(error.help);
> +       free(error.first_str);
> +       free(error.first_help);
> +       return ret;
> +}
> +
>  static void expr_failure(const char *msg,
>                          const struct pmu_events_map *map,
>                          const struct pmu_event *pe)
> @@ -499,6 +512,100 @@ static int test_parsing(void)
>         return ret == 0 ? TEST_OK : TEST_SKIP;
>  }
>
> +struct test_metric {
> +       const char *str;
> +};
> +
> +static struct test_metric metrics[] = {
> +       { "(unc_p_power_state_occupancy.cores_c0 / unc_p_clockticks) * 100." },
> +       { "imx8_ddr0@read\\-cycles@ * 4 * 4", },
> +       { "imx8_ddr0@axid\\-read\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@ * 4", },
> +       { "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100", },
> +       { "(imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@)", },
> +};
> +
> +static int metric_parse_fake(const char *str)
> +{
> +       struct expr_parse_ctx ctx;
> +       struct hashmap_entry *cur;
> +       double result;
> +       int ret = -1;
> +       size_t bkt;
> +       int i;
> +
> +       pr_debug("parsing '%s'\n", str);
> +
> +       expr__ctx_init(&ctx);
> +       if (expr__find_other(str, NULL, &ctx, 0) < 0) {
> +               pr_err("expr__find_other failed\n");
> +               return -1;
> +       }
> +
> +       /*
> +        * Add all ids with a made up value. The value may
> +        * trigger divide by zero when subtracted and so try to
> +        * make them unique.
> +        */
> +       i = 1;
> +       hashmap__for_each_entry((&ctx.ids), cur, bkt)
> +               expr__add_id(&ctx, strdup(cur->key), i++);
> +
> +       hashmap__for_each_entry((&ctx.ids), cur, bkt) {
> +               if (check_parse_fake(cur->key)) {
> +                       pr_err("check_parse_fake failed\n");
> +                       goto out;
> +               }
> +       }
> +
> +       if (expr__parse(&result, &ctx, str, 1))
> +               pr_err("expr__parse failed\n");
> +       else
> +               ret = 0;
> +
> +out:
> +       expr__ctx_clear(&ctx);
> +       return ret;
> +}
> +
> +/*
> + * Parse all the metrics for current architecture,
> + * or all defined cpus via the 'fake_pmu' bool
> + * in parse_events.
> + */
> +static int test_parsing_fake(void)
> +{
> +       struct pmu_events_map *map;
> +       struct pmu_event *pe;
> +       unsigned int i, j;
> +       int err = 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(metrics); i++) {
> +               err = metric_parse_fake(metrics[i].str);
> +               if (err)
> +                       return err;
> +       }
> +
> +       i = 0;
> +       for (;;) {
> +               map = &pmu_events_map[i++];
> +               if (!map->table)
> +                       break;
> +               j = 0;
> +               for (;;) {
> +                       pe = &map->table[j++];
> +                       if (!pe->name && !pe->metric_group && !pe->metric_name)
> +                               break;
> +                       if (!pe->metric_expr)
> +                               continue;
> +                       err = metric_parse_fake(pe->metric_expr);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct {
>         int (*func)(void);
>         const char *desc;
> @@ -515,6 +622,10 @@ static const struct {
>                 .func = test_parsing,
>                 .desc = "Parsing of PMU event table metrics",
>         },
> +       {
> +               .func = test_parsing_fake,
> +               .desc = "Parsing of PMU event table metrics with fake PMUs",
> +       },
>  };
>
>  const char *test__pmu_events_subtest_get_desc(int subtest)
> --
> 2.25.4
>
