Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C4C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08829222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgOoJi9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgBURbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:31:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32156 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726672AbgBURbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582306273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gre7ZeHoqmuVRTzKby7XOW3ou3/ssFLu22ygHR886dQ=;
        b=bgOoJi9xSZfzCNqFrbzAFKHcjA2FqUEzE8+W1ph17D2XAKCvbqPCABk5H0nyjEVS5vwSh7
        IlXjynd7dXHdkEGLouDPsG2adzDDzaChzu/G0tUpgs4VWAcQ6G08fHH0UN+YBY3kS135Z6
        Wj0w9Oy5xqNB1Ah25u0hmlUynOBuhf4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-VpDK6f7OM5OYGH3ksvznNw-1; Fri, 21 Feb 2020 12:31:12 -0500
X-MC-Unique: VpDK6f7OM5OYGH3ksvznNw-1
Received: by mail-wr1-f72.google.com with SMTP id w6so1309106wrm.16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gre7ZeHoqmuVRTzKby7XOW3ou3/ssFLu22ygHR886dQ=;
        b=VjRgKdbn9wTYrOVPpERrSHzK6wUwhKWb6FnaMS88bkB+h/92CDzFyj9s8J/Vf3XXnc
         qavJl0e79xr0M3uDZrmvDuEZPvgJpLD2B6Mg4SnOhIJ+hrPTGXXuySDS4DXJADo6YKEF
         mjYb9CQtoLOXomqg8r1qXlGBM9gLeIow6YsZD9SEZ3J5XwV/omY7fEqu/cTi2GK8WFEB
         aTNN8jJ8rdDONJSvO/KL14fprLxsEQlfloC3jwn4u/fAW5eQ5lBv3PFbe21LRg3MHK9G
         4jF/PLV4xSQnA1AThkwGgnX9HoFN0ZAcCXNOPTBH6Onu0Lv18FG+PYGgdOBXXMnWX0Ou
         eL1g==
X-Gm-Message-State: APjAAAWmiEKqwUCbQcMZ1MHdRxVxstb2u6amPbtdbDanKdpEvjqrxE2I
        N53Eyu62mkYRSaxoBuPXHaByceHk+gbl5pxQ13oKoGjCoaVN4vXjqiFFUlmTCZVoQTZFuPIfvaL
        CBa/Ca0oZzpHs9zN4tS4XPXoq
X-Received: by 2002:adf:a285:: with SMTP id s5mr52449170wra.118.1582306270989;
        Fri, 21 Feb 2020 09:31:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7DaCwm5dSXMY0+lvo38I3IH/+yBcp1BncOFZ36eQi1wCSVSKGwh91upvl4OmRXmjCzVSTDg==
X-Received: by 2002:adf:a285:: with SMTP id s5mr52449151wra.118.1582306270694;
        Fri, 21 Feb 2020 09:31:10 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id j66sm4767694wmb.21.2020.02.21.09.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:31:10 -0800 (PST)
Subject: Re: [PATCH 06/10] KVM: x86: Move "flush guest's TLB" logic to
 separate kvm_x86_ops hook
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200220204356.8837-1-sean.j.christopherson@intel.com>
 <20200220204356.8837-7-sean.j.christopherson@intel.com>
 <87tv3krqta.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cef77bcf-0921-a530-9745-7922e657b013@redhat.com>
Date:   Fri, 21 Feb 2020 18:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87tv3krqta.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/20 14:52, Vitaly Kuznetsov wrote:
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index fbabb2f06273..72f7ca4baa6d 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2675,7 +2675,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
>>  	trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
>>  		st->preempted & KVM_VCPU_FLUSH_TLB);
>>  	if (xchg(&st->preempted, 0) & KVM_VCPU_FLUSH_TLB)
>> -		kvm_vcpu_flush_tlb(vcpu, false);
>> +		kvm_x86_ops->tlb_flush_guest(vcpu);
>>  
>>  	vcpu->arch.st.preempted = 0;
> There is one additional place in hyperv.c where we do TLB flush on
> behalf of the guest, kvm_hv_flush_tlb(). Currently, it does
> KVM_REQ_TLB_FLUSH (resulting in kvm_x86_ops->tlb_flush()), do we need
> something like KVM_REQ_TLB_FLUSH_GUEST instead?

Yes, that would be better since INVEPT does not flush linear mappings.
So, when EPT and VPID is enabled, KVM_REQ_TLB_FLUSH would not flush the
guest's translations.

Paolo

