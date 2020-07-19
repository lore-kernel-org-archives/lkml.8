Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97936C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679AC207FC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgvYonmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGSWTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGSWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:19:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1A3C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:19:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so23350773wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5qqCynPZ5812JWo8lg+Mv0378GsQVeJSpZEmZbICu8=;
        b=SgvYonmq9kIioRV+j2xUk+rKka/cHwu2O46+N/aMyRfMaqQcUyWl9AUImpMcvu220l
         +zsu/saC3RPdMTYYYaI4m0CaM8diiJfEieHApJ1oIDIb1SQRv+stRqaI9/bBpClRsCcB
         Z03S23GguW4r/TAV/1873qXWLtaniiwrAFvAXSQmURdSgluk2Dog+bG/5kUdxbknwcB+
         fDhiQfmHKsfz+XqsPPHv1/ohU6k/v0jZm/s5fgkS7lpFhLjsJw3Xwmoi6OuZCEgXPCf6
         /H+Qn8dDOsd2pUwmKGEkWDE74rgwZGgjU9Ukl+w1ACwHDH7pzGIzpw3sj3uMoK3Gnrrx
         qfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5qqCynPZ5812JWo8lg+Mv0378GsQVeJSpZEmZbICu8=;
        b=b9r256TZ4ayC5gJGcSR+pd0NXOYUBRalCt7qV6xuHt6beh9xe1yLbDva51peUGjDhB
         6BhRxegC6R85C6uzdz8cFcd0+r9p6yairVpoqe74FYBc+kGwxVwmOOH0WH7Dltx+sMfK
         FBxhb2fgy+DPr4U4cpW+UBXUlLKvoXi3cgvzFWCQl1ABrenkGdYY5CtUgrN3D3r/yiq1
         SwepaCvWm/VPAyKB9JH/+oinT6FU7170q6EgFoMDQFVmkJ52Df6EXTf2dYv8eUAmt/AA
         tX6IeTXBUBtysyo3tzbdRFBn6zp95CWpLXUPvPdNrgwpPKdq7hawN6rV1QmFG83nDaoT
         DDeA==
X-Gm-Message-State: AOAM533Toyb/0PuOTOaBzpKoFeZWu8/3kkixNI1Nn1x+ixl01JuhufAb
        0UngPL2hCwWDqGokgZXKAv8xI8+pYCASP2w2yrDbNA==
X-Google-Smtp-Source: ABdhPJynQyl56c42hOHDdxILS022QMbA21vYFSYUNuYMdfZXKU6Tu8OOwEIJHAY+p2cQgudVv9zveUdrZZqpgBvGGpQ=
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr18272663wmf.87.1595197149855;
 Sun, 19 Jul 2020 15:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200719181320.785305-1-jolsa@kernel.org> <20200719181320.785305-9-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-9-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 19 Jul 2020 15:18:58 -0700
Message-ID: <CAP-5=fW59n2_GXVvcfmwiOHks3OWjvB=Et5wqh1a8zupEZci+w@mail.gmail.com>
Subject: Re: [PATCH 08/19] perf metric: Collect referenced metrics in struct metric_ref_node
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

On Sun, Jul 19, 2020 at 11:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Collecting referenced metrics in struct metric_ref_node object,
> so we can process them later on.
>
> The change will parse nested metric names out of expression and
> 'resolve' them.
>
> All referenced metrics are dissolved into one context, meaning all
> nested metrics events and added to the parent context.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 170 +++++++++++++++++++++++++++++++---
>  1 file changed, 156 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index ccd80538a6ae..d1b2c1aa436f 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -102,12 +102,25 @@ void metricgroup__rblist_exit(struct rblist *metric_events)
>         rblist__exit(metric_events);
>  }
>
> +/*
> + * A node in the list of referenced metrics. metric_expr
> + * is held as a convenience to avoid a search through the
> + * metric list.
> + */
> +struct metric_ref_node {
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
> +       struct list_head metric_refs;
> +       int metric_refs_cnt;
>         int runtime;
>         bool has_constraint;
>  };
> @@ -574,27 +587,72 @@ int __weak arch_get_runtimeparam(void)
>  static int __add_metric(struct list_head *group_list,
>                         struct pmu_event *pe,
>                         bool metric_no_group,
> -                       int runtime)
> +                       int runtime,
> +                       struct egroup **egp)
>  {
> +       struct metric_ref_node *ref;
>         struct egroup *eg;
>
> -       eg = malloc(sizeof(*eg));
> -       if (!eg)
> -               return -ENOMEM;
> +       if (*egp == NULL) {
> +               /*
> +                * We got in here for the parent group,
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
> +               INIT_LIST_HEAD(&eg->metric_refs);
> +               eg->metric_refs_cnt = 0;
> +               *egp = eg;
> +       } else {
> +               /*
> +                * We got here for the referenced metric, via the
> +                * recursive metricgroup__add_metric call, add
> +                * it to the parent group.
> +                */
> +               eg = *egp;
> +
> +               ref = malloc(sizeof(*ref));
> +               if (!ref)
> +                       return -ENOMEM;
> +
> +               /*
> +                * Intentionally passing just const char pointers,
> +                * from 'pe' object, so they never go away. We don't
> +                * need to change them, so there's no need to create
> +                * our own copy.
> +                */
> +               ref->metric_name = pe->metric_name;
> +               ref->metric_expr = pe->metric_expr;
>
> -       expr__ctx_init(&eg->pctx);
> -       eg->metric_name = pe->metric_name;
> -       eg->metric_expr = pe->metric_expr;
> -       eg->metric_unit = pe->unit;
> -       eg->runtime = runtime;
> -       eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
> +               list_add(&ref->list, &eg->metric_refs);
> +               eg->metric_refs_cnt++;
> +       }
>
> +       /*
> +        * For both the parent and referenced metrics, we parse
> +        * all the metric's IDs and add it to the parent context.
> +        */
>         if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
>                 expr__ctx_clear(&eg->pctx);
>                 free(eg);
>                 return -EINVAL;
>         }
>
> +       /*
> +        * We add new group only in the 'parent' call,
> +        * so bail out for referenced metric case.
> +        */
> +       if (eg->metric_refs_cnt)
> +               return 0;
> +
>         if (list_empty(group_list))
>                 list_add(&eg->nd, group_list);
>         else {
> @@ -625,16 +683,78 @@ static int __add_metric(struct list_head *group_list,
>                     (match_metric(__pe->metric_group, __metric) ||      \
>                      match_metric(__pe->metric_name, __metric)))
>
> +static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
> +{
> +       struct pmu_event *pe;
> +       int i;
> +
> +       map_for_each_event(pe, i, map) {
> +               if (match_metric(pe->metric_name, metric))
> +                       return pe;
> +       }
> +
> +       return NULL;
> +}
> +
> +static int add_metric(struct list_head *group_list,
> +                     struct pmu_event *pe,
> +                     bool metric_no_group,
> +                     struct egroup **egp);
> +
> +static int resolve_metric(struct egroup *eg,
> +                         bool metric_no_group,
> +                         struct list_head *group_list,
> +                         struct pmu_events_map *map)
> +{
> +       struct hashmap_entry *cur;
> +       size_t bkt;
> +       bool all;
> +       int ret;
> +
> +       /*
> +        * Iterate all the parsed IDs and if there's metric,
> +        * add it to the context.
> +        */
> +       do {
> +               all = true;
> +               hashmap__for_each_entry((&eg->pctx.ids), cur, bkt) {
> +                       struct pmu_event *pe;
> +
> +                       pe = find_metric(cur->key, map);
> +                       if (!pe)
> +                               continue;
> +
> +                       all = false;
> +                       /* The metric key itself needs to go out.. */
> +                       expr__del_id(&eg->pctx, cur->key);
> +
> +                       /* ... and it gets resolved to the parent context. */
> +                       ret = add_metric(group_list, pe, metric_no_group, &eg);
> +                       if (ret)
> +                               return ret;
> +
> +                       /*
> +                        * We added new metric to hashmap, so we need
> +                        * to break the iteration and start over.
> +                        */
> +                       break;
> +               }
> +       } while (!all);
> +
> +       return 0;
> +}
> +
>  static int add_metric(struct list_head *group_list,
>                       struct pmu_event *pe,
> -                     bool metric_no_group)
> +                     bool metric_no_group,
> +                     struct egroup **egp)
>  {
>         int ret = 0;
>
>         pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>
>         if (!strstr(pe->metric_expr, "?")) {
> -               ret = __add_metric(group_list, pe, metric_no_group, 1);
> +               ret = __add_metric(group_list, pe, metric_no_group, 1, egp);
>         } else {
>                 int j, count;
>
> @@ -646,7 +766,7 @@ static int add_metric(struct list_head *group_list,
>                  */
>
>                 for (j = 0; j < count && !ret; j++) {
> -                       ret = __add_metric(group_list, pe, metric_no_group, j);
> +                       ret = __add_metric(group_list, pe, metric_no_group, j, egp);
>                 }
>         }
>
> @@ -657,6 +777,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                    struct strbuf *events,
>                                    struct list_head *group_list,
>                                    struct pmu_events_map *map)
> +
>  {
>         struct pmu_event *pe;
>         struct egroup *eg;
> @@ -665,8 +786,18 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>
>         map_for_each_metric(pe, i, map, metric) {
>                 has_match = true;
> +               eg = NULL;
>
> -               ret = add_metric(group_list, pe, metric_no_group);
> +               ret = add_metric(group_list, pe, metric_no_group, &eg);
> +               if (ret)
> +                       return ret;
> +
> +               /*
> +                * Process any possible referenced metrics
> +                * included in the expression.
> +                */
> +               ret = resolve_metric(eg, metric_no_group,
> +                                    group_list, map);
>                 if (ret)
>                         return ret;
>         }
> @@ -723,11 +854,22 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>         return ret;
>  }
>
> +static void egroup__free_refs(struct egroup *egroup)
> +{
> +       struct metric_ref_node *ref, *tmp;
> +
> +       list_for_each_entry_safe(ref, tmp, &egroup->metric_refs, list) {
> +               list_del(&ref->list);
> +               free(ref);
> +       }
> +}
> +
>  static void metricgroup__free_egroups(struct list_head *group_list)
>  {
>         struct egroup *eg, *egtmp;
>
>         list_for_each_entry_safe (eg, egtmp, group_list, nd) {
> +               egroup__free_refs(eg);
>                 expr__ctx_clear(&eg->pctx);
>                 list_del_init(&eg->nd);
>                 free(eg);
> --
> 2.25.4
>
