Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2031C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707BA20672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV0BJ9dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGOVNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:13:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726929AbgGOVNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594847620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdMRdm6egSWyWBEKkyFj3q3OxoU4alwAcP1Td/hH5vc=;
        b=bV0BJ9dV+6UhFxEoYyOpFP/7vqblxe1skwvGs05OqnHJM4lijgB2/QzR26oy1VjuE8fD1B
        YVLzdEH6iYguwFN11yKoiKPUDO0GTDm2tMPgM5sEZKfreFrSrNy5K9i4vU8coIrgG8KOS5
        tvE4OZ6u8FKD6Z50Vup/ws+C6F4Xlik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-uM95gTZhOb61h5k9j6KTYA-1; Wed, 15 Jul 2020 17:13:36 -0400
X-MC-Unique: uM95gTZhOb61h5k9j6KTYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 891271083;
        Wed, 15 Jul 2020 21:13:34 +0000 (UTC)
Received: from krava (unknown [10.40.194.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6F8E82C24F;
        Wed, 15 Jul 2020 21:13:31 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:13:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH 09/18] perf metric: Collect referenced metrics in struct
 metric_ref_node
Message-ID: <20200715211330.GR183694@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-10-jolsa@kernel.org>
 <CAP-5=fUa0TKW5U3hivu4HMi+9s+9BEygPhGUNRDM-oAH-BOSsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUa0TKW5U3hivu4HMi+9s+9BEygPhGUNRDM-oAH-BOSsw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 05:07:04PM -0700, Ian Rogers wrote:
> On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
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
> > ---
> >  tools/perf/util/metricgroup.c | 147 ++++++++++++++++++++++++++++++----
> >  1 file changed, 132 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index f0b0a053bfd2..9923eef1e2d4 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -102,12 +102,20 @@ void metricgroup__rblist_exit(struct rblist *metric_events)
> >         rblist__exit(metric_events);
> >  }
> >
> > +struct metric_ref_node {
> > +       const char *metric_name;
> > +       const char *metric_expr;
> > +       struct list_head list;
> > +};
> 
> Perhaps a comment like this above:
> /* A node in the list of referenced metrics. metric_expr is held as a
> convenience to avoid a search through the metric list. */

sounds good

> 
> > +
> >  struct egroup {
> >         struct list_head nd;
> >         struct expr_parse_ctx pctx;
> >         const char *metric_name;
> >         const char *metric_expr;
> >         const char *metric_unit;
> > +       struct list_head refs;
> > +       int refs_cnt;
> 
> A comment would be nice here as refs is a pretty overloaded term. For
> example, is refs_cnt a reference count for memory management or the
> length of the refs list? I'm unpopular and would use a long variable
> name here of something like referenced_metrics for the list.

how about metric_refs ? ;-)

> 
> >         int runtime;
> >         bool has_constraint;
> >  };
> > @@ -574,27 +582,66 @@ int __weak arch_get_runtimeparam(void)
> >  static int __add_metric(struct list_head *group_list,
> >                         struct pmu_event *pe,
> >                         bool metric_no_group,
> > -                       int runtime)
> > +                       int runtime,
> > +                       struct egroup **egp)
> 
> Rather than egp perhaps parent_eg or parent_metric?

I'm changing that later on, but perhaps not to parent_metric,
which sounds good, I'll check

> 
> >  {
> > +       struct metric_ref_node *ref;
> >         struct egroup *eg;
> >
> > -       eg = malloc(sizeof(*eg));
> > -       if (!eg)
> > -               return -ENOMEM;
> > +       if (*egp == NULL) {
> > +               /*
> > +                * We got in here for the master group,
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
> > +               INIT_LIST_HEAD(&eg->refs);
> > +               eg->refs_cnt = 0;
> > +               *egp = eg;
> > +       } else {
> > +               /*
> > +                * We got here for the referenced metric, via the
> > +                * recursive metricgroup__add_metric call, add
> > +                * it to the master group.
> 
> Probably want to avoid the term master here and below:
> https://www.kernel.org/doc/html/latest/process/coding-style.html?highlight=language%20master#naming
> Perhaps parent or referencing metric?

right.. will change

> 
> > +                */
> > +               eg = *egp;
> > +
> > +               ref = malloc(sizeof(*ref));
> > +               if (!ref)
> > +                       return -ENOMEM;
> >
> > -       expr__ctx_init(&eg->pctx);
> > -       eg->metric_name = pe->metric_name;
> > -       eg->metric_expr = pe->metric_expr;
> > -       eg->metric_unit = pe->unit;
> > -       eg->runtime = runtime;
> > -       eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
> > +               ref->metric_name = pe->metric_name;
> > +               ref->metric_expr = pe->metric_expr;
> > +               list_add(&ref->list, &eg->refs);
> > +               eg->refs_cnt++;
> > +               eg->has_constraint |= metricgroup__has_constraint(pe);
> 
> Why not metric_no_group here? Perhaps use a function to avoid
> duplication with the code above.

oops, I think that has_constraint update should not be there at al,
just for the 'parent' metric, thanks!

> 
> > +       }
> >
> > +       /*
> > +        * For both the master and referenced metrics, we parse
> > +        * all the metric's IDs and add it to the parent context.
> > +        */
> >         if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
> >                 expr__ctx_clear(&eg->pctx);
> >                 free(eg);
> >                 return -EINVAL;
> >         }
> >
> > +       /*
> > +        * We add new group only in the 'master' call,
> > +        * so bail out for referenced metric case.
> > +        */
> > +       if (eg->refs_cnt)
> > +               return 0;
> > +
> >         if (list_empty(group_list))
> >                 list_add(&eg->nd, group_list);
> >         else {
> > @@ -636,14 +683,63 @@ static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *
> >
> >  static int add_metric(struct list_head *group_list,
> >                       struct pmu_event *pe,
> > -                     bool metric_no_group)
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
> 
> Does this mean that the ID doesn't need to begin "metric:" to
> reference a different metric as per Andi Kleen's request?

correct, that's why I separated find_metric function earlier,
now I see I did not put this to the changelog :-\ sry

> 
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

SNIP

