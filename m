Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86443C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDA020792
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596473403;
	bh=5rh0kW+cS1WpmnSck8h1lrLmzrU4xiuAAMrZ7P/VDfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DNslCd/wqn5XfXfT5vkX6vtarnQijbF/0aJLd2qjVcoOoVnWhvPOVwJGS7a39gBcb
	 4NVQeHr5gTCVdd9ByVztPqDE2wNL9CMnmJI2Oztd4Bn+6fk2ZTjtDOrSo8BzbeaC/h
	 PyKSrAZeqrJ14uJce7c1X5oK1SCN1nVJ7Gg8Rf5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHCQuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgHCQuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:50:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05DC2207DF;
        Mon,  3 Aug 2020 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596473401;
        bh=5rh0kW+cS1WpmnSck8h1lrLmzrU4xiuAAMrZ7P/VDfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rFAjfSFKL0+krkWwCPZ1oVHuVC3BP/5iQl0Q6Oup5g+TTYZCubT/IvnQokXrIiZQb
         y4Cd6brWza/aMGAsVs3CLoVQ4A7euxoPidIUjHN5Pkew4nby0GZXKvJ2pT2lyI9ldk
         HgpEVxi1ubvWuIYZt+rZoII8AH8ht3X4tRhc2xFY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A884040C7C; Mon,  3 Aug 2020 13:49:59 -0300 (-03)
Date:   Mon, 3 Aug 2020 13:49:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, "Paul A. Clarke" <pc@us.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCHv4 00/19] perf metric: Add support to reuse metric
Message-ID: <20200803164959.GC3440834@kernel.org>
References: <20200729091908.1378911-1-jolsa@kernel.org>
 <20200801114050.GB377079@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <CAP-5=fUjMH-VHaLhNjBhk4pSsAGs_9kUuy1N68RRF4d6E5e5Lg@mail.gmail.com>
 <20200803162636.GF139381@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803162636.GF139381@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 03, 2020 at 06:26:36PM +0200, Jiri Olsa escreveu:
> On Mon, Aug 03, 2020 at 08:54:16AM -0700, Ian Rogers wrote:
> > On Sat, Aug 1, 2020 at 4:41 AM Paul A. Clarke <pc@us.ibm.com> wrote:
> > >
> > > On Wed, Jul 29, 2020 at 11:18:49AM +0200, Jiri Olsa wrote:
> > > > this patchset is adding the support to reused metric in
> > > > another metric.
> > > >
> > > > For example, to define IPC by using CPI with change like:
> > > >
> > > >      {
> > > >          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> > > > -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> > > > +        "MetricExpr": "1/CPI",
> > > >          "MetricGroup": "TopDownL1",
> > > >          "MetricName": "IPC"
> > > >      },
> > > >
> > > > I won't be able to find all the possible places we could
> > > > use this at, so I wonder you guys (who was asking for this)
> > > > would try it and come up with comments if there's something
> > > > missing or we could already use it at some places.
> > > >
> > > > It's based on Arnaldo's tmp.perf/core.
> > > >
> > > > v4 changes:
> > > >   - removed acks from patch because it changed a bit
> > > >     with the last fixes:
> > > >       perf metric: Collect referenced metrics in struct metric_ref_node
> > > >   - fixed runtime metrics [Kajol Jain]
> > > >   - increased recursion depth [Paul A. Clarke]
> > > >   - changed patches due to dependencies:
> > > >       perf metric: Collect referenced metrics in struct metric_ref_node
> > > >       perf metric: Add recursion check when processing nested metrics
> > > >       perf metric: Rename struct egroup to metric
> > > >       perf metric: Rename group_list to metric_list
> > > >
> > > > Also available in here:
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > > >   perf/metric
> > >
> > > I built and ran from the above git branch, and things seem to work.
> > > Indeed, I was able to apply my changes to exploit the new capabilities
> > > via modifications to tools/perf/pmu-events/arch/powerpc/power9/metrics.json,
> > > as I posted earlier (and will submit once this set gets merged).
> > >
> > > Tested-by: Paul A. Clarke <pc@us.ibm.com>
> > >
> > > One thing I noted, but which also occurs without these patches, is that
> > > the perf metrics are not computed unless run as root:
> > > --
> > > $ perf stat --metrics br_misprediction_percent command
> > >
> > >  Performance counter stats for 'command':
> > >
> > >      1,823,530,051      pm_br_pred:u
> > >          2,662,705      pm_br_mpred_cmpl:u
> 
> it's because when you don't run as root, events will get the :u suffix,

s/as root/with the required permissions/

I.e. using CAP_PERFMON, etc as per the explanation at
Documentation/admin-guide/perf-security.rst.

Just to help more people be aware of a more secure way of using perf.

> so they will not match the events in metric.. we need to decide if we
> want the metric to match events without modifiers or be strict about it
> 
> > >
> > > $ /usr/bin/sudo perf stat --metrics br_misprediction_percent command
> > >
> > >  Performance counter stats for 'command':
> > >
> > >      1,824,655,269      pm_br_pred                #     0.09 br_misprediction_percent
> > >          1,654,466      pm_br_mpred_cmpl
> > > --
> > >
> > > Is that expected?  I don't think it's always been that way.
> > 
> > I agree Paul, this seems broken. I've noticed a bunch of issues with
> > printing CSV, per-socket output and so on. Jiri may have a better idea
> > but I plan to look at problems in this area later, and hopefully stick
> > a few tests on it :-)
> 
> ok, that'd be great, thanks

Yeah, tests are good, keep them coming :-)

- Arnaldo
