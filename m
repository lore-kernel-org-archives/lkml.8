Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2FEC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC60207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgAMK2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:28:12 -0500
Received: from foss.arm.com ([217.140.110.172]:37224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgAMK2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:28:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1988313D5;
        Mon, 13 Jan 2020 02:28:11 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69B43F534;
        Mon, 13 Jan 2020 02:28:09 -0800 (PST)
Subject: Re: [PATCH v2 7/7] arm64: nofpsmid: Handle TIF_FOREIGN_FPSTATE flag
 cleanly
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, dave.martin@arm.com,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        christoffer.dall@arm.com, Marc Zyngier <marc.zyngier@arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
 <20191217183402.2259904-8-suzuki.poulose@arm.com>
 <94c0bdd9f26c3262ff8a885d13a64d22@www.loen.fr>
 <9e491901-b589-b486-1cad-1bd92a35da95@arm.com>
 <3b30d44c34bc265ce4122396077a1670@www.loen.fr>
 <d5e27bf5-3cc9-c8bd-5699-71658983054e@arm.com>
 <e1ba712b42886594fe1095019f2c5813@kernel.org>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <ea8f50f9-66fa-1cf5-1292-a205993258fa@arm.com>
Date:   Mon, 13 Jan 2020 10:28:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e1ba712b42886594fe1095019f2c5813@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2020 15:21, Marc Zyngier wrote:
> On 2019-12-18 12:00, Suzuki Kuruppassery Poulose wrote:
>> On 18/12/2019 11:56, Marc Zyngier wrote:
>>> On 2019-12-18 11:42, Suzuki Kuruppassery Poulose wrote:
>>>> Hi Marc,
>>>>
>>>> On 17/12/2019 19:05, Marc Zyngier wrote:


>>>>>> KVM also uses the TIF_FOREIGN_FPSTATE flag to manage the FP/SIMD 
>>>>>> state
>>>>>> on the CPU. However, without FP/SIMD support we trap all accesses and
>>>>>> inject undefined instruction. Thus we should never "load" guest 
>>>>>> state.
>>>>>> Add a sanity check to make sure this is valid.
>>>>> Yes, but no, see below.
>>>>>
>>>>>>
>>>>>> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>> No idea who that guy is. It's a fake! ;-)
>>>>
>>>> Sorry about that, will fix it.
>>>>
>>>>>
>>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>> ---
>>>>>>  arch/arm64/kernel/fpsimd.c  | 31 +++++++++++++++++++++++++++----
>>>>>>  arch/arm64/kvm/hyp/switch.c |  9 +++++++++
>>>>>>  2 files changed, 36 insertions(+), 4 deletions(-)
>>>>>>
>>>>> [...]
>>>>>
>>>>>> diff --git a/arch/arm64/kvm/hyp/switch.c 
>>>>>> b/arch/arm64/kvm/hyp/switch.c
>>>>>> index 72fbbd86eb5e..9696ebb5c13a 100644
>>>>>> --- a/arch/arm64/kvm/hyp/switch.c
>>>>>> +++ b/arch/arm64/kvm/hyp/switch.c
>>>>>> @@ -28,10 +28,19 @@
>>>>>>  /* Check whether the FP regs were dirtied while in the host-side run
>>>>>> loop: */
>>>>>>  static bool __hyp_text update_fp_enabled(struct kvm_vcpu *vcpu)
>>>>>>  {
>>>>>> +    /*
>>>>>> +     * When the system doesn't support FP/SIMD, we cannot rely on
>>>>>> +     * the state of _TIF_FOREIGN_FPSTATE. However, we will never
>>>>>> +     * set the KVM_ARM64_FP_ENABLED, as the FP/SIMD accesses always
>>>>>> +     * inject an abort into the guest. Thus we always trap the
>>>>>> +     * accesses.
>>>>>> +     */
>>>>>>      if (vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE)
>>>>>>          vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
>>>>>>                        KVM_ARM64_FP_HOST);
>>>>>>
>>>>>> +    WARN_ON(!system_supports_fpsimd() &&
>>>>>> +        (vcpu->arch.flags & KVM_ARM64_FP_ENABLED));
>>>>> Careful, this will panic the host if it happens on a !VHE host
>>>>> (calling non-inline stuff from a __hyp_text function is usually
>>>>> not a good idea).
>>>>
>>>> Ouch! Sorry about that WARN_ON()! I could drop the warning and
>>>> make this :
>>>>
>>>> if (!system_supports_fpsimd() ||
>>>>     (vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE))
>>>>     vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
>>>>                   KVM_ARM64_FP_HOST);
>>>>
>>>> to make sure we never say fp is enabled.
>>>>
>>>> What do you think ?
>>>
>>> Sure, that would work. I can't really see how KVM_ARM64_FP_ENABLED
>>
>> Thanks I have fixed this locally now.
>>
>>> would get set though. But it probably doesn't matter (WTF is going
>>
>> Right. That cannot be set to begin with, as the first access to FP/SIMD
>> injects an abort back to the guest, which is why I added a WARN() to
>> begin with.
>>
>> Just wanted to be extra safe.
>>
>>> to run KVM with such broken HW?), and better safe than sorry.
>>
>> Right, with no COMPAT KVM support it is really hard to get this far.
> 
> So with the above fix:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
>          M.

Thanks, I have changed the KVM hunk to :


diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 72fbbd86eb5e..e5816d885761 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -28,7 +28,15 @@
  /* Check whether the FP regs were dirtied while in the host-side run 
loop: */
  static bool __hyp_text update_fp_enabled(struct kvm_vcpu *vcpu)
  {
-	if (vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE)
+	/*
+	 * When the system doesn't support FP/SIMD, we cannot rely on
+	 * the _TIF_FOREIGN_FPSTATE flag. However, we always inject an
+	 * abort on the very first access to FP and thus we should never
+	 * see KVM_ARM64_FP_ENABLED. For added safety, make sure we always
+	 * trap the accesses.
+	 */
+	if (!system_supports_fpsimd() ||
+	    vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE)
  		vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
  				      KVM_ARM64_FP_HOST);


Suzuki


