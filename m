Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7262BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480EE2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ie1+P5fS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgE2Irh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:47:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34447 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726844AbgE2Irg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590742054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TC044dR3OSla2e2jOr1hQDaPo8ct77ckTcoEOVeGup0=;
        b=ie1+P5fScC5kFBDGqNGyTq909pOiKB4voul+0/5YNRyx77kypS1LqEBc4Pu/l/HbPDJaBA
        fVyxMVZaOZeLkSJvX2ue2cPZCwhrBw1+BazLomGmwtVCewuZeiWOpFrYh20O9O0MAtANLl
        CcWbcnc4VipE04MlXFB8kf6S4rqL7yo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-K-XnuGcfMMiCCdA7f2zOfg-1; Fri, 29 May 2020 04:47:30 -0400
X-MC-Unique: K-XnuGcfMMiCCdA7f2zOfg-1
Received: by mail-wm1-f71.google.com with SMTP id q7so516544wmj.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TC044dR3OSla2e2jOr1hQDaPo8ct77ckTcoEOVeGup0=;
        b=mFDe6i5k5KGMEytVREmo+AXc+w0CYB1Pb8PgbJcopPrt/EkT0kV4/SPB2pcKmdxLRo
         Zi/p98RKjOZelV4OuuyS92qs5SVt39KDrDQqyeFG8SRc0uNLIsMCRqkxZWmbRM1sRWxS
         rIbL3JzfcpVwHhcd2fvhw7WD3Ihns0SOKYj7RUYJx+l1J6OeesjLxBBVzgEMZ3+SUlKd
         0vRlQTMutHmY3XKrwwX07av3f6T16L+UgjJOtK31s1eItgIn7Dy6wMXnnTMY91O+TFJl
         Hdjvhern2qBUpVprA9MT7je/GJn3EHx20SsD0ExX6UlkC/Kf77PbzCX+gwz01tu1jvKv
         JUHg==
X-Gm-Message-State: AOAM533IC47KD4H7TxePo6GaBexATWSmKpW33lRkmo5At7zV38GaP12Q
        t0A+hya8FhQSXpTjEjPHbfuuF+prhrGNBz0BQB54vsMHWVR6G8qI6I10y80sOp6bznrqx0F5ZZe
        MnhX7f8vkSLG5By4zlFWSFV4U
X-Received: by 2002:adf:a55e:: with SMTP id j30mr8410867wrb.60.1590742048999;
        Fri, 29 May 2020 01:47:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymqvTlBW+7kW1wAuWaPZwjkZSe8LlrehYX8zniYkylzs7yqPj5Jm1359wcy8rb0GyyAgXDrw==
X-Received: by 2002:adf:a55e:: with SMTP id j30mr8410839wrb.60.1590742048779;
        Fri, 29 May 2020 01:47:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7? ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
        by smtp.gmail.com with ESMTPSA id h137sm12589680wme.0.2020.05.29.01.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 01:47:28 -0700 (PDT)
Subject: Re: [PATCH RESEND] Enable full width counting for KVM: x86/pmu
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200529074347.124619-1-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ff77a5b-21fd-31f0-b97c-d188ec776808@redhat.com>
Date:   Fri, 29 May 2020 10:47:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200529074347.124619-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/20 09:43, Like Xu wrote:
> Hi Paolo,
> 
> As you said, you will queue the v3 of KVM patch, but it looks like we
> are missing that part at the top of the kvm/queue tree.
> 
> For your convenience, let me resend v4 so that we can upstream this
> feature in the next merged window. Also this patch series includes
> patches for qemu and kvm-unit-tests. Please help review.
> 
> Previous:
> https://lore.kernel.org/kvm/f1c77c79-7ff8-c5f3-e011-9874a4336217@redhat.com/
> 
> Like Xu (1):
>   KVM: x86/pmu: Support full width counting
>   [kvm-unit-tests] x86: pmu: Test full-width counter writes 
>   [Qemu-devel] target/i386: define a new MSR based feature
>  word - FEAT_PERF_CAPABILITIES
> 
> Wei Wang (1):
>   KVM: x86/pmu: Tweak kvm_pmu_get_msr to pass 'struct msr_data' in
> 
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/cpuid.c            |  2 +-
>  arch/x86/kvm/pmu.c              |  4 +-
>  arch/x86/kvm/pmu.h              |  4 +-
>  arch/x86/kvm/svm/pmu.c          |  7 ++--
>  arch/x86/kvm/vmx/capabilities.h | 11 +++++
>  arch/x86/kvm/vmx/pmu_intel.c    | 71 +++++++++++++++++++++++++++------
>  arch/x86/kvm/vmx/vmx.c          |  3 ++
>  arch/x86/kvm/x86.c              |  6 ++-
>  9 files changed, 87 insertions(+), 22 deletions(-)
> 

Thanks, I was busy with AMD stuff as you saw. :)  I've queued it now.

Paolo

