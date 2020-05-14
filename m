Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46624C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2782065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgENSLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:11:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:36739 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgENSLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:11:02 -0400
IronPort-SDR: gAlNNrmRDDR7z0RrNAKRFZOAGkU/0iucxXqfsnt98Cr0IQvB/KelSVqCzOkw4iKD4p39NTQ/82
 9nc3OS4XB78g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 11:11:00 -0700
IronPort-SDR: 1WuFxPK59P5nJ3Hi4zIjWhsSgVASxzmr6OkywUNv5lNFuz1V1hZpbXLsOrINiQjBCF9CvGxa+q
 Ax8nJ+flm+aA==
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="280943080"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.66.120]) ([10.254.66.120])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 11:11:00 -0700
Subject: Re: [PATCH V3 1/4] x86/resctrl: Enable user to view and select thread
 throttling mode
To:     Babu Moger <babu.moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "kuo-lang.tseng@intel.com" <kuo-lang.tseng@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1588808537.git.reinette.chatre@intel.com>
 <56f9ee29b04599cdf502565dc223a70912a449f6.1588808538.git.reinette.chatre@intel.com>
 <0d1fc0a8-7544-861e-a2f6-42c34ad798d9@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <591cfbf0-fe1d-d96c-9842-79e62e76fbfe@intel.com>
Date:   Thu, 14 May 2020 11:10:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0d1fc0a8-7544-861e-a2f6-42c34ad798d9@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

Thank you very much for taking a look.

On 5/14/2020 9:45 AM, Babu Moger wrote:
> Hi Reinnette,
> 
> The patches did not apply on my tree. I got the latest tree today. You

Which tree did you use as baseline? These patches should apply cleanly
on top of the other resctrl patches already queued for inclusion into
v5.8 as found on the x86/cache branch of the tip repo.

> might want to check again.
> Hunk #1 FAILED at 29.
> 1 out of 7 hunks FAILED -- saving rejects to file
> arch/x86/kernel/cpu/resctrl/rdtgroup.c.rej
> 
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Wednesday, May 6, 2020 6:50 PM
>> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
>> tony.luck@intel.com
>> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
>> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
>> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
>> Subject: [PATCH V3 1/4] x86/resctrl: Enable user to view and select thread
>> throttling mode
>>

...

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index 12f967c6b603..1bc686777069 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -250,6 +250,30 @@ static inline bool rdt_get_mb_table(struct rdt_resource
>> *r)
>>  	return false;
>>  }
>>
>> +/*
>> + * Model-specific test to determine if platform where memory bandwidth
>> + * control is applied to a core can be configured to apply either the
>> + * maximum or minimum of the per-thread delay values.
>> + * By default, platforms where memory bandwidth control is applied to a
>> + * core will select the maximum delay value of the per-thread CLOS.
>> + *
>> + * NOTE: delay value programmed to hardware is inverse of bandwidth
>> + * percentage configured via user interface.
>> + */
>> +bool mba_cfg_supports_min_max_intel(void)
>> +{
>> +	switch (boot_cpu_data.x86_model) {
>> +	case INTEL_FAM6_ATOM_TREMONT_D:
>> +	case INTEL_FAM6_ICELAKE_X:
>> +	case INTEL_FAM6_ICELAKE_D:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +
>> +	return false;
>> +}
> 
> I see that you are calling this function multiple times. Why don't you

It is called:
- once during initialization
- once per package initialization (when first CPU on a package comes online)
- once per read from or write to the new "thread_throttle_mode" file

> make it as a property in rdt_resource. Set it only once during the
> init(may be in get_mem_config_intel). Then you can use it wherever
> required. This also probably help James to make everything architecture
> independent. What do you think?

If I understand correctly this would require understanding how each
architecture behaves in this regard to ensure the property within
rdt_resource is initialized correctly. While it could just be set within
get_mem_config_intel as you suggest, this property would be present in
AMD's resource and thus need a value ... could you please provide
guidance what this property should be on AMD? I looked at the bandwidth
enforcement section of
https://developer.amd.com/wp-content/resources/56375.pdf but it is not
obvious to me where bandwidth is actually enforced and how this
enforcement is affected when threads and/or cores are running tasks with
different CLOS that have different bandwidth limits assigned.

With AMD's properties understood then the new "thread_throttle_mode"
file could be visible on all platforms, not just Intel, and display
accurate values for all and be architecture independent.

Alternatively, the new property could have values: UNDEFINED, MIN, MAX,
or PER_THREAD ... with AMD having UNDEFINED and the
"thread_throttle_mode" continues to be visible on Intel platforms only.

I would appreciate your thoughts on this.

> I assume that this property is probably not part of CPUID.

Correct. This specific property is model specific, but also transient in
that it is replaced by X86_FEATURE_PER_THREAD_MBA (that is part of
CPUID) in future platforms.

Reinette
