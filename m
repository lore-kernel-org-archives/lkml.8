Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9057DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F4A2064C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGGQnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:43:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:56936 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgGGQnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:43:33 -0400
IronPort-SDR: vwEPATn9OEm6bJy6J7o8z0/VIHXzivsVaGdPL49QbqJBVA+AWYzCyMVHb4aaeceqQKw0xA5mqa
 FyOxlj/HEBpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="212602699"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="212602699"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 09:43:32 -0700
IronPort-SDR: oQJ/tEihpDHExqAfyy+Cnpez1MU6oJYlK9ZIkEtPwN0yIGIoumosSVlUET8NOTFm5yQnJ1Xoys
 KKPo4owxLmCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="314370861"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2020 09:43:31 -0700
Received: from [10.249.228.33] (abudanko-mobl.ccr.corp.intel.com [10.249.228.33])
        by linux.intel.com (Postfix) with ESMTP id 7379458033E;
        Tue,  7 Jul 2020 09:43:29 -0700 (PDT)
Subject: Re: [PATCH v9 11/15] perf stat: implement control commands handling
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <21669f5a-6220-df0a-09f1-b73b32487f23@linux.intel.com>
 <20200706123436.GD3401866@krava>
 <6cf91811-ea6a-3c7c-8bbf-7f96bfa1fc82@linux.intel.com>
 <20200706193418.GB3424581@krava>
 <b28806b9-b66e-aa2e-5425-4d9f00341387@linux.intel.com>
 <20200707131403.GD3424581@krava>
 <865ad42a-6085-41d6-06d5-730cb9904ce8@linux.intel.com>
 <20200707142351.GE3424581@krava>
 <44f494d6-b4a5-2d56-001e-b3289cbeedaa@linux.intel.com>
 <20200707160524.GA3524217@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1a996f82-edce-1a27-2dda-5f162e358cfe@linux.intel.com>
Date:   Tue, 7 Jul 2020 19:43:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707160524.GA3524217@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.07.2020 19:05, Jiri Olsa wrote:
> On Tue, Jul 07, 2020 at 05:55:14PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> process_evlist() now looks suboptimal since record mode code directly calls evlist__ctlfd_process()
>> and then handles returned command specifically to the mode. So in v10 I replaced process_evlist()
>> call with direct evlist__ctlfd_process() call and then handling the returned command by printing
>> command msg tag and counter values in the required order. Like this:
>>
>> +		clock_gettime(CLOCK_MONOTONIC, &time_start);
>> +		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
>> +			if (timeout)
>> +				break;
>> +			else
>> +				stop = handle_interval(interval, times);
>> +			time_to_sleep = sleep_time;
>> +		} else { /* fd revent */
>> +			if (evlist__ctlfd_process(evsel_list, &cmd) > 0) {
>> +				if (interval) {
>> +					switch (cmd) {
>> +					case EVLIST_CTL_CMD_ENABLE:
>> +						pr_info(EVLIST_ENABLED_MSG);
>> +						process_interval();
>> +						break;
>> +					case EVLIST_CTL_CMD_DISABLE:
>> +						process_interval();
>> +						pr_info(EVLIST_DISABLED_MSG);
>> +						break;
>> +					case EVLIST_CTL_CMD_ACK:
>> +					case EVLIST_CTL_CMD_UNSUPPORTED:
>> +					default:
>> +						break;
>> +					}
>> +				}
>> +			}
>> +			clock_gettime(CLOCK_MONOTONIC, &time_stop);
>> +			compute_tts(&time_start, &time_stop, &time_to_sleep);
>> +		}
> 
> 
> hum, why not just get the bool from process_evlist like below?

Yes, also possible and works. However it checks twice to implement
parts of logically the same work and passes the result using extra
memory: switch/case at process_evlist(), 'if' at dispatch_events(),
dispatch_events() should also call process_interval() instead of 
handle_interval() to avoid wasting of times counter for commands.

Alexey

> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 5021f7286422..32dd3de93f35 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -485,20 +485,20 @@ static bool handle_interval(unsigned int interval, int *times)
>  	return false;
>  }
>  
> -static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
> +static bool process_evlist(struct evlist *evlist)
>  {
> -	bool stop = false;
>  	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
> +	bool display = false;
>  
>  	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
>  		switch (cmd) {
>  		case EVLIST_CTL_CMD_ENABLE:
>  			pr_info(EVLIST_ENABLED_MSG);
> -			stop = handle_interval(interval, times);
> +			display = true;
>  			break;
>  		case EVLIST_CTL_CMD_DISABLE:
> -			stop = handle_interval(interval, times);
>  			pr_info(EVLIST_DISABLED_MSG);
> +			display = true;
>  			break;
>  		case EVLIST_CTL_CMD_ACK:
>  		case EVLIST_CTL_CMD_UNSUPPORTED:
> @@ -507,7 +507,7 @@ static bool process_evlist(struct evlist *evlist, unsigned int interval, int *ti
>  		}
>  	}
>  
> -	return stop;
> +	return display;
>  }
>  
>  static void enable_counters(void)
> @@ -618,7 +618,8 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times)
>  				stop = handle_interval(interval, times);
>  			time_to_sleep = sleep_time;
>  		} else { /* fd revent */
> -			stop = process_evlist(evsel_list, interval, times);
> +			if (process_evlist(evsel_list))
> +				stop = handle_interval(interval, times);
>  			clock_gettime(CLOCK_MONOTONIC, &time_stop);
>  			diff_timespec(&time_diff, &time_stop, &time_start);
>  			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +
> 
