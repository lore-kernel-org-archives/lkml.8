Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA92C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6439A217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8hXKyjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgAWJpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:45:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27436 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgAWJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579772719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzX6+vB1Xsw4thPSPKllXzkIMMw9yMJ4EsBg/hWVsio=;
        b=X8hXKyjTGFLdB1iJnyxrPFusY5mrxMi4MITekeLD3qPVEHXx1k5zVJyN/rs12eZB1+0Up+
        m3JD20SOjXCQAx/mbHuUWXGK6QeRdu6KzFyBcycZPJMWHYMpNU/n0/8Gqg+Bn2j7VCitI+
        /M9h4voDSe/k9T/lYyeTiz8m79804HE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-1H301O7MOj25qqFp8h-iTg-1; Thu, 23 Jan 2020 04:45:16 -0500
X-MC-Unique: 1H301O7MOj25qqFp8h-iTg-1
Received: by mail-wr1-f71.google.com with SMTP id j4so1455161wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 01:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MzX6+vB1Xsw4thPSPKllXzkIMMw9yMJ4EsBg/hWVsio=;
        b=Ei+FZwipoVAl7V5pZblp9FYDUuh3Rs+yhZA7ZY5IubAloAUAYKVwJeMG0P2fDgn19G
         zMdCZLs3tC/cipDAVwIdqhkVeb/2iua8iSOUIN1bH0novaWcbx7Sr0wKqLbSSkQTJjtl
         XotM6IK7kCI556vEAs/Ly+2yiMhcfnS9TT3l0nbAVMeObOkGdVYmSdgASfvzrO5OiOP9
         Ti6uK4W0vDrmmOmKwVMNpgyXLdpijyAuphlC5YgQSbuqdsPIgAXwP7YYTcMTbdthP13d
         NAWXn+NWtbsXNhsesnM5KageAW58tlyYsUgyvaTH2dWX6b4pV1OvCmXc1FJfxXWrDYLK
         uVzA==
X-Gm-Message-State: APjAAAXNYTwkFGAQeUDQaHJv5roAEXABEIINikvnBx7HhcfQECY2OHYN
        pOTvmWvdCEuAKX9IrBrCI1xSnHiM6pIqqQoAc3yFr097V6aSeydx9kMOkpIXttEi2uMUfLJ2O5s
        hWl4nceK9YowmGa4BfwvPlq0E
X-Received: by 2002:a1c:4144:: with SMTP id o65mr3109661wma.81.1579772715480;
        Thu, 23 Jan 2020 01:45:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAIX93bsgTcrSBiFj30of2pgg0VpgNuw/XwpFAIlGghwGu9wEyJwZ0l8Ywl/vNLBijmNtpdQ==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr3109641wma.81.1579772715295;
        Thu, 23 Jan 2020 01:45:15 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o15sm2251300wra.83.2020.01.23.01.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 01:45:14 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: nVMX: set rflags to specify success in handle_invvpid() default case
In-Reply-To: <1a083ac8-3b01-fd2d-d867-2b3956cdef6d@redhat.com>
References: <1579749241-712-1-git-send-email-linmiaohe@huawei.com> <8736c6sga7.fsf@vitty.brq.redhat.com> <1a083ac8-3b01-fd2d-d867-2b3956cdef6d@redhat.com>
Date:   Thu, 23 Jan 2020 10:45:13 +0100
Message-ID: <87wo9iqzfa.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/01/20 09:55, Vitaly Kuznetsov wrote:
>>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>>> index 7608924ee8c1..985d3307ec56 100644
>>> --- a/arch/x86/kvm/vmx/nested.c
>>> +++ b/arch/x86/kvm/vmx/nested.c
>>> @@ -5165,7 +5165,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
>>>  		break;
>>>  	default:
>>>  		WARN_ON_ONCE(1);
>>> -		return kvm_skip_emulated_instruction(vcpu);
>>> +		break;
>>>  	}
>>>  
>>>  	return nested_vmx_succeed(vcpu);
>> Your patch seems to do the right thing, however, I started wondering if
>> WARN_ON_ONCE() is the right thing to do. SDM says that "If an
>> unsupported INVVPID type is specified, the instruction fails." and this
>> is similar to INVEPT and I decided to check what handle_invept()
>> does. Well, it does BUG_ON(). 
>> 
>> Are we doing the right thing in any of these cases?
>
> Yes, both INVEPT and INVVPID catch this earlier.
>
> For INVEPT:
>
>         types = (vmx->nested.msrs.ept_caps >> VMX_EPT_EXTENT_SHIFT) & 6;
>
>         if (type >= 32 || !(types & (1 << type)))
>                 return nested_vmx_failValid(vcpu,
>                                 VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
>
>
>
> For INVVPID:
>
>         types = (vmx->nested.msrs.vpid_caps &
>                         VMX_VPID_EXTENT_SUPPORTED_MASK) >> 8;
>
>         if (type >= 32 || !(types & (1 << type)))
>                 return nested_vmx_failValid(vcpu,
>                         VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
>

Ah, true, thanks for checking!

> So I'm leaning towards not applying Miaohe's patch.

Well, we may at least want to converge on BUG_ON() for both
handle_invvpid()/handle_invept(), there's no need for them to differ.

-- 
Vitaly

