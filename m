Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353B9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164E2207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgHLNmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:42:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:44726 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHLNmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:42:24 -0400
IronPort-SDR: OufvAZcy2nwEEJkebiEzUqlVNQiufbY02hzcPptz7pIe3jE1e5zFsLHyJCcaoc2hEmtssCfKFs
 XsFTrE6XRacQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="134007706"
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="134007706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 06:42:23 -0700
IronPort-SDR: aPlriRr8VqNjD5ld++sd6RWd+F04QO3Etlyd7GCKUnllvm1r6lh3zhj+SBOdhqEQ9oA/L6OaUh
 ZIL/i6JXc6bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="295070521"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2020 06:42:23 -0700
Received: from [10.251.5.39] (kliang2-MOBL.ccr.corp.intel.com [10.251.5.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0320E580785;
        Wed, 12 Aug 2020 06:42:21 -0700 (PDT)
Subject: Re: [PATCH V6 06/16] perf script: Use ULL for enum perf_output_field
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, ak@linux.intel.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-7-kan.liang@linux.intel.com>
 <20200812122139.GG13995@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b6d59617-c3a1-62e6-5141-cd0353d22e2f@linux.intel.com>
Date:   Wed, 12 Aug 2020 09:42:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812122139.GG13995@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/2020 8:21 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 10, 2020 at 02:24:26PM -0700, Kan Liang escreveu:
>> The Bitwise-Shift operator (1U << ) is used in the enum
>> perf_output_field, which has already reached its capacity (32 items).
>> If more items are added, a compile error will be triggered.
>>
>> Change the U to ULL, which extend the capacity to 64 items.
>>
>> The enum perf_output_field is only used to calculate a value for the
>> 'fields' in the output structure. The 'fields' is u64. The change
>> doesn't break anything.
> 
> Jiri did this already:
> 
> https://git.kernel.org/torvalds/c/60e5eeb56a1

Thanks for pointing it out.

I will rebase the code on top of it.

Thanks,
Kan

>   
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/builtin-script.c | 64 ++++++++++++++++++-------------------
>>   1 file changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 447457786362..214bec350971 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -82,38 +82,38 @@ static bool			native_arch;
>>   unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
>>   
>>   enum perf_output_field {
>> -	PERF_OUTPUT_COMM            = 1U << 0,
>> -	PERF_OUTPUT_TID             = 1U << 1,
>> -	PERF_OUTPUT_PID             = 1U << 2,
>> -	PERF_OUTPUT_TIME            = 1U << 3,
>> -	PERF_OUTPUT_CPU             = 1U << 4,
>> -	PERF_OUTPUT_EVNAME          = 1U << 5,
>> -	PERF_OUTPUT_TRACE           = 1U << 6,
>> -	PERF_OUTPUT_IP              = 1U << 7,
>> -	PERF_OUTPUT_SYM             = 1U << 8,
>> -	PERF_OUTPUT_DSO             = 1U << 9,
>> -	PERF_OUTPUT_ADDR            = 1U << 10,
>> -	PERF_OUTPUT_SYMOFFSET       = 1U << 11,
>> -	PERF_OUTPUT_SRCLINE         = 1U << 12,
>> -	PERF_OUTPUT_PERIOD          = 1U << 13,
>> -	PERF_OUTPUT_IREGS	    = 1U << 14,
>> -	PERF_OUTPUT_BRSTACK	    = 1U << 15,
>> -	PERF_OUTPUT_BRSTACKSYM	    = 1U << 16,
>> -	PERF_OUTPUT_DATA_SRC	    = 1U << 17,
>> -	PERF_OUTPUT_WEIGHT	    = 1U << 18,
>> -	PERF_OUTPUT_BPF_OUTPUT	    = 1U << 19,
>> -	PERF_OUTPUT_CALLINDENT	    = 1U << 20,
>> -	PERF_OUTPUT_INSN	    = 1U << 21,
>> -	PERF_OUTPUT_INSNLEN	    = 1U << 22,
>> -	PERF_OUTPUT_BRSTACKINSN	    = 1U << 23,
>> -	PERF_OUTPUT_BRSTACKOFF	    = 1U << 24,
>> -	PERF_OUTPUT_SYNTH           = 1U << 25,
>> -	PERF_OUTPUT_PHYS_ADDR       = 1U << 26,
>> -	PERF_OUTPUT_UREGS	    = 1U << 27,
>> -	PERF_OUTPUT_METRIC	    = 1U << 28,
>> -	PERF_OUTPUT_MISC            = 1U << 29,
>> -	PERF_OUTPUT_SRCCODE	    = 1U << 30,
>> -	PERF_OUTPUT_IPC             = 1U << 31,
>> +	PERF_OUTPUT_COMM            = 1ULL << 0,
>> +	PERF_OUTPUT_TID             = 1ULL << 1,
>> +	PERF_OUTPUT_PID             = 1ULL << 2,
>> +	PERF_OUTPUT_TIME            = 1ULL << 3,
>> +	PERF_OUTPUT_CPU             = 1ULL << 4,
>> +	PERF_OUTPUT_EVNAME          = 1ULL << 5,
>> +	PERF_OUTPUT_TRACE           = 1ULL << 6,
>> +	PERF_OUTPUT_IP              = 1ULL << 7,
>> +	PERF_OUTPUT_SYM             = 1ULL << 8,
>> +	PERF_OUTPUT_DSO             = 1ULL << 9,
>> +	PERF_OUTPUT_ADDR            = 1ULL << 10,
>> +	PERF_OUTPUT_SYMOFFSET       = 1ULL << 11,
>> +	PERF_OUTPUT_SRCLINE         = 1ULL << 12,
>> +	PERF_OUTPUT_PERIOD          = 1ULL << 13,
>> +	PERF_OUTPUT_IREGS	    = 1ULL << 14,
>> +	PERF_OUTPUT_BRSTACK	    = 1ULL << 15,
>> +	PERF_OUTPUT_BRSTACKSYM	    = 1ULL << 16,
>> +	PERF_OUTPUT_DATA_SRC	    = 1ULL << 17,
>> +	PERF_OUTPUT_WEIGHT	    = 1ULL << 18,
>> +	PERF_OUTPUT_BPF_OUTPUT	    = 1ULL << 19,
>> +	PERF_OUTPUT_CALLINDENT	    = 1ULL << 20,
>> +	PERF_OUTPUT_INSN	    = 1ULL << 21,
>> +	PERF_OUTPUT_INSNLEN	    = 1ULL << 22,
>> +	PERF_OUTPUT_BRSTACKINSN	    = 1ULL << 23,
>> +	PERF_OUTPUT_BRSTACKOFF	    = 1ULL << 24,
>> +	PERF_OUTPUT_SYNTH           = 1ULL << 25,
>> +	PERF_OUTPUT_PHYS_ADDR       = 1ULL << 26,
>> +	PERF_OUTPUT_UREGS	    = 1ULL << 27,
>> +	PERF_OUTPUT_METRIC	    = 1ULL << 28,
>> +	PERF_OUTPUT_MISC            = 1ULL << 29,
>> +	PERF_OUTPUT_SRCCODE	    = 1ULL << 30,
>> +	PERF_OUTPUT_IPC             = 1ULL << 31,
>>   };
>>   
>>   struct output_option {
>> -- 
>> 2.17.1
>>
> 
