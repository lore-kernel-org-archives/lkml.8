Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483E2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221F4206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404768AbgFXQF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:05:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:2419 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404503AbgFXQF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:05:29 -0400
IronPort-SDR: s0yWpK82lRo4MREWLCwZtXvulRO5AVKiPrWY74zFV8jnx/ixDJ4CP22Coz1dPKQyRQcuzZsR35
 aP23A1KppFqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="131956387"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="131956387"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 09:05:28 -0700
IronPort-SDR: Xaxzl8waK90AozKfIeCdD7dRFk0jFr33uE8BYTqVtLyeJ48U1IjcznpR4D+PWsHO8KGGer7JJj
 K6F1+dwW8c/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="385208447"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2020 09:05:25 -0700
Subject: Re: [PATCH] [perf] intel_pt_recording_options: Remove redundant
 intel_pt_evsel null check
To:     Gaurav Singh <gaurav1086@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ian Rogers <irogers@google.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
References: <20200623234905.18608-1-gaurav1086@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <39a03e45-472c-c7ef-76f8-e36a714d62bf@intel.com>
Date:   Wed, 24 Jun 2020 19:04:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200623234905.18608-1-gaurav1086@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/20 2:48 am, Gaurav Singh wrote:
> intel_pt_evsel cannot be NULL here since its already being
> dereferenced above. Remove this redundant check.
> 
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/x86/util/intel-pt.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 839ef52c1ac2..8cc87fd2dc6f 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -836,19 +836,17 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  		}
>  	}
>  
> -	if (intel_pt_evsel) {
> -		/*
> -		 * To obtain the auxtrace buffer file descriptor, the auxtrace
> -		 * event must come first.
> -		 */
> -		perf_evlist__to_front(evlist, intel_pt_evsel);
> -		/*
> -		 * In the case of per-cpu mmaps, we need the CPU on the
> -		 * AUX event.
> -		 */
> -		if (!perf_cpu_map__empty(cpus))
> -			evsel__set_sample_bit(intel_pt_evsel, CPU);
> -	}
> +	/*
> +	 * To obtain the auxtrace buffer file descriptor, the auxtrace
> +	 * event must come first.
> +	 */
> +	perf_evlist__to_front(evlist, intel_pt_evsel);
> +	/*
> +	 * In the case of per-cpu mmaps, we need the CPU on the
> +	 * AUX event.
> +	 */
> +	if (!perf_cpu_map__empty(cpus))
> +		evsel__set_sample_bit(intel_pt_evsel, CPU);
>  
>  	/* Add dummy event to keep tracking */
>  	if (opts->full_auxtrace) {
> 

