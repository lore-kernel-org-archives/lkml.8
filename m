Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FC0C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7B4206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I04So+p9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgC0MsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:48:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54073 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgC0MsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585313288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J3R9pjfcrLfveJt0OaJwOudwQhu7GzXewbxhBYVgwpg=;
        b=I04So+p9VSD2hBwynFiXK+dmEn7MeZnQ5SOLdGNa5yArhKHYDpfXNyQQeCiANEiQEj/SHZ
        3mnfhENd+MqjhXJVNs1ZuOs/xhDZZaPeCz3hQbxrgxVa76Awl43ej42yMPF/bIvMIQoVcF
        cCDgqNfrzAo9s9kS6HQhMRl2k7QIGF4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-LPpkSmZJMEe8A8K9hONBgQ-1; Fri, 27 Mar 2020 08:48:07 -0400
X-MC-Unique: LPpkSmZJMEe8A8K9hONBgQ-1
Received: by mail-wr1-f70.google.com with SMTP id u18so4466700wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=J3R9pjfcrLfveJt0OaJwOudwQhu7GzXewbxhBYVgwpg=;
        b=MF2NzFFfE40v3AoqmNPTpU0CCFzN7w2bt+0nluaO2VijDVu9FB+2+1qvK445BwPLAE
         fdcJTbw9Ayd3je14qpoLVnDEDTaOrJymsKV3u7OZx77ksrl5cm/CrIu2U2p0DwtQxeEP
         dbMnlRrvhEwiNpF+lkyMxfWOxmTbSx6I15YPcXxi0WwvVtJwufT5GwWonT4ePMUrg6hH
         MQsbRWXojYrWMCOzZY9yEVuO1zV8fge+mjNPSd8eXcmJXvK4Jwn513PBiAqbLHu4L43I
         pnLjxBimkGcOJyylvZJCuhNgVXihp64KK9qorCegb1mOUveVOQnCWHBk0UoNDrrK0dsJ
         5hkQ==
X-Gm-Message-State: ANhLgQ3yqE20tv1UQRZzGkvFM69ONexbp67bAseS1K/4J+j3Ki2I/WmL
        FdYOu/Jj0NdmYqpgxNgvfcSYwFypEFUUfQUL0WCso9TkbQHiJpi09EaO1AK8L7gG3Xf6RGr+Y9R
        tIAgjeGTuHqKcZOUbt+fw62Ag
X-Received: by 2002:adf:f5c8:: with SMTP id k8mr13922486wrp.33.1585313286078;
        Fri, 27 Mar 2020 05:48:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt5vgDE/lGJRuJHFUg90TW5N/ADRnKJCzJQ3za8iF5BR3iNikqZ3JIgzc9k8sjECJJks2AE1A==
X-Received: by 2002:adf:f5c8:: with SMTP id k8mr13922457wrp.33.1585313285753;
        Fri, 27 Mar 2020 05:48:05 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a8sm7715284wmb.39.2020.03.27.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:48:04 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Junaid Shahid <junaids@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/3] KVM: x86: cleanup kvm_inject_emulated_page_fault
In-Reply-To: <d2222e81-8618-b3b0-baf3-2bda72d48ede@redhat.com>
References: <20200326093516.24215-1-pbonzini@redhat.com> <20200326093516.24215-3-pbonzini@redhat.com> <877dz75j4i.fsf@vitty.brq.redhat.com> <d2222e81-8618-b3b0-baf3-2bda72d48ede@redhat.com>
Date:   Fri, 27 Mar 2020 13:48:04 +0100
Message-ID: <87a7423qwr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 26/03/20 14:41, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> To reconstruct the kvm_mmu to be used for page fault injection, we
>>> can simply use fault->nested_page_fault.  This matches how
>>> fault->nested_page_fault is assigned in the first place by
>>> FNAME(walk_addr_generic).
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  arch/x86/kvm/mmu/mmu.c         | 6 ------
>>>  arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
>>>  arch/x86/kvm/x86.c             | 7 +++----
>>>  3 files changed, 4 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>>> index e26c9a583e75..6250e31ac617 100644
>>> --- a/arch/x86/kvm/mmu/mmu.c
>>> +++ b/arch/x86/kvm/mmu/mmu.c
>>> @@ -4353,12 +4353,6 @@ static unsigned long get_cr3(struct kvm_vcpu *vcpu)
>>>  	return kvm_read_cr3(vcpu);
>>>  }
>>>  
>>> -static void inject_page_fault(struct kvm_vcpu *vcpu,
>>> -			      struct x86_exception *fault)
>>> -{
>>> -	vcpu->arch.mmu->inject_page_fault(vcpu, fault);
>>> -}
>>> -
>> 
>> This is already gone with Sean's "KVM: x86: Consolidate logic for
>> injecting page faults to L1".
>> 
>> It would probably make sense to have a combined series (or a branch on
>> kvm.git) to simplify testing efforts.
>
> Yes, these three patches replace part of Sean's (the patch you mention
> and the next one, "KVM: x86: Sync SPTEs when injecting page/EPT fault
> into L1").
>
> I pushed the result to a branch named kvm-tlb-cleanup on kvm.git.
>

Thank you,

I've tested it with Hyper-V on both VMX and SVM with and without PV TLB
flush and nothing immediately blew up. I'm also observing a very nice
19000 -> 14000 cycles improvement on tight cpuid loop test (with EVMCS
enabled).

-- 
Vitaly

