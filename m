Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AF4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57C42075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939654;
	bh=VG0WHoiEK8itXzCY7Q6JWiaT2vv/gFNMzcOU2lxL7xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jBmZA9tUVYD05CtZ2HCftJZ+Zw0CJ26nl1x65IYzQ2Y7/kXrFBSKFqNGbaB7MevUG
	 dRN1CAj78Mt4cdCLWH6W22bpcj9fBRvO+7F7IVptH14Gyx7FyKTYiDVzwlulw/v7h2
	 zCwLszK2hk+plWzt2l22RS+c3ZM148wg+8PCVf6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgG1MeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbgG1MeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:34:13 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE742074F;
        Tue, 28 Jul 2020 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939652;
        bh=VG0WHoiEK8itXzCY7Q6JWiaT2vv/gFNMzcOU2lxL7xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LwyI6rkwWJtpI+0a1AN7bVU2JYbuy9ZmxIO8Lep03+Y50Y6EUQL8E6MvYFa+LpTCG
         iELghPWBd8KMofBX9a0/0VWpSjvoFTi1WOK7QHCM9dUx+CwYT2HTF+oOpua+nG3P0g
         OYfnZJzRccUdyBv44aszVHLldp8/lxF/lPJ/FcHA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E63F404B1; Tue, 28 Jul 2020 09:34:09 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:34:09 -0300
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
Subject: Re: [PATCH 13/19] perf metric: Add cache_miss_cycles to metric parse
 test
Message-ID: <20200728123409.GT40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-14-jolsa@kernel.org>
 <d5fc8fdc-35ee-7e01-eb6b-bfdfce177910@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5fc8fdc-35ee-7e01-eb6b-bfdfce177910@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 26, 2020 at 02:49:35PM +0530, kajoljain escreveu:
> 
> 
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > Adding test that compute metric with other metrics in it.
> > 
> >   cache_miss_cycles = metric:dcache_miss_cpi + metric:icache_miss_cycles
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
> >  tools/perf/tests/parse-metric.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index 8c48251425e1..28f33893338b 100644
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
> >  			  "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
> >  	.metric_name	= "Frontend_Bound_SMT",
> >  },
> > +{
> > +	.metric_expr	= "l1d\\-loads\\-misses / inst_retired.any",
> > +	.metric_name	= "dcache_miss_cpi",
> > +},
> > +{
> > +	.metric_expr	= "l1i\\-loads\\-misses / inst_retired.any",
> > +	.metric_name	= "icache_miss_cycles",
> > +},
> > +{
> > +	.metric_expr	= "(dcache_miss_cpi + icache_miss_cycles)",
> > +	.metric_name	= "cache_miss_cycles",
> > +},
> >  };
> >  
> >  static struct pmu_events_map map = {
> > @@ -162,9 +176,28 @@ static int test_frontend(void)
> >  	return 0;
> >  }
> >  
> > +static int test_cache_miss_cycles(void)
> > +{
> > +	double ratio;
> > +	struct value vals[] = {
> > +		{ .event = "l1d-loads-misses",  .val = 300 },
> > +		{ .event = "l1i-loads-misses",  .val = 200 },
> > +		{ .event = "inst_retired.any",  .val = 400 },
> > +		{ 0 },
> > +	};
> > +
> > +	TEST_ASSERT_VAL("failed to compute metric",
> > +			compute_metric("cache_miss_cycles", vals, &ratio) == 0);
> > +
> > +	TEST_ASSERT_VAL("cache_miss_cycles failed, wrong ratio",
> > +			ratio == 1.25);
> > +	return 0;
> > +}
> > +
> >  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
> >  {
> >  	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
> >  	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
> > +	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
> >  	return 0;
> >  }
> > 

-- 

- Arnaldo
