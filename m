Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD799C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2C92067B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgFBX2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:28:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:58382 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgFBX2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:28:18 -0400
IronPort-SDR: T+1ReKr1T7wcC6J6gN1+ZOv/ySPs5Jx30p6vbdL9LlGJdrxzKWCtJQalajjGOLzUAP6YY1FSBI
 g7m5mutnNixA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 16:28:18 -0700
IronPort-SDR: N09uJ+7Y0dNPSgwYr9zhSYvR1e3DZdCOjixmglYP2XfmiKe5V2xpLo5sXLOd4Kei/ePRxXUJ3M
 /n7D3W5wfC9Q==
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="272535837"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.209.123.248]) ([10.209.123.248])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 16:28:17 -0700
Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
To:     Babu Moger <babu.moger@amd.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com>
 <b7625596-c1f9-798d-a138-b619178497b2@intel.com>
 <c7c5c0e5-6839-234e-38e0-69834aa2c8dd@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <6cc9bdb5-bf41-ed8b-0b30-3464d6c290b9@intel.com>
Date:   Tue, 2 Jun 2020 16:28:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <c7c5c0e5-6839-234e-38e0-69834aa2c8dd@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/2/2020 3:12 PM, Babu Moger wrote:
> 
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Tuesday, June 2, 2020 4:51 PM
>> To: Moger, Babu <Babu.Moger@amd.com>; fenghua.yu@intel.com;
>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; x86@kernel.org;
>> hpa@zytor.com; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
>>
>> Hi Babu,
>>
>> On 6/1/2020 4:00 PM, Babu Moger wrote:
>>> Memory bandwidth is calculated reading the monitoring counter
>>> at two intervals and calculating the delta. It is the software’s
>>> responsibility to read the count often enough to avoid having
>>> the count roll over _twice_ between reads.
>>>
>>> The current code hardcodes the bandwidth monitoring counter's width
>>> to 24 bits for AMD. This is due to default base counter width which
>>> is 24. Currently, AMD does not implement the CPUID 0xF.[ECX=1]:EAX
>>> to adjust the counter width. But, the AMD hardware supports much
>>> wider bandwidth counter with the default width of 44 bits.
>>>
>>> Kernel reads these monitoring counters every 1 second and adjusts the
>>> counter value for overflow. With 24 bits and scale value of 64 for AMD,
>>> it can only measure up to 1GB/s without overflowing. For the rates
>>> above 1GB/s this will fail to measure the bandwidth.
>>>
>>> Fix the issue setting the default width to 44 bits by adjusting the
>>> offset.
>>>
>>> AMD future products will implement the CPUID 0xF.[ECX=1]:EAX.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> - Sending it second time. Email client had some issues first time.
>>> - Generated the patch on top of
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (x86/cache).
>>>
>>>  arch/x86/kernel/cpu/resctrl/core.c     |    8 +++++++-
>>>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>>> index 12f967c6b603..6040e9ae541b 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -983,7 +983,13 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>>>  		c->x86_cache_occ_scale = ebx;
>>>  		if (c->x86_vendor == X86_VENDOR_INTEL)
>>>  			c->x86_cache_mbm_width_offset = eax & 0xff;
>>> -		else
>>> +		else if (c->x86_vendor == X86_VENDOR_AMD) {
>>> +			if (eax)
>>
>> This test checks if _any_ bit is set in eax ...
>>
>>> +				c->x86_cache_mbm_width_offset = eax & 0xff;
>>
>> ... with the assumption that the first eight bits contain a value.
>>
>> Even so, now that Intel and AMD will be using eax in the same way,
>> perhaps it can be done simpler by always using eax to obtain the offset
>> (and thus avoid the code duplication) and on AMD initialize the default
>> if it cannot be obtained from eax?
>>
>> What I mean is something like:
>>
>> @@ -1024,10 +1024,12 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>>
>>  		c->x86_cache_max_rmid  = ecx;
>>  		c->x86_cache_occ_scale = ebx;
>> -		if (c->x86_vendor == X86_VENDOR_INTEL)
>> -			c->x86_cache_mbm_width_offset = eax & 0xff;
>> -		else
>> -			c->x86_cache_mbm_width_offset = -1;
>> +		c->x86_cache_mbm_width_offset = eax & 0xff;
>> +		if (c->x86_vendor == X86_VENDOR_AMD &&
>> +		    c->x86_cache_mbm_width_offset == 0) {
>> +			c->x86_cache_mbm_width_offset =
>> +				MBM_CNTR_WIDTH_OFFSET_AMD;
>> +		}
>>  	}
>>  }
>>
>> What do you think?
> 
> That looks good. But we still need to keep the
> default(c->x86_cache_mbm_width_offset = -1;) for non-AMD and non-Intel.
> How about this?

This original default of -1 was added to deal with AMD when it was not
known to support eax. Now that AMD's support of eax is captured among
the default code I did not find it necessary to keep that considering
resctrl_cpu_detect() is only called on AMD and Intel.

> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index 12f967c6b603..7269bd896ba9 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -983,6 +983,9 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>                 c->x86_cache_occ_scale = ebx;
>                 if (c->x86_vendor == X86_VENDOR_INTEL)
>                         c->x86_cache_mbm_width_offset = eax & 0xff;
> +               else if (c->x86_vendor == X86_VENDOR_AMD)
> +                       c->x86_cache_mbm_width_offset = eax ? eax & 0xff :

This has the same concern that I mentioned earlier where the contents of
the entire register is used to determine if the first eight bits
contains a value. Did I miss something obvious?

> +
> MBM_CNTR_WIDTH_OFFSET_AMD;
>                 else
>                         c->x86_cache_mbm_width_offset = -1;
>         }
> 

Reinette
