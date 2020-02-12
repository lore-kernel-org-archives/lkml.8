Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971F9C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FB720578
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBLEld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:41:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:47468 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgBLEld (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:41:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 20:41:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="406173139"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.249.160.130]) ([10.249.160.130])
  by orsmga005.jf.intel.com with ESMTP; 11 Feb 2020 20:41:28 -0800
Subject: Re: [PATCH v2] perf stat: Show percore counts in per CPU output
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200211023434.2220-1-yao.jin@linux.intel.com>
 <20200211232955.GB122432@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f5c10d38-1c6d-c9e7-8ff3-b8800748db0c@linux.intel.com>
Date:   Wed, 12 Feb 2020 12:41:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211232955.GB122432@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/2020 7:29 AM, Jiri Olsa wrote:
> On Tue, Feb 11, 2020 at 10:34:34AM +0800, Jin Yao wrote:
>> We have supported the event modifier "percore" which sums up the
>> event counts for all hardware threads in a core and show the counts
>> per core.
>>
>> For example,
>>
>>   # perf stat -e cpu/event=cpu-cycles,percore/ -a -A -- sleep 1
>>
>>    Performance counter stats for 'system wide':
>>
>>   S0-D0-C0                395,072      cpu/event=cpu-cycles,percore/
>>   S0-D0-C1                851,248      cpu/event=cpu-cycles,percore/
>>   S0-D0-C2                954,226      cpu/event=cpu-cycles,percore/
>>   S0-D0-C3              1,233,659      cpu/event=cpu-cycles,percore/
>>
>> This patch provides a new option "--percore-show-thread". It is
>> used with event modifier "percore" together to sum up the event counts
>> for all hardware threads in a core but show the counts per hardware
>> thread.
>>
>> This is essentially a replacement for the any bit (which is gone in
>> Icelake). Per core counts are useful for some formulas, e.g. CoreIPC.
>> The original percore version was inconvenient to post process. This
>> variant matches the output of the any bit.
>>
>> With this patch, for example,
>>
>>   # perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread  -- sleep 1
>>
>>    Performance counter stats for 'system wide':
>>
>>   CPU0               2,453,061      cpu/event=cpu-cycles,percore/
>>   CPU1               1,823,921      cpu/event=cpu-cycles,percore/
>>   CPU2               1,383,166      cpu/event=cpu-cycles,percore/
>>   CPU3               1,102,652      cpu/event=cpu-cycles,percore/
>>   CPU4               2,453,061      cpu/event=cpu-cycles,percore/
>>   CPU5               1,823,921      cpu/event=cpu-cycles,percore/
>>   CPU6               1,383,166      cpu/event=cpu-cycles,percore/
>>   CPU7               1,102,652      cpu/event=cpu-cycles,percore/
>>
>> We can see counts are duplicated in CPU pairs
>> (CPU0/CPU4, CPU1/CPU5, CPU2/CPU6, CPU3/CPU7).
>>
>>   v2:
>>   ---
>>   Add the explanation in change log. This is essentially a replacement
>>   for the any bit. No code change.
> 
> -I output is still wrong:
> 
> 	$ sudo ./perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread  -I 1000
> 	#           time CPU                    counts unit events
> 	     1.000251427      1.000251427 CPU0              43,474,700      cpu/event=cpu-cycles,percore/
> 	     1.000251427      1.000251427 CPU1              66,495,270      cpu/event=cpu-cycles,percore/
> 	     1.000251427      1.000251427 CPU2              42,342,367      cpu/event=cpu-cycles,percore/
> 	     1.000251427      1.000251427 CPU3              43,247,607      cpu/event=cpu-cycles,percore/
> 

Ah, double time output, I just realize this issue, very sorry about that :(

It doesn't need to print the prefix.

> plus some comments below,
> jirka
> 
> 
> SNIP
> 
>> @@ -628,7 +628,7 @@ static void aggr_cb(struct perf_stat_config *config,
>>   static void print_counter_aggrdata(struct perf_stat_config *config,
>>   				   struct evsel *counter, int s,
>>   				   char *prefix, bool metric_only,
>> -				   bool *first)
>> +				   bool *first, int cpu)
>>   {
>>   	struct aggr_data ad;
>>   	FILE *output = config->output;
>> @@ -654,8 +654,15 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>>   		fprintf(output, "%s", prefix);
>>   
>>   	uval = val * counter->scale;
>> -	printout(config, id, nr, counter, uval, prefix,
>> -		 run, ena, 1.0, &rt_stat);
>> +
>> +	if (cpu == -1) {
>> +		printout(config, id, nr, counter, uval, prefix,
>> +			 run, ena, 1.0, &rt_stat);
>> +	} else {
>> +		printout(config, cpu, nr, counter, uval, prefix,
>> +			 run, ena, 1.0, &rt_stat);
>> +	}
> 
> this would be shorter instad of above:
> 
> printout(config, cpu != -1 ?: id, nr, counter, uval, prefix, run, ena, 1.0, &rt_stat);
> 

Yes, that would be shorter.

>> +
>>   	if (!metric_only)
>>   		fputc('\n', output);
>>   }
>> @@ -687,7 +694,7 @@ static void print_aggr(struct perf_stat_config *config,
>>   		evlist__for_each_entry(evlist, counter) {
>>   			print_counter_aggrdata(config, counter, s,
>>   					       prefix, metric_only,
>> -					       &first);
>> +					       &first, -1);
>>   		}
>>   		if (metric_only)
>>   			fputc('\n', output);
>> @@ -1163,13 +1170,38 @@ static void print_percore(struct perf_stat_config *config,
>>   
>>   		print_counter_aggrdata(config, counter, s,
>>   				       prefix, metric_only,
>> -				       &first);
>> +				       &first, -1);
>>   	}
>>   
>>   	if (metric_only)
>>   		fputc('\n', output);
>>   }
>>   
>> +static void print_percore_thread(struct perf_stat_config *config,
>> +				 struct evsel *counter, char *prefix)
>> +{
>> +	int cpu, s, s2, id;
>> +	bool first = true;
>> +	FILE *output = config->output;
>> +
> 
> missing check for
>            if (!(config->aggr_map || config->aggr_get_id))
> 
> 

Yes, we should add checking for config->aggr_map and 
config->aggr_get_id, like what the print_aggr does.

>> +	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
>> +		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
> 
> should you use real cpu valu in here instead of an index? like value of:
> 
> 	perf_cpu_map__cpu(,evsel__cpus(counter), cpu)
> 
> instead of 'cpu' above
> 

Yes, my fault. I should use the cpu value here but not the cpu idx. 
Thanks for pointing this issue out.

>> +
>> +		for (s = 0; s < config->aggr_map->nr; s++) {
>> +			id = config->aggr_map->map[s];
>> +			if (s2 == id)
>> +				break;
>> +		}
>> +
>> +		if (prefix)
>> +			fprintf(output, "%s", prefix);
>> +
>> +		print_counter_aggrdata(config, counter, s,
>> +				       prefix, false,
>> +				       &first, cpu);
>> +	}
>> +}
>> +
>>   void
>>   perf_evlist__print_counters(struct evlist *evlist,
>>   			    struct perf_stat_config *config,
>> @@ -1222,9 +1254,16 @@ perf_evlist__print_counters(struct evlist *evlist,
>>   			print_no_aggr_metric(config, evlist, prefix);
>>   		else {
>>   			evlist__for_each_entry(evlist, counter) {
>> -				if (counter->percore)
>> -					print_percore(config, counter, prefix);
>> -				else
>> +				if (counter->percore) {
>> +					if (config->percore_show_thread) {
>> +						print_percore_thread(config,
>> +								     counter,
>> +								     prefix);
>> +					} else {
>> +						print_percore(config, counter,
>> +							      prefix);
> 
> please keep the print_percore call in here and check/call
> for the percore_show_thread in it
> 

OK, Yes, that's fine. I will keep the print_percore here and call 
percore_show_thread from it.

Thanks
Jin Yao

>> +					}
>> +				} else
>>   					print_counter(config, counter, prefix);
>>   			}
>>   		}
>> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
>> index fb990efa54a8..b4fdfaa7f2c0 100644
>> --- a/tools/perf/util/stat.h
>> +++ b/tools/perf/util/stat.h
>> @@ -109,6 +109,7 @@ struct perf_stat_config {
>>   	bool			 walltime_run_table;
>>   	bool			 all_kernel;
>>   	bool			 all_user;
>> +	bool			 percore_show_thread;
>>   	FILE			*output;
>>   	unsigned int		 interval;
>>   	unsigned int		 timeout;
>> -- 
>> 2.17.1
>>
> 
