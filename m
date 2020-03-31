Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DE7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE0C20658
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgCaUEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:04:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:20388 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbgCaUEO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:04:14 -0400
IronPort-SDR: 4NAeKYh1SehZZLjID1VeXR5aVVNkQIg7WaHODs1MZCTI3monmJpxlmuzHEez/2OnQDoFPOWyTv
 tKqx8jTilWmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 13:04:12 -0700
IronPort-SDR: tooVZKGD1u1yhUaN6q63MJLEeqF+wgUaco/cA2k/d6/bjK6miEcoFOdizCrHK2IMdkIRKtK1aX
 1Ogmm8MG21pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="359618004"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2020 13:04:11 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1CCCB30178A; Tue, 31 Mar 2020 13:04:11 -0700 (PDT)
Date:   Tue, 31 Mar 2020 13:04:11 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf/x86/pmu-events: Use CPU_CLK_UNHALTED.THREAD in
 Kernel_Utilization metric
Message-ID: <20200331200411.GA397189@tassilo.jf.intel.com>
References: <20200309013125.7559-1-yao.jin@linux.intel.com>
 <f335f8ec-f92e-787e-0594-00cec2e06036@linux.intel.com>
 <20200331190804.GK9917@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331190804.GK9917@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 04:08:04PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 30, 2020 at 08:38:29AM +0800, Jin, Yao escreveu:
> > Hi,
> > 
> > Any comments for this patch?
> 
> Can someone help Jin reviewing this x86 specific metric?

Looks good to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> - Arnaldo
>  
> > Thanks
> > Jin Yao
> > 
> > On 3/9/2020 9:31 AM, Jin Yao wrote:
> > > The kernel utilization metric does multiplexing currently and is somewhat
> > > unreliable. The problem is that it uses two instances of the fixed counter,
> > > and the kernel has to multipleplex which causes errors. So should use
> > > CPU_CLK_UNHALTED.THREAD instead.
> > > 
> > > Before:
> > > 
> > >    # perf stat -M Kernel_Utilization -- sleep 1
> > > 
> > >    Performance counter stats for 'sleep 1':
> > > 
> > >            1,419,425      cpu_clk_unhalted.ref_tsc:k
> > >        <not counted>      cpu_clk_unhalted.ref_tsc	(0.00%)
> > > 
> > > After:
> > > 
> > >    # perf stat -M Kernel_Utilization -- sleep 1
> > > 
> > >    Performance counter stats for 'sleep 1':
> > > 
> > >              746,688      cpu_clk_unhalted.thread:k #      0.7 Kernel_Utilization
> > >            1,088,348      cpu_clk_unhalted.thread
> > > 
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json     | 2 +-
> > >   tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
> > >   tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json    | 2 +-
> > >   tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 2 +-
> > >   tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json       | 2 +-
> > >   tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json      | 2 +-
> > >   tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json     | 2 +-
> > >   tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json       | 2 +-
> > >   tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json      | 2 +-
> > >   tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json   | 2 +-
> > >   tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json       | 2 +-
> > >   tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json      | 2 +-
> > >   12 files changed, 12 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > > index 45a34ce4fe89..8cdc7c13dc2a 100644
> > > --- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > > @@ -297,7 +297,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > index 961fe4395758..16fd8a7490fc 100644
> > > --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > @@ -115,7 +115,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > > index 746734ce09be..1eb0415fa11a 100644
> > > --- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > > @@ -297,7 +297,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > > index f94653229dd4..a2c32db8f14e 100644
> > > --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > > @@ -315,7 +315,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> > > index 5402cd3120f9..f57c5f3506c2 100644
> > > --- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> > > @@ -267,7 +267,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> > > index 832f3cb40b34..311a005dc35b 100644
> > > --- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> > > @@ -267,7 +267,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> > > index d69b2a8fc0bc..28e25447d3ef 100644
> > > --- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> > > @@ -285,7 +285,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> > > index 5f465fd81315..db23db2e98be 100644
> > > --- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> > > @@ -285,7 +285,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> > > index 3e909b306003..dbb33e00b72a 100644
> > > --- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> > > @@ -171,7 +171,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> > > index 50c053235752..fb2d7b8875f8 100644
> > > --- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> > > @@ -171,7 +171,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > > index e7feb60f9fa9..e3afc3178958 100644
> > > --- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > > @@ -303,7 +303,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> > > index 21d7a0c2c2e8..12d1efba79bb 100644
> > > --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> > > @@ -315,7 +315,7 @@
> > >       },
> > >       {
> > >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> > >           "MetricGroup": "Summary",
> > >           "MetricName": "Kernel_Utilization"
> > >       },
> > > 
> 
> -- 
> 
> - Arnaldo
