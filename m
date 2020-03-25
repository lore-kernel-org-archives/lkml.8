Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6806C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4792073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyKwMif1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgCYPlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:41:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41748 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727705AbgCYPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585150872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Ngiuyi2mPOkcihv5oJIqBDsHsKSsKleu59l1oFbskM=;
        b=RyKwMif1TJyCfgXvXlK70cF/HAH2Z6Kux+E7tqzMnclvUOrjWHZrlYkyUe9jx8xQ7+xVWE
        /C/Ka6LqMqq3dUPUG1sHTjs/zn2FouVs/O4B8MgOEScsyHl0w9lvXW7ILmnZih2LEM6pWc
        4jXloO5hOVtEYA6zP0euqE5XtBVHd5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-QWEOr6s2Pz67q8pUNJng2g-1; Wed, 25 Mar 2020 11:41:11 -0400
X-MC-Unique: QWEOr6s2Pz67q8pUNJng2g-1
Received: by mail-wm1-f72.google.com with SMTP id s15so834962wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Ngiuyi2mPOkcihv5oJIqBDsHsKSsKleu59l1oFbskM=;
        b=F20KPN/8GqxawZjvB39REcVhm7fJibKEGXi4+1ubP5bh87GSJ7g43MZVHo8tkRn3NV
         txl5hl71TwHobMEN54w+wBEbHhUs+scdqWg3s3CfYre7WoT851kyrm6/UuTBm8eeEqo2
         xBTjqeS6rWm4D8n58uLfA19Rr3DjZg+ie3AOu66J9uy1GS9wWaZntIbpR/CzlCQi2dka
         7jd630eZFLPUnkQRc0e2ChS5+UbLq0tv1j/0pYcfHys/OhQgkFOFqE/OHkB+3gf+NqKg
         eqs/PDRwh62c5y2O/KT+w9xpI8AHCIpmbr9DLAfFTmHAtgz7//oFNRGrh0L4/C1kgEiD
         i9mw==
X-Gm-Message-State: ANhLgQ2hvWi8Cs+xTxwSwP6BlmOqAAVRZ9agftkpbp4XobXL66WfUP8R
        VByOtsWZnxfHu/s7DyDx00QNPUAJg03RCab+UYvJn2Jn8Ec54LVcBIcT7khkvgwa3un9MSPAeQ1
        zhIhQJLZ74yoMpVrILqxOcg3m
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr3959974wml.120.1585150869592;
        Wed, 25 Mar 2020 08:41:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvbr1+l/xZMbMViqldvquG3f4mIsOv7XLQLH9qfgp9XfXr6o0IjBTSGNeUaZgxu8Y59Ae59mQ==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr3959958wml.120.1585150869364;
        Wed, 25 Mar 2020 08:41:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e4f4:3c00:2b79:d6dc? ([2001:b07:6468:f312:e4f4:3c00:2b79:d6dc])
        by smtp.gmail.com with ESMTPSA id n9sm6377963wru.50.2020.03.25.08.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:41:08 -0700 (PDT)
Subject: Re: [PATCH v3 14/37] KVM: x86: Move "flush guest's TLB" logic to
 separate kvm_x86_ops hook
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-15-sean.j.christopherson@intel.com>
 <87369w7mxe.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d1ef88c-2b68-58c5-c62e-8b123187e573@redhat.com>
Date:   Wed, 25 Mar 2020 16:41:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87369w7mxe.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/20 11:23, Vitaly Kuznetsov wrote:
> What do you think about the following (very lightly
> tested)?
> 
> commit 485b4a579605597b9897b3d9ec118e0f7f1138ad
> Author: Vitaly Kuznetsov <vkuznets@redhat.com>
> Date:   Wed Mar 25 11:14:25 2020 +0100
> 
>     KVM: x86: make Hyper-V PV TLB flush use tlb_flush_guest()
>     
>     Hyper-V PV TLB flush mechanism does TLB flush on behalf of the guest
>     so doing tlb_flush_all() is an overkill, switch to using tlb_flush_guest()
>     (just like KVM PV TLB flush mechanism) instead. Introduce
>     KVM_REQ_HV_TLB_FLUSH to support the change.
>     
>     Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 167729624149..8c5659ed211b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -84,6 +84,7 @@
>  #define KVM_REQ_APICV_UPDATE \
>  	KVM_ARCH_REQ_FLAGS(25, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_TLB_FLUSH_CURRENT	KVM_ARCH_REQ(26)
> +#define KVM_REQ_HV_TLB_FLUSH		KVM_ARCH_REQ(27)
>  
>  #define CR0_RESERVED_BITS                                               \
>  	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index a86fda7a1d03..0d051ed11f38 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1425,8 +1425,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>  	 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we can't
>  	 * analyze it here, flush TLB regardless of the specified address space.
>  	 */
> -	kvm_make_vcpus_request_mask(kvm,
> -				    KVM_REQ_TLB_FLUSH | KVM_REQUEST_NO_WAKEUP,
> +	kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH,
>  				    vcpu_mask, &hv_vcpu->tlb_flush);
>  

Looks good, but why are you dropping KVM_REQUEST_NO_WAKEUP?

Paolo

