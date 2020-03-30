Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903B8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 00:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E3F20780
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 00:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgC3Aie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:38:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:63049 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgC3Aid (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 20:38:33 -0400
IronPort-SDR: 5yn+51Exat0X1zkpsVk1zpt2p+HFXmvCxLjz5HQmuuCukSSF0wYkvpRQqaeq3Ptm+K7sQL3XyC
 QZMp6O/UJeTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 17:38:32 -0700
IronPort-SDR: FoVSLBcD2+G6A4CKsu6XNQcUdfLO8NnKvubZ/E2ePVHJY8vN6gB3gr2xXyKICzC1W1L8IoXBUD
 8mCdZ4wViRjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,322,1580803200"; 
   d="scan'208";a="239625188"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2020 17:38:30 -0700
Subject: Re: [PATCH] perf/x86/pmu-events: Use CPU_CLK_UNHALTED.THREAD in
 Kernel_Utilization metric
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200309013125.7559-1-yao.jin@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f335f8ec-f92e-787e-0594-00cec2e06036@linux.intel.com>
Date:   Mon, 30 Mar 2020 08:38:29 +0800
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

Hi,

Any comments for this patch?

Thanks
Jin Yao

On 3/9/2020 9:31 AM, Jin Yao wrote:
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
