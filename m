Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E476C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A8524683
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kbp3FpN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAWJXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:23:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29873 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726099AbgAWJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579771428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLPtPbflHkEcsflpAEJimzZzCHBwCpiVv1nVRjVe5L0=;
        b=Kbp3FpN7U58z1O2pSqa/LJoZJnO/3NKycnitdK9q+fYH/ryLsL0VWsRdTHmWf3H6BXdQiJ
        Cjne5GNGAwd8qe+sfU0/IyLKpeO10NBuddhC+bk4rCH9XIwwELeZSSth9e8OzS0b8daBsV
        2TFwMun3RIRy8HQO5cuDomtpNnRftig=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-WzpPDFIlNXSaDcbMF0xGag-1; Thu, 23 Jan 2020 04:23:46 -0500
X-MC-Unique: WzpPDFIlNXSaDcbMF0xGag-1
Received: by mail-wm1-f69.google.com with SMTP id t17so348821wmi.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 01:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xLPtPbflHkEcsflpAEJimzZzCHBwCpiVv1nVRjVe5L0=;
        b=Z3sT/KDwXP3USSzfWtcUba2q2nn7Z+6z4c86z7Y4+k9R/+MIUS/8k3g5h/vJvYJezU
         fPco4oEUH5vwyV4a0gt+d/NKC+ExIwhkVjqQnwwEjCJaZUn02xRXZDNCeeoQzvCQ3aa6
         9alr/DBSVvrw2zbBeTfuQhtVB8FjpcYaB1sWnGarbZMLwBIebqO1sfqD39PkX6P3ReEH
         0tsf2FFf/xJ0pDz7N9cQYQ5tiyU3bYbCfhizvUwXCHELPeatwxbuSJzhE5jvogUdkDA4
         nDgJr+jZSm/JE2pvpKvRVzp36At0zT9MXmrw2LG9QqsPFR8JM3ifqUijFC/ZG8tudXjN
         4fQg==
X-Gm-Message-State: APjAAAVI9S+z4CfTEmGOWJWvKTxKRG02empANUDiiwuN/SdE1cZUCv25
        5yXeQMVa9ydg6ki7jx7G7yEjIUqNrjpnAEb00IRjJjZ6IX8sc78MuMg0DNMPU/PHVf7NaXbTZiy
        FaTlMLOrAobcqWTStNdjzmep8
X-Received: by 2002:adf:e591:: with SMTP id l17mr16599143wrm.139.1579771424890;
        Thu, 23 Jan 2020 01:23:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzELIoIdvuyZLL2GrfNb1F5kfvJAuwopX6+bWrOHnJuStIZz7wtxB1xm4a+UrGei4ixbrQBPw==
X-Received: by 2002:adf:e591:: with SMTP id l17mr16599120wrm.139.1579771424641;
        Thu, 23 Jan 2020 01:23:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id 16sm1874485wmi.0.2020.01.23.01.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 01:23:44 -0800 (PST)
Subject: Re: [PATCH] KVM: nVMX: set rflags to specify success in
 handle_invvpid() default case
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
References: <1579749241-712-1-git-send-email-linmiaohe@huawei.com>
 <8736c6sga7.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a083ac8-3b01-fd2d-d867-2b3956cdef6d@redhat.com>
Date:   Thu, 23 Jan 2020 10:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8736c6sga7.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/20 09:55, Vitaly Kuznetsov wrote:
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index 7608924ee8c1..985d3307ec56 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -5165,7 +5165,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
>>  		break;
>>  	default:
>>  		WARN_ON_ONCE(1);
>> -		return kvm_skip_emulated_instruction(vcpu);
>> +		break;
>>  	}
>>  
>>  	return nested_vmx_succeed(vcpu);
> Your patch seems to do the right thing, however, I started wondering if
> WARN_ON_ONCE() is the right thing to do. SDM says that "If an
> unsupported INVVPID type is specified, the instruction fails." and this
> is similar to INVEPT and I decided to check what handle_invept()
> does. Well, it does BUG_ON(). 
> 
> Are we doing the right thing in any of these cases?

Yes, both INVEPT and INVVPID catch this earlier.

For INVEPT:

        types = (vmx->nested.msrs.ept_caps >> VMX_EPT_EXTENT_SHIFT) & 6;

        if (type >= 32 || !(types & (1 << type)))
                return nested_vmx_failValid(vcpu,
                                VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);



For INVVPID:

        types = (vmx->nested.msrs.vpid_caps &
                        VMX_VPID_EXTENT_SUPPORTED_MASK) >> 8;

        if (type >= 32 || !(types & (1 << type)))
                return nested_vmx_failValid(vcpu,
                        VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);

So I'm leaning towards not applying Miaohe's patch.  Happy Mouse Year
to everyone, here is an ASCII art (except for one Unicode character) mouse:


       __()()
      /     o)
  ~~~~\_,__,_>°

Thanks,

