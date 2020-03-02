Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BE4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A6A246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ci8NDOIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCBJDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:03:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34124 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgCBJDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583139800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zh8cgchJm1y3v+DF2yCaLs1qahz0gPLON0uwqCUOxqk=;
        b=ci8NDOImEG8D098RboSnMmXX1gRT/3eybqBFTGyOoAn+COLcm/ldrwCsZWtrnT+f7v5g2C
        P3J7GmNY0ys6ZqzS8QfLKG9o+TEkXTpPtGWMp35n2pzwT/XaZDtP7wjL32JY3qjCGbqFxu
        8s+nLTUGUy7olwWIKGaIt6wlY8e6L8Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-7JSrurCbO0K9rVDdU58Kvg-1; Mon, 02 Mar 2020 04:03:19 -0500
X-MC-Unique: 7JSrurCbO0K9rVDdU58Kvg-1
Received: by mail-wr1-f71.google.com with SMTP id j32so5471661wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 01:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zh8cgchJm1y3v+DF2yCaLs1qahz0gPLON0uwqCUOxqk=;
        b=TMdZ5QeSr/s71leoBMZ7+8RPb9KfbTuFnVB+Qbu6vrdkFeqygYxoF74w729RtoCwi1
         s88m72nvHxflQA+huvBb6BhLcS9lyry9rWJukgWqa/47jQOz3teI8Bd92DmaxNkQ9iKD
         hMaXnDUuLnTX0/WjHgJX2Lc43XRGzo5keZ3HRu4XfykaVcI2RNE4yY3wkhC3xuMSk8HD
         QNuYFwviHYO1sBR4hZWZ1txyQMXzVUelGi4Z38YNefugmBrA/57VEdLlVPZvo90oUGEz
         1PBe7MZJqc6W7BLbcRD6yArGpMxZIF5x+8ji4zjiBabwjX5M08L2Lv8jJmhawHnTBrSD
         As6g==
X-Gm-Message-State: APjAAAWfe6VsKWW8Gie6tF/iaXo/2KSg0qI1fI54nOZ1S/Z40gj5bxgX
        9qJJCKzq7xGCFiH/O9JTw2WR6Qn2t/fW+jtb3LhfT8bpTJivWbNCs95rnOS7D/45AfAYtpuYAXA
        GX9Dx4bi+XjyRS7VMt/IInGTo
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr21266753wrt.102.1583139797981;
        Mon, 02 Mar 2020 01:03:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqyC8l2PJhEaf0MiIHxDflEbFnI0+GLughJFRf0goS12IzY5n+bQfTBb90jKAb24wmRK/g4wRA==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr21266722wrt.102.1583139797799;
        Mon, 02 Mar 2020 01:03:17 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w1sm14213034wmc.11.2020.03.02.01.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 01:03:17 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/61] KVM: x86: Introduce KVM cpu caps
In-Reply-To: <20200229183219.GA22451@linux.intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <87wo8ak84x.fsf@vitty.brq.redhat.com> <20200229183219.GA22451@linux.intel.com>
Date:   Mon, 02 Mar 2020 10:03:16 +0100
Message-ID: <8736ari0x7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Feb 25, 2020 at 04:18:38PM +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 
>> >
>> >   7. Profit!
>> 
>> Would it be better or worse if we eliminate set_supported_cpuid() hook
>> completely by doing an ugly hack like (completely untested):
>> 
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index a2a091d328c6..5ad291d48e1b 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -1145,8 +1145,6 @@ struct kvm_x86_ops {
>>  
>>         void (*set_tdp_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
>>  
>> -       void (*set_supported_cpuid)(struct kvm_cpuid_entry2 *entry);
>> -
>>         bool (*has_wbinvd_exit)(void);
>>  
>>         u64 (*read_l1_tsc_offset)(struct kvm_vcpu *vcpu);
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index e8beb1e542a8..88431fc02797 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -749,6 +749,16 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  		cpuid_entry_override(entry, CPUID_8000_0008_EBX);
>>  		break;
>>  	}
>> +	case 0x8000000A:
>> +		if (boot_cpu_has(X86_FEATURE_SVM)) {
>> +			entry->eax = 1; /* SVM revision 1 */
>> +			entry->ebx = 8; /* Lets support 8 ASIDs in case we add proper
>> +					   ASID emulation to nested SVM */
>> +			entry->ecx = 0; /* Reserved */
>> +			entry->edx = 0; /* Per default do not support any
>> +					   additional features */
>
> Lucky thing that you suggested this change, patch ("KVM: SVM: Convert
> feature updates from CPUID to KVM cpu caps") was buggy in that clearing
> entry->edx here would wipe out all X86_FEATURE_NRIPS and X86_FEATURE_NPT.
> Only noticed it when moving this code. 
>

I plan to give your v2 a spin on AMD Epyc, just in case)

-- 
Vitaly

