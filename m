Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A741C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232C92075F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex4z2G/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbgE0DBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:01:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60510 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387424AbgE0DBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590548505;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cpbim3FlbcrNy7gJlhAHb6/Vs/A9UAxM9oWCouCSNuc=;
        b=ex4z2G/+5ufStgo8bdAnper+vTCl2n7CNbbZAUKRQlGPFqblHu5nmgGpx52yxPQSrD68nT
        tDAGHFnlQiOaXGq5BSLeMBaLjgIsgCFAhCNQeayiIeWJ3R8xGWGPS5jaLq9h+6bo5Nlels
        VBjCS2OmC6tdOt5BKNEhzKp+c30aSDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-Q6siw2vvNzC2MrlGNtVjmw-1; Tue, 26 May 2020 23:01:40 -0400
X-MC-Unique: Q6siw2vvNzC2MrlGNtVjmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DA15801503;
        Wed, 27 May 2020 03:01:39 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-130.bne.redhat.com [10.64.54.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 476AE5D9E5;
        Wed, 27 May 2020 03:01:32 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv2 6/9] kvm/arm64: Export kvm_handle_user_mem_abort()
 with prefault mode
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-7-gshan@redhat.com>
 <20200526105807.GE1363@C02TD0UTHF1T.local>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <8d758b47-3fb0-ee70-700f-fa8af407c115@redhat.com>
Date:   Wed, 27 May 2020 13:01:29 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200526105807.GE1363@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 5/26/20 8:58 PM, Mark Rutland wrote:
> On Fri, May 08, 2020 at 01:29:16PM +1000, Gavin Shan wrote:
>> This renames user_mem_abort() to kvm_handle_user_mem_abort(), and
>> then export it. The function will be used in asynchronous page fault
>> to populate a page table entry once the corresponding page is populated
>> from the backup device (e.g. swap partition):
>>
>>     * Parameter @fault_status is replace by @esr.
>>     * The parameters are reorder based on their importance.
> 
> It seems like multiple changes are going on here, and it would be
> clearer with separate patches.
> 
> Passing the ESR rather than the extracted fault status seems fine, but
> for clarirty it's be nicer to do this in its own patch.
> 

Ok. I'll have a separate patch to do this.

> Why is it necessary to re-order the function parameters? Does that align
> with other function prototypes?
> 

There are no explicit reasons for it. I can restore the order to what we
had previously if you like.

> What exactly is the `prefault` parameter meant to do? It doesn't do
> anything currently, so it'd be better to introduce it later when logic
> using it is instroduced, or where callers will pass distinct values.
> 

Yes, fair enough. I will merge the logic with PATCH[7] then.

> Thanks,
> Mark.
> 

Thanks,
Gavin

>>
>> This shouldn't cause any functional changes.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/kvm_host.h |  4 ++++
>>   virt/kvm/arm/mmu.c                | 14 ++++++++------
>>   2 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 32c8a675e5a4..f77c706777ec 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -437,6 +437,10 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>>   			      struct kvm_vcpu_events *events);
>>   
>>   #define KVM_ARCH_WANT_MMU_NOTIFIER
>> +int kvm_handle_user_mem_abort(struct kvm_vcpu *vcpu, unsigned int esr,
>> +			      struct kvm_memory_slot *memslot,
>> +			      phys_addr_t fault_ipa, unsigned long hva,
>> +			      bool prefault);
>>   int kvm_unmap_hva_range(struct kvm *kvm,
>>   			unsigned long start, unsigned long end);
>>   int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index e462e0368fd9..95aaabb2b1fc 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1656,12 +1656,12 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
>>   	       (hva & ~(map_size - 1)) + map_size <= uaddr_end;
>>   }
>>   
>> -static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>> -			  struct kvm_memory_slot *memslot, unsigned long hva,
>> -			  unsigned long fault_status)
>> +int kvm_handle_user_mem_abort(struct kvm_vcpu *vcpu, unsigned int esr,
>> +			      struct kvm_memory_slot *memslot,
>> +			      phys_addr_t fault_ipa, unsigned long hva,
>> +			      bool prefault)
>>   {
>> -	int ret;
>> -	u32 esr = kvm_vcpu_get_esr(vcpu);
>> +	unsigned int fault_status = kvm_vcpu_trap_get_fault_type(esr);
>>   	bool write_fault, writable, force_pte = false;
>>   	bool exec_fault, needs_exec;
>>   	unsigned long mmu_seq;
>> @@ -1674,6 +1674,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	pgprot_t mem_type = PAGE_S2;
>>   	bool logging_active = memslot_is_logging(memslot);
>>   	unsigned long vma_pagesize, flags = 0;
>> +	int ret;
>>   
>>   	write_fault = kvm_is_write_fault(esr);
>>   	exec_fault = kvm_vcpu_trap_is_iabt(esr);
>> @@ -1995,7 +1996,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>   		goto out_unlock;
>>   	}
>>   
>> -	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
>> +	ret = kvm_handle_user_mem_abort(vcpu, esr, memslot,
>> +					fault_ipa, hva, false);
>>   	if (ret == 0)
>>   		ret = 1;
>>   out:
>> -- 
>> 2.23.0
>>
> 

