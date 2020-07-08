Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBE2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994F721D6C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBEpcF+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgGHIi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:38:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54323 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726787AbgGHIi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594197505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69BhJ5TklPv9IEA6MOVSk3TCKrQG02Q0fSUC+Usvs9U=;
        b=RBEpcF+vF5kXQFL8b+6ucAtpjC+8kuQEu+JmbZbaVIeoQWwD1POqTBujxDmGbRsdfsxthQ
        TTQ73X0n7HUHUe/YF0YaJat95vodL8DlX/3RNHpi4bnVJYlQiFsyMq9EnLYGmMB8JcZ4Zw
        IBn1mLpW0gsdos+BWpYpm797+L6xmzA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-p4Ql11HCNzWOO2ztBYBcOA-1; Wed, 08 Jul 2020 04:38:24 -0400
X-MC-Unique: p4Ql11HCNzWOO2ztBYBcOA-1
Received: by mail-wm1-f69.google.com with SMTP id g187so2270146wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 01:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=69BhJ5TklPv9IEA6MOVSk3TCKrQG02Q0fSUC+Usvs9U=;
        b=IFGry37ZvMl+p74eDD4SNN2n530+No8YuIxYIJoWur8EQdv1yoY9uWJUHUxUl5aip/
         cqsXLVMr3AnMvVGLAEPHIPHZ8RIG1uLCRKCcWb6vcvh1rtGtdYaSdq32074YeK9TPiqv
         hbui9rcENZCm0KV8BMPm7GG84dAEFmKnl8nRP1wHqSi3C6FZL1f6JsJxuvvX8DGdoAEJ
         4VGxXM1/QV45YbBpvCbhpPjOEmp1MwL4wHFWfoRxZlU3V+HFGqgq5UmNq4DIO1sb64NA
         WQLdS8EYwF+mBWbUiZiq97KqwpDZNRJMlcXgBoYmJ0DuBlVr67fz9x4lOJG0Z/Cf0otS
         +GyA==
X-Gm-Message-State: AOAM533OQdmjo+wNtX+lbvshVTIg/hqtwObKDoTVFxbXgl9a710NkEv0
        5/jegpb2Gt31wx7n6F/KHnevhyPPs2cb3ahCpmh2aZ0sWXUdg8g/EqU3XoUfCsOYHqfYJjFpjGY
        RWXCHLzOcLF5Et8DZnqK12OiE
X-Received: by 2002:a5d:6990:: with SMTP id g16mr48536913wru.131.1594197502901;
        Wed, 08 Jul 2020 01:38:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWePtjMU0TTtx2MY8HJ/yPg1WFUm+oDrlqf02p0ziiwedP9bBIT4OxuzK5wxCbzQvL73uVpw==
X-Received: by 2002:a5d:6990:: with SMTP id g16mr48536890wru.131.1594197502645;
        Wed, 08 Jul 2020 01:38:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id v12sm4815462wrt.31.2020.07.08.01.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 01:38:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: SVM: avoid infinite loop on NPF from bad address
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "# v3 . 10+" <stable@vger.kernel.org>
References: <20200417163843.71624-1-pbonzini@redhat.com>
 <20200417163843.71624-2-pbonzini@redhat.com>
 <CANRm+CyWKbSU9FZkGoPx2nff-Se3Qcfn1TXXw8exy-6nuZrirg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57a405b3-6836-83f0-ed97-79f637f7b456@redhat.com>
Date:   Wed, 8 Jul 2020 10:38:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CyWKbSU9FZkGoPx2nff-Se3Qcfn1TXXw8exy-6nuZrirg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 10:17, Wanpeng Li wrote:
> On Sat, 18 Apr 2020 at 00:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> When a nested page fault is taken from an address that does not have
>> a memslot associated to it, kvm_mmu_do_page_fault returns RET_PF_EMULATE
>> (via mmu_set_spte) and kvm_mmu_page_fault then invokes svm_need_emulation_on_page_fault.
>>
>> The default answer there is to return false, but in this case this just
>> causes the page fault to be retried ad libitum.  Since this is not a
>> fast path, and the only other case where it is taken is an erratum,
>> just stick a kvm_vcpu_gfn_to_memslot check in there to detect the
>> common case where the erratum is not happening.
>>
>> This fixes an infinite loop in the new set_memory_region_test.
>>
>> Fixes: 05d5a4863525 ("KVM: SVM: Workaround errata#1096 (insn_len maybe zero on SMAP violation)")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  arch/x86/kvm/svm/svm.c | 7 +++++++
>>  virt/kvm/kvm_main.c    | 1 +
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index a91e397d6750..c86f7278509b 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -3837,6 +3837,13 @@ static bool svm_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
>>         bool smap = cr4 & X86_CR4_SMAP;
>>         bool is_user = svm_get_cpl(vcpu) == 3;
>>
>> +       /*
>> +        * If RIP is invalid, go ahead with emulation which will cause an
>> +        * internal error exit.
>> +        */
>> +       if (!kvm_vcpu_gfn_to_memslot(vcpu, kvm_rip_read(vcpu) >> PAGE_SHIFT))
>> +               return true;
>> +
>>         /*
>>          * Detect and workaround Errata 1096 Fam_17h_00_0Fh.
>>          *
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index e2f60e313c87..e7436d054305 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -1602,6 +1602,7 @@ struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn
>>  {
>>         return __gfn_to_memslot(kvm_vcpu_memslots(vcpu), gfn);
>>  }
>> +EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_memslot);
> 
> This commit incurs the linux guest fails to boot once add --overcommit
> cpu-pm=on or not intercept hlt instruction, any thoughts?

Can you write a selftest?

Paolo

