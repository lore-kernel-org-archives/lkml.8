Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B7C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3912054F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgEHCDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:03:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:49304 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgEHCDg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:03:36 -0400
IronPort-SDR: XrnOrlsuBSK0hfcOuD9+g7QLjCE2jILqOZF8WQvc18ajYQ7rL5S9I8VjdRWfITfYSrIjT5QLNv
 0qbg9av5FdfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 19:03:34 -0700
IronPort-SDR: bWkDiNSVm8GbpzdQBrJkQ64jnnFB/+2Mwvzm271SGgiyGhZUoEpLbz7+gLbzVZjXrkuvv8d8+e
 fTxkoNi2pjVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="370303981"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 19:03:32 -0700
Subject: Re: [PATCH v3 1/4] perf stat: Fix wrong per-thread runtime stat for
 interval mode
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200507065822.8255-1-yao.jin@linux.intel.com>
 <20200507065822.8255-2-yao.jin@linux.intel.com>
 <20200507151919.GE2804092@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <baf21213-0fd5-9973-b8bf-2566bab50580@linux.intel.com>
Date:   Fri, 8 May 2020 10:03:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200507151919.GE2804092@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/7/2020 11:19 PM, Jiri Olsa wrote:
> On Thu, May 07, 2020 at 02:58:19PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index e0c1ad23c768..97ee941649e6 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -351,6 +351,16 @@ static void read_counters(struct timespec *rs)
>>   	}
>>   }
>>   
>> +static void thread_stats_reset(struct perf_stat_config *config)
>> +{
>> +	int i;
>> +
>> +	if (config->stats) {
>> +		for (i = 0; i < config->stats_num; i++)
>> +			perf_stat__reset_shadow_per_stat(&config->stats[i]);
>> +	}
>> +}
>> +
>>   static void process_interval(void)
>>   {
>>   	struct timespec ts, rs;
>> @@ -359,6 +369,7 @@ static void process_interval(void)
>>   	diff_timespec(&rs, &ts, &ref_time);
>>   
>>   	perf_stat__reset_shadow_per_stat(&rt_stat);
>> +	thread_stats_reset(&stat_config);
> 
> can't you call in here perf_stat__reset_stats?
> 

If we call perf_stat__reset_stat here, it will reset the evsel->counts, but I 
don't think it's necessary. The counts will be updated in read_counts() soon.

> and if not, I know it's threads related, but new
> and delete functions are:
> 
>    runtime_stat_new, runtime_stat_delete
> 
> so let's call it runtime_stat_reset and place it next to
> the new/delete functions
>

Yes, that's good idea. I will create runtime_stat_reset and place it next to
untime_stat_new/runtime_stat_delete.

> other than that it looks ok, thanks
> 
> jirka
> 

Thanks!

Thanks
Jin Yao

>>   	read_counters(&rs);
>>   
>>   	if (STAT_RECORD) {
>> -- 
>> 2.17.1
>>
> 
