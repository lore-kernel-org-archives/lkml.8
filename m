Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7678C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8756E20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404871AbgFXQFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:05:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:52909 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404551AbgFXQFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:05:40 -0400
IronPort-SDR: 4zAy2CGEMIHZB1EweszIjL0AE3swoMAgX2aMI2EHCBAfVz4E6XtwGQyO47Trpp3K2VIyagYhZJ
 YUdEHAobOClQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="124782192"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="124782192"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 09:05:40 -0700
IronPort-SDR: RXeouA/apnHQ7YZett2vnnFyYNDVHOp1tzEFxw3NOrqoKcZLmcup13oGomgk+u/CrxQqo/B7LO
 IaaL/f74/7eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="385208483"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2020 09:05:37 -0700
Subject: Re: [PATCH] [perf] intel_pt_recording_options: Remove redundant
 intel_pt_evsel null check
To:     Jiri Olsa <jolsa@redhat.com>, Gaurav Singh <gaurav1086@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ian Rogers <irogers@google.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
References: <20200623234905.18608-1-gaurav1086@gmail.com>
 <20200624124241.GA2719003@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d99f3f5c-6abd-5ba5-90cd-7982571d5006@intel.com>
Date:   Wed, 24 Jun 2020 19:05:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200624124241.GA2719003@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/20 3:42 pm, Jiri Olsa wrote:
> On Tue, Jun 23, 2020 at 07:48:50PM -0400, Gaurav Singh wrote:
>> intel_pt_evsel cannot be NULL here since its already being
>> dereferenced above. Remove this redundant check.
>>
>> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
>> ---
>>  tools/perf/arch/x86/util/intel-pt.c | 24 +++++++++++-------------
>>  1 file changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
>> index 839ef52c1ac2..8cc87fd2dc6f 100644
>> --- a/tools/perf/arch/x86/util/intel-pt.c
>> +++ b/tools/perf/arch/x86/util/intel-pt.c
>> @@ -836,19 +836,17 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>>  		}
>>  	}
>>  
> 
> I wonder we sould put check before that above usage of intel_pt_evsel,
> because there's no check for that.. but yes, if intel_pt_evsel is NULL
> it will fail earlier.. Adrian?

The code was written when sampling-mode did not require an intel_pt_evsel.
Now it does, so intel_pt_evsel will not be NULL.  I think it is OK as is.

> 
> thanks,
> jirka
> 
>> -	if (intel_pt_evsel) {
>> -		/*
>> -		 * To obtain the auxtrace buffer file descriptor, the auxtrace
>> -		 * event must come first.
>> -		 */
>> -		perf_evlist__to_front(evlist, intel_pt_evsel);
>> -		/*
>> -		 * In the case of per-cpu mmaps, we need the CPU on the
>> -		 * AUX event.
>> -		 */
>> -		if (!perf_cpu_map__empty(cpus))
>> -			evsel__set_sample_bit(intel_pt_evsel, CPU);
>> -	}
>> +	/*
>> +	 * To obtain the auxtrace buffer file descriptor, the auxtrace
>> +	 * event must come first.
>> +	 */
>> +	perf_evlist__to_front(evlist, intel_pt_evsel);
>> +	/*
>> +	 * In the case of per-cpu mmaps, we need the CPU on the
>> +	 * AUX event.
>> +	 */
>> +	if (!perf_cpu_map__empty(cpus))
>> +		evsel__set_sample_bit(intel_pt_evsel, CPU);
>>  
>>  	/* Add dummy event to keep tracking */
>>  	if (opts->full_auxtrace) {
>> -- 
>> 2.17.1
>>
> 

