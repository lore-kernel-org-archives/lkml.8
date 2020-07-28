Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900B02074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939683;
	bh=fP2HXQ7ciWz1TposxskS6ICdP9ajQ8ia66gVN5M9t4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fQRIJqymPlG8d6uVfHJGN818KOCQhZJ4spnL/w4QVuHD26vK90EZd6INBhBmreCNK
	 UhR5yAnaEffYpVr/fY63CSZpnpFqq2Vj8u3e5f6UHIFyqkHQwLFsNTM9LCs7CUKHjP
	 S/X/nu4K6oZbVfLUDvLDbEc9js20OxD6Q5vCDg4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgG1Mem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbgG1Mel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:34:41 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303292070B;
        Tue, 28 Jul 2020 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939681;
        bh=fP2HXQ7ciWz1TposxskS6ICdP9ajQ8ia66gVN5M9t4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkujjZ0Qlp3qSYoIKZHyLPUCaeKBSXERr/FIc+oJcaR6UiEpV5CoCLeKEdtatTOQ4
         njIu5/jC5c9oE2FALsToqhjaRFHqCnJ1eH2OWReff0t6Ac+92bwBCydDZcHNSH5OKR
         ontXiWm9RPIPhuFAxPnI8dli0mjA7JCEJHMBvtPs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A47A1404B1; Tue, 28 Jul 2020 09:34:36 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:34:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 14/19] perf metric: Add DCache_L2 to metric parse test
Message-ID: <20200728123436.GU40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-15-jolsa@kernel.org>
 <7addd402-9d59-674e-8d02-0e330cb5665f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7addd402-9d59-674e-8d02-0e330cb5665f@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 26, 2020 at 02:49:46PM +0530, kajoljain escreveu:
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > Adding test that compute DCache_L2 metrics with other related metrics in it.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Kajol Jain
> > ---
> >  tools/perf/tests/parse-metric.c | 71 +++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> > 
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index 28f33893338b..aa4d5a9f09a8 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -36,6 +36,27 @@ static struct pmu_event pme_test[] = {
> >  	.metric_expr	= "(dcache_miss_cpi + icache_miss_cycles)",
> >  	.metric_name	= "cache_miss_cycles",
> >  },
> > +{
> > +	.metric_expr	= "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
> > +	.metric_name	= "DCache_L2_All_Hits",
> > +},
> > +{
> > +	.metric_expr	= "max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + "
> > +			  "l2_rqsts.pf_miss + l2_rqsts.rfo_miss",
> > +	.metric_name	= "DCache_L2_All_Miss",
> > +},
> > +{
> > +	.metric_expr	= "dcache_l2_all_hits + dcache_l2_all_miss",
> > +	.metric_name	= "DCache_L2_All",
> > +},
> > +{
> > +	.metric_expr	= "d_ratio(dcache_l2_all_hits, dcache_l2_all)",
> > +	.metric_name	= "DCache_L2_Hits",
> > +},
> > +{
> > +	.metric_expr	= "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
> > +	.metric_name	= "DCache_L2_Misses",
> > +},
> >  };
> >  
> >  static struct pmu_events_map map = {
> > @@ -194,10 +215,60 @@ static int test_cache_miss_cycles(void)
> >  	return 0;
> >  }
> >  
> > +
> > +/*
> > + * DCache_L2_All_Hits = l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hi
> > + * DCache_L2_All_Miss = max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) +
> > + *                      l2_rqsts.pf_miss + l2_rqsts.rfo_miss
> > + * DCache_L2_All      = dcache_l2_all_hits + dcache_l2_all_miss
> > + * DCache_L2_Hits     = d_ratio(dcache_l2_all_hits, dcache_l2_all)
> > + * DCache_L2_Misses   = d_ratio(dcache_l2_all_miss, dcache_l2_all)
> > + *
> > + * l2_rqsts.demand_data_rd_hit = 100
> > + * l2_rqsts.pf_hit             = 200
> > + * l2_rqsts.rfo_hi             = 300
> > + * l2_rqsts.all_demand_data_rd = 400
> > + * l2_rqsts.pf_miss            = 500
> > + * l2_rqsts.rfo_miss           = 600
> > + *
> > + * DCache_L2_All_Hits = 600
> > + * DCache_L2_All_Miss = MAX(400 - 100, 0) + 500 + 600 = 1400
> > + * DCache_L2_All      = 600 + 1400  = 2000
> > + * DCache_L2_Hits     = 600 / 2000  = 0.3
> > + * DCache_L2_Misses   = 1400 / 2000 = 0.7
> > + */
> > +static int test_dcache_l2(void)
> > +{
> > +	double ratio;
> > +	struct value vals[] = {
> > +		{ .event = "l2_rqsts.demand_data_rd_hit", .val = 100 },
> > +		{ .event = "l2_rqsts.pf_hit",             .val = 200 },
> > +		{ .event = "l2_rqsts.rfo_hit",            .val = 300 },
> > +		{ .event = "l2_rqsts.all_demand_data_rd", .val = 400 },
> > +		{ .event = "l2_rqsts.pf_miss",            .val = 500 },
> > +		{ .event = "l2_rqsts.rfo_miss",           .val = 600 },
> > +		{ 0 },
> > +	};
> > +
> > +	TEST_ASSERT_VAL("failed to compute metric",
> > +			compute_metric("DCache_L2_Hits", vals, &ratio) == 0);
> > +
> > +	TEST_ASSERT_VAL("DCache_L2_Hits failed, wrong ratio",
> > +			ratio == 0.3);
> > +
> > +	TEST_ASSERT_VAL("failed to compute metric",
> > +			compute_metric("DCache_L2_Misses", vals, &ratio) == 0);
> > +
> > +	TEST_ASSERT_VAL("DCache_L2_Misses failed, wrong ratio",
> > +			ratio == 0.7);
> > +	return 0;
> > +}
> > +
> >  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
> >  {
> >  	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
> >  	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
> >  	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
> > +	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
> >  	return 0;
> >  }
> > 

-- 

- Arnaldo
