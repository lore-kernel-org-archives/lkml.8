Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C6CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985622074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939631;
	bh=zCNo22uiKyrwMBQfvgXdj50JSNeFd2xR6b3wPrgUHow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JEMRxkvf8xYiNCAFJPZstnkdMmw9BDWidv8MsyQGF5Tz/dekmUYAa0xcDHIQE5fqp
	 QxPjmWzThHJSiG4CxWByGDqRLdp/0QWa59e2QJ7AtA8NU6DyOYgRVICGxixNiECdwX
	 hYKVqt0g4fzuHnprfLlhpapggXcCBEDQtE5T3UVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgG1Mdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbgG1Mdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:33:49 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9786206D4;
        Tue, 28 Jul 2020 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939628;
        bh=zCNo22uiKyrwMBQfvgXdj50JSNeFd2xR6b3wPrgUHow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbeLdJp2smymHvcbKMFA+T08aCFygVeLiwFXVb+b7PhCTM8JMWyW4sSIPgGfQSmqK
         YhgswRzwigWqleCeuBvHREHEMoX47rrSfGm7yPOIjTEElN7F9wqvlh+21PXegRzewE
         oKJ557ay4LNoqPCuCewlsf9K4M1CqgZe5QafXuvo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 20C87404B1; Tue, 28 Jul 2020 09:33:46 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:33:46 -0300
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
Subject: Re: [PATCH 12/19] perf metric: Add events for the current list
Message-ID: <20200728123346.GS40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-13-jolsa@kernel.org>
 <CAP-5=fXsspq4xBehRZOBrFAEHAnE1tPnH9FybooiCcTxynh6wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXsspq4xBehRZOBrFAEHAnE1tPnH9FybooiCcTxynh6wg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 19, 2020 at 03:34:48PM -0700, Ian Rogers escreveu:
> On Sun, Jul 19, 2020 at 11:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > There's no need to iterate the whole list of groups,
> > when adding new events. The currently created groups
> > are the ones we want to add.
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
> >  tools/perf/util/metricgroup.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index bb5757b9419d..332414d93f7a 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -813,6 +813,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >  {
> >         struct pmu_event *pe;
> >         struct egroup *eg;
> > +       LIST_HEAD(list);
> >         int i, ret;
> >         bool has_match = false;
> >
> > @@ -820,7 +821,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >                 has_match = true;
> >                 eg = NULL;
> >
> > -               ret = add_metric(group_list, pe, metric_no_group, &eg);
> > +               ret = add_metric(&list, pe, metric_no_group, &eg);
> >                 if (ret)
> >                         return ret;
> >
> > @@ -829,7 +830,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >                  * included in the expression.
> >                  */
> >                 ret = resolve_metric(eg, metric_no_group,
> > -                                    group_list, map);
> > +                                    &list, map);
> >                 if (ret)
> >                         return ret;
> >         }
> > @@ -838,7 +839,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >         if (!has_match)
> >                 return -EINVAL;
> >
> > -       list_for_each_entry(eg, group_list, nd) {
> > +       list_for_each_entry(eg, &list, nd) {
> >                 if (events->len > 0)
> >                         strbuf_addf(events, ",");
> >
> > @@ -850,6 +851,8 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >                                                            &eg->pctx);
> >                 }
> >         }
> > +
> > +       list_splice(&list, group_list);
> >         return 0;
> >  }
> >
> > --
> > 2.25.4
> >

-- 

- Arnaldo
