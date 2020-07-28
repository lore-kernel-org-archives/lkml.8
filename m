Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF53C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F46C2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939494;
	bh=26Bck7TTqY0hKNpLT4A7totx/TZUfntY69zkOdcBjF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fLPhV73JkvGTjLtJjUjgsExutrNh25HEfwGTrUx72n0Xna4aX2Hj4WPcwn650PHWT
	 USViW0xWMBD+lNFn4CYQonRMIU7ycDeCKJwoGVPC0MDPhoUDskVSwDmOllQIsT2iWa
	 kLz5gsj+pJCM6SmOdLFYTPX+AIFwjuGW8OLykkrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgG1Mbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbgG1Mbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:31:32 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB72206D4;
        Tue, 28 Jul 2020 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939491;
        bh=26Bck7TTqY0hKNpLT4A7totx/TZUfntY69zkOdcBjF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mia2CpAQZGjKd8JapdUOft7Oz2bLnH38tkoH741u5R/VwfKd57c5d1SkmgpU5+rai
         CRdGaGbcMLV+qicLjCqEfg0j5LQ/r3easszlWqeHdsVXuDeDROhZW8oXzqYhCF+Eo4
         pYGPuFHz/bmj86cKHORruL9rjt5KSF/3Lctzhgww=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 81445404B1; Tue, 28 Jul 2020 09:31:27 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:31:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH 08/19] perf metric: Collect referenced metrics in struct
 metric_ref_node
Message-ID: <20200728123127.GO40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-9-jolsa@kernel.org>
 <CAP-5=fW59n2_GXVvcfmwiOHks3OWjvB=Et5wqh1a8zupEZci+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW59n2_GXVvcfmwiOHks3OWjvB=Et5wqh1a8zupEZci+w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 19, 2020 at 03:18:58PM -0700, Ian Rogers escreveu:
> On Sun, Jul 19, 2020 at 11:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Collecting referenced metrics in struct metric_ref_node object,
> > so we can process them later on.
> >
> > The change will parse nested metric names out of expression and
> > 'resolve' them.
> >
> > All referenced metrics are dissolved into one context, meaning all
> > nested metrics events and added to the parent context.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/metricgroup.c | 170 +++++++++++++++++++++++++++++++---
> >  1 file changed, 156 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index ccd80538a6ae..d1b2c1aa436f 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -102,12 +102,25 @@ void metricgroup__rblist_exit(struct rblist *metric_events)
> >         rblist__exit(metric_events);
> >  }
> >
> > +/*
> > + * A node in the list of referenced metrics. metric_expr
> > + * is held as a convenience to avoid a search through the
> > + * metric list.
> > + */
> > +struct metric_ref_node {
> > +       const char *metric_name;
> > +       const char *metric_expr;
> > +       struct list_head list;
> > +};
> > +
> >  struct egroup {
> >         struct list_head nd;
> >         struct expr_parse_ctx pctx;
> >         const char *metric_name;
> >         const char *metric_expr;
> >         const char *metric_unit;
> > +       struct list_head metric_refs;
> > +       int metric_refs_cnt;
> >         int runtime;
> >         bool has_constraint;
> >  };
> > @@ -574,27 +587,72 @@ int __weak arch_get_runtimeparam(void)
> >  static int __add_metric(struct list_head *group_list,
> >                         struct pmu_event *pe,
> >                         bool metric_no_group,
> > -                       int runtime)
> > +                       int runtime,
> > +                       struct egroup **egp)
> >  {
> > +       struct metric_ref_node *ref;
> >         struct egroup *eg;
> >
> > -       eg = malloc(sizeof(*eg));
> > -       if (!eg)
> > -               return -ENOMEM;
> > +       if (*egp == NULL) {
> > +               /*
> > +                * We got in here for the parent group,
> > +                * allocate it and put it on the list.
> > +                */
> > +               eg = malloc(sizeof(*eg));
> > +               if (!eg)
> > +                       return -ENOMEM;
> > +
> > +               expr__ctx_init(&eg->pctx);
> > +               eg->metric_name = pe->metric_name;
> > +               eg->metric_expr = pe->metric_expr;
> > +               eg->metric_unit = pe->unit;
> > +               eg->runtime = runtime;
> > +               eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
> > +               INIT_LIST_HEAD(&eg->metric_refs);
> > +               eg->metric_refs_cnt = 0;
> > +               *egp = eg;
> > +       } else {
> > +               /*
> > +                * We got here for the referenced metric, via the
> > +                * recursive metricgroup__add_metric call, add
> > +                * it to the parent group.
> > +                */
> > +               eg = *egp;
> > +
> > +               ref = malloc(sizeof(*ref));
> > +               if (!ref)
> > +                       return -ENOMEM;
> > +
> > +               /*
> > +                * Intentionally passing just const char pointers,
> > +                * from 'pe' object, so they never go away. We don't
> > +                * need to change them, so there's no need to create
> > +                * our own copy.
> > +                */
> > +               ref->metric_name = pe->metric_name;
> > +               ref->metric_expr = pe->metric_expr;
> >
> > -       expr__ctx_init(&eg->pctx);
> > -       eg->metric_name = pe->metric_name;
> > -       eg->metric_expr = pe->metric_expr;
> > -       eg->metric_unit = pe->unit;
> > -       eg->runtime = runtime;
> > -       eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
> > +               list_add(&ref->list, &eg->metric_refs);
> > +               eg->metric_refs_cnt++;
> > +       }
> >
> > +       /*
> > +        * For both the parent and referenced metrics, we parse
> > +        * all the metric's IDs and add it to the parent context.
> > +        */
> >         if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
> >                 expr__ctx_clear(&eg->pctx);
> >                 free(eg);
> >                 return -EINVAL;
> >         }
> >
> > +       /*
> > +        * We add new group only in the 'parent' call,
> > +        * so bail out for referenced metric case.
> > +        */
> > +       if (eg->metric_refs_cnt)
> > +               return 0;
> > +
> >         if (list_empty(group_list))
> >                 list_add(&eg->nd, group_list);
> >         else {
> > @@ -625,16 +683,78 @@ static int __add_metric(struct list_head *group_list,
> >                     (match_metric(__pe->metric_group, __metric) ||      \
> >                      match_metric(__pe->metric_name, __metric)))
> >
> > +static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
> > +{
> > +       struct pmu_event *pe;
> > +       int i;
> > +
> > +       map_for_each_event(pe, i, map) {
> > +               if (match_metric(pe->metric_name, metric))
> > +                       return pe;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +static int add_metric(struct list_head *group_list,
> > +                     struct pmu_event *pe,
> > +                     bool metric_no_group,
> > +                     struct egroup **egp);
> > +
> > +static int resolve_metric(struct egroup *eg,
> > +                         bool metric_no_group,
> > +                         struct list_head *group_list,
> > +                         struct pmu_events_map *map)
> > +{
> > +       struct hashmap_entry *cur;
> > +       size_t bkt;
> > +       bool all;
> > +       int ret;
> > +
> > +       /*
> > +        * Iterate all the parsed IDs and if there's metric,
> > +        * add it to the context.
> > +        */
> > +       do {
> > +               all = true;
> > +               hashmap__for_each_entry((&eg->pctx.ids), cur, bkt) {
> > +                       struct pmu_event *pe;
> > +
> > +                       pe = find_metric(cur->key, map);
> > +                       if (!pe)
> > +                               continue;
> > +
> > +                       all = false;
> > +                       /* The metric key itself needs to go out.. */
> > +                       expr__del_id(&eg->pctx, cur->key);
> > +
> > +                       /* ... and it gets resolved to the parent context. */
> > +                       ret = add_metric(group_list, pe, metric_no_group, &eg);
> > +                       if (ret)
> > +                               return ret;
> > +
> > +                       /*
> > +                        * We added new metric to hashmap, so we need
> > +                        * to break the iteration and start over.
> > +                        */
> > +                       break;
> > +               }
> > +       } while (!all);
> > +
> > +       return 0;
> > +}
> > +
> >  static int add_metric(struct list_head *group_list,
> >                       struct pmu_event *pe,
> > -                     bool metric_no_group)
> > +                     bool metric_no_group,
> > +                     struct egroup **egp)
> >  {
> >         int ret = 0;
> >
> >         pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> >
> >         if (!strstr(pe->metric_expr, "?")) {
> > -               ret = __add_metric(group_list, pe, metric_no_group, 1);
> > +               ret = __add_metric(group_list, pe, metric_no_group, 1, egp);
> >         } else {
> >                 int j, count;
> >
> > @@ -646,7 +766,7 @@ static int add_metric(struct list_head *group_list,
> >                  */
> >
> >                 for (j = 0; j < count && !ret; j++) {
> > -                       ret = __add_metric(group_list, pe, metric_no_group, j);
> > +                       ret = __add_metric(group_list, pe, metric_no_group, j, egp);
> >                 }
> >         }
> >
> > @@ -657,6 +777,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >                                    struct strbuf *events,
> >                                    struct list_head *group_list,
> >                                    struct pmu_events_map *map)
> > +
> >  {
> >         struct pmu_event *pe;
> >         struct egroup *eg;
> > @@ -665,8 +786,18 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >
> >         map_for_each_metric(pe, i, map, metric) {
> >                 has_match = true;
> > +               eg = NULL;
> >
> > -               ret = add_metric(group_list, pe, metric_no_group);
> > +               ret = add_metric(group_list, pe, metric_no_group, &eg);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               /*
> > +                * Process any possible referenced metrics
> > +                * included in the expression.
> > +                */
> > +               ret = resolve_metric(eg, metric_no_group,
> > +                                    group_list, map);
> >                 if (ret)
> >                         return ret;
> >         }
> > @@ -723,11 +854,22 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
> >         return ret;
> >  }
> >
> > +static void egroup__free_refs(struct egroup *egroup)
> > +{
> > +       struct metric_ref_node *ref, *tmp;
> > +
> > +       list_for_each_entry_safe(ref, tmp, &egroup->metric_refs, list) {
> > +               list_del(&ref->list);
> > +               free(ref);
> > +       }
> > +}
> > +
> >  static void metricgroup__free_egroups(struct list_head *group_list)
> >  {
> >         struct egroup *eg, *egtmp;
> >
> >         list_for_each_entry_safe (eg, egtmp, group_list, nd) {
> > +               egroup__free_refs(eg);
> >                 expr__ctx_clear(&eg->pctx);
> >                 list_del_init(&eg->nd);
> >                 free(eg);
> > --
> > 2.25.4
> >

-- 

- Arnaldo
