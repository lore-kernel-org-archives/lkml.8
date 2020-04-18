Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F71C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 04:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DE7221EA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 04:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgDREQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 00:16:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:22686 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgDREQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 00:16:02 -0400
IronPort-SDR: xZI/Ycn5yRyLkstBEYfIAIrcexxiME6hHzoDRvu1DtKVQQC0YTR9QlYkaPrEAeTS6E4Ba1G/nA
 ONfTy+4c+2sw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 21:16:01 -0700
IronPort-SDR: RCBQioQJYCEZzgKpRw4Pohmp4A1QQXJfz1t4hNK1VYPzBCeDAwC3T/Ekz22h01VTlxucpzYDpx
 ruYn9k4Fxvhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,397,1580803200"; 
   d="scan'208";a="401252768"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.173.187]) ([10.249.173.187])
  by orsmga004.jf.intel.com with ESMTP; 17 Apr 2020 21:15:58 -0700
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are
 not architectural
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <873691zuqu.fsf@nanos.tec.linutronix.de>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <651504d9-f458-1d25-870d-b8c55061be45@intel.com>
Date:   Sat, 18 Apr 2020 12:15:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <873691zuqu.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/2020 5:07 AM, Thomas Gleixner wrote:
> Tony,
> 
> Thomas Gleixner <tglx@linutronix.de> writes:
>> "Luck, Tony" <tony.luck@intel.com> writes:
>>> Swings and roundabouts ... getting rid of the goto makes for
>>> deeper indentation. But if you really want to get rid of the
>>> goto, then your version is fine with me.
>>>
>>> Do you want me to spin it into v3?
>>
>> Nah. I tweak it myself.
> 
> as I fear that the infinite wisdom of HW folks will add yet another
> variant in the foreseeable future, I used a switch() right away and
> tweaked the comments a bit.
> 
> Can you have a look, please?
> 
> Thanks,
> 
>          tglx
> 
> 8<------------------
> From: Tony Luck <tony.luck@intel.com>
> Subject: x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not architectural
> Date: Thu, 16 Apr 2020 13:57:53 -0700
> 
> From: Tony Luck <tony.luck@intel.com>
> 
> The Intel Software Developers' Manual erroneously listed bit 5 of the
> IA32_CORE_CAPABILITIES register as an architectural feature. It is not.
> 
> Features enumerated by IA32_CORE_CAPABILITIES are model specific and
> implementation details may vary in different cpu models. Thus it is only
> safe to trust features after checking the CPU model.
> 
> Icelake client and server models are known to implement the split lock
> detect feature even though they don't enumerate IA32_CORE_CAPABILITIES
> 
> Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/20200416205754.21177-3-tony.luck@intel.com
> 
> ---
>   arch/x86/kernel/cpu/intel.c |   45 ++++++++++++++++++++++++++++++--------------
>   1 file changed, 31 insertions(+), 14 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1120,10 +1120,17 @@ void switch_to_sld(unsigned long tifn)
>   }
>   
>   /*
> - * The following processors have the split lock detection feature. But
> - * since they don't have the IA32_CORE_CAPABILITIES MSR, the feature cannot
> - * be enumerated. Enable it by family and model matching on these
> - * processors.
> + * Bits in the IA32_CORE_CAPABILITIES are not architectural, so they should
> + * only be trusted if it is confirmed that a CPU model implements a
> + * specific feature at a particular bit position.
> + *
> + * The possible driver data field values:
> + *
> + * - 0: CPU models that are known to have the per-core split-lock detection
> + *	feature even though they do not enumerate IA32_CORE_CAPABILITIES.
> + *
> + * - 1: CPU models which may enumerate IA32_CORE_CAPABILITIES and if so use
> + *      bit 5 to enumerate the per-core split-lock detection feature.

So now, it's tightly associated with CPU model, which makes it harder to 
expose this feature to guest. For guest, the CPU model can be configured 
to anything.

As suggested by Sean internally, we'd better use a KVM CPUID to expose 
it to guest, which makes it independent of CPU model.

Paolo, tglx,

What do you think?

>    */
>   static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
>   	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
> @@ -1133,19 +1140,29 @@ static const struct x86_cpu_id split_loc
>   
>   void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
>   {
> -	u64 ia32_core_caps = 0;
> +	const struct x86_cpu_id *m;
> +	u64 ia32_core_caps;
>   
> -	if (c->x86_vendor != X86_VENDOR_INTEL)
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>   		return;
> -	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
> -		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
> +
> +	m = x86_match_cpu(split_lock_cpu_ids);
> +	if (!m)
> +		return;
> +
> +	switch (m->driver_data) {
> +	case 0:
> +		break;
> +	case 1:
> +		if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
> +			return;
>   		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
> -	} else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> -		/* Enumerate split lock detection by family and model. */
> -		if (x86_match_cpu(split_lock_cpu_ids))
> -			ia32_core_caps |= MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT;
> +		if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
> +			return;
> +		break;
> +	default:
> +		return;
>   	}
>   
> -	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
> -		split_lock_setup();
> +	split_lock_setup();
>   }
> 

