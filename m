Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22858C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F512074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595940152;
	bh=zLz4M5wkxbZNepiSL3Hcv83ECJB7S4PmkNmrgGvw8bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sHf8SqMfi4sYineRi15zAV8ufsvV3K3F+/XrqrQAdVHGVWEbAv5VG3JEhf8H8Wxph
	 siwZch/meqvM3gW2wo7dhsHBN/DFIqabpzmpCGbHYkcE65pL484FBQC8ql0QIjhcdt
	 goJmwLasjp3R5ebQWheT+rAzm1Mk/1XnPoselByk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgG1Mma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbgG1Mma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:42:30 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9309620714;
        Tue, 28 Jul 2020 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595940149;
        bh=zLz4M5wkxbZNepiSL3Hcv83ECJB7S4PmkNmrgGvw8bY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQ4uWy+YTPp2joyDxNRyIK7eKqoco7ViDYdc3Sl7eAZAh57+fi0aMCm+eRIJgtATl
         ixhfVhGWuPOcrIu+G+KQZQ17PcI/6SMaqDfKrzOJ+xjfjfsvsQGu9+QL5OWMSz/rT/
         3NetWlyTogegQp9Xdxs+CCadw361OGJfBquQ1em0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E4A3404B1; Tue, 28 Jul 2020 09:42:27 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:42:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
Message-ID: <20200728124227.GA40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200721143702.GA15990@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <20200722181158.GF981884@krava>
 <20200723155958.GA7141@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723155958.GA7141@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 23, 2020 at 10:59:58AM -0500, Paul A. Clarke escreveu:
> On Wed, Jul 22, 2020 at 08:11:58PM +0200, Jiri Olsa wrote:
> > On Tue, Jul 21, 2020 at 09:48:48AM -0500, Paul A. Clarke wrote:
> > > On Sun, Jul 19, 2020 at 08:13:01PM +0200, Jiri Olsa wrote:
> > > > hi,
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
> > > > v3 changes:
> > > >   - added some acks
> > > >   - some patches got merged
> > > >   - added missing zalloc include [John Garry]
> > > >   - added ids array outside the egroup object [Ian]
> > > >   - removed wrong m->has_constraint assignment [Ian]
> > > >   - renamed 'list' to 'metric_list' [Ian]
> > > >   - fixed group metric and added test for it [Paul A. Clarke]
> > > >   - fixed memory leak [Arnaldo]
> > > >   - using lowercase keys for metrics in hashmap, because jevents
> > > >     converts metric_expr to lowercase
> > > > 
> > > > Also available in here:
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > > >   perf/metric
> > > 
> > > These changes seem to be mostly working for me.
> > > 
> > > I attempted to exploit the new capability in the metrics definitions in
> > > tools/perf/pmu-events/arch/powerpc/power9/metrics.json.  Those changes
> > > are included below.
> > > 
> > > The one problem I found is with the "cpi_breakdown" metric group, as it
> > > no longer works:
> > > ```
> > > # perf stat --metrics cpi_breakdown ./command
> > > Cannot find metric or group `cpi_breakdown'
> > > ```
> > > 
> > > "cpi_breakdown" does show up in `perf list --metricgroup`, and all of the
> > > (95!) metrics listed in that group are usable, so it's not obvious whether
> > > my changes have a problem, or merely provoke one.
> > 
> > I underestimated the recursion depth setup for groups,
> > your change is working for me with following change:
> > 
> > -#define RECURSION_ID_MAX 100
> > +#define RECURSION_ID_MAX 1000
> 
> That indeed addressed the issue.

Thanks, I made that change on the cset that added this define.

- Arnaldo
 
> Is there a point where that limit was being hit and the code silently fails?
> If so, should that failure be less silent?
> 
> PC

-- 

- Arnaldo
