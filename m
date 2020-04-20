Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAB8C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C69206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgDTO7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:59:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:57430 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgDTO7Y (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:59:24 -0400
IronPort-SDR: dmT73muuylOQ63d8se5teCMIGWiSZ9ZuJGH5VzA2e8YPKtoF2TaeiPwm8ekesgvPZQg+MQ7Jre
 PQJOX1+IF3jg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 07:59:23 -0700
IronPort-SDR: XXK4GdzGXmrZi3l65EHShU54lESBk2xeuIS2plT+u330zClWH9A7Ks+6EFKlXps2OeJYZgezP9
 Crk8u1y7RlYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="245392876"
Received: from minliu1-mobl2.ccr.corp.intel.com (HELO [10.254.214.219]) ([10.254.214.219])
  by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2020 07:59:19 -0700
Subject: Re: [PATCH] perf stat: Improve runtime stat for interval mode
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200417005154.9024-1-yao.jin@linux.intel.com>
 <20200420091906.GG718574@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <84bc1330-dbcb-ea13-e1f6-db0fef214003@linux.intel.com>
Date:   Mon, 20 Apr 2020 22:59:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420091906.GG718574@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/20/2020 5:19 PM, Jiri Olsa wrote:
> On Fri, Apr 17, 2020 at 08:51:54AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index ec053dc1e35c..d5c326ff46d0 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -359,6 +359,7 @@ static void process_interval(void)
>>   	clock_gettime(CLOCK_MONOTONIC, &ts);
>>   	diff_timespec(&rs, &ts, &ref_time);
>>   
>> +	perf_stat__reset_rt_stat();
> 
> could you use just existing:
> 
> 	perf_stat__reset_shadow_per_stat(&rt_stat)
> 
> or perhaps event perf_stat__reset_shadow_stats, given
> that we init walltime_nsecs_stats just few lines below
> 
> jirka
>

Yes, I can use the existing function to reset rt_stat, I don't need to 
define a new one.

Posted v2 yet.

Thanks
Jin Yao

>>   	read_counters(&rs);
>>   
>>   	if (STAT_RECORD) {
> 
> SNIP
> 
