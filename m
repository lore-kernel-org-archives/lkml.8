Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6394AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA2B20672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6lCAmsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgF1WBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 18:01:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28154 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbgF1WBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593381669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4aw2LV4QYh3CzKLGA3AMNwowiWBppLOoNKVxSBZvo4=;
        b=P6lCAmsFNiqOBrq7vhW5fEm5zBxfYLhq0rjAEJ/8JbAXviW10Cbet4Zd0+tbqsyesecUFv
        xp3J8FxRkV7umuiNEK0vZimCthvH8RhH/FPl0ehXJOlMTxUiqVD8JQasXTOPaexgsgWQ1Y
        3pIwezcg7Em9Ig9TvUn8y/KMZU/KKlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-SZJSy8bEMTyuRmVzYXGYNA-1; Sun, 28 Jun 2020 18:01:04 -0400
X-MC-Unique: SZJSy8bEMTyuRmVzYXGYNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D70CB804001;
        Sun, 28 Jun 2020 22:01:02 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 022FF9CFD2;
        Sun, 28 Jun 2020 22:00:59 +0000 (UTC)
Date:   Mon, 29 Jun 2020 00:00:59 +0200
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
Subject: Re: [PATCH 10/10] perf tests: Add cache_miss_cycles to metric parse
 test
Message-ID: <20200628220059.GP2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-11-jolsa@kernel.org>
 <CAP-5=fXk6ZqWdXqVGtiKemn254wTOKW3m4UuwF1Qum+mZQhYPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXk6ZqWdXqVGtiKemn254wTOKW3m4UuwF1Qum+mZQhYPg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:40:34PM -0700, Ian Rogers wrote:
> On Fri, Jun 26, 2020 at 12:48 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test that compute metric with other metrics in it.
> >
> >   cache_miss_cycles = metric:dcache_miss_cpi + metric:icache_miss_cycles
> >
> 
> This is really nice! Do we need to do anything in tests/pmu-events.c?
> Presumably if a metric is referencing another metric the call to
> expr__parse there will test the other metric is parseable. Just wanted
> to sanity check.

right, I did not realize that, but that test is passing for me,
so I guess it's fine.. I'll double check

thanks,
jirka

> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/tests/parse-metric.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index 8c48251425e1..feb97f7c90c8 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -11,6 +11,8 @@
> >  #include "debug.h"
> >  #include "expr.h"
> >  #include "stat.h"
> > +#include <perf/cpumap.h>
> > +#include <perf/evlist.h>
> >
> >  static struct pmu_event pme_test[] = {
> >  {
> > @@ -22,6 +24,18 @@ static struct pmu_event pme_test[] = {
> >                           "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
> >         .metric_name    = "Frontend_Bound_SMT",
> >  },
> > +{
> > +       .metric_expr    = "l1d\\-loads\\-misses / inst_retired.any",
> > +       .metric_name    = "dcache_miss_cpi",
> > +},
> > +{
> > +       .metric_expr    = "l1i\\-loads\\-misses / inst_retired.any",
> > +       .metric_name    = "icache_miss_cycles",
> > +},
> > +{
> > +       .metric_expr    = "(metric:dcache_miss_cpi + metric:icache_miss_cycles)",
> > +       .metric_name    = "cache_miss_cycles",
> > +},
> >  };
> >
> >  static struct pmu_events_map map = {
> > @@ -162,9 +176,28 @@ static int test_frontend(void)
> >         return 0;
> >  }
> >
> > +static int test_cache_miss_cycles(void)
> > +{
> > +       double ratio;
> > +       struct value vals[] = {
> > +               { .event = "l1d-loads-misses",  .val = 300 },
> > +               { .event = "l1i-loads-misses",  .val = 200 },
> > +               { .event = "inst_retired.any",  .val = 400 },
> > +               { 0 },
> > +       };
> > +
> > +       TEST_ASSERT_VAL("failed to compute metric",
> > +                       compute_metric("cache_miss_cycles", vals, &ratio) == 0);
> > +
> > +       TEST_ASSERT_VAL("cache_miss_cycles failed, wrong ratio",
> > +                       ratio == 1.25);
> > +       return 0;
> > +}
> > +
> >  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
> >  {
> >         TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
> >         TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
> > +       TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
> >         return 0;
> >  }
> > --
> > 2.25.4
> >
> 

