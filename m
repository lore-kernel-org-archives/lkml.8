Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA4C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA0B2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3eFJEX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgEEIIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:08:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725833AbgEEIIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588666096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=47lMT6kLVt1KyFlpgunpLpY9wxuv5GbgX9JkN70Ja9o=;
        b=O3eFJEX1FohfI9y3TgLD+APUYT5JYfV7vbFUtRomW8LuGlv9W5nE8a0DMnzbQs7pKqOf1H
        xHQCQq3uzm1FBZe8zlcCd7/YOxVu2CHBLAVdmU+yu6yR72o3kbRnxqU7v5toF02cGC6lnD
        h6Mk2ptUwd8rTM4XO5ZHgQ7le6qKLTg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-c7J4xIlQNOKfc2GWHvl0Og-1; Tue, 05 May 2020 04:08:13 -0400
X-MC-Unique: c7J4xIlQNOKfc2GWHvl0Og-1
Received: by mail-wm1-f70.google.com with SMTP id n17so495900wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 01:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=47lMT6kLVt1KyFlpgunpLpY9wxuv5GbgX9JkN70Ja9o=;
        b=L5RdE4WDj9u0s8BBdlbu26FNnIST0hdahBzananFT5vBRD+97otz1piGcQFEG/L8JS
         wm6PdbJRDKeZh1qtJr8zFni9vQN3POjP74lA94Bis1ZM4Mrz3ya2cOmTasXdv/19Hvow
         TrLWAIrXFUVEehA7wlCpT9SDAdxXfWxMh1aGCa0rQySSfpZwPDTfwSfoalJ9kxeiS59o
         PQhFnUdQ7/jMJZulQsSHzhDTDMHTV4dGJZGSVRLNcKmrnVZEzk7s4sOdeKXoM2MGbVLE
         9/0psyJjQE/95NcogOj3stvByTgeUV6ZG/Mf3hVfHdpttNLw/JNxmjosC8rwvi59iAzT
         Wz9g==
X-Gm-Message-State: AGi0PuaN9xpWmRkcrx4DRMM1EGvJiGBAz6A7SyVfvU9eT7FR+BAtXoAL
        K8rJxSpQWNguM6h7cM5HY/vCZCiY+SCVZTWX/kgOv4MgM91wMwQz3C4AQY9Io1OAPSEX4pQIoxv
        3TT2j7QjLCg2FJ63pygDtJDhQ
X-Received: by 2002:adf:fcc6:: with SMTP id f6mr1990873wrs.388.1588666092230;
        Tue, 05 May 2020 01:08:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXLB0CZpg9ZBJB9HEiNOemJV+reID+sLNqwbwJIMFth2tEFPjtycRqGqog0JhAopNBJApfJA==
X-Received: by 2002:adf:fcc6:: with SMTP id f6mr1990842wrs.388.1588666091942;
        Tue, 05 May 2020 01:08:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i17sm2584491wml.23.2020.05.05.01.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 01:08:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Gavin Shan <gshan@redhat.com>, x86@kernel.org, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RFC 2/6] KVM: x86: extend struct kvm_vcpu_pv_apf_data with token info
In-Reply-To: <409b802c-0abe-0cb4-92fe-925733bfd612@redhat.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com> <20200429093634.1514902-3-vkuznets@redhat.com> <409b802c-0abe-0cb4-92fe-925733bfd612@redhat.com>
Date:   Tue, 05 May 2020 10:08:09 +0200
Message-ID: <871rnyerdi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gavin Shan <gshan@redhat.com> writes:

> Hi Vitaly,
>
> On 4/29/20 7:36 PM, Vitaly Kuznetsov wrote:
>> Currently, APF mechanism relies on the #PF abuse where the token is being
>> passed through CR2. If we switch to using interrupts to deliver page-ready
>> notifications we need a different way to pass the data. Extent the existing
>> 'struct kvm_vcpu_pv_apf_data' with token information.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>   arch/x86/include/uapi/asm/kvm_para.h |  3 ++-
>>   arch/x86/kvm/x86.c                   | 10 ++++++----
>>   2 files changed, 8 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
>> index 2a8e0b6b9805..df2ba34037a2 100644
>> --- a/arch/x86/include/uapi/asm/kvm_para.h
>> +++ b/arch/x86/include/uapi/asm/kvm_para.h
>> @@ -113,7 +113,8 @@ struct kvm_mmu_op_release_pt {
>>   
>>   struct kvm_vcpu_pv_apf_data {
>>   	__u32 reason;
>> -	__u8 pad[60];
>> +	__u32 token;
>> +	__u8 pad[56];
>>   	__u32 enabled;
>>   };
>>   
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index b93133ee07ba..7c21c0cf0a33 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2662,7 +2662,7 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>>   	}
>>   
>>   	if (kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
>> -					sizeof(u32)))
>> +					sizeof(u64)))
>>   		return 1;
>>   
>>   	vcpu->arch.apf.send_user_only = !(data & KVM_ASYNC_PF_SEND_ALWAYS);
>> @@ -10352,8 +10352,9 @@ static void kvm_del_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
>>   	}
>>   }
>>   
>> -static int apf_put_user(struct kvm_vcpu *vcpu, u32 val)
>> +static int apf_put_user(struct kvm_vcpu *vcpu, u32 reason, u32 token)
>>   {
>> +	u64 val = (u64)token << 32 | reason;
>>   
>>   	return kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.apf.data, &val,
>>   				      sizeof(val));
>> @@ -10405,7 +10406,8 @@ void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
>>   	kvm_add_async_pf_gfn(vcpu, work->arch.gfn);
>>   
>>   	if (kvm_can_deliver_async_pf(vcpu) &&
>> -	    !apf_put_user(vcpu, KVM_PV_REASON_PAGE_NOT_PRESENT)) {
>> +	    !apf_put_user(vcpu, KVM_PV_REASON_PAGE_NOT_PRESENT,
>> +			  work->arch.token)) {
>>   		fault.vector = PF_VECTOR;
>>   		fault.error_code_valid = true;
>>   		fault.error_code = 0;
>> @@ -10438,7 +10440,7 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>>   	trace_kvm_async_pf_ready(work->arch.token, work->cr2_or_gpa);
>>   
>>   	if (vcpu->arch.apf.msr_val & KVM_ASYNC_PF_ENABLED &&
>> -	    !apf_put_user(vcpu, KVM_PV_REASON_PAGE_READY)) {
>> +	    !apf_put_user(vcpu, KVM_PV_REASON_PAGE_READY, work->arch.token)) {
>>   			fault.vector = PF_VECTOR;
>>   			fault.error_code_valid = true;
>>   			fault.error_code = 0;
>> 
>
> It would be as below based on two facts: (1) token is more important than reason;
> (2) token will be put into high word of @val. I think apf_{get,put}_user() might
> be worthy to be inline. However, it's not a big deal.

This is to be changed in v1 as we agreed to drop page-ready delivery via
#PF completely.

>     static inline int apf_put_user(struct kvm_vcpu *vcpu, u32 token, u32 reason)
>

Yes, it makes sense to inline these. Thanks!

-- 
Vitaly

