Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE7AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEE5206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgHJWgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:36:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:14994 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgHJWgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:36:08 -0400
IronPort-SDR: ONvBJm4F2+NXH8x2bTrbAynVrxJaPB6GedCZjQNhUDpqxvf+l1v/+6zdqnrPq12alEb9qQqxwb
 BQt8rTdpmf3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151063379"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="151063379"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 15:36:06 -0700
IronPort-SDR: IIv3FE73gPTs/Q+5ELdW4MGfoGtSnoW5zIK59DW3ZgjMseBTrSLt6kLfslueMwuyJ6BSEaavk2
 TFxnP3TbKXCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="326653118"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2020 15:36:06 -0700
Received: from [10.254.81.180] (kliang2-MOBL.ccr.corp.intel.com [10.254.81.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5D08F580785;
        Mon, 10 Aug 2020 15:36:05 -0700 (PDT)
Subject: Re: [PATCH V6 01/16] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-2-kan.liang@linux.intel.com>
 <20200810213909.GJ3982@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <719f19f7-a368-7a5c-7e08-84deafbf8473@linux.intel.com>
Date:   Mon, 10 Aug 2020 18:36:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810213909.GJ3982@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2020 5:39 PM, Peter Zijlstra wrote:
> On Mon, Aug 10, 2020 at 02:24:21PM -0700, Kan Liang wrote:
>> Current perf can report both virtual addresses and physical addresses,
>> but not the page size. Without the page size information of the utilized
>> page, users cannot decide whether to promote/demote large pages to
>> optimize memory usage.
>>
>> Add a new sample type for the data page size.
>>
>> Current perf already has a facility to collect data virtual addresses.
>> A page walker is required to walk the pages tables and calculate the
>> page size from a given virtual address.
>>
>> On some platforms, e.g., X86, the page walker is invoked in an NMI
>> handler. So the page walker must be IRQ-safe and low overhead. Besides,
>> the page walker should work for both user and kernel virtual address.
>> The existing generic page walker, e.g., walk_page_range_novma(), is a
>> little bit complex and doesn't guarantee the IRQ-safe. The follow_page()
>> is only for user-virtual address.
>>
>> Add a new function perf_get_page_size() to walk the page tables and
>> calculate the page size. In the function:
>> - Interrupts have to be disabled to prevent any teardown of the page
>>    tables.
>> - The size of a normal page is from the pre-defined page size macros.
>> - The size of a compound page is retrieved from the helper function,
>>    page_size().
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
>>   /* default value for data source */
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 52ca2093831c..32484accc7a3 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -143,8 +143,9 @@ enum perf_event_sample_format {
>>   	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
>>   	PERF_SAMPLE_AUX				= 1U << 20,
>>   	PERF_SAMPLE_CGROUP			= 1U << 21,
>> +	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
>>   
>> -	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
>> +	PERF_SAMPLE_MAX = 1U << 23,		/* non-ABI */
>>   
>>   	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>>   };
> 
>> @@ -7151,6 +7269,9 @@ void perf_prepare_sample(struct perf_event_header *header,
>>   	}
>>   #endif
>>   
>> +	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
>> +		data->data_page_size = perf_get_page_size(data->addr);
>> +
> 
> We could just require SAMPLE_DATA_PAGE requires SAMPLE_ADDR.
> 

If we only require the SAMPLE_DATA_PAGE_SIZE and no SAMPLE_ADDR, the 
data->addr will be updated implicitly, but the value will not dump to 
userspace tool. I will add a comment here.

Thanks,
Kan
