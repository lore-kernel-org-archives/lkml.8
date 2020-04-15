Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17269C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8445206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx2FDyTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408291AbgDOJIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:08:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22374 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2408269AbgDOJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586941679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lisOMIPYzGEOUKW/w9q538cTmyUuHd07/Sojgyr8MlQ=;
        b=Jx2FDyTWiVDSj+TGOWOlb6Tpt+VTUEEy0yd9fpRMKl7rQKOY871ngDkQGOjhAC8N+d7SY0
        Bs4Q8EQdCr8SzcYu4yqzOh5h22g90k72oCAFQQ0KvtupPEZo/SY0pBdzJTkbeMQmNX+mlb
        qi4WIYZbc8j89wpMCMzWuylFT++B45o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-rIEPXwd8Nc-T0FjIs46uOw-1; Wed, 15 Apr 2020 05:07:57 -0400
X-MC-Unique: rIEPXwd8Nc-T0FjIs46uOw-1
Received: by mail-wm1-f70.google.com with SMTP id h184so1896162wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lisOMIPYzGEOUKW/w9q538cTmyUuHd07/Sojgyr8MlQ=;
        b=ANaGpkGukQskXo2Dfqa6PT+49hcz5Qe526yTFpDEFNGgbN3WAGHN7COFSDYj/BBOsf
         hK2jDpm2HJJG4eGSM2wrScYAhONti6y1RjR3HlmfqpkyUQMgMcLcRSXTb9Yo5iRFhNVq
         jc9d8S8Qcs5LJrSp8lud9tfrlFQAOElD9T6WCMcMJYiuIn4syIKtooXfeOHPpnFJSHxy
         /kj8aPS/lKI2ZkzCyvmzFpoySnynHmCXbkOUpdZxL3mxr3H6yi0kdHVZocfE8ilCSs3j
         uxn0COZKJOmqx1uqa9oECIhMubBRjWAr7gKBIWiED98pbSG9elJAeiCrxF364BGNnZvp
         N52Q==
X-Gm-Message-State: AGi0PuaNdih1fPVJKRJ7+gOxfljp9POyddKY+g+WIdVlQO6PyOQhqgr9
        NWdM1VobpQq45v0/HVbJBbnhx2K9GKlZkRCtib3dqrKQGO+T6x1UVEnWW2kb7GkCLIG5e4a4EL0
        jlVNPDOay/bk9CZ1WXhfEQfzM
X-Received: by 2002:a5d:6841:: with SMTP id o1mr27977386wrw.412.1586941676332;
        Wed, 15 Apr 2020 02:07:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypIXD/p9LNlXg20pn+U/yQCcvvORh177d5YZbgu7SsoqIprQYNJ2FhjSis/HsfEJeQMW+4tCHg==
X-Received: by 2002:a5d:6841:: with SMTP id o1mr27977353wrw.412.1586941676047;
        Wed, 15 Apr 2020 02:07:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e5sm23214697wru.92.2020.04.15.02.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:07:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
Subject: Re: [PATCH] KVM: Optimize kvm_arch_vcpu_ioctl_run function
In-Reply-To: <cc29ce22-4c70-87d1-d7aa-9d38438ba8a5@linux.alibaba.com>
References: <20200413034523.110548-1-tianjia.zhang@linux.alibaba.com> <875ze2ywhy.fsf@vitty.brq.redhat.com> <cc29ce22-4c70-87d1-d7aa-9d38438ba8a5@linux.alibaba.com>
Date:   Wed, 15 Apr 2020 11:07:53 +0200
Message-ID: <87a73dxgk6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianjia Zhang <tianjia.zhang@linux.alibaba.com> writes:

> On 2020/4/14 22:26, Vitaly Kuznetsov wrote:
>> Tianjia Zhang <tianjia.zhang@linux.alibaba.com> writes:
>> 
>>> kvm_arch_vcpu_ioctl_run() is only called in the file kvm_main.c,
>>> where vcpu->run is the kvm_run parameter, so it has been replaced.
>>>
>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>> ---
>>>   arch/x86/kvm/x86.c | 8 ++++----
>>>   virt/kvm/arm/arm.c | 2 +-
>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 3bf2ecafd027..70e3f4abbd4d 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -8726,18 +8726,18 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>>   		r = -EAGAIN;
>>>   		if (signal_pending(current)) {
>>>   			r = -EINTR;
>>> -			vcpu->run->exit_reason = KVM_EXIT_INTR;
>>> +			kvm_run->exit_reason = KVM_EXIT_INTR;
>> 
>> I have a more generic question: why do we need to pass 'kvm_run' to
>> kvm_arch_vcpu_ioctl_run() if it can be extracted from 'struct kvm_vcpu'?
>> The only call site looks like
>> 
>> virt/kvm/kvm_main.c:            r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
>> 
>
> In the earlier version, kvm_run is used to pass parameters with user 
> mode and is not included in the vcpu structure, so it has been retained 
> until now.
>

In case this is no longer needed I'd suggest we drop 'kvm_run' parameter
and extract it from 'struct kvm_vcpu' when needed. This looks like a
natural add-on to your cleanup patch.

-- 
Vitaly

