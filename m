Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7AFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E223A206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbgCaTaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:30:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:18117 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbgCaTaa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:30:30 -0400
IronPort-SDR: rtfxLbm5RkI9JIuBvUa/COyfMKWcv8Iq25ng+akFGOfcVnFGiRnF4my+TQcq1XDR/j8V3Mzp1T
 TC3HiUpltAgw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 12:30:29 -0700
IronPort-SDR: Gip97aRSbXPMHQh6BQo1/euN3xJv3VtIvPXNoDpNk7poNict4KawwQcfSw87qUKiFevnmh2eSM
 7a2Jth9YxKwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="240227846"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 31 Mar 2020 12:30:28 -0700
Received: from [10.255.229.165] (kliang2-mobl.ccr.corp.intel.com [10.255.229.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B135158077B;
        Tue, 31 Mar 2020 12:30:27 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/pmu-events: Use CPU_CLK_UNHALTED.THREAD in
 Kernel_Utilization metric
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200309013125.7559-1-yao.jin@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3e2ee47f-d351-64c3-b547-993a2b65f871@linux.intel.com>
Date:   Tue, 31 Mar 2020 15:30:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200309013125.7559-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/2020 9:31 PM, Jin Yao wrote:
> The kernel utilization metric does multiplexing currently and is somewhat
> unreliable. The problem is that it uses two instances of the fixed counter,
> and the kernel has to multipleplex which causes errors. So should use
> CPU_CLK_UNHALTED.THREAD instead.
> 
> Before:
> 
>    # perf stat -M Kernel_Utilization -- sleep 1
> 
>    Performance counter stats for 'sleep 1':
> 
>            1,419,425      cpu_clk_unhalted.ref_tsc:k
>        <not counted>      cpu_clk_unhalted.ref_tsc	(0.00%)
> 
> After:
> 
>    # perf stat -M Kernel_Utilization -- sleep 1
> 
>    Performance counter stats for 'sleep 1':
> 
>              746,688      cpu_clk_unhalted.thread:k #      0.7 Kernel_Utilization
>            1,088,348      cpu_clk_unhalted.thread
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>


Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>   tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json     | 2 +-
>   tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
>   tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json    | 2 +-
>   tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 2 +-
>   tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json       | 2 +-
>   tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json      | 2 +-
>   tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json     | 2 +-
>   tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json       | 2 +-
>   tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json      | 2 +-
>   tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json   | 2 +-
>   tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json       | 2 +-
>   tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json      | 2 +-
>   12 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> index 45a34ce4fe89..8cdc7c13dc2a 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> @@ -297,7 +297,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> index 961fe4395758..16fd8a7490fc 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> @@ -115,7 +115,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> index 746734ce09be..1eb0415fa11a 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> @@ -297,7 +297,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> index f94653229dd4..a2c32db8f14e 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> @@ -315,7 +315,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> index 5402cd3120f9..f57c5f3506c2 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> @@ -267,7 +267,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> index 832f3cb40b34..311a005dc35b 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> @@ -267,7 +267,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> index d69b2a8fc0bc..28e25447d3ef 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> @@ -285,7 +285,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> index 5f465fd81315..db23db2e98be 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> @@ -285,7 +285,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> index 3e909b306003..dbb33e00b72a 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> @@ -171,7 +171,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> index 50c053235752..fb2d7b8875f8 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> @@ -171,7 +171,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> index e7feb60f9fa9..e3afc3178958 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> @@ -303,7 +303,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> index 21d7a0c2c2e8..12d1efba79bb 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> @@ -315,7 +315,7 @@
>       },
>       {
>           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
>           "MetricGroup": "Summary",
>           "MetricName": "Kernel_Utilization"
>       },
> 
