Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FB9C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC2F2468D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJvgm/l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgARVjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:39:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23832 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726960AbgARVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579383541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LpBEUuDwvWW3/yC4b/2BYg92lPDd6HIiI6tDhikopY8=;
        b=gJvgm/l2WQQ7/ndzAOSwOoLHeN/RN1n7i/2enHHUSIa37uCbXjs19TUkB3Gu1WYG5kicvc
        bv+8/yqZHINPOxAQtQTNXbZCvIxhIBTBvsum+opl/cQS+fPbEawM5tiLLLkvnczYuFQFNH
        7vuvdyeN4qmyzsXtMoX07yr0i5sVOwM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-ZIC0HYOlOnmpY5gG9oRq2A-1; Sat, 18 Jan 2020 16:39:00 -0500
X-MC-Unique: ZIC0HYOlOnmpY5gG9oRq2A-1
Received: by mail-wr1-f71.google.com with SMTP id y7so12184704wrm.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 13:39:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LpBEUuDwvWW3/yC4b/2BYg92lPDd6HIiI6tDhikopY8=;
        b=sWXjWGzmVoczS/sc6feFpbnHYe0EGzxWNY6cAENTBQlPTzDWTbLcv7LWgsnsOgJPfh
         ujDHua7TdV+PWDPJLC6vqOxmj8n4ma4kThHOzi+PIKmJkEr9G/v01wizdP+//jnjXBtO
         ieUcSd8io/pS91LF7ZwJuwrJt6I4te3fCcIMbPG0mHwiOn9BPQGLPIigTvcOTvdswUkE
         uQ/05jsT6Tl1QXI+FWCIBe2BMwmBa30SyaghKPqSxe5XnHRWBVJthIE+5QgmcEpejiTf
         oS5NomuZE4jjUVTovrChnOIJpT/4N7TOiXhA2VISIvkw3wEzNwJScGHvX5qLvX1OGWrG
         Gxbg==
X-Gm-Message-State: APjAAAXcwbFvpjaJfKcNNJYASs1fN/ZlCI8CXHbT6rnHC0Bj+9eMjW8B
        M+kal0EdyVHdl8kZdRf79iJFZKTkaFRCLGAhKyoNLEYVEuEQP42xQBJ5x0ZmxwoJaIh4R3ZIZq+
        NodydpkcxA6DADyYVfpZ/cNVe
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr11312265wme.148.1579383539128;
        Sat, 18 Jan 2020 13:38:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1wOzcIlp0MwOfex7nuYP8ORd5FMC/dhKir9fpXdSSBz/nJbqOxTtUELUes+VzgjVRx9V5Qw==
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr11312254wme.148.1579383538917;
        Sat, 18 Jan 2020 13:38:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9? ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
        by smtp.gmail.com with ESMTPSA id w17sm40345413wrt.89.2020.01.18.13.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 13:38:58 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Perform non-canonical checks in 32-bit KVM
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200115183605.15413-1-sean.j.christopherson@intel.com>
 <cf9a9746-e0b8-8303-afd5-b1c3a2a9ac83@oracle.com>
 <20200116155057.GB20561@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c88c77f4-83c8-2d6d-6c78-c004f7917efd@redhat.com>
Date:   Sat, 18 Jan 2020 22:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200116155057.GB20561@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/20 16:50, Sean Christopherson wrote:
> On Wed, Jan 15, 2020 at 05:37:16PM -0800, Krish Sadhukhan wrote:
>>
>> On 01/15/2020 10:36 AM, Sean Christopherson wrote:
>>>  arch/x86/kvm/x86.h | 8 --------
>>>  1 file changed, 8 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
>>> index cab5e71f0f0f..3ff590ec0238 100644
>>> --- a/arch/x86/kvm/x86.h
>>> +++ b/arch/x86/kvm/x86.h
>>> @@ -166,21 +166,13 @@ static inline u64 get_canonical(u64 la, u8 vaddr_bits)
>>>  static inline bool is_noncanonical_address(u64 la, struct kvm_vcpu *vcpu)
>>>  {
>>> -#ifdef CONFIG_X86_64
>>>  	return get_canonical(la, vcpu_virt_addr_bits(vcpu)) != la;
>>> -#else
>>> -	return false;
>>> -#endif
>>>  }
>>>  static inline bool emul_is_noncanonical_address(u64 la,
>>>  						struct x86_emulate_ctxt *ctxt)
>>>  {
>>> -#ifdef CONFIG_X86_64
>>>  	return get_canonical(la, ctxt_virt_addr_bits(ctxt)) != la;
>>> -#else
>>> -	return false;
>>> -#endif
>>>  }
>>>  static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
>>
>> nested_vmx_check_host_state() still won't call it on 32-bit because it has
>> the CONFIG_X86_64 guard around the callee:
>>
>>  #ifdef CONFIG_X86_64
>>         if (CC(is_noncanonical_address(vmcs12->host_fs_base, vcpu)) ||
>>             CC(is_noncanonical_address(vmcs12->host_gs_base, vcpu)) ||
>>  ...
> 
> Doh, I was looking at an older version of nested.c.  Nice catch!
> 
>> Don't we need to remove these guards in the callers as well ?
> 
> Ya, that would be my preference.
> 

Fixed and queued, thanks.

Paolo

