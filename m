Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C22DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6865B20675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389564AbgF3Pge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:36:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:62964 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389403AbgF3Pge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:36:34 -0400
IronPort-SDR: 79rWBxQZ8BPWXp3ozzaqh6L3Ns9CP8Hql6QgxLWWw74Jgk8ELC1lFafLJJWL9icDqo+r87W5Sb
 +HKYv4Q4ZYdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147821531"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="147821531"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 08:36:33 -0700
IronPort-SDR: 5Q6yG6C3ceUN6gQVJUBg9vJlOm+3iVcNHGRLg0Z9+AZSQZwtFT+SA1bAN3vRXYs4c3kciNhLdD
 PzmwAWet2jvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="386728558"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2020 08:36:32 -0700
Received: from [10.252.132.55] (kliang2-mobl.ccr.corp.intel.com [10.252.132.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 940A0580107;
        Tue, 30 Jun 2020 08:36:30 -0700 (PDT)
Subject: Re: [PATCH V2 08/23] perf/x86: Expose CPUID enumeration bits for arch
 LBR
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
 <1593195620-116988-9-git-send-email-kan.liang@linux.intel.com>
 <20200630150154.GS4781@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <211b4d70-eec5-4577-45fb-99435023cab8@linux.intel.com>
Date:   Tue, 30 Jun 2020 11:36:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630150154.GS4781@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2020 11:01 AM, Peter Zijlstra wrote:
> On Fri, Jun 26, 2020 at 11:20:05AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The LBR capabilities of Architecture LBR are retrieved from the CPUID
>> enumeration once at boot time. The capabilities have to be saved for
>> future usage.
>>
>> Several new fields are added into structure x86_pmu to indicate the
>> capabilities. The fields will be used in the following patches.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/perf_event.h      |  5 +++++
>>   arch/x86/include/asm/perf_event.h | 40 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 45 insertions(+)
>>
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index d04818b..9b0e533 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -690,6 +690,11 @@ struct x86_pmu {
>>   	const int	*lbr_sel_map;		   /* lbr_select mappings */
>>   	bool		lbr_double_abort;	   /* duplicated lbr aborts */
>>   	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
>> +	bool		arch_lbr;		   /* Arch LBR supported */
>> +
>> +	union cpuid28_eax	lbr_eax;
>> +	union cpuid28_ebx	lbr_ebx;
>> +	union cpuid28_ecx	lbr_ecx;
> 
> Why keep the full CPUID leaf here? What's wrong with something like:
> 
> 	unsigned int	lbr_depth_mask:8;
> 	unsigned int	lbr_deep_c_reset:1;
> 	unsigned int	lbr_lip:1;
> 	unsigned int	lbr_cpl:1;
> 	unsigned int	lbr_filter:1;
> 	unsigned int	lbr_call_stack:1;
> 	unsigned int	lbr_mispred:1;
> 	unsigned int	lbr_timed_lbr:1;
> 	unsigned int	lbr_br_type:1;
> 
> That's only 2 bytes, instead of 24.

Yes, it can save the space.
I will add some codes in patch 14 to initialize these items in 
intel_pmu_arch_lbr_init().

Thanks,
Kan

> 
>>   	void		(*lbr_reset)(void);
>>   	void		(*lbr_read)(struct cpu_hw_events *cpuc);
