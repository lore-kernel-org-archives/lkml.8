Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F46C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A223122525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgATUrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:47:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:39913 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgATUrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 15:47:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 12:47:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,343,1574150400"; 
   d="scan'208";a="227140992"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 20 Jan 2020 12:47:24 -0800
Received: from [10.251.23.107] (kliang2-mobl.ccr.corp.intel.com [10.251.23.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D700F5802C1;
        Mon, 20 Jan 2020 12:47:23 -0800 (PST)
Subject: Re: [RESEND PATCH V5 1/2] perf/core: Add new branch sample type for
 HW index of raw branch records
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     eranian@google.com, acme@redhat.com, mingo@kernel.org,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com
References: <20200116155757.19624-1-kan.liang@linux.intel.com>
 <20200116155757.19624-2-kan.liang@linux.intel.com>
 <20200120092300.GK14879@hirez.programming.kicks-ass.net>
 <88802724-aa70-23bc-b2c8-a7a34aa3dfe5@linux.intel.com>
 <20200120202445.GD14914@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <71ead9fd-04db-e859-2842-3eddc77c35c4@linux.intel.com>
Date:   Mon, 20 Jan 2020 15:47:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120202445.GD14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2020 3:24 PM, Peter Zijlstra wrote:
> On Mon, Jan 20, 2020 at 11:50:59AM -0500, Liang, Kan wrote:
>>
>>
>> On 1/20/2020 4:23 AM, Peter Zijlstra wrote:
>>> On Thu, Jan 16, 2020 at 07:57:56AM -0800, kan.liang@linux.intel.com wrote:
>>>
>>>>    struct perf_branch_stack {
>>>>    	__u64				nr;
>>>> +	__u64				hw_idx;
>>>>    	struct perf_branch_entry	entries[0];
>>>>    };
>>>
>>> The above and below order doesn't match.
>>>
>>>> @@ -849,7 +853,11 @@ enum perf_event_type {
>>>>    	 *	  char                  data[size];}&& PERF_SAMPLE_RAW
>>>>    	 *
>>>>    	 *	{ u64                   nr;
>>>> -	 *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
>>>> +	 *        { u64 from, to, flags } lbr[nr];
>>>> +	 *
>>>> +	 *        # only available if PERF_SAMPLE_BRANCH_HW_INDEX is set
>>>> +	 *        u64			hw_idx;
>>>> +	 *      } && PERF_SAMPLE_BRANCH_STACK
>>>
>>> That wants to be written as:
>>>
>>> 		{ u64			nr;
>>> 		  { u64 from, to, flags; } entries[nr];
>>> 		  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
>>> 		} && PERF_SAMPLE_BRANCH_STACK
>>>
>>> But the big question is; why isn't it:
>>>
>>> 		{ u64			nr;
>>> 		  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
>>> 		  { u64 from, to, flags; } entries[nr];
>>> 		} && PERF_SAMPLE_BRANCH_STACK
>>>
>>> to match the struct perf_branch_stack order. Having that variable sized
>>> entry in the middle just seems weird.
>>
>>
>> Usually, new data should be output to the end of a sample.
> 
> Because.... you want old tools to read new output?
>

Yes, for some cases, it helps.
If no other sample types are output after PERF_SAMPLE_BRANCH_STACK,
old perf tool will ignore the hw_idx.
But, if we also have to output other sample types, e.g 
PERF_SAMPLE_DATA_SRC or PERF_SAMPLE_PHYS_ADDR, which are output after 
PERF_SAMPLE_BRANCH_STACK. The hw_idx will mess them up.
Old perf tool doesn't work anymore.


>> However, the entries[0] is sized entry, so I have to put the hw_idx before
> 
> entries[0] is only in the C thing, and in C you indeed have to put
> hw_idx before.
> 
>> entry. It makes the inconsistency. Sorry for the confusion caused.
> 
> n/p it's clear now I think.

Should I send V6 patch to move hw_idx before entry as below?

@@ -853,7 +857,9 @@ enum perf_event_type {
          *        char                  data[size];}&& PERF_SAMPLE_RAW
          *
          *      { u64                   nr;
-        *        { u64 from, to, flags } lbr[nr];} && 
PERF_SAMPLE_BRANCH_STACK
+        *        { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
+        *        { u64 from, to, flags } lbr[nr];
+        *      } && PERF_SAMPLE_BRANCH_STACK
          *
          *      { u64                   abi; # enum perf_sample_regs_abi
          *        u64                   regs[weight(mask)]; } && 
PERF_SAMPLE_REGS_USER

@@ -6634,6 +6639,8 @@ void perf_output_sample(struct perf_output_handle 
*handle,
                              * sizeof(struct perf_branch_entry);

                         perf_output_put(handle, data->br_stack->nr);
+                       if (perf_sample_save_hw_index(event))
+                               perf_output_put(handle, 
data->br_stack->hw_idx);
                         perf_output_copy(handle, 
data->br_stack->entries, size);
                 } else {
                         /*



Thanks,
Kan
