Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AE6C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF673206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCtrT90O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgEMHFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgEMHFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:05:07 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD6AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:05:07 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id o134so2638784ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PkVewOwNAcqRHQExqxciULVlpyGkYUIYG6Zp7ZT93M=;
        b=PCtrT90OuQU0uGO/h8ovlXAAf+Wnk2Olw7Fs3xTd1NBAFsgC2hbvKwNaaqEssKxVrK
         S/pkhgqOwOHrBKY3vp5KPlI7JG5HKdthQxizOq1bHqVDhwVlaSCXDr1VzbgTAOGre2xM
         aGi3sMb81wIQM/mQPedCk8OFyrbyQHeiqrBLB6zidcdgY1WNCEcNIcFcx/iYgixMGggE
         CgpHoeTTJCOvzKW38bYTFaSLw0dsNjcSv0TSLpFoKgZGARudEjohaAJWj9tOmk1WDjpP
         UfWmm824LWeFGvFDBphR0IB1VVioslx6n8dhf9pVLfIlpZ5pMg+LoAIbTYrWT088a4ff
         Voiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PkVewOwNAcqRHQExqxciULVlpyGkYUIYG6Zp7ZT93M=;
        b=BIXGd0LTq+gvQq4DDPpbUjj6S7I1BzyFBJyc16HN+KzoX8zXxqKXISzlZZx2FDQAIO
         BS4WPipehemSl1KQP4y2hFxAgZbBssOTSJCuZFcO+HyV9hS6GsAuZO9/KtJrj9ekr//V
         o5L3WEy3gHIMLm65aWyzu//x9E86ANB23UP0ZWcRg9x7GCK6n/YvJPbo5eAD4TH8FuEX
         BuSJ4JQGxtMLdCwCXqqji6Cgy2SCGuDwcj6yjn+z4UGHJoO/Xux6xFwwTAdipj485JLC
         Rku3cDQdtFze7KSELuwHVCdJp9+uKTRcz+Oi2bdA7DymLOSu6KK7BPVvrbbjk4f/sLWh
         hBqw==
X-Gm-Message-State: AOAM531Q+RjeC1gJ1whzv6b6fysp8fHXQ/vJbHbX5NVM73uJNY2c8wYy
        0gttuG7/Dg1pD+sdhHWsysFlS8zjZGPVSiOpMLplwg==
X-Google-Smtp-Source: ABdhPJw5w02rgO1FiDZw/DQFcANIW5siUm7MUF9L68Yrgt60jQLJHf3xFaXCMX7lpeJL91mpMhE3x70TXIUTTGuf8Pk=
X-Received: by 2002:a25:d450:: with SMTP id m77mr19672476ybf.177.1589353506353;
 Wed, 13 May 2020 00:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200511205307.3107775-1-jolsa@kernel.org> <20200511205307.3107775-4-jolsa@kernel.org>
In-Reply-To: <20200511205307.3107775-4-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 May 2020 00:04:55 -0700
Message-ID: <CAP-5=fU5bbWWyWXDMoMvsMY4BbUsRUqgrOtGUrdiYjSsJZ+t-A@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf stat: Add --metrics-file option
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 1:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding --metrics-file option that allows to specify metrics
> in the file.
>
> It's now possible to define metrics in file and use them like:
>
>   $ cat metrics
>   // IPC
>   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
>
>   /* DECODED_ICACHE_UOPS% */
>   mine2 = 100 * (idq.dsb_uops / (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops));
>
>   $ sudo perf stat --metrics-file ./metrics -M mine1,mine2 -a -I 1000 --metric-only
>   #           time                mine1                mine2
>        1.000997184                 0.41                18.47
>        2.002479737                 0.57                22.46
>        3.003932935                 0.40                17.52
>   ...
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-stat.txt | 77 ++++++++++++++++++++++++++
>  tools/perf/builtin-stat.c              |  7 ++-
>  tools/perf/util/metricgroup.c          | 69 ++++++++++++++++++++---
>  tools/perf/util/metricgroup.h          |  3 +-
>  tools/perf/util/stat.h                 |  1 +
>  5 files changed, 147 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 3fb5028aef08..9f0a646d719c 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -266,6 +266,10 @@ For a group all metrics from the group are added.
>  The events from the metrics are automatically measured.
>  See perf list output for the possble metrics and metricgroups.
>
> +--metrics-file file::
> +Read metrics definitions from file in addition to compiled in metrics.
> +Please check the file's syntax details in METRICS FILE section below.
> +
>  -A::
>  --no-aggr::
>  Do not aggregate counts across all monitored CPUs.
> @@ -404,6 +408,79 @@ The fields are in this order:
>
>  Additional metrics may be printed with all earlier fields being empty.
>
> +METRICS FILE
> +------------
> +The file with metrics has following syntax:
> +
> +  NAME = EXPRESSION ;
> +  NAME = EXPRESSION ;
> +  ...
> +
> +where NAME is unique identifier of the metric, which is later used in
> +perf stat as -M option argument (see below).
> +
> +The EXPRESSION is the metric's formula with following grammar:
> +
> +  EXPR: EVENT
> +  EXPR: EXPR if EXPR else EXPR

Not introduced by this patch, but this patch is exposing it as an API.
This notion of if-else is really weird. For one thing there are no
comparison operators. The unit test doesn't really help:
        ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
What kind of comparison is "3*4"? If 0.0 causes the else clause then will -0.0?
A typical expression I see written in C is to give a ratio such:
  value = denom == 0 ? 0 : nom / denom;
I've worked around encoding this by extending expr.y locally.

> +  EXPR: NUMBER
> +  EXPR: EXPR | EXPR
> +  EXPR: EXPR & EXPR
> +  EXPR: EXPR ^ EXPR

Again, it's odd that these cast the double to a long and then assign
the result back to a double.

> +  EXPR: EXPR + EXPR
> +  EXPR: EXPR - EXPR
> +  EXPR: EXPR * EXPR
> +  EXPR: EXPR / EXPR
> +  EXPR: EXPR % EXPR
> +  EXPR: - EXPR
> +  EXPR: ( EXPR )
> +  EXPR: min( EXPR, EXPR )
> +  EXPR: max( EXPR, EXPR )
> +  EXPR: #smt_on
> +
> +where:
> +
> +  EVENT is monitored event name
> +  min returns smaller of 2 expressions
> +  max returns bigger of 2 expressions
> +  #smt_on returns true if SMT is enabled
> +
> +The metric's definition can be spread across multiple lines and it's finished
> +with ';' character.
> +
> +The syntax allows for C style comments:
> +
> +  // single line
> +  /* multiple
> +              lines */
> +
> +Metrics file example with 2 custom metrics mine1 and mine2:
> +
> +  $ cat metrics
> +  // IPC
> +  mine1 = inst_retired.any / cpu_clk_unhalted.thread;
> +
> +   /* DECODED_ICACHE_UOPS% */
> +  mine2 = 100 * (idq.dsb_uops / (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops));
> +
> +  $ sudo perf stat --metrics-file ./metrics -M mine1,mine2 -a -I 1000 --metric-only
> +  #           time                mine1                mine2
> +       1.000997184                 0.41                18.47
> +       2.002479737                 0.57                22.46
> +       3.003932935                 0.40                17.52
> +  ...
> +
> +
> +It's possible to mix custom metrics with compiled-in metrics in one -M argument:
> +
> +  $ sudo perf stat --metrics-file ./metrics -M mine1,mine2,IPC -a -I 1000 --metric-only
> +  #           time                mine1                mine2                  IPC
> +       1.001142007                 0.85                22.33                 0.85
> +       2.002460174                 0.86                23.37                 0.86
> +       3.003969795                 1.03                23.93                 1.03
> +  ...

A feature request would be to allow metrics in terms of other metrics,
not just events :-) For example, it is common to sum all cache
hit/miss events. It is laborious to copy that expression for hit rate,
miss rate, etc.

Perhaps the expression parsing code should be folded into the event
parsing code.

Thanks,
Ian

> +
>  SEE ALSO
>  --------
>  linkperf:perf-top[1], linkperf:perf-list[1]
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e0c1ad23c768..5eda298654a8 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -840,7 +840,8 @@ static int parse_metric_groups(const struct option *opt,
>                                const char *str,
>                                int unset __maybe_unused)
>  {
> -       return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
> +       return metricgroup__parse_groups(opt, str, &stat_config.metric_events,
> +                                        stat_config.metrics_file);
>  }
>
>  static struct option stat_options[] = {
> @@ -925,6 +926,8 @@ static struct option stat_options[] = {
>         OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
>                      "monitor specified metrics or metric groups (separated by ,)",
>                      parse_metric_groups),
> +       OPT_STRING(0, "metrics-file", &stat_config.metrics_file, "file path",
> +                  "file with metrics definitions"),
>         OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
>                          "Configure all used events to run in kernel space.",
>                          PARSE_OPT_EXCLUSIVE),
> @@ -1442,7 +1445,7 @@ static int add_default_attributes(void)
>                         struct option opt = { .value = &evsel_list };
>
>                         return metricgroup__parse_groups(&opt, "transaction",
> -                                                        &stat_config.metric_events);
> +                                                        &stat_config.metric_events, NULL);
>                 }
>
>                 if (pmu_have_event("cpu", "cycles-ct") &&
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index b071df373f8b..3b4d5bdb5ac6 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -527,17 +527,17 @@ static int __metricgroup__add_metric(struct strbuf *events,
>  }
>
>  static int metricgroup__add_metric(const char *metric, struct strbuf *events,
> -                                  struct list_head *group_list)
> +                                  struct list_head *group_list,
> +                                  struct expr_parse_ctx *ctx)
>  {
>         struct pmu_events_map *map = perf_pmu__find_map(NULL);
> -       struct pmu_event *pe;
>         int i, ret = -EINVAL;
>
>         if (!map)
>                 return 0;
>
>         for (i = 0; ; i++) {
> -               pe = &map->table[i];
> +               struct pmu_event *pe = &map->table[i];
>
>                 if (!pe->name && !pe->metric_group && !pe->metric_name)
>                         break;
> @@ -567,15 +567,59 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>                                 break;
>                 }
>         }
> +
> +       if (!ctx->num_custom || ret == -ENOMEM)
> +               return ret;
> +
> +       for (i = 0; i < ctx->num_custom; i++) {
> +               struct pmu_event pe = { 0 };
> +
> +               if (!match_metric(ctx->custom[i].name, metric))
> +                       continue;
> +
> +               pe.metric_name = strdup(ctx->custom[i].name);
> +               pe.metric_expr = strdup(ctx->custom[i].expr);
> +
> +               if (!pe.metric_name && !pe.metric_expr)
> +                       return -ENOMEM;
> +
> +               ret = __metricgroup__add_metric(events, group_list, &pe, 1);
> +               if (ret) {
> +                       free((char *) pe.metric_name);
> +                       free((char *) pe.metric_expr);
> +                       break;
> +               }
> +       }
> +
>         return ret;
>  }
>
>  static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
> -                                       struct list_head *group_list)
> +                                       struct list_head *group_list,
> +                                       const char *metrics_file)
>  {
> +       struct expr_parse_ctx ctx = { 0 };
>         char *llist, *nlist, *p;
>         int ret = -EINVAL;
>
> +       if (metrics_file) {
> +               size_t size;
> +               char *buf;
> +
> +               if (filename__read_str(metrics_file, &buf, &size)) {
> +                       pr_err("failed to read metrics file: %s\n", metrics_file);
> +                       return -1;
> +               }
> +
> +               expr__ctx_init(&ctx);
> +               ret = expr__parse_custom(&ctx, buf);
> +               free(buf);
> +               if (ret) {
> +                       pr_err("failed to parse metrics file: %s\n", metrics_file);
> +                       return -1;
> +               }
> +       }
> +
>         nlist = strdup(list);
>         if (!nlist)
>                 return -ENOMEM;
> @@ -585,7 +629,7 @@ static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
>         strbuf_addf(events, "%s", "");
>
>         while ((p = strsep(&llist, ",")) != NULL) {
> -               ret = metricgroup__add_metric(p, events, group_list);
> +               ret = metricgroup__add_metric(p, events, group_list, &ctx);
>                 if (ret == -EINVAL) {
>                         fprintf(stderr, "Cannot find metric or group `%s'\n",
>                                         p);
> @@ -597,6 +641,15 @@ static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
>         if (!ret)
>                 metricgroup___watchdog_constraint_hint(NULL, true);
>
> +       if (metrics_file) {
> +               int i;
> +
> +               for (i = 0; i < ctx.num_custom; i++) {
> +                       zfree(&ctx.custom[i].name);
> +                       zfree(&ctx.custom[i].expr);
> +               }
> +       }
> +
>         return ret;
>  }
>
> @@ -616,7 +669,8 @@ static void metricgroup__free_egroups(struct list_head *group_list)
>
>  int metricgroup__parse_groups(const struct option *opt,
>                            const char *str,
> -                          struct rblist *metric_events)
> +                          struct rblist *metric_events,
> +                          const char *metrics_file)
>  {
>         struct parse_events_error parse_error;
>         struct evlist *perf_evlist = *(struct evlist **)opt->value;
> @@ -626,7 +680,8 @@ int metricgroup__parse_groups(const struct option *opt,
>
>         if (metric_events->nr_entries == 0)
>                 metricgroup__rblist_init(metric_events);
> -       ret = metricgroup__add_metric_list(str, &extra_events, &group_list);
> +       ret = metricgroup__add_metric_list(str, &extra_events, &group_list,
> +                                          metrics_file);
>         if (ret)
>                 return ret;
>         pr_debug("adding %s\n", extra_events.buf);
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 6b09eb30b4ec..33dcdcad15dd 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -30,7 +30,8 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>                                          bool create);
>  int metricgroup__parse_groups(const struct option *opt,
>                         const char *str,
> -                       struct rblist *metric_events);
> +                       struct rblist *metric_events,
> +                       const char *metrics_file);
>
>  void metricgroup__print(bool metrics, bool groups, char *filter,
>                         bool raw, bool details);
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b4fdfaa7f2c0..57c4c7695aaf 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -123,6 +123,7 @@ struct perf_stat_config {
>         struct runtime_stat     *stats;
>         int                      stats_num;
>         const char              *csv_sep;
> +       const char              *metrics_file;
>         struct stats            *walltime_nsecs_stats;
>         struct rusage            ru_data;
>         struct perf_cpu_map             *aggr_map;
> --
> 2.25.4
>
