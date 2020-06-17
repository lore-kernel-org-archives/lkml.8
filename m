Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C249C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6DF20720
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgFQKuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:50:23 -0400
Received: from foss.arm.com ([217.140.110.172]:55458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQKuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:50:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B32B31B;
        Wed, 17 Jun 2020 03:50:22 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACC3F3F71F;
        Wed, 17 Jun 2020 03:50:20 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: kvm_reset_vcpu() return code incorrect with
 SVE
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
References: <20200617104339.35094-1-steven.price@arm.com>
 <c9761495762abe174e6546122916fc38@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <969fe724-de5a-897b-fd55-ca48656e1c46@arm.com>
Date:   Wed, 17 Jun 2020 11:50:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c9761495762abe174e6546122916fc38@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2020 11:47, Marc Zyngier wrote:
> Hi Steven,
> 
> On 2020-06-17 11:43, Steven Price wrote:
>> If SVE is enabled then 'ret' can be assigned the return value of
>> kvm_vcpu_enable_sve() which may be 0 causing future "goto out" sites to
>> erroneously return 0 on failure rather than -EINVAL as expected.
>>
>> Remove the initialisation of 'ret' and make setting the return value
>> explicit to avoid this situation in the future.
>>
>> Fixes: 9a3cdf26e336 ("KVM: arm64/sve: Allow userspace to enable SVE 
>> for vcpus")
>> Reported-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>> The problematic chunk isn't visible in the diff, so reproduced here:
>>
>>     if (!kvm_arm_vcpu_sve_finalized(vcpu)) {
>>         if (test_bit(KVM_ARM_VCPU_SVE, vcpu->arch.features)) {
>>             ret = kvm_vcpu_enable_sve(vcpu);
>>             if (ret)
>>                 goto out;
>>         }
>>     } else {
>>         kvm_vcpu_reset_sve(vcpu);
>>     }
>>
>>  arch/arm64/kvm/reset.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index d3b209023727..f1057603b756 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -245,7 +245,7 @@ static int kvm_vcpu_enable_ptrauth(struct kvm_vcpu 
>> *vcpu)
>>   */
>>  int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>  {
>> -    int ret = -EINVAL;
>> +    int ret;
>>      bool loaded;
>>      u32 pstate;
>>
>> @@ -269,15 +269,19 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>
>>      if (test_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, vcpu->arch.features) ||
>>          test_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, vcpu->arch.features)) {
>> -        if (kvm_vcpu_enable_ptrauth(vcpu))
>> +        if (kvm_vcpu_enable_ptrauth(vcpu)) {
>> +            ret = -EINVAL;
>>              goto out;
>> +        }
>>      }
>>
>>      switch (vcpu->arch.target) {
>>      default:
>>          if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
>> -            if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1))
>> +            if (cpus_have_const_cap(ARM64_HAS_32BIT_EL1)) {
> 
> Do you really mean this? Seems counter-productive... :-(

Clearly not... I'm really not sure how I managed to screw that up so 
badly :(

I'm glad someone is awake!

Sorry about that,

Steve

>> +                ret = -EINVAL;
>>                  goto out;
>> +            }
>>              pstate = VCPU_RESET_PSTATE_SVC;
>>          } else {
>>              pstate = VCPU_RESET_PSTATE_EL1;
> 
> Thanks,
> 
>          M.

