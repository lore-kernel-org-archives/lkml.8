Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2EBC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9C72076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONnsW4TU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCRKgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:36:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36753 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgCRKgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584527769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kOGaEvY0uUWWp0UDmf+47Tlqah6zLj19Jn9s94Xy88=;
        b=ONnsW4TUP1s8hdVX68HMe7Cwz71izN65/aYZ3JJvIB4LVRRXwJs9DV9DtQdptXB16VuQs2
        I33Uc9zSNi4vpW1tInfv6/KQBjSPgr1YCZSoFghdW1lwH2IPN5krNXUUkEnzMkmqM00GmY
        2h11jAox4KdGguprvMGflzyiKwvVJx0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-avJAj4x8NzORoY0tjuBUTg-1; Wed, 18 Mar 2020 06:36:08 -0400
X-MC-Unique: avJAj4x8NzORoY0tjuBUTg-1
Received: by mail-wr1-f69.google.com with SMTP id w11so12121067wrp.20
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9kOGaEvY0uUWWp0UDmf+47Tlqah6zLj19Jn9s94Xy88=;
        b=LsfM01xxuRzfLKhmiMd7bbs3R2D6L+C4fXw3pzzWq1Dk7esZ88D6+UUXouZ/UtgsYx
         7nBySwuiUZZzmqaXMPrLCTN7950594X1N5EQtBBffbglxxIE+QfBlhLpmc9aQQ++oF99
         CxG25JuBsGbNThv9mEgkNc1z/lUExD9HX9c+XUJiamo95soDZ6uCvAutslQZgE4xcbeN
         lRLumTnPShNqaCnDrOhKAAxo5QFqyuMiWXqlb/213zWth2b9rhQkJJ3pwm5zztrb2CFF
         0gVRINC06cGnptPbTgrjyFbVPCKpjtnZt7J+T6yUPdpIRMQntAssCXXJ9qa/1CWCI+IK
         8QmQ==
X-Gm-Message-State: ANhLgQ1Rif4q+NjbJ272VLoAb4iu4Bc83IUbwYc4dzWn4tFva5EWeSdg
        0zNy4dSQkKf1bJ+CeFl34MWfrBLYJ4xHpkBL/AJhmoD23gHqCL1G+w7HO9FHotd8nfbE5NRgrEf
        ay0BiVkjmHgvSzbHJytD8LWKU
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr5262328wra.157.1584527767068;
        Wed, 18 Mar 2020 03:36:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuuOOj7mHIPHFJZLgSdpePaCmID9395Fcz/+5L89ZGcwdLxZ3fvs1hiO/Pb1h9lf/7IQevihg==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr5262303wra.157.1584527766824;
        Wed, 18 Mar 2020 03:36:06 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id a184sm3141380wmf.29.2020.03.18.03.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 03:36:06 -0700 (PDT)
Subject: Re: [PATCH v2 31/32] KVM: nVMX: Don't flush TLB on nested VM
 transition with EPT enabled
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200317045238.30434-1-sean.j.christopherson@intel.com>
 <20200317045238.30434-32-sean.j.christopherson@intel.com>
 <97f91b27-65ac-9187-6b60-184e1562d228@redhat.com>
 <20200317182251.GD12959@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <218d4dbd-20f1-5bf8-ca44-c53dd9345dab@redhat.com>
Date:   Wed, 18 Mar 2020 11:36:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317182251.GD12959@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/20 19:22, Sean Christopherson wrote:
> On Tue, Mar 17, 2020 at 06:18:37PM +0100, Paolo Bonzini wrote:
>> On 17/03/20 05:52, Sean Christopherson wrote:
>>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>>> index d816f1366943..a77eab5b0e8a 100644
>>> --- a/arch/x86/kvm/vmx/nested.c
>>> +++ b/arch/x86/kvm/vmx/nested.c
>>> @@ -1123,7 +1123,7 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool ne
>>>  	}
>>>  
>>>  	if (!nested_ept)
>>> -		kvm_mmu_new_cr3(vcpu, cr3, false);
>>> +		kvm_mmu_new_cr3(vcpu, cr3, enable_ept);
>>
>> Even if enable_ept == false, we could have already scheduled or flushed
>> the TLB soon due to one of 1) nested_vmx_transition_tlb_flush 2)
>> vpid_sync_context in prepare_vmcs02 3) the processor doing it for
>> !enable_vpid.
>>
>> So for !enable_ept only KVM_REQ_MMU_SYNC is needed, not
>> KVM_REQ_TLB_FLUSH_CURRENT I think.  Worth adding a TODO?
> 
> Now that you point it out, I think it makes sense to unconditionally pass
> %true here, i.e. rely 100% on nested_vmx_transition_tlb_flush() to do the
> right thing.

Why doesn't it need KVM_REQ_MMU_SYNC either?  All this should be in a
comment as well, of course.

(All patches I didn't comment on look good).

Paolo

