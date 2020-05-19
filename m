Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA5BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED422072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgESCvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:51:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:6742 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgESCvv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:51:51 -0400
IronPort-SDR: ftivuqErd0wIe2NNBfFLwd/E4VkutgjlFlBLvxrnH5I3rk0NxKMbx0P6WFKN/3PBglTmb1f/nN
 gxXjoBT7R0xA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 19:51:50 -0700
IronPort-SDR: aEDM2V2zqBosuin09cVqTASYR2J/Dfa8h1XD35Pp2/vcUU6t+3y6oI89v3OBDjpilDBVVqTJMR
 EFUkRAoQGJ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="373588140"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.212.132]) ([10.254.212.132])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2020 19:51:47 -0700
Subject: Re: [PATCH v5 5/5] perf stat: Report summary for interval mode
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200514053638.3736-1-yao.jin@linux.intel.com>
 <20200514053638.3736-6-yao.jin@linux.intel.com>
 <20200518124732.GE3726797@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6170d482-d537-d122-fead-1f883d3c270f@linux.intel.com>
Date:   Tue, 19 May 2020 10:51:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518124732.GE3726797@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/18/2020 8:47 PM, Jiri Olsa wrote:
> On Thu, May 14, 2020 at 01:36:38PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   
>>   	evlist__for_each_entry(evsel_list, counter) {
>>   		if (counter->err)
>> @@ -394,6 +403,7 @@ static void runtime_stat_reset(struct perf_stat_config *config)
>>   static void process_interval(void)
>>   {
>>   	struct timespec ts, rs;
>> +	struct stats walltime_nsecs_stats_bak;
>>   
>>   	clock_gettime(CLOCK_MONOTONIC, &ts);
>>   	diff_timespec(&rs, &ts, &ref_time);
>> @@ -407,9 +417,11 @@ static void process_interval(void)
>>   			pr_err("failed to write stat round event\n");
>>   	}
>>   
>> +	walltime_nsecs_stats_bak = walltime_nsecs_stats;
>>   	init_stats(&walltime_nsecs_stats);
>>   	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
>>   	print_counters(&rs, 0, NULL);
>> +	walltime_nsecs_stats = walltime_nsecs_stats_bak;
> 
> could we instead of above initialize walltime_nsecs_stats
> in the condition below, like:
> 
> 	init_stats(&walltime_nsecs_stats);
> 	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
> 
> jirka
> 

Yes, I think that's OK and better. My fix is:

@@ -775,11 +772,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
         if (stat_config.walltime_run_table)
                 stat_config.walltime_run[run_idx] = t1 - t0;

-       update_stats(&walltime_nsecs_stats, t1 - t0);
-
         if (interval) {
                 stat_config.interval = 0;
                 stat_config.summary = true;
+               init_stats(&walltime_nsecs_stats);
+               update_stats(&walltime_nsecs_stats, t1 - t0);

                 if (stat_config.aggr_mode == AGGR_GLOBAL)
                         perf_evlist__save_aggr_prev_raw_counts(evsel_list);
@@ -788,7 +785,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
                 perf_evlist__reset_prev_raw_counts(evsel_list);
                 runtime_stat_reset(&stat_config);
                 perf_stat__reset_shadow_per_stat(&rt_stat);
-       }
+       } else
+               update_stats(&walltime_nsecs_stats, t1 - t0);

         /*
          * Closing a group leader splits the group, and as we only disable

Thanks
Jin Yao

>>   }
>>   
>>   static void enable_counters(void)
>> @@ -765,6 +777,19 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>   
>>   	update_stats(&walltime_nsecs_stats, t1 - t0);
>>   
>> +	if (interval) {
>> +		stat_config.interval = 0;
>> +		stat_config.summary = true;
>> +
>> +		if (stat_config.aggr_mode == AGGR_GLOBAL)
>> +			perf_evlist__save_aggr_prev_raw_counts(evsel_list);
>> +
>> +		perf_evlist__copy_prev_raw_counts(evsel_list);
>> +		perf_evlist__reset_prev_raw_counts(evsel_list);
>> +		runtime_stat_reset(&stat_config);
>> +		perf_stat__reset_shadow_per_stat(&rt_stat);
>> +	}
>> +
> 
> SNIP
> 
