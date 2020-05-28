Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D92DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D00207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390562AbgE1Nqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:46:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:45762 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390486AbgE1Nqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:46:45 -0400
IronPort-SDR: npT3tUtQIe4jSIxpmT52vyFPUx2UxSB3Qybe3uMt502qVZU/XryZHVgjVCNTnokr9Tu6FCD7IH
 OUZ4IetSx5zg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 06:46:44 -0700
IronPort-SDR: OcAbiyyG/qrTRK8vKeoK7Nfvn2wQ4Q/svmoglcme+HUxD21WAW76eipKWK6maq0/JXJ1b2rkoK
 skAbXoyIsYpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="255789532"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 28 May 2020 06:46:44 -0700
Received: from [10.251.9.11] (kliang2-mobl.ccr.corp.intel.com [10.251.9.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D2179580785;
        Thu, 28 May 2020 06:46:43 -0700 (PDT)
Subject: Re: [PATCH V2 3/3] perf/x86/intel/uncore: Validate MMIO address
 before accessing
To:     Andi Kleen <ak@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, David.Laight@aculab.com
References: <1590671727-99311-1-git-send-email-kan.liang@linux.intel.com>
 <1590671727-99311-3-git-send-email-kan.liang@linux.intel.com>
 <20200528133008.GH611145@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4f804e10-97c0-9861-4131-b33ca977d2eb@linux.intel.com>
Date:   Thu, 28 May 2020 09:46:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528133008.GH611145@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2020 9:30 AM, Andi Kleen wrote:
> On Thu, May 28, 2020 at 06:15:27AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> An oops will be triggered, if perf tries to access an invalid address
>> which exceeds the mapped area.
>>
>> Check the address before the actual access to MMIO sapce of an uncore
>> unit.
> 
> Ah ok the range check is here
> 
>>
>> Suggested-by: David Laight <David.Laight@ACULAB.COM>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/intel/uncore.c       |  3 +++
>>   arch/x86/events/intel/uncore.h       | 12 ++++++++++++
>>   arch/x86/events/intel/uncore_snbep.c |  6 ++++++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index cf76d66..284f8e7 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -132,6 +132,9 @@ u64 uncore_mmio_read_counter(struct intel_uncore_box *box,
>>   	if (!box->io_addr)
>>   		return 0;
>>   
>> +	if (!is_valid_mmio_offset(box, event->hw.event_base))
>> +		return 0;
> 
> Is this function used somewhere else? Otherwise it should be added
> together with its users.
> 

Yes, it's generic function. Current MMIO uncore units invoke it to read 
counter.

Thanks,
Kan
