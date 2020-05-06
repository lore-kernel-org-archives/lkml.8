Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F282C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE5B206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgEFKww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:52:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:31903 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgEFKww (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:52:52 -0400
IronPort-SDR: XjjQWpQcYTTJ2+Y16gPbnf2w6w9lat1rPgzO+2I1fOtZLlsaxWCcmU5IgiWY6DTMbw5zoZ9eE/
 Alse6e+/fyiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 03:52:50 -0700
IronPort-SDR: xYWfGsZ9oIbWy2UUDHQU6YZjJ+T4E4TLCswPiYDVfGctCCL57OE7Qlzbh+3dpC4TqsB0zP1su/
 2pmDS80gReHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,358,1583222400"; 
   d="scan'208";a="369762589"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.255.30.99]) ([10.255.30.99])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2020 03:52:46 -0700
Subject: Re: [PATCH v2 2/2] perf stat: Report summary for interval mode
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200502020705.19295-1-yao.jin@linux.intel.com>
 <20200502020705.19295-3-yao.jin@linux.intel.com>
 <20200504234159.GF1916255@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e386585b-6208-63a1-82ad-a42c7d61ac72@linux.intel.com>
Date:   Wed, 6 May 2020 18:52:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504234159.GF1916255@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/5/2020 7:41 AM, Jiri Olsa wrote:
> On Sat, May 02, 2020 at 10:07:05AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   	init_stats(&walltime_nsecs_stats);
>>   	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
>>   	print_counters(&rs, 0, NULL);
>> +	walltime_nsecs_stats = walltime_nsecs_stats_bak;
>>   }
>>   
>>   static void enable_counters(void)
>> @@ -732,7 +735,14 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>   	 * avoid arbitrary skew, we must read all counters before closing any
>>   	 * group leaders.
>>   	 */
>> -	read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
>> +	if (!interval)
>> +		read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
>> +	else {
>> +		stat_config.interval = 0;
>> +		stat_config.summary = true;
>> +		perf_evlist__copy_summary_counts(evsel_list);
>> +		perf_evlist__process_summary_counts(&stat_config, evsel_list);
> 
> I think keeping the summary and copying it to evsel->count is ok,
> but when we pretend to have new counts in place, could we process
> it with perf_stat_process_counter function? so we keep just
> 1 processing code?
> 
> perhaps have some setup functions for non-interval settings?
> 
> SNIP
> 
>> +
>> +	evsel->prev_raw_counts->aggr = evsel->summary_counts->aggr;
>> +}
>> +
>> +void perf_evlist__copy_summary_counts(struct evlist *evlist)
>> +{
>> +	struct evsel *evsel;
>> +
>> +	evlist__for_each_entry(evlist, evsel)
>> +		perf_evsel__copy_summary_counts(evsel);
>> +}
>> +
>> +static void perf_stat_process_summary_counts(struct perf_stat_config *config,
>> +					     struct evsel *evsel)
>> +{
>> +	struct perf_counts_values *summary = &evsel->summary_counts->aggr;
> 
> as I said earlier, why not copy all summary_counts data into 'counts'
> and use the current code the process and display the result?
> 
> thanks,
> jirka
> 

I'm now working on a much simpler patchset. I will post v3.

Thanks
Jin Yao

>> +	struct perf_stat_evsel *ps = evsel->stats;
>> +	u64 *count = evsel->summary_counts->aggr.values;
>> +	int i;
>> +
>> +	if (!config->summary || config->aggr_mode != AGGR_GLOBAL)
>> +		return;
>> +
>> +	for (i = 0; i < 3; i++)
>> +		init_stats(&ps->res_stats[i]);
>> +
>> +	perf_counts_values__scale(summary, config->scale,
>> +				  &evsel->summary_counts->scaled);
>> +
>> +	for (i = 0; i < 3; i++)
> 
> SNIP
> 
