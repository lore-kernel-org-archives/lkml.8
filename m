Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C518C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF442068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgEEWPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:15:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:16097 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgEEWPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:15:23 -0400
IronPort-SDR: 6W2FH3KBKAnB0Mjl06WenQFjE6VsQwrpf0152crkqs/PpbvUVgvGr0LXYobU4niXdhyrKYhi6Y
 nDhEEHen2EyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:15:22 -0700
IronPort-SDR: 2djZaS+Ua3kYgAVBksmlGcdbv9mfIAB2CiNn0ln1iWG2qZA2YEFqy1xs8eX+n09OLEQ3AoYIch
 gnht/wFh7rpg==
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; 
   d="scan'208";a="259903462"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.111.36]) ([10.254.111.36])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:15:22 -0700
Subject: Re: [PATCH 2/2] x86/resctrl: Support CPUID enumeration of MBM counter
 width
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1585763047.git.reinette.chatre@intel.com>
 <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
 <20200429181149.GE16407@zn.tnic>
 <6fb58472-88f2-925b-3a4e-4692957a9582@intel.com>
 <20200430095913.GA3996@zn.tnic>
 <4288b11f-d4da-d311-7112-fa05887f50b4@intel.com>
 <20200504075632.GB15046@zn.tnic>
 <b357e1f6-bf92-ec50-73f2-bd5987b159fc@intel.com>
Message-ID: <6718a36a-f0f8-51be-913c-7700f110b1fb@intel.com>
Date:   Tue, 5 May 2020 15:15:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b357e1f6-bf92-ec50-73f2-bd5987b159fc@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 5/4/2020 9:19 PM, Reinette Chatre wrote:
> On 5/4/2020 12:56 AM, Borislav Petkov wrote:
>> Hi,
>>
>> On Sun, May 03, 2020 at 11:51:00AM -0700, Reinette Chatre wrote:
>>> I am struggling with what should follow ...
>>
>> Since a diff is better than a thousand words :-) see below.
>>
> 
> Thank you so much for providing the details. Your explanation is clear
> to me but I do have one clarification question ...
> 
> 
>> @@ -597,6 +598,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
>>  			x86_amd_ls_cfg_ssbd_mask = 1ULL << bit;
>>  		}
>>  	}
>> +
>> +	resctrl_cpu_detect(c);
>>  }
>>  
> 
> ...
> 
>> @@ -322,6 +323,11 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>>  		detect_ht_early(c);
>>  }
>>  
>> +static void bsp_init_intel(struct cpuinfo_x86 *c)
>> +{
>> +	resctrl_cpu_detect(c);
>> +}
>> +
>>  #ifdef CONFIG_X86_32
>>  /*
>>   *	Early probe support logic for ppro memory erratum #50
>> @@ -961,6 +967,7 @@ static const struct cpu_dev intel_cpu_dev = {
>>  #endif
>>  	.c_detect_tlb	= intel_detect_tlb,
>>  	.c_early_init   = early_init_intel,
>> +	.c_bsp_init	= bsp_init_intel,
>>  	.c_init		= init_intel,
>>  	.c_x86_vendor	= X86_VENDOR_INTEL,
>>  };
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index d8cc5223b7ce..5e5955aa6593 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -22,7 +22,7 @@
>>  #include <linux/cpuhotplug.h>
>>  
>>  #include <asm/intel-family.h>
>> -#include <asm/resctrl_sched.h>
>> +#include <asm/resctrl.h>
>>  #include "internal.h"
>>  
>>  /* Mutex to protect rdtgroup access. */
>> @@ -958,6 +958,35 @@ static __init void rdt_init_res_defs(void)
>>  
>>  static enum cpuhp_state rdt_online;
>>  
>> +/* Runs once on the BSP during boot. */
>> +void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>> +{
>> +	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
>> +		c->x86_cache_max_rmid  = -1;
>> +		c->x86_cache_occ_scale = -1;
>> +		c->x86_cache_mbm_width_offset = -1;
>> +		return;
>> +	}
>> +
>> +	/* will be overridden if occupancy monitoring exists */
>> +	c->x86_cache_max_rmid = cpuid_ebx(0xf);
>> +
>> +	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
>> +	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
>> +	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
>> +		u32 eax, ebx, ecx, edx;
>> +
>> +		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
>> +		cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
>> +
>> +		c->x86_cache_max_rmid  = ecx;
>> +		c->x86_cache_occ_scale = ebx;
>> +
>> +		if (c->x86_vendor == X86_VENDOR_INTEL)
>> +			c->x86_cache_mbm_width_offset = eax & 0xff;
>> +	}
>> +}
>> +
> 
> resctrl_cpu_detect() is now identical among vendors. Do we still need
> the c_bsp_init helpers? Could we not perhaps call resctrl_cpu_detect()
> directly from early_identify_cpu()?
> 

I should have given this more thought ... even though the function will
be identical between the two vendors it does contain vendor-specific
code, thus needing to be called from the c_bsp_init helpers? I will
resubmit the new series that intends to follow all your suggestions shortly.

Thank you very much for your feedback

Reinette
