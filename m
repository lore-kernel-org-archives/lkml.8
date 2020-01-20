Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4093AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BD92073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgATQvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:51:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:45399 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgATQvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:51:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 08:51:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="275080916"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2020 08:51:03 -0800
Received: from [10.251.23.107] (kliang2-mobl.ccr.corp.intel.com [10.251.23.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1D39E58033E;
        Mon, 20 Jan 2020 08:51:02 -0800 (PST)
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <88802724-aa70-23bc-b2c8-a7a34aa3dfe5@linux.intel.com>
Date:   Mon, 20 Jan 2020 11:50:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120092300.GK14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2020 4:23 AM, Peter Zijlstra wrote:
> On Thu, Jan 16, 2020 at 07:57:56AM -0800, kan.liang@linux.intel.com wrote:
> 
>>   struct perf_branch_stack {
>>   	__u64				nr;
>> +	__u64				hw_idx;
>>   	struct perf_branch_entry	entries[0];
>>   };
> 
> The above and below order doesn't match.
> 
>> @@ -849,7 +853,11 @@ enum perf_event_type {
>>   	 *	  char                  data[size];}&& PERF_SAMPLE_RAW
>>   	 *
>>   	 *	{ u64                   nr;
>> -	 *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
>> +	 *        { u64 from, to, flags } lbr[nr];
>> +	 *
>> +	 *        # only available if PERF_SAMPLE_BRANCH_HW_INDEX is set
>> +	 *        u64			hw_idx;
>> +	 *      } && PERF_SAMPLE_BRANCH_STACK
> 
> That wants to be written as:
> 
> 		{ u64			nr;
> 		  { u64 from, to, flags; } entries[nr];
> 		  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
> 		} && PERF_SAMPLE_BRANCH_STACK
> 
> But the big question is; why isn't it:
> 
> 		{ u64			nr;
> 		  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
> 		  { u64 from, to, flags; } entries[nr];
> 		} && PERF_SAMPLE_BRANCH_STACK
> 
> to match the struct perf_branch_stack order. Having that variable sized
> entry in the middle just seems weird.


Usually, new data should be output to the end of a sample.
The comments and codes are all based on that way.
However, the entries[0] is sized entry, so I have to put the hw_idx 
before entry. It makes the inconsistency. Sorry for the confusion caused.

I will fix it in V6.

Thanks,
Kan

> 
>>   	 *
>>   	 * 	{ u64			abi; # enum perf_sample_regs_abi
>>   	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
