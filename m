Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774532067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gj0AI5WM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgGOWGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgGOWGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:06:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE42AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:06:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so4482422wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8m9FtX5eIRxxEGkJ0Lce4REVD7q0EvKZoqbJaoqZRCg=;
        b=Gj0AI5WM4CKBm3PDYivqAZMB4W6NxyoPmVP1C8hpgzYnhlchJ+gFlbzsH3bI1pS06p
         nnz3T045oc0NlLd1U0CwZcAye67cMTrzmNH9T8gCMCCec08D54tCnr/cFDDoypzwHr/p
         jWpFC44A+HURQ1hX42Asx31XXUwkvLn4zFjmNgBSkvX4HbUyC3hFtkP9V7wLoEd4fY2F
         0OjeHPXqpNmAH0ED0G0swZ8cwSL2JS3c3kgnVFWTXkGQVuwRBAKv9QX61AuEJB7sGoIT
         B3x2fRkiAejKYEsW+zRFeYmmmHsPQg7SylTu5I8LFvH3YSpfhDd8phu7avmqTgNjEvnA
         V/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8m9FtX5eIRxxEGkJ0Lce4REVD7q0EvKZoqbJaoqZRCg=;
        b=qyWMI3/XeB/fuYrijXIbi4K9ywZfQUQdBo5j/fwIiNf5pZIjoIeHBSNC7KHkjmeXCl
         JqUwPPwgiEMTlH7IV+QXUSJZ+vam2twHr6Qq/jNJgT8P0JuCrB6N8M0wowd7bABWrFBg
         1RzcDgbP+OuURicewzRlwKaFAi/OX1Lhmod+GT2IZcIDo2ulf1h8F6mMqbPfzQLo5VR2
         QGrspKQbckcbQOrsewUdZ3WOn9ZUyrCYQq6n01aMJO7P5bwiH9fPyVObZV0RR3jrZSPS
         tDtBZrOI+5aLnhPoOMPBw8sUk7x4KYY9JiUr4WJMwCHleUD0G5t3gnolk92yk3AT3WMA
         ECdw==
X-Gm-Message-State: AOAM533g56H4PTSflEd7eFOvoRtGcd7iA29TucsKRjF3TiKoTSHwL4bF
        cp1fGtBAmTWXoFSfL/buOzvoAUVpLYcQFmPDMGFW6w==
X-Google-Smtp-Source: ABdhPJydpxJSwZCpcK5GzBu9Hh0c/sExF8OFyRybZH100bBeOXYAkAPeAJtXipM2g1Saz7xMy6g3jTNerPIQsazbt6g=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr1785463wrm.271.1594850771094;
 Wed, 15 Jul 2020 15:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-10-jolsa@kernel.org>
 <CAP-5=fUa0TKW5U3hivu4HMi+9s+9BEygPhGUNRDM-oAH-BOSsw@mail.gmail.com> <20200715211330.GR183694@krava>
In-Reply-To: <20200715211330.GR183694@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jul 2020 15:05:59 -0700
Message-ID: <CAP-5=fUX0Lk0nw2SaeBf3+_-3tWr-gbJT0t3ADmat2o5Ax1iuQ@mail.gmail.com>
Subject: Re: [PATCH 09/18] perf metric: Collect referenced metrics in struct metric_ref_node
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Wed, Jul 15, 2020 at 2:13 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jul 14, 2020 at 05:07:04PM -0700, Ian Rogers wrote:
> > On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Collecting referenced metrics in struct metric_ref_node object,
> > > so we can process them later on.
> > >
> > > The change will parse nested metric names out of expression and
> > > 'resolve' them.
> > >
> > > All referenced metrics are dissolved into one context, meaning all
> > > nested metrics events and added to the parent context.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/metricgroup.c | 147 ++++++++++++++++++++++++++++++----
> > >  1 file changed, 132 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > > index f0b0a053bfd2..9923eef1e2d4 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -102,12 +102,20 @@ void metricgroup__rblist_exit(struct rblist *metric_events)
> > >         rblist__exit(metric_events);
> > >  }
> > >
> > > +struct metric_ref_node {
> > > +       const char *metric_name;
> > > +       const char *metric_expr;
> > > +       struct list_head list;
> > > +};
> >
> > Perhaps a comment like this above:
> > /* A node in the list of referenced metrics. metric_expr is held as a
> > convenience to avoid a search through the metric list. */
>
> sounds good
>
> >
> > > +
> > >  struct egroup {
> > >         struct list_head nd;
> > >         struct expr_parse_ctx pctx;
> > >         const char *metric_name;
> > >         const char *metric_expr;
> > >         const char *metric_unit;
> > > +       struct list_head refs;
> > > +       int refs_cnt;
> >
> > A comment would be nice here as refs is a pretty overloaded term. For
> > example, is refs_cnt a reference count for memory management or the
> > length of the refs list? I'm unpopular and would use a long variable
> > name here of something like referenced_metrics for the list.
>
> how about metric_refs ? ;-)

Sounds great, thanks!
Ian

> >
> > >         int runtime;
> > >         bool has_constraint;
> > >  };
> > > @@ -574,27 +582,66 @@ int __weak arch_get_runtimeparam(void)
> > >  static int __add_metric(struct list_head *group_list,
> > >                         struct pmu_event *pe,
> > >                         bool metric_no_group,
> > > -                       int runtime)
> > > +                       int runtime,
> > > +                       struct egroup **egp)
> >
> > Rather than egp perhaps parent_eg or parent_metric?
>
> I'm changing that later on, but perhaps not to parent_metric,
> which sounds good, I'll check
>
> >
> > >  {
> > > +       struct metric_ref_node *ref;
> > >         struct egroup *eg;
> > >
> > > -       eg = malloc(sizeof(*eg));
> > > -       if (!eg)
> > > -               return -ENOMEM;
> > > +       if (*egp == NULL) {
> > > +               /*
> > > +                * We got in here for the master group,
> > > +                * allocate it and put it on the list.
> > > +                */
> > > +               eg = malloc(sizeof(*eg));
> > > +               if (!eg)
> > > +                       return -ENOMEM;
> > > +
> > > +               expr__ctx_init(&eg->pctx);
> > > +               eg->metric_name = pe->metric_name;
> > > +               eg->metric_expr = pe->metric_expr;
> > > +               eg->metric_unit = pe->unit;
> > > +               eg->runtime = runtime;
> > > +               eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
> > > +               INIT_LIST_HEAD(&eg->refs);
> > > +               eg->refs_cnt = 0;
> > > +               *egp = eg;
> > > +       } else {
> > > +               /*
> > > +                * We got here for the referenced metric, via the
> > > +                * recursive metricgroup__add_metric call, add
> > > +                * it to the master group.
> >
> > Probably want to avoid the term master here and below:
> > https://www.kernel.org/doc/html/latest/process/coding-style.html?highlight=language%20master#naming
> > Perhaps parent or referencing metric?
>
> right.. will change
>
> >
> > > +                */
> > > +               eg = *egp;
> > > +
> > > +               ref = malloc(sizeof(*ref));
> > > +               if (!ref)
> > > +                       return -ENOMEM;
> > >
> > > -       expr__ctx_init(&eg->pctx);
> > > -       eg->metric_name = pe->metric_name;
> > > -       eg->metric_expr = pe->metric_expr;
> > > -       eg->metric_unit = pe->unit;
> > > -       eg->runtime = runtime;
> > > -       eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
> > > +               ref->metric_name = pe->metric_name;
> > > +               ref->metric_expr = pe->metric_expr;
> > > +               list_add(&ref->list, &eg->refs);
> > > +               eg->refs_cnt++;
> > > +               eg->has_constraint |= metricgroup__has_constraint(pe);
> >
> > Why not metric_no_group here? Perhaps use a function to avoid
> > duplication with the code above.
>
> oops, I think that has_constraint update should not be there at al,
> just for the 'parent' metric, thanks!
>
> >
> > > +       }
> > >
> > > +       /*
> > > +        * For both the master and referenced metrics, we parse
> > > +        * all the metric's IDs and add it to the parent context.
> > > +        */
> > >         if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
> > >                 expr__ctx_clear(&eg->pctx);
> > >                 free(eg);
> > >                 return -EINVAL;
> > >         }
> > >
> > > +       /*
> > > +        * We add new group only in the 'master' call,
> > > +        * so bail out for referenced metric case.
> > > +        */
> > > +       if (eg->refs_cnt)
> > > +               return 0;
> > > +
> > >         if (list_empty(group_list))
> > >                 list_add(&eg->nd, group_list);
> > >         else {
> > > @@ -636,14 +683,63 @@ static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *
> > >
> > >  static int add_metric(struct list_head *group_list,
> > >                       struct pmu_event *pe,
> > > -                     bool metric_no_group)
> > > +                     bool metric_no_group,
> > > +                     struct egroup **egp);
> > > +
> > > +static int resolve_metric(struct egroup *eg,
> > > +                         bool metric_no_group,
> > > +                         struct list_head *group_list,
> > > +                         struct pmu_events_map *map)
> > > +{
> > > +       struct hashmap_entry *cur;
> > > +       size_t bkt;
> > > +       bool all;
> > > +       int ret;
> > > +
> > > +       /*
> > > +        * Iterate all the parsed IDs and if there's metric,
> > > +        * add it to the context.
> > > +        */
> >
> > Does this mean that the ID doesn't need to begin "metric:" to
> > reference a different metric as per Andi Kleen's request?
>
> correct, that's why I separated find_metric function earlier,
> now I see I did not put this to the changelog :-\ sry
>
> >
> > > +       do {
> > > +               all = true;
> > > +               hashmap__for_each_entry((&eg->pctx.ids), cur, bkt) {
> > > +                       struct pmu_event *pe;
> > > +
> > > +                       pe = find_metric(cur->key, map);
> > > +                       if (!pe)
> > > +                               continue;
> > > +
> > > +                       all = false;
> > > +                       /* The metric key itself needs to go out.. */
> > > +                       expr__del_id(&eg->pctx, cur->key);
> > > +
> > > +                       /* ... and it gets resolved to the parent context. */
> > > +                       ret = add_metric(group_list, pe, metric_no_group, &eg);
> > > +                       if (ret)
> > > +                               return ret;
> > > +
> > > +                       /*
> > > +                        * We added new metric to hashmap, so we need
> > > +                        * to break the iteration and start over.
> > > +                        */
> > > +                       break;
> > > +               }
> > > +       } while (!all);
> > > +
> > > +       return 0;
> > > +}
>
> SNIP
>
