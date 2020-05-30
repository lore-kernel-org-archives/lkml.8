Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B5AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B15206DA
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgE3Kpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 06:45:39 -0400
Received: from foss.arm.com ([217.140.110.172]:45208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgE3Kpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 06:45:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 665131042;
        Sat, 30 May 2020 03:45:38 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC74B3F6C4;
        Sat, 30 May 2020 03:45:37 -0700 (PDT)
Subject: Re: [PATCH RFC] KVM: arm64: Sidestep stage2_unmap_vm() on vcpu reset
 when S2FWB is supported
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>
References: <20200415072835.1164-1-yuzenghui@huawei.com>
 <e99bc07d-0dd4-055c-808f-fd9cde88d2fc@arm.com>
Message-ID: <a1a1961a-2eae-b26c-e607-ab5c0c929f37@arm.com>
Date:   Sat, 30 May 2020 11:46:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <e99bc07d-0dd4-055c-808f-fd9cde88d2fc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/20/20 5:10 PM, Alexandru Elisei wrote:
> Hi,
>
> On 4/15/20 8:28 AM, Zenghui Yu wrote:
>> stage2_unmap_vm() was introduced to unmap user RAM region in the stage2
>> page table to make the caches coherent. E.g., a guest reboot with stage1
>> MMU disabled will access memory using non-cacheable attributes. If the
>> RAM and caches are not coherent at this stage, some evicted dirty cache
>> line may go and corrupt guest data in RAM.
>>
>> Since ARMv8.4, S2FWB feature is mandatory and KVM will take advantage
>> of it to configure the stage2 page table and the attributes of memory
>> access. So we ensure that guests always access memory using cacheable
>> attributes and thus, the caches always be coherent.
>>
>> So on CPUs that support S2FWB, we can safely reset the vcpu without a
>> heavy stage2 unmapping.
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>
>> If this is correct, there should be a great performance improvement on
>> a guest reboot (or reset) on systems support S2FWB. But I'm afraid that
>> I've missed some points here, so please comment!
>>
>> The commit 957db105c997 ("arm/arm64: KVM: Introduce stage2_unmap_vm")
>> was merged about six years ago and I failed to track its histroy and
>> intention. Instead of a whole stage2 unmapping, something like
>> stage2_flush_vm() looks enough to me. But again, I'm unsure...
>>
>> Thanks for having a look!
> I had a chat with Christoffer about stage2_unmap_vm, and as I understood it, the
> purpose was to make sure that any changes made by userspace were seen by the guest
> while the MMU is off. When a stage 2 fault happens, we do clean+inval on the
> dcache, or inval on the icache if it was an exec fault. This means that whatever
> the host userspace writes while the guest is shut down and is still in the cache,
> the guest will be able to read/execute.
>
> This can be relevant if the guest relocates the kernel and overwrites the original
> image location, and userspace copies the original kernel image back in before
> restarting the vm.
>
>>  virt/kvm/arm/arm.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>> index 48d0ec44ad77..e6378162cdef 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -983,8 +983,11 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
>>  	/*
>>  	 * Ensure a rebooted VM will fault in RAM pages and detect if the
>>  	 * guest MMU is turned off and flush the caches as needed.
>> +	 *
>> +	 * S2FWB enforces all memory accesses to RAM being cacheable, we
>> +	 * ensure that the cache is always coherent.
>>  	 */
>> -	if (vcpu->arch.has_run_once)
>> +	if (vcpu->arch.has_run_once && !cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> I think userspace does not invalidate the icache when loading a new kernel image,
> and if the guest patched instructions, they could potentially still be in the
> icache. Should the icache be invalidated if FWB is present?

I noticed that this was included in the current pull request and I remembered that
I wasn't sure about this part. Did some more digging and it turns out that FWB
implies no cache maintenance needed for *data to instruction* coherence. From ARM
DDI 0487F.b, page D5-2635:

"When ARMv8.4-S2FWB is implemented, the architecture requires that
CLIDR_EL1.{LOUU, LOIUS} are zero so that no levels of data cache need to be
cleaned in order to manage coherency with instruction fetches".

However, there's no mention that I found for instruction to data coherence,
meaning that the icache would still need to be invalidated on each vcpu in order
to prevent fetching of patched instructions from the icache. Am I missing something?

Thanks,
Alex
>
> Thanks,
> Alex
>>  		stage2_unmap_vm(vcpu->kvm);
>>  
>>  	vcpu_reset_hcr(vcpu);
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
