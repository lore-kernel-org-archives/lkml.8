Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A04EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD66C20706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHXMl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:41:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:23096 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXMl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:41:56 -0400
IronPort-SDR: J6Fz7NX5z3v9XBB3cVNLbP3myR7L4pBHGsafVr/kT+4QWDN9iz6t0PPzyxipn/wKF4iiZe6O8E
 VWluGljMGrKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="135952775"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="135952775"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 05:41:55 -0700
IronPort-SDR: nHxh7m7iG/L4ELDnjySrE9FkOh8ejEXHx7CCTm18bB1uWzWQyE57N3Nfldf30Gp9NLo2MuJLvu
 J4r3IvzJavhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="331007620"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga002.fm.intel.com with ESMTP; 24 Aug 2020 05:41:47 -0700
Subject: Re: [PATCH 2/2] perf intel-pt: Fix corrupt data after perf inject
 from
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Al Grant <al.grant@arm.com>
References: <20200819084751.17686-1-leo.yan@linaro.org>
 <20200819084751.17686-2-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b957484e-19f0-4a7c-c67e-38f9d81fa879@intel.com>
Date:   Mon, 24 Aug 2020 15:41:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819084751.17686-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/20 11:47 am, Leo Yan wrote:
> From: Al Grant <al.grant@arm.com>
> 
> Commit 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> changed the format of branch stacks in perf samples. When samples use
> this new format, a flag must be set in the corresponding event.
> Synthesized branch stacks generated from Intel PT were using the new
> format, but not setting the event attribute, leading to consumers
> seeing corrupt data. This patch fixes the issue by setting the event
> attribute to indicate use of the new format.
> 
> Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> Signed-off-by: Al Grant <al.grant@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/intel-pt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 2a8d245351e7..0af4e81c46e2 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3017,8 +3017,15 @@ static int intel_pt_synth_events(struct intel_pt *pt,
>  
>  	if (pt->synth_opts.callchain)
>  		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
> -	if (pt->synth_opts.last_branch)
> +	if (pt->synth_opts.last_branch) {
>  		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
> +		/*
> +		 * We don't use the hardware index, but the sample generation
> +		 * code uses the new format branch_stack with this field,
> +		 * so the event attributes must indicate that it's present.
> +		 */
> +		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
> +	}
>  
>  	if (pt->synth_opts.instructions) {
>  		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
> 

