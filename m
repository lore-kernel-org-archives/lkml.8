Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E655C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F0F2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgBJNqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:46:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:49941 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbgBJNqu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:46:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:46:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="405590568"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.249.160.130]) ([10.249.160.130])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2020 05:46:47 -0800
Subject: Re: [PATCH] perf stat: Show percore counts in per CPU output
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200206015613.527-1-yao.jin@linux.intel.com>
 <20200210132804.GA9922@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f749694f-b3b3-c498-74ea-ec2e6bb0d0f1@linux.intel.com>
Date:   Mon, 10 Feb 2020 21:46:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210132804.GA9922@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/2020 9:28 PM, Jiri Olsa wrote:
> On Thu, Feb 06, 2020 at 09:56:13AM +0800, Jin Yao wrote:
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
>> For example,
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
> 
> I don't understand how is this different from -A output:
> 
>    # ./perf stat -e cpu/event=cpu-cycles/ -A
>    ^C
>     Performance counter stats for 'system wide':
> 
>    CPU0              56,847,497      cpu/event=cpu-cycles/
>    CPU1              75,274,384      cpu/event=cpu-cycles/
>    CPU2              63,866,342      cpu/event=cpu-cycles/
>    CPU3              89,559,693      cpu/event=cpu-cycles/
>    CPU4              74,761,132      cpu/event=cpu-cycles/
>    CPU5              76,320,191      cpu/event=cpu-cycles/
>    CPU6              55,100,175      cpu/event=cpu-cycles/
>    CPU7              48,472,895      cpu/event=cpu-cycles/
> 
>         1.074800857 seconds time elapsed
> 

The results are different.

With --percore-show-thread, CPU0 and CPU4 have the same counts (CPU0 and 
CPU4 are siblings, e.g. 2,453,061 in my example). The value is sum of 
CPU0 + CPU4.

Without --percore-show-thread, CPU0 and CPU4 have their own counts.

> also the interval output is mangled:
> 
>    # ./perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread  -I 1000
>    #           time CPU                    counts unit events
>       1.000177375      1.000177375 CPU0             138,483,540      cpu/event=cpu-cycles,percore/
>       1.000177375      1.000177375 CPU1             143,159,477      cpu/event=cpu-cycles,percore/
>       1.000177375      1.000177375 CPU2             177,554,642      cpu/event=cpu-cycles,percore/
>       1.000177375      1.000177375 CPU3             150,974,512      cpu/event=cpu-cycles,percore/
>       1.000177375      1.000177375 CPU4             138,483,540      cpu/event=cpu-cycles,percore/
>       1.000177375      1.000177375 CPU5             143,159,477      cpu/event=cpu-cycles,percore/
>       1.000177375      1.000177375 CPU6             177,554,642      cpu/event=cpu-cycles,percore/
> 
> jirka
> 

Sorry, why the interval output is mangled? It's expected that CPU0 and 
CPU4 have the same counts.

Thanks
Jin Yao

