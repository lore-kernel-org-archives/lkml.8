Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D0DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C996E20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0AXpyUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbgE0Q43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:56:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35485 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728296AbgE0Q42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590598586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iV7PJ6499KBh2jHYA4ZAtJgeGbwihYkeZJNBRtXPRHU=;
        b=b0AXpyUYdPcA704oEKDtOsJZ7zzbsuXYjXbx1qV/Nt2JFWkzHuqVugOYgu2sJo1sw5CzUv
        yYT3fFf4Z47xAs+ZfeJ4oUz75RLJteQdFcG2pD1pOPA0XYGf8WZz/OCOpkhq7qnmU0mrEq
        7POy7tRwV27yu3WZq0CtN8XkJ+3fcQQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-y4g_OSpmPaW649lhO_50Ow-1; Wed, 27 May 2020 12:56:23 -0400
X-MC-Unique: y4g_OSpmPaW649lhO_50Ow-1
Received: by mail-wr1-f72.google.com with SMTP id a4so2265680wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iV7PJ6499KBh2jHYA4ZAtJgeGbwihYkeZJNBRtXPRHU=;
        b=XINy491Vw8e8l3KdQ3fHClrt3rgIIKPS2h+kPM4XDOtb6y/9l11WV6MXA3seFE2fEG
         ZGDpMaZDQKj79OWTJkdeI9IHmw89t9216CIwsvV8vWw3x13hF/vOlcGuZ5BaTY0QppLe
         m8e4Kn2sxDlD0mmFqFPk9vR5it6E6k5Kb6tubC4XgM0z5li4n1QDrs4+LKQRxX2eoFuG
         ISm9/T9l3QUb3z47pxivAvV4m6fCyaAi/dQVlOVWbBKJ9HMm9b/huNrYwvXL9ss7ae7g
         y8tv99m9SluUaulQubiGcRw2qRcxeWGYQkDjJYKgUzu5tD7MDhUobAEmMTbJta626q9+
         vwmw==
X-Gm-Message-State: AOAM5333xNfuB73ohLKQqFN2CNSLt9p3He4uHhSffgZPpwh18h/pcj1G
        ktNwKiwnWamQj3+aO06e1ImJuH752cX6aXCm0H1u2Ce3LAMzMRBLdZVnJbRD+t0gTK5mIKf0s5p
        p1PCJVHg2xqCANcOmmymjTM4y
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr5127047wmc.95.1590598581817;
        Wed, 27 May 2020 09:56:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWqtxWIpSj7lNv4aAoT7R1wHmHCL5CoZGek+Bmi7wvG2hiEcJDp9eWQVm/NvOtXtAmmI1Rhw==
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr5127030wmc.95.1590598581595;
        Wed, 27 May 2020 09:56:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id i21sm3504216wml.5.2020.05.27.09.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 09:56:21 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Initialize tdp_level during vCPU creation
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+904752567107eefb728c@syzkaller.appspotmail.com
References: <20200527085400.23759-1-sean.j.christopherson@intel.com>
 <40800163-2b28-9879-f21b-687f89070c91@redhat.com>
 <20200527162933.GE24461@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <078365dd-64ff-4f3c-813c-3d9fc955ed1a@redhat.com>
Date:   Wed, 27 May 2020 18:56:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200527162933.GE24461@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/20 18:29, Sean Christopherson wrote:
> On Wed, May 27, 2020 at 06:17:57PM +0200, Paolo Bonzini wrote:
>> On 27/05/20 10:54, Sean Christopherson wrote:
>>> Initialize vcpu->arch.tdp_level during vCPU creation to avoid consuming
>>> garbage if userspace calls KVM_RUN without first calling KVM_SET_CPUID.
>>>
>>> Fixes: e93fd3b3e89e9 ("KVM: x86/mmu: Capture TDP level when updating CPUID")
>>> Reported-by: syzbot+904752567107eefb728c@syzkaller.appspotmail.com
>>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>>> ---
>>>  arch/x86/kvm/x86.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index b226fb8abe41b..01a6304056197 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -9414,6 +9414,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>>>  	fx_init(vcpu);
>>>  
>>>  	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
>>> +	vcpu->arch.tdp_level = kvm_x86_ops.get_tdp_level(vcpu);
>>>  
>>>  	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
>>
>> Queued, it is probably a good idea to add a selftests testcase for this
>> (it's even okay if it doesn't use the whole selftests infrastructure and
>> invokes KVM_CREATE_VM/KVM_CREATE_VCPU/KVM_RUN manually).
> 
> Ya.  syzbot is hitting a #GP due to NULL pointer during debugfs on the exact
> same sequence.  I haven't been able to reproduce that one (have yet to try
> syzbot's exact config), but it's another example of a "dumb" test hitting
> meaningful bugs.

Saw that, it's mine. :)

Paolo

