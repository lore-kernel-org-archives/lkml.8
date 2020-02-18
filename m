Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA989C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81C020836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgBRBCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 20:02:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:54819 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgBRBCz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:02:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 17:02:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,454,1574150400"; 
   d="scan'208";a="228151092"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.238.4.8]) ([10.238.4.8])
  by fmsmga007.fm.intel.com with ESMTP; 17 Feb 2020 17:02:52 -0800
Subject: Re: [PATCH v4] perf stat: Show percore counts in per CPU output
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200214080452.26402-1-yao.jin@linux.intel.com>
 <20200216225407.GB157041@krava>
 <d79a1bbe-bca5-0420-0480-1d508d2a038c@linux.intel.com>
 <20200217110629.GD157041@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <9c16e98e-aa9e-8879-0690-990a5dcda303@linux.intel.com>
Date:   Tue, 18 Feb 2020 09:02:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217110629.GD157041@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/2020 7:06 PM, Jiri Olsa wrote:
> On Mon, Feb 17, 2020 at 09:22:57AM +0800, Jin, Yao wrote:
>>
>>
>> On 2/17/2020 6:54 AM, Jiri Olsa wrote:
>>> On Fri, Feb 14, 2020 at 04:04:52PM +0800, Jin Yao wrote:
>>>
>>> SNIP
>>>
>>>>    CPU1               1,009,312      cpu/event=cpu-cycles,percore/
>>>>    CPU2               2,784,072      cpu/event=cpu-cycles,percore/
>>>>    CPU3               2,427,922      cpu/event=cpu-cycles,percore/
>>>>    CPU4               2,752,148      cpu/event=cpu-cycles,percore/
>>>>    CPU6               2,784,072      cpu/event=cpu-cycles,percore/
>>>>    CPU7               2,427,922      cpu/event=cpu-cycles,percore/
>>>>
>>>>           1.001416041 seconds time elapsed
>>>>
>>>>    v4:
>>>>    ---
>>>>    Ravi Bangoria reports an issue in v3. Once we offline a CPU,
>>>>    the output is not correct. The issue is we should use the cpu
>>>>    idx in print_percore_thread rather than using the cpu value.
>>>
>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>>
>>
>> Thanks so much for ACK this patch. :)
>>
>>> btw, there's slight misalignment in -I output, but not due
>>> to your change, it's there for some time now, and probably
>>> in other agregation  outputs as well:
>>>
>>>
>>>     $ sudo ./perf stat -e cpu/event=cpu-cycles/ -a -A  -I 1000
>>>     #           time CPU                    counts unit events
>>>          1.000224464 CPU0               7,251,151      cpu/event=cpu-cycles/
>>>          1.000224464 CPU1              21,614,946      cpu/event=cpu-cycles/
>>>          1.000224464 CPU2              30,812,097      cpu/event=cpu-cycles/
>>>
>>> should be (extra space after CPUX):
>>>
>>>          1.000224464 CPU2               30,812,097      cpu/event=cpu-cycles/
>>>
>>> I'll put it on my TODO, but if you're welcome to check on it ;-)
>>>
>>> thanks,
>>> jirka
>>>
>>
>> I have a simple fix for this misalignment issue.
>>
>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>> index bc31fccc0057..95b29c9cba36 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -114,11 +114,11 @@ static void aggr_printout(struct perf_stat_config
>> *config,
>>                          fprintf(config->output, "S%d-D%d-C%*d%s",
>>                                  cpu_map__id_to_socket(id),
>>                                  cpu_map__id_to_die(id),
>> -                               config->csv_output ? 0 : -5,
>> +                               config->csv_output ? 0 : -3,
>>                                  cpu_map__id_to_cpu(id), config->csv_sep);
>>                  } else {
>> -                       fprintf(config->output, "CPU%*d%s ",
>> -                               config->csv_output ? 0 : -5,
>> +                       fprintf(config->output, "CPU%*d%s",
>> +                               config->csv_output ? 0 : -7,
>>                                  evsel__cpus(evsel)->map[id],
>>                                  config->csv_sep);
> 
> I guess that's ok, will that work with higher (3 digit) cpu numbers?
> 
> jirka
> 

Yes, it works with hundreds of CPU. I have tested with that case.

BTW, do you need me to post a separate patch or you will add this fix in 
your patch series?

Thanks
Jin Yao

>>                  }
>>
>> Following command lines are tested OK.
>>
>> perf stat -e cpu/event=cpu-cycles/ -I 1000
>> perf stat -e cpu/event=cpu-cycles/ -a -I 1000
>> perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000
>> perf stat -e cpu/event=cpu-cycles,percore/ -a -A -I 1000
>> perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread -I
>> 1000
>>
>> Could you help to look at that?
>>
>> Thanks
>> Jin Yao
>>
> 
