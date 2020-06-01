Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31752C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4982077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591024137;
	bh=eHhvtyo5/lCeJtq9drq3IibVhm0T3Et4gGxVzJNeYs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CBRGOuUg2Z0BGN5s3qIBUnKtDavJQbcwRCNl69TY4F/om0hv/kbOHqMusb0lNQTd1
	 FkGzreHYcJk1fhiowCoSgJG1oeCMcqfCwL7/a652RTmWzo50fLkSvIedmndZsETWAG
	 9gxoj1FFE5tRoKGTK2yvOObL7AXIgkPrQR5OpFoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgFAPI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgFAPIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:08:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B7920738;
        Mon,  1 Jun 2020 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591024135;
        bh=eHhvtyo5/lCeJtq9drq3IibVhm0T3Et4gGxVzJNeYs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAM1mFJohoIroY+7Q3FL06id0sq8WEZfPpzdZ7zwsHKQj+ooyWdeZiu5a/t6ToUC7
         jWyFHg+MHRyYBamGZJJ0XRLUNF6xYCDbhlkD8O3JOevktCqtjvd5KKsU8reG7MjTAQ
         GTlztNOypOzwaCdRDudVf4D8tS9S3+/hZuI16Kt0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 13BCB40AFD; Mon,  1 Jun 2020 12:08:53 -0300 (-03)
Date:   Mon, 1 Jun 2020 12:08:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 14/14] perf tests: Add parse metric test for frontend
 metric
Message-ID: <20200601150852.GM31795@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
 <20200524224219.234847-15-jolsa@kernel.org>
 <CAP-5=fWz9=RhSmWgv1cH4MPXcq49xrqx=9A2P=NK80qvjgn6TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWz9=RhSmWgv1cH4MPXcq49xrqx=9A2P=NK80qvjgn6TA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 01, 2020 at 01:06:01AM -0700, Ian Rogers escreveu:
> On Sun, May 24, 2020 at 3:43 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new metri test for frontend metric. It's stolen
> 
> s/metri/metric/
> 
> > from x86 pmu events.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Ditto.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/parse-metric.c | 46 +++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index 3005d27c5c48..38f20850bba3 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -15,6 +15,11 @@ static struct pmu_event pme_test[] = {
> >         .metric_expr    = "inst_retired.any / cpu_clk_unhalted.thread",
> >         .metric_name    = "IPC",
> >  },
> > +{
> > +       .metric_expr    = "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * "
> > +                         "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
> > +       .metric_name    = "Frontend_Bound_SMT",
> > +},
> >  };
> >
> >  static struct pmu_events_map map = {
> > @@ -110,8 +115,49 @@ static int test_ipc(void)
> >         return 0;
> >  }
> >
> > +static int test_frontend(void)
> > +{
> > +       double ratio;
> > +       struct rblist metric_events = { 0 };
> > +       struct evlist *evlist;
> > +       struct evsel *evsel;
> > +       struct value vals[] = {
> > +               { .event = "idq_uops_not_delivered.core",        .val = 300 },
> > +               { .event = "cpu_clk_unhalted.thread",            .val = 200 },
> > +               { .event = "cpu_clk_unhalted.one_thread_active", .val = 400 },
> > +               { .event = "cpu_clk_unhalted.ref_xclk",          .val = 600 },
> > +               { 0 },
> > +       };
> > +       struct runtime_stat st;
> > +       int err;
> > +
> > +       evlist = evlist__new();
> > +       if (!evlist)
> > +               return -1;
> > +
> > +       err = metricgroup__parse_groups_test(evlist, &map,
> > +                                            "Frontend_Bound_SMT",
> > +                                            false, false,
> > +                                            &metric_events);
> > +
> > +       TEST_ASSERT_VAL("failed to parse metrics", err == 0);
> > +
> > +       runtime_stat__init(&st);
> > +       load_runtime_stat(&st, evlist, vals);
> > +
> > +       evsel = evlist__first(evlist);
> > +       ratio = compute_single(&metric_events, evsel, &st);
> > +
> > +       TEST_ASSERT_VAL("Frontend_Bound_SMT failed, wrong ratio", ratio == 0.45);
> > +
> > +       runtime_stat__exit(&st);
> > +       evlist__delete(evlist);
> > +       return 0;
> > +}
> > +
> >  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
> >  {
> >         TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
> > +       TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
> >         return 0;
> >  }
> > --
> > 2.25.4
> >

-- 

- Arnaldo
