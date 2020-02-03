Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BC5C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5293B2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHrs/RyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgBCPLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:11:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31358 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728656AbgBCPLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580742674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yiCdfrSN5EVKEsI/Ra3J2Zu0bhodQqtE6L9IDdhIO3s=;
        b=fHrs/RyJ6InA+90hSFUxneobIKTJoeYY2KrmGAGI9e1QXJdxOMbvm2gkWUQy6up9RJn/gu
        N2DxnlvrH5W8GBz0mq6JOIAGjrE1YYGAZrvFDTT8uj8Y3SmyWCH7xSiY0+gZj22npp3y+A
        EvL+soflEJjbboayFBUhpRRSDQHrcH0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-p0KRqx2fOHu3LXmG1YrSdA-1; Mon, 03 Feb 2020 10:11:09 -0500
X-MC-Unique: p0KRqx2fOHu3LXmG1YrSdA-1
Received: by mail-wr1-f70.google.com with SMTP id c6so8342599wrm.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 07:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yiCdfrSN5EVKEsI/Ra3J2Zu0bhodQqtE6L9IDdhIO3s=;
        b=JSt51ah1z64LPbqvX85oGZoswlmkXsvN9pjF7iQd3A/LpoMzHrkz+Rd4e0EqeyNNlc
         rhG/R9RxPurEx75tfpmcsy1gxv4CDzz79xL/lJlHZ8Fijf0AkMAa9mC3S3UeMxsRa8jm
         UuabcHOT4/GY4H5KzXjXeY/+sPn8qUDuwJ9IsBdDBlwsqIVqyCEGDXrkZYVJ6Nr8iUrU
         cZOgf5KtDZHnZxo6QRwmop3B7nS/CrgR4z5BopIraXuMo5VCXgPGjNIB3gc9mozVy5nZ
         RFzNBdE86+e/hLoueRDjU3fiYzHXcAj6zbyGpSPkySWBjj9tW4fASATyb/cKq7+EmcrC
         kDow==
X-Gm-Message-State: APjAAAUM7PFdzuxUljhvPoy8PIBkm/G4Xzj06MZfqxiT2M0WxPWgoe4y
        cHH7gKHsabwk8rxaODKC9zfl/Ousm6t5wCA5KgG43bEO4K6P+8CdjoWiFK/TVAsndS2YNXIGPRn
        9deU2b/e9ukcH6TgpFqfC1+k6
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr16660807wrx.10.1580742668301;
        Mon, 03 Feb 2020 07:11:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAh+riVZBbe94jkHrX19MsZ8p6ppv9Z7/2yNDOtBFU1YrWfUl65HuNrx4GfZzIcc9XM4Mg2Q==
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr16660782wrx.10.1580742668070;
        Mon, 03 Feb 2020 07:11:08 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n13sm23763969wmd.21.2020.02.03.07.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 07:11:07 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH RFC 2/3] x86/kvm/hyper-v: move VMX controls sanitization out of nested_enable_evmcs()
In-Reply-To: <87a76niypi.fsf@vitty.brq.redhat.com>
References: <20200115171014.56405-1-vkuznets@redhat.com> <20200115171014.56405-3-vkuznets@redhat.com> <A93CDB6E-0E46-4AA8-9B45-8F2EE3C723F5@oracle.com> <87a76niypi.fsf@vitty.brq.redhat.com>
Date:   Mon, 03 Feb 2020 16:11:06 +0100
Message-ID: <87h807ogdx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Liran Alon <liran.alon@oracle.com> writes:
>
>>> On 15 Jan 2020, at 19:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>> 
>>> With fine grained VMX feature enablement QEMU>=4.2 tries to do KVM_SET_MSRS
>>> with default (matching CPU model) values and in case eVMCS is also enabled,
>>> fails.
>>> 
>>> It would be possible to drop VMX feature filtering completely and make
>>> this a guest's responsibility: if it decides to use eVMCS it should know
>>> which fields are available and which are not. Hyper-V mostly complies to
>>> this, however, there is at least one problematic control:
>>> SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES
>>> which Hyper-V enables. As there is no 'apic_addr_field' in eVMCS, we
>>> fail to handle this properly in KVM. It is unclear how this is supposed
>>> to work, genuine Hyper-V doesn't expose the control so it is possible that
>>> this is just a bug (in Hyper-V).
>>
>> Have you tried contacted someone at Hyper-V team about this?
>>
>
> Yes, I have.

I heard back from MS, they admited the bug and suggested us ... to hide
the control from L1 when eVMCS is enabled. No surprises here. They also
said the bug is unlikely to get fixed in the existing Hyper-V versions
(2016 and 2019) so it seems we're stuck with the hack for awhile :-(

...

>>> 
>>> #endif /* __KVM_X86_VMX_EVMCS_H */
>>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>>> index e3394c839dea..8eb74618b8d8 100644
>>> --- a/arch/x86/kvm/vmx/vmx.c
>>> +++ b/arch/x86/kvm/vmx/vmx.c
>>> @@ -1849,8 +1849,14 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>> 	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
>>> 		if (!nested_vmx_allowed(vcpu))
>>> 			return 1;
>>> -		return vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
>>> -				       &msr_info->data);
>>> +		if (vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
>>> +				    &msr_info->data))
>>> +			return 1;
>>> +		if (!msr_info->host_initiated &&
>>> +		    vmx->nested.enlightened_vmcs_enabled)
>>> +			nested_evmcs_filter_control_msr(msr_info->index,
>>> +							&msr_info->data);
>>> +		break;
>>
>> Nit: It seems more elegant to me to put the call to nested_evmcs_filter_control_msr() inside vmx_get_vmx_msr().
>>
>
> Sure, will move it there (in case we actually decide to merge this)
>

Thinking more about it, we can't check host_initiated in
vmx_get_vmx_msr() as it's not passed there, this can probably get
changed but I don't see a big difference so I'll probably keep the hack
where it is now.

-- 
Vitaly

