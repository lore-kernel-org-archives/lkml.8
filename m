Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DC6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBE12074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939830;
	bh=5TPhzH5vO99n2PNcTutP3rvbIJuX0RRXUhLLe7DOHI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yc2FSriEiW1x835fFUntlRDMDR5wDT2YSzRzJP8xNfUUEeKgbLUenq5Q8DuUDPOdL
	 Tcwwlfdp+uIt2Dmr2n+jR7SbSBw64N06JNB/n8BMLF8nYLBd8r5pkyZ/LIl5f//OWO
	 MEGbEhqOrgFq0ax51jzj3nYzgduSGviMLL7f2HvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgG1MhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgG1MhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:37:07 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B197A20759;
        Tue, 28 Jul 2020 12:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939827;
        bh=5TPhzH5vO99n2PNcTutP3rvbIJuX0RRXUhLLe7DOHI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Notg73rBoii6IUqtxUD5qZwUqggHruDOBYmKXcC/on+ISeZOl7YtjJLOvfNtgqBmb
         QFq/wiK0T42FzhBP2CIfukU9KkVJCpKBfK87RiqpUpfdU4YQxVfb9bw7Tde/w8ZTN1
         D6ElooFvYrnZOkusacU+tLoj9/q+8cFECYSb0Vd4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B279404B1; Tue, 28 Jul 2020 09:37:04 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:37:04 -0300
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
Subject: Re: [PATCH 17/19] perf metric: Add metric group test
Message-ID: <20200728123704.GX40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-18-jolsa@kernel.org>
 <CAP-5=fWmm5pvH-hwkaAKV=__7Ocbc-4Qj8OCJWz_xi4pc65A=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWmm5pvH-hwkaAKV=__7Ocbc-4Qj8OCJWz_xi4pc65A=Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 19, 2020 at 03:41:14PM -0700, Ian Rogers escreveu:
> On Sun, Jul 19, 2020 at 11:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test for metric group plus compute_metric_group
> > function to get metrics values within the group.
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
> >  tools/perf/tests/parse-metric.c | 48 +++++++++++++++++++++++++++++++--
> >  1 file changed, 46 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index 5ac32f80f8ea..f2ba5b2c5557 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -18,6 +18,7 @@ static struct pmu_event pme_test[] = {
> >  {
> >         .metric_expr    = "inst_retired.any / cpu_clk_unhalted.thread",
> >         .metric_name    = "IPC",
> > +       .metric_group   = "group1",
> >  },
> >  {
> >         .metric_expr    = "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * "
> > @@ -35,6 +36,7 @@ static struct pmu_event pme_test[] = {
> >  {
> >         .metric_expr    = "(dcache_miss_cpi + icache_miss_cycles)",
> >         .metric_name    = "cache_miss_cycles",
> > +       .metric_group   = "group1",
> >  },
> >  {
> >         .metric_expr    = "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
> > @@ -127,7 +129,9 @@ static double compute_single(struct rblist *metric_events, struct evlist *evlist
> >         return 0.;
> >  }
> >
> > -static int compute_metric(const char *name, struct value *vals, double *ratio)
> > +static int __compute_metric(const char *name, struct value *vals,
> > +                           const char *name1, double *ratio1,
> > +                           const char *name2, double *ratio2)
> >  {
> >         struct rblist metric_events = {
> >                 .nr_entries = 0,
> > @@ -166,7 +170,10 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
> >         load_runtime_stat(&st, evlist, vals);
> >
> >         /* And execute the metric */
> > -       *ratio = compute_single(&metric_events, evlist, &st, name);
> > +       if (name1 && ratio1)
> > +               *ratio1 = compute_single(&metric_events, evlist, &st, name1);
> > +       if (name2 && ratio2)
> > +               *ratio2 = compute_single(&metric_events, evlist, &st, name2);
> >
> >         /* ... clenup. */
> >         metricgroup__rblist_exit(&metric_events);
> > @@ -177,6 +184,18 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
> >         return 0;
> >  }
> >
> > +static int compute_metric(const char *name, struct value *vals, double *ratio)
> > +{
> > +       return __compute_metric(name, vals, name, ratio, NULL, NULL);
> > +}
> > +
> > +static int compute_metric_group(const char *name, struct value *vals,
> > +                               const char *name1, double *ratio1,
> > +                               const char *name2, double *ratio2)
> > +{
> > +       return __compute_metric(name, vals, name1, ratio1, name2, ratio2);
> > +}
> > +
> >  static int test_ipc(void)
> >  {
> >         double ratio;
> > @@ -297,6 +316,30 @@ static int test_recursion_fail(void)
> >         return 0;
> >  }
> >
> > +static int test_metric_group(void)
> > +{
> > +       double ratio1, ratio2;
> > +       struct value vals[] = {
> > +               { .event = "cpu_clk_unhalted.thread", .val = 200 },
> > +               { .event = "l1d-loads-misses",        .val = 300 },
> > +               { .event = "l1i-loads-misses",        .val = 200 },
> > +               { .event = "inst_retired.any",        .val = 400 },
> > +               { 0 },
> > +       };
> > +
> > +       TEST_ASSERT_VAL("failed to find recursion",
> > +                       compute_metric_group("group1", vals,
> > +                                            "IPC", &ratio1,
> > +                                            "cache_miss_cycles", &ratio2) == 0);
> > +
> > +       TEST_ASSERT_VAL("group IPC failed, wrong ratio",
> > +                       ratio1 == 2.0);
> > +
> > +       TEST_ASSERT_VAL("group cache_miss_cycles failed, wrong ratio",
> > +                       ratio2 == 1.25);
> > +       return 0;
> > +}
> > +
> >  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
> >  {
> >         TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
> > @@ -304,5 +347,6 @@ int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unu
> >         TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
> >         TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
> >         TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
> > +       TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
> >         return 0;
> >  }
> > --
> > 2.25.4
> >

-- 

- Arnaldo
