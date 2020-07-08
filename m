Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F70C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D0420786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJQVrG4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgGHOjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:39:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22684 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729720AbgGHOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594219160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5kAbKh4gT6sckOUOu13UxFIyniT4oyc+Q75JU+xCpvM=;
        b=DJQVrG4b9bGmsf82hCnZrWBPOhwW0B0EKrzxIiTHKzXQXi+ypwUTnOGLDOGnnVX+QMLNsT
        7QDQzZWRMTXJutVpcKFSzPOmLPQcbLjFiLhHD4QI+NlzdU5TOFgFDkWDcN/cXPmYPgXhi/
        qi9FBISQujzfVWv/yoTJQtR6w+4Z/pU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-toEotK6FMdCGqbRtBrWA-w-1; Wed, 08 Jul 2020 10:39:18 -0400
X-MC-Unique: toEotK6FMdCGqbRtBrWA-w-1
Received: by mail-ej1-f69.google.com with SMTP id q11so44013608eja.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 07:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5kAbKh4gT6sckOUOu13UxFIyniT4oyc+Q75JU+xCpvM=;
        b=UEn6/LLqsHef4QwR+/7/c/2tY0/pbl2VAuLLQBv6qA2m7bdY28+KcMTtpckr1G3/hI
         lr2NFXGqONgcwlmM+uzk/lRS6cEUySfXaGlIQVW0OTPHYR2c6o4zRzaHBX5w+Wf+pfil
         Iog73nNCr2TYpnyICS/132F6GZlv/L1V+9LL8BCK7lwjarvu+TV6X4OIrNpRYR4Q/n8t
         EQEzpiFoijUEi+XH5/V3U4yEaQSLsIDCyYN95QbaDk+bh+nBQLl1jqRwZiUELiumAqoE
         lLS8WBNjrtUDt/OKK1NxzXCqJtzoFU/u37s+rQnczbvU7m89z/vxMk1MY9QYn1F8neb5
         VV/w==
X-Gm-Message-State: AOAM530/pacnQsJu/2+GYbGQSGORRWROfbDgISVEnttKh9pdSwXsgVZ5
        Eb/Qjhd3sxiVEzcopL3qyeVlGa9LfpaWVizJU9zg1v85UUXDOVvN4vU+Lt2CzrwDL1nxE4dxzE5
        IQTsPxtXVxQQKCJfffCQgA/UW
X-Received: by 2002:a17:906:dbe5:: with SMTP id yd5mr52676074ejb.328.1594219156578;
        Wed, 08 Jul 2020 07:39:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIx3r6gC9MR8WQxYaKP1dcyHPBhsGUyPQRqWiSjReS9r0fzHOSnBWVo07r5QzzbcLhV1fN6w==
X-Received: by 2002:a17:906:dbe5:: with SMTP id yd5mr52676047ejb.328.1594219156284;
        Wed, 08 Jul 2020 07:39:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t25sm2077440ejc.34.2020.07.08.07.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:39:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: nSVM: properly call kvm_mmu_new_pgd() upon switching to guest
In-Reply-To: <b7989497-562e-c9a1-3f62-dd5afb9fd3d5@redhat.com>
References: <20200708093611.1453618-1-vkuznets@redhat.com> <20200708093611.1453618-3-vkuznets@redhat.com> <b7989497-562e-c9a1-3f62-dd5afb9fd3d5@redhat.com>
Date:   Wed, 08 Jul 2020 16:39:14 +0200
Message-ID: <87eepmul4d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 08/07/20 11:36, Vitaly Kuznetsov wrote:
>> Undesired triple fault gets injected to L1 guest on SVM when L2 is
>> launched with certain CR3 values. #TF is raised by mmu_check_root()
>> check in fast_pgd_switch() and the root cause is that when
>> kvm_set_cr3() is called from nested_prepare_vmcb_save() with NPT
>> enabled CR3 points to a nGPA so we can't check it with
>> kvm_is_visible_gfn().
>> 
>> Calling kvm_mmu_new_pgd() with L2's CR3 idea when NPT is in use
>> seems to be wrong, an acceptable place for it seems to be
>> kvm_init_shadow_npt_mmu(). This also matches nVMX code.
>> 
>> Fixes: 7c390d350f8b ("kvm: x86: Add fast CR3 switch code path")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h | 7 ++++++-
>>  arch/x86/kvm/mmu/mmu.c          | 2 ++
>>  arch/x86/kvm/svm/nested.c       | 2 +-
>>  arch/x86/kvm/x86.c              | 8 +++++---
>>  4 files changed, 14 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index be5363b21540..49b62f024f51 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -1459,7 +1459,12 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
>>  		    int reason, bool has_error_code, u32 error_code);
>>  
>>  int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
>> -int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
>> +int __kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool cr3_is_nested);
>> +static inline int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
>> +{
>> +	return __kvm_set_cr3(vcpu, cr3, false);
>> +}
>> +
>>  int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
>>  int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
>>  int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> index 167d12ab957a..ebf0cb3f1ce0 100644
>> --- a/arch/x86/kvm/mmu/mmu.c
>> +++ b/arch/x86/kvm/mmu/mmu.c
>> @@ -4987,6 +4987,8 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer,
>>  	union kvm_mmu_role new_role =
>>  		kvm_calc_shadow_mmu_root_page_role(vcpu, false);
>>  
>> +	__kvm_mmu_new_pgd(vcpu, nested_cr3, new_role.base, true, true);
>> +
>>  	if (new_role.as_u64 != context->mmu_role.as_u64)
>>  		shadow_mmu_init_context(vcpu, cr0, cr4, efer, new_role);
>>  }
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index e424bce13e6c..b467917a9784 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -324,7 +324,7 @@ static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *nested_v
>>  	svm_set_efer(&svm->vcpu, nested_vmcb->save.efer);
>>  	svm_set_cr0(&svm->vcpu, nested_vmcb->save.cr0);
>>  	svm_set_cr4(&svm->vcpu, nested_vmcb->save.cr4);
>> -	(void)kvm_set_cr3(&svm->vcpu, nested_vmcb->save.cr3);
>> +	(void)__kvm_set_cr3(&svm->vcpu, nested_vmcb->save.cr3, npt_enabled);
>>  
>>  	svm->vmcb->save.cr2 = svm->vcpu.arch.cr2 = nested_vmcb->save.cr2;
>>  	kvm_rax_write(&svm->vcpu, nested_vmcb->save.rax);
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 3b92db412335..3761135eb052 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -1004,7 +1004,7 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>>  }
>>  EXPORT_SYMBOL_GPL(kvm_set_cr4);
>>  
>> -int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
>> +int __kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool cr3_is_nested)
>>  {
>>  	bool skip_tlb_flush = false;
>>  #ifdef CONFIG_X86_64
>> @@ -1031,13 +1031,15 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
>>  		 !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
>>  		return 1;
>>  
>> -	kvm_mmu_new_pgd(vcpu, cr3, skip_tlb_flush, skip_tlb_flush);
>> +	if (!cr3_is_nested)
>> +		kvm_mmu_new_pgd(vcpu, cr3, skip_tlb_flush, skip_tlb_flush);
>> +
>>  	vcpu->arch.cr3 = cr3;
>>  	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
>>  
>>  	return 0;
>>  }
>> -EXPORT_SYMBOL_GPL(kvm_set_cr3);
>> +EXPORT_SYMBOL_GPL(__kvm_set_cr3);
>>  
>>  int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8)
>>  {
>> 
>
> Instead of the new argument (which is not really named right since it's
> never true for !NPT) you could perhaps check vcpu->arch.mmu.  But also,
> for NPT=1 the kvm_mmu_new_pgd is also unnecessary on vmexit, because the
> old roots are still valid (or has been invalidated otherwise) while L2
> was running.
>
> I'm also not sure if skip_tlb_flush can use X86_CR3_PCID_NOFLUSH the way
> kvm_set_cr3 does, so I wouldn't mind duplicating the code completely as
> is already the case for nested_vmx_load_cr3.  It would introduce some
> code duplication, but overall the code would be better.  For now, there
> need not be an equivalent to nested_vmx_transition_mmu_sync, ASID
> handling can be left for later.

Sounds reasonable,

let's introduce nested_svm_load_cr3() to not mix these two concepts
together. I'll be back with v3 shortly, thanks!

-- 
Vitaly

