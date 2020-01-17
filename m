Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F88AC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E784420842
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAQPK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:10:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:56221 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgAQPK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:10:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 07:10:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="243692720"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2020 07:10:55 -0800
Received: from [10.251.27.134] (kliang2-mobl.ccr.corp.intel.com [10.251.27.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 36420580332;
        Fri, 17 Jan 2020 07:10:55 -0800 (PST)
Subject: Re: [RESEND PATCH V2] perf/x86/intel: Avoid unnecessary PEBS_ENABLE
 MSR access in PMI
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com
References: <20200116182112.20782-1-kan.liang@linux.intel.com>
 <20200117085412.GU2827@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e6126115-a802-35fe-3b53-65e8a3d84db7@linux.intel.com>
Date:   Fri, 17 Jan 2020 10:10:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117085412.GU2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2020 3:54 AM, Peter Zijlstra wrote:
> On Thu, Jan 16, 2020 at 10:21:12AM -0800, kan.liang@linux.intel.com wrote:
> 
>> A PMI may land after cpuc->enabled=0 in x86_pmu_disable() and
>> PMI throttle may be triggered for the PMI. For this rare case,
>> intel_pmu_pebs_disable() will not touch PEBS_ENABLE MSR. The patch
>> explicitly disable the PEBS for this case.
> 
> intel_pmu_handle_irq()
>    pmu_enabled = cpuc->enabled;
>    cpuc->enabled = 0;
>    __intel_pmu_disable_all();
> 
>    ...
>      x86_pmu_stop()
>        intel_pmu_disable_event()
>          intel_pmu_pebs_disable()
> 	  if (cpuc->enabled) // FALSE!!!

Right, it always be false in PMI.
We force the 'enabled' to 0 when entering the PMI.

For this case, I think we may add a variable to save the pebs_enabled 
when entering PMI. If it's changed, we have to write the new value.
I will prepare the V3.

Thanks,
Kan

> 
>    cpuc->enabled = pmu_enabled;
>    if (pmu_enabled)
>      __intel_pmu_enable_all();
> 
>> @@ -2620,6 +2627,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>   		handled++;
>>   		x86_pmu.drain_pebs(regs);
>>   		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
>> +
>> +		/*
>> +		 * PMI may land after cpuc->enabled=0 in x86_pmu_disable() and
>> +		 * PMI throttle may be triggered for the PMI.
>> +		 * For this rare case, intel_pmu_pebs_disable() will not touch
>> +		 * MSR_IA32_PEBS_ENABLE. Explicitly disable the PEBS here.
>> +		 */
>> +		if (unlikely(!cpuc->enabled && !cpuc->pebs_enabled))
>> +			wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
>>   	}
> 
> How does that make sense? AFAICT this is all still completely broken.
> 
> Please be more careful.
> 
