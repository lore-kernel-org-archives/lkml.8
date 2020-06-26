Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C15DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4922208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2MeQhJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgFZVsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:48:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234B5C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:48:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so7829548wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbgVIy+gHOSYoZc+w0PMsyvazFnil6UWhidHPS3x4Is=;
        b=a2MeQhJHqT3jUC304EFlZMhJDf06S1o/Gh2Q/D2HdkLzgwz8/9hEzsJWSYHyaWrfDZ
         XrtsmSwNa6ZGjHwgApf+I3LijyQD3/sMur4hRomvufg7SnDc6XsZhgu/gUobLyxLrh4v
         vDzR+vgplvYwLwVg3HSn4GA5zgMoTK2pcW9F9JMRAfQkdN1AWw9qskelVhlaH09YGgAB
         LP52s0A+m1RNr5HK2ZjEzL56TwVjL46Ipha0PTOl5mFL6UfxayOyualsZ8+rNc/1mOnw
         Q+SMg1i73EW7657K5reIRW4AbUUEMyXB+FPGfy6I4zdhAd2drm5aw9onpe5eD1HRGGF6
         OXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbgVIy+gHOSYoZc+w0PMsyvazFnil6UWhidHPS3x4Is=;
        b=keQlfA5vIap5NeHqlpXoV6GknfJUTaTYvEge3nJind9sEZCBW3exLmy6jkTpHlmWpA
         lNwg+SfkVZUDpDJ4Uf36byQHT20bgKsNRjSrMiVkieZqnAeqrglUJz8Zy1J8XKmWaBUK
         iPbFJysyHmTiWqxd07dqLl9Tm7Z4uuD2B/jMytmKMoHkDDr96CIr+uKW6Tfg3KghbzLF
         NduY5beQmBblnO4xZTcbJxC+4Egu9RMDrOCfpjUnJrkYDvwC2pCxiXN6a9WYbGTeRLJg
         3pwGxbuv8r4hgM/5wABqpfO6TQym+mCwcNwgu7hiMBPH5OYpUIArwV133lvynVhlPm9M
         4E4A==
X-Gm-Message-State: AOAM532s5qvpO2x1UJbGCrV2WzTUJsEGcJLlf9ODXLqrvUoXZxHKf7C4
        mDDBpP7FZoZsmv7mBdmVDFHqP6Vcinum/6JTYtqyjQ==
X-Google-Smtp-Source: ABdhPJxl/Wi/+ZpB6zqcJtveO8/So0Gqtgu0Y3RYcdyXgiHu2OwMacmsaXWRye3OaoXa4BKNWDvUiFWlPOu+WUMN9Lk=
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr5540672wrn.48.1593208094521;
 Fri, 26 Jun 2020 14:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-7-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-7-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jun 2020 14:48:02 -0700
Message-ID: <CAP-5=fWJGGPCx4Rk_5UXLjDjQ3fLzzPO-gnRtPGV2GWoNLzL=w@mail.gmail.com>
Subject: Re: [PATCH 06/10] perf tools: Collect other metrics in struct egroup
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

On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Collecting other metrics in struct egroup object,
> so we can process them later on.
>
> The change will parse or 'other' metric names out of
> expression and 'resolve' them.
>
> Every used expression needs to have 'metric:' prefix,
> like:
>   cache_miss_cycles = metric:dcache_miss_cpi + metric:icache_miss_cycles
>
> All 'other' metrics are disolved into one context,
> meaning all 'other' metrics events and addded to
> the parent context.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../arch/x86/skylake/skl-metrics.json         |   2 +-
>  tools/perf/util/expr.c                        |  11 ++
>  tools/perf/util/expr.h                        |   1 +
>  tools/perf/util/metricgroup.c                 | 158 ++++++++++++++++--
>  4 files changed, 157 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> index 8704efeb8d31..71e5a2b471ac 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> @@ -57,7 +57,7 @@
>      },
>      {
>          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> +        "MetricExpr": "1/metric:CPI",
>          "MetricGroup": "TopDownL1",
>          "MetricName": "IPC"
>      },
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index aa14c7111ecc..cd73dae4588c 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -150,3 +150,14 @@ int expr__find_other(const char *expr, const char *one,
>
>         return ret;
>  }
> +
> +#define METRIC "metric:"
> +
> +bool expr__is_metric(const char *name, const char **metric)
> +{
> +       int ret = !strncmp(name, METRIC, sizeof(METRIC) - 1);
> +
> +       if (ret && metric)
> +               *metric = name + sizeof(METRIC) - 1;
> +       return ret;
> +}

Should expr.l recognize metric:... as a different kind of token rather
than an ID?

Thanks,
Ian

> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 1a76b002c576..fd924bb4e5cd 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -35,5 +35,6 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
>                 const char *expr, int runtime);
>  int expr__find_other(const char *expr, const char *one,
>                 struct expr_parse_ctx *ids, int runtime);
> +bool expr__is_metric(const char *name, const char **metric);
>
>  #endif
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 85e7fa2e2707..f88fd667cc78 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -102,12 +102,20 @@ void metricgroup__rblist_exit(struct rblist *metric_events)
>         rblist__exit(metric_events);
>  }
>
> +struct eother {
> +       const char *metric_name;
> +       const char *metric_expr;
> +       struct list_head list;
> +};
> +
>  struct egroup {
>         struct list_head nd;
>         struct expr_parse_ctx pctx;
>         const char *metric_name;
>         const char *metric_expr;
>         const char *metric_unit;
> +       struct list_head other;
> +       int other_cnt;
>         int runtime;
>         bool has_constraint;
>  };
> @@ -574,27 +582,66 @@ int __weak arch_get_runtimeparam(void)
>  static int __metricgroup__add_metric(struct list_head *group_list,
>                                      struct pmu_event *pe,
>                                      bool metric_no_group,
> -                                    int runtime)
> +                                    int runtime,
> +                                    struct egroup **egp)
>  {
> +       struct eother *eo;
>         struct egroup *eg;
>
> -       eg = malloc(sizeof(*eg));
> -       if (!eg)
> -               return -ENOMEM;
> +       if (*egp == NULL) {
> +               /*
> +                * We got in here for the master group,
> +                * allocate it and put it on the list.
> +                */
> +               eg = malloc(sizeof(*eg));
> +               if (!eg)
> +                       return -ENOMEM;
> +
> +               expr__ctx_init(&eg->pctx);
> +               eg->metric_name = pe->metric_name;
> +               eg->metric_expr = pe->metric_expr;
> +               eg->metric_unit = pe->unit;
> +               eg->runtime = runtime;
> +               eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
> +               INIT_LIST_HEAD(&eg->other);
> +               eg->other_cnt = 0;
> +               *egp = eg;
> +       } else {
> +               /*
> +                * We got here for the 'other' metric, via the
> +                * recursive metricgroup__add_metric call, add
> +                * it to the master group.
> +                */
> +               eg = *egp;
>
> -       expr__ctx_init(&eg->pctx);
> -       eg->metric_name = pe->metric_name;
> -       eg->metric_expr = pe->metric_expr;
> -       eg->metric_unit = pe->unit;
> -       eg->runtime = runtime;
> -       eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
> +               eo = malloc(sizeof(*eo));
> +               if (!eo)
> +                       return -ENOMEM;
>
> +               eo->metric_name = pe->metric_name;
> +               eo->metric_expr = pe->metric_expr;
> +               list_add(&eo->list, &eg->other);
> +               eg->other_cnt++;
> +               eg->has_constraint |= metricgroup__has_constraint(pe);
> +       }
> +
> +       /*
> +        * For both the master and other metrics, we parse all
> +        * the metric's IDs and add it to the parent context.
> +        */
>         if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
>                 expr__ctx_clear(&eg->pctx);
>                 free(eg);
>                 return -EINVAL;
>         }
>
> +       /*
> +        * We add new group only in the 'master' call,
> +        * so bail out for 'other' metric case.
> +        */
> +       if (eg->other_cnt)
> +               return 0;
> +
>         if (list_empty(group_list))
>                 list_add(&eg->nd, group_list);
>         else {
> @@ -617,12 +664,67 @@ static int __metricgroup__add_metric(struct list_head *group_list,
>  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                    struct strbuf *events,
>                                    struct list_head *group_list,
> -                                  struct pmu_events_map *map)
> +                                  struct pmu_events_map *map,
> +                                  struct egroup *egp);
> +
> +static int resolve_group(struct egroup *eg,
> +                        bool metric_no_group,
> +                        struct strbuf *events,
> +                        struct list_head *group_list,
> +                        struct pmu_events_map *map)
> +{
> +       struct hashmap_entry *cur;
> +       size_t bkt;
> +       bool all;
> +       int ret;
> +
> +       /*
> +        * Iterate all the parsed IDs and if there's metric,
> +        * add it to the same context - recursive call to
> +        * metricgroup__add_metric and remove the metric ID
> +        * from the context.
> +        */
> +       do {
> +               all = true;
> +               hashmap__for_each_entry((&eg->pctx.ids), cur, bkt) {
> +                       const char *name;
> +                       char *m;
> +
> +                       if (!expr__is_metric(cur->key, &name))
> +                               continue;
> +
> +                       all = false;
> +
> +                       m = strdup(name);
> +                       if (!m)
> +                               return -ENOMEM;
> +
> +                       /* The metric:* key itself needs to go out.. */
> +                       expr__del_id(&eg->pctx, cur->key);
> +
> +                       /* ... and it gets resolved to the parent context. */
> +                       ret = metricgroup__add_metric(m, metric_no_group, events,
> +                                                     group_list, map, eg);
> +                       if (ret)
> +                               return ret;
> +                       break;
> +               }
> +       } while (!all);
> +
> +       return 0;
> +}
> +
> +static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> +                                  struct strbuf *events,
> +                                  struct list_head *group_list,
> +                                  struct pmu_events_map *map,
> +                                  struct egroup *egp)
>  {
>         struct pmu_event *pe;
>         struct egroup *eg;
>         int i, ret;
>         bool has_match = false;
> +       bool base = egp == NULL;
>
>         for (i = 0; ; i++) {
>                 pe = &map->table[i];
> @@ -644,7 +746,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                 ret = __metricgroup__add_metric(group_list,
>                                                                 pe,
>                                                                 metric_no_group,
> -                                                               1);
> +                                                               1, &egp);
>                                 if (ret)
>                                         return ret;
>                         } else {
> @@ -660,13 +762,30 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                 for (j = 0; j < count; j++) {
>                                         ret = __metricgroup__add_metric(
>                                                 group_list, pe,
> -                                               metric_no_group, j);
> +                                               metric_no_group, j, &egp);
>                                         if (ret)
>                                                 return ret;
>                                 }
>                         }
> +
> +                       /*
> +                        * Process any possible other metrics
> +                        * included in the expression.
> +                        */
> +                       ret = resolve_group(egp, metric_no_group, events,
> +                                           group_list, map);
> +                       if (ret)
> +                               return ret;
>                 }
>         }
> +
> +       /*
> +        * All the IDs are added to the base context,
> +        * so we add events only in the 'base' call.
> +        */
> +       if (!base)
> +               return 0;
> +
>         list_for_each_entry(eg, group_list, nd) {
>                 if (events->len > 0)
>                         strbuf_addf(events, ",");
> @@ -700,7 +819,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>
>         while ((p = strsep(&llist, ",")) != NULL) {
>                 ret = metricgroup__add_metric(p, metric_no_group, events,
> -                                             group_list, map);
> +                                             group_list, map, NULL);
>                 if (ret == -EINVAL) {
>                         fprintf(stderr, "Cannot find metric or group `%s'\n",
>                                         p);
> @@ -715,11 +834,22 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>         return ret;
>  }
>
> +static void egroup__free_other(struct egroup *egroup)
> +{
> +       struct eother *eo, *oetmp;
> +
> +       list_for_each_entry_safe(eo, oetmp, &egroup->other, list) {
> +               list_del(&eo->list);
> +               free(eo);
> +       }
> +}
> +
>  static void metricgroup__free_egroups(struct list_head *group_list)
>  {
>         struct egroup *eg, *egtmp;
>
>         list_for_each_entry_safe (eg, egtmp, group_list, nd) {
> +               egroup__free_other(eg);
>                 expr__ctx_clear(&eg->pctx);
>                 list_del_init(&eg->nd);
>                 free(eg);
> --
> 2.25.4
>
