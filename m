Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C68C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA622072D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpGn5HgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGOAHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 20:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgGOAHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 20:07:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71177C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 17:07:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so534568wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCsvWHMFwQCkIyblreEWmVYkj4jsb8u3rKO56xByVZs=;
        b=lpGn5HgZbuDP9ylEBUNzc14d7+OMrAfnaiEZH01+vtmc4SBQgn/imHg8LWncE9AnRW
         +UqvO+EGKVepIIvs+nhCSAA6sUwLlyt5CNPiFkfwXkRAOwWCFEgpCziF6jqcpj675seq
         EAbr9XgDqD72LriKwqjE9Z10tkfkWnANIa8SDz6idOvHUzbpXSjloFlttWQfYHNX1K9H
         SVY+FAKPJ6DEDt+vPk/wPsjdlaOb1m9CcH7vFxj+nYjIpQcrWBIEQqsePqEPz8jVQqTU
         RVkB435jX66IukxL4A6y2VRJT6SulwNpxNElhz+Cd5dEw/gsTxBpnUixQDYzlrj8C4nH
         HDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCsvWHMFwQCkIyblreEWmVYkj4jsb8u3rKO56xByVZs=;
        b=kvFJmnawKe4CZM3Gxh45JfA34unvsOb5x2Y7bZPdK4j73MhrbPp14Dq6p6OBAwhDWb
         G4UyR3aC+HwNFefjwmjHW6ynMLfV5AZSiXk6XJAeX++I4nYeOs+zODzEs2zAGJADMPZx
         /oEf1Vp+CpFDIcCAi2PpFwL3qJ1WeGS/BvieWLRJ7NGI39PmfMF/sUwqDO2VnW3rx1uU
         67y/BeZbik5/5e4H8FJ7N3sJCh7tePR2YevmTVB0GKUYj8CnzKwxKSL7c/k1u0A/dnv8
         dzmIbv/ReRIvQ4GEYh01jI3hU+y5UVrYILOH5A9LN0aLZdGqnfEMIbsp0zpvcYpHud9f
         7agg==
X-Gm-Message-State: AOAM531gsuZDIdp5rrw+YGPrL2So5O53+2bk4o0eOF2I9j9IQ9KSGIc+
        Qnl3DYrRQ1UI5YWjvXtRILkVVqKTCbx7pek7uJdiww==
X-Google-Smtp-Source: ABdhPJwznz7DG3lneSkNmhwSYgCLIbBiJRbrvOH4dwTnjKOCexkxOybh1+7N0+QaVdX0BnQDOxDfmBdpUYWpbjkSo3c=
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr8215330wrm.282.1594771635889;
 Tue, 14 Jul 2020 17:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-10-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-10-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jul 2020 17:07:04 -0700
Message-ID: <CAP-5=fUa0TKW5U3hivu4HMi+9s+9BEygPhGUNRDM-oAH-BOSsw@mail.gmail.com>
Subject: Re: [PATCH 09/18] perf metric: Collect referenced metrics in struct metric_ref_node
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
> ---
>  tools/perf/util/metricgroup.c | 147 ++++++++++++++++++++++++++++++----
>  1 file changed, 132 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index f0b0a053bfd2..9923eef1e2d4 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -102,12 +102,20 @@ void metricgroup__rblist_exit(struct rblist *metric_events)
>         rblist__exit(metric_events);
>  }
>
> +struct metric_ref_node {
> +       const char *metric_name;
> +       const char *metric_expr;
> +       struct list_head list;
> +};

Perhaps a comment like this above:
/* A node in the list of referenced metrics. metric_expr is held as a
convenience to avoid a search through the metric list. */

> +
>  struct egroup {
>         struct list_head nd;
>         struct expr_parse_ctx pctx;
>         const char *metric_name;
>         const char *metric_expr;
>         const char *metric_unit;
> +       struct list_head refs;
> +       int refs_cnt;

A comment would be nice here as refs is a pretty overloaded term. For
example, is refs_cnt a reference count for memory management or the
length of the refs list? I'm unpopular and would use a long variable
name here of something like referenced_metrics for the list.

>         int runtime;
>         bool has_constraint;
>  };
> @@ -574,27 +582,66 @@ int __weak arch_get_runtimeparam(void)
>  static int __add_metric(struct list_head *group_list,
>                         struct pmu_event *pe,
>                         bool metric_no_group,
> -                       int runtime)
> +                       int runtime,
> +                       struct egroup **egp)

Rather than egp perhaps parent_eg or parent_metric?

>  {
> +       struct metric_ref_node *ref;
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
> +               INIT_LIST_HEAD(&eg->refs);
> +               eg->refs_cnt = 0;
> +               *egp = eg;
> +       } else {
> +               /*
> +                * We got here for the referenced metric, via the
> +                * recursive metricgroup__add_metric call, add
> +                * it to the master group.

Probably want to avoid the term master here and below:
https://www.kernel.org/doc/html/latest/process/coding-style.html?highlight=language%20master#naming
Perhaps parent or referencing metric?

> +                */
> +               eg = *egp;
> +
> +               ref = malloc(sizeof(*ref));
> +               if (!ref)
> +                       return -ENOMEM;
>
> -       expr__ctx_init(&eg->pctx);
> -       eg->metric_name = pe->metric_name;
> -       eg->metric_expr = pe->metric_expr;
> -       eg->metric_unit = pe->unit;
> -       eg->runtime = runtime;
> -       eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
> +               ref->metric_name = pe->metric_name;
> +               ref->metric_expr = pe->metric_expr;
> +               list_add(&ref->list, &eg->refs);
> +               eg->refs_cnt++;
> +               eg->has_constraint |= metricgroup__has_constraint(pe);

Why not metric_no_group here? Perhaps use a function to avoid
duplication with the code above.

> +       }
>
> +       /*
> +        * For both the master and referenced metrics, we parse
> +        * all the metric's IDs and add it to the parent context.
> +        */
>         if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
>                 expr__ctx_clear(&eg->pctx);
>                 free(eg);
>                 return -EINVAL;
>         }
>
> +       /*
> +        * We add new group only in the 'master' call,
> +        * so bail out for referenced metric case.
> +        */
> +       if (eg->refs_cnt)
> +               return 0;
> +
>         if (list_empty(group_list))
>                 list_add(&eg->nd, group_list);
>         else {
> @@ -636,14 +683,63 @@ static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *
>
>  static int add_metric(struct list_head *group_list,
>                       struct pmu_event *pe,
> -                     bool metric_no_group)
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

Does this mean that the ID doesn't need to begin "metric:" to
reference a different metric as per Andi Kleen's request?

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
> +static int add_metric(struct list_head *group_list,
> +                     struct pmu_event *pe,
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
> @@ -655,7 +751,7 @@ static int add_metric(struct list_head *group_list,
>                  */
>
>                 for (j = 0; j < count && !ret; j++) {
> -                       ret = __add_metric(group_list, pe, metric_no_group, j);
> +                       ret = __add_metric(group_list, pe, metric_no_group, j, egp);
>                 }
>         }
>
> @@ -666,16 +762,26 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                    struct strbuf *events,
>                                    struct list_head *group_list,
>                                    struct pmu_events_map *map)
> +
>  {
> +       struct egroup *eg = NULL;
>         struct pmu_event *pe;
> -       struct egroup *eg;
>         int ret;
>
>         pe = find_metric(metric, map);
>         if (!pe)
>                 return -EINVAL;
>
> -       ret = add_metric(group_list, pe, metric_no_group);
> +       ret = add_metric(group_list, pe, metric_no_group, &eg);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Process any possible referenced metrics
> +        * included in the expression.
> +        */
> +       ret = resolve_metric(eg, metric_no_group,
> +                            group_list, map);
>         if (ret)
>                 return ret;
>
> @@ -727,11 +833,22 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>         return ret;
>  }
>
> +static void egroup__free_refs(struct egroup *egroup)
> +{
> +       struct metric_ref_node *ref, *tmp;
> +
> +       list_for_each_entry_safe(ref, tmp, &egroup->refs, list) {
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
