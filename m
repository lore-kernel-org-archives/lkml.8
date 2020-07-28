Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2B2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3172070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939384;
	bh=VB/LWQGIJZs4oQUb9P6Md/HK1rt96WyNZ5+T3ag5OG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SZDhh2tZPCTE98GSaH/Z/NTD0Q3/Y0seetWqHqD02QXw1iza+FcXWcY5tOHyfriWr
	 9uU7oBMDA6Zd79a0v6YmG5FzB9O+8aNFigN4IfRAjGJRDRmA5+rtDsIPLazVWh35V7
	 YmePOUYiuC0tUATlCYNU2JvjhHh1JpDYETJdzSKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgG1M3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbgG1M3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:29:42 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01DA7206D4;
        Tue, 28 Jul 2020 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939382;
        bh=VB/LWQGIJZs4oQUb9P6Md/HK1rt96WyNZ5+T3ag5OG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK9ciowhYnf9gFnbqyXxWqX3cFfbLVxH4hXaJkE5E8aViWMnBbtaW/7imqiDe8/9B
         qcxQwODFAWnVPOiKRoi3VPXCg+ldAFgmRlKtW5BXBu2GVAEAIUBou6aQpcVIIjeM0a
         3z4oZXfgh6YKGK0p0/B2GsWcnYTzjr75cufeaMC8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 22480404B1; Tue, 28 Jul 2020 09:29:40 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:29:40 -0300
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
Subject: Re: [PATCH 05/19] perf metric: Add macros for iterating map events
Message-ID: <20200728122940.GL40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-6-jolsa@kernel.org>
 <CAP-5=fWYOjCSruJ1=c6896zjJe-e-EMKJTrOUcoeo0fED3tk2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWYOjCSruJ1=c6896zjJe-e-EMKJTrOUcoeo0fED3tk2A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 19, 2020 at 02:46:12PM -0700, Ian Rogers escreveu:
> On Sun, Jul 19, 2020 at 11:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding following macros to iterate events and metric:
> >   map_for_each_event(__pe, __idx, __map)
> >     - iterates over all pmu_events_map events
> >   map_for_each_metric(__pe, __idx, __map, __metric)
> >     - iterates over all metrics that match __metric argument
> >
> > and use it in metricgroup__add_metric function. Macros
> > will be be used from other places in following changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
 
> Thanks!
> Ian
> 
> > ---
> >  tools/perf/util/metricgroup.c | 77 ++++++++++++++++++-----------------
> >  1 file changed, 40 insertions(+), 37 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index df0356ec120d..b37008fc253c 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -614,6 +614,17 @@ static int __metricgroup__add_metric(struct list_head *group_list,
> >         return 0;
> >  }
> >
> > +#define map_for_each_event(__pe, __idx, __map)                         \
> > +       for (__idx = 0, __pe = &__map->table[__idx];                    \
> > +            __pe->name || __pe->metric_group || __pe->metric_name;     \
> > +            __pe = &__map->table[++__idx])
> > +
> > +#define map_for_each_metric(__pe, __idx, __map, __metric)              \
> > +       map_for_each_event(__pe, __idx, __map)                          \
> > +               if (__pe->metric_expr &&                                \
> > +                   (match_metric(__pe->metric_group, __metric) ||      \
> > +                    match_metric(__pe->metric_name, __metric)))
> > +
> >  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >                                    struct strbuf *events,
> >                                    struct list_head *group_list,
> > @@ -624,49 +635,41 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >         int i, ret;
> >         bool has_match = false;
> >
> > -       for (i = 0; ; i++) {
> > -               pe = &map->table[i];
> > -
> > -               if (!pe->name && !pe->metric_group && !pe->metric_name) {
> > -                       /* End of pmu events. */
> > -                       if (!has_match)
> > -                               return -EINVAL;
> > -                       break;
> > -               }
> > -               if (!pe->metric_expr)
> > -                       continue;
> > -               if (match_metric(pe->metric_group, metric) ||
> > -                   match_metric(pe->metric_name, metric)) {
> > -                       has_match = true;
> > -                       pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> > -
> > -                       if (!strstr(pe->metric_expr, "?")) {
> > -                               ret = __metricgroup__add_metric(group_list,
> > -                                                               pe,
> > -                                                               metric_no_group,
> > -                                                               1);
> > -                               if (ret)
> > -                                       return ret;
> > -                       } else {
> > -                               int j, count;
> > +       map_for_each_metric(pe, i, map, metric) {
> > +               pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> > +               has_match = true;
> > +
> > +               if (!strstr(pe->metric_expr, "?")) {
> > +                       ret = __metricgroup__add_metric(group_list,
> > +                                                       pe,
> > +                                                       metric_no_group,
> > +                                                       1);
> > +                       if (ret)
> > +                               return ret;
> > +               } else {
> > +                       int j, count;
> >
> > -                               count = arch_get_runtimeparam();
> > +                       count = arch_get_runtimeparam();
> >
> > -                               /* This loop is added to create multiple
> > -                                * events depend on count value and add
> > -                                * those events to group_list.
> > -                                */
> > +                       /* This loop is added to create multiple
> > +                        * events depend on count value and add
> > +                        * those events to group_list.
> > +                        */
> >
> > -                               for (j = 0; j < count; j++) {
> > -                                       ret = __metricgroup__add_metric(
> > -                                               group_list, pe,
> > -                                               metric_no_group, j);
> > -                                       if (ret)
> > -                                               return ret;
> > -                               }
> > +                       for (j = 0; j < count; j++) {
> > +                               ret = __metricgroup__add_metric(
> > +                                       group_list, pe,
> > +                                       metric_no_group, j);
> > +                               if (ret)
> > +                                       return ret;
> >                         }
> >                 }
> >         }
> > +
> > +       /* End of pmu events. */
> > +       if (!has_match)
> > +               return -EINVAL;
> > +
> >         list_for_each_entry(eg, group_list, nd) {
> >                 if (events->len > 0)
> >                         strbuf_addf(events, ",");
> > --
> > 2.25.4
> >

-- 

- Arnaldo
