Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188E420772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFAG00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:26:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5315 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbgFAG0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:26:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D7BD5F8F2CAC077568D;
        Mon,  1 Jun 2020 14:26:22 +0800 (CST)
Received: from [10.173.221.230] (10.173.221.230) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 1 Jun 2020 14:26:15 +0800
Subject: Re: [PATCH RFC] KVM: arm64: Sidestep stage2_unmap_vm() on vcpu reset
 when S2FWB is supported
To:     Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>
References: <20200415072835.1164-1-yuzenghui@huawei.com>
 <e99bc07d-0dd4-055c-808f-fd9cde88d2fc@arm.com>
 <a1a1961a-2eae-b26c-e607-ab5c0c929f37@arm.com>
 <13db879dff56d091f98f7c5416ab1535@kernel.org>
CC:     Zenghui Yu <yuzenghui@huawei.com>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   zhukeqian <zhukeqian1@huawei.com>
Message-ID: <d72e4299-e9f7-064c-98c7-621721e5671c@huawei.com>
Date:   Mon, 1 Jun 2020 14:26:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <13db879dff56d091f98f7c5416ab1535@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/5/31 0:31, Marc Zyngier wrote:
> Hi Alex,
> 
> On 2020-05-30 11:46, Alexandru Elisei wrote:
>> Hi,
> 
> [...]
> 
>>>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>>>> index 48d0ec44ad77..e6378162cdef 100644
>>>> --- a/virt/kvm/arm/arm.c
>>>> +++ b/virt/kvm/arm/arm.c
>>>> @@ -983,8 +983,11 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
>>>>      /*
>>>>       * Ensure a rebooted VM will fault in RAM pages and detect if the
>>>>       * guest MMU is turned off and flush the caches as needed.
>>>> +     *
>>>> +     * S2FWB enforces all memory accesses to RAM being cacheable, we
>>>> +     * ensure that the cache is always coherent.
>>>>       */
>>>> -    if (vcpu->arch.has_run_once)
>>>> +    if (vcpu->arch.has_run_once && !cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
>>> I think userspace does not invalidate the icache when loading a new kernel image,
>>> and if the guest patched instructions, they could potentially still be in the
>>> icache. Should the icache be invalidated if FWB is present?
>>
>> I noticed that this was included in the current pull request and I
>> remembered that
>> I wasn't sure about this part. Did some more digging and it turns out that FWB
>> implies no cache maintenance needed for *data to instruction*
>> coherence. From ARM
>> DDI 0487F.b, page D5-2635:
>>
>> "When ARMv8.4-S2FWB is implemented, the architecture requires that
>> CLIDR_EL1.{LOUU, LOIUS} are zero so that no levels of data cache need to be
>> cleaned in order to manage coherency with instruction fetches".
>>
>> However, there's no mention that I found for instruction to data coherence,
>> meaning that the icache would still need to be invalidated on each vcpu in order
>> to prevent fetching of patched instructions from the icache. Am I
>> missing something?
> 
> I think you are right, and this definitely matches the way we deal with
> the icache on the fault path. For some bizarre reason, I always assume
> that FWB implies DIC, which isn't true at all.
> 
> I'm planning to address it as follows. Please let me know what you think.
> 
> Thanks,
> 
>         M.
> 
> From f7860d1d284f41afea176cc17e5c9d895ae665e9 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Sat, 30 May 2020 17:22:19 +0100
> Subject: [PATCH] KVM: arm64: Flush the instruction cache if not unmapping the
>  VM on reboot
> 
> On a system with FWB, we don't need to unmap Stage-2 on reboot,
> as even if userspace takes this opportunity to repaint the whole
> of memory, FWB ensures that the data side stays consistent even
> if the guest uses non-cacheable mappings.
> 
> However, the I-side is not necessarily coherent with the D-side
> if CTR_EL0.DIC is 0. In this case, invalidate the i-cache to
> preserve coherency.
> 
> Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Fixes: 892713e97ca1 ("KVM: arm64: Sidestep stage2_unmap_vm() on vcpu reset when S2FWB is supported")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/arm.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index b0b569f2cdd0..d6988401c22a 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -989,11 +989,17 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
>       * Ensure a rebooted VM will fault in RAM pages and detect if the
>       * guest MMU is turned off and flush the caches as needed.
>       *
> -     * S2FWB enforces all memory accesses to RAM being cacheable, we
> -     * ensure that the cache is always coherent.
> +     * S2FWB enforces all memory accesses to RAM being cacheable,
> +     * ensuring that the data side is always coherent. We still
> +     * need to invalidate the I-cache though, as FWB does *not*
> +     * imply CTR_EL0.DIC.
>       */
> -    if (vcpu->arch.has_run_once && !cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> -        stage2_unmap_vm(vcpu->kvm);
> +    if (vcpu->arch.has_run_once) {
> +        if (!cpus_have_final_cap(ARM64_HAS_STAGE2_FWB))
> +            stage2_unmap_vm(vcpu->kvm);
> +        else
> +            __flush_icache_all();
After I looking into this function, I think it's OK here. Please ignore
my question :-).
> +    }
> 
>      vcpu_reset_hcr(vcpu);
> 
Thanks,
Keqian
