Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E18C433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2779F206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMk6ildC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgGIJht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:37:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47735 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726514AbgGIJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594287465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZkZGfD7uhGw3aCbwlHuBrGlMvsJLTE0nJJY8zr08K0=;
        b=SMk6ildCunFJCiPiFFX3qziPINhGsl97vDnSB1Tja2Y3YRl3NgMunGta8b1unLB9VWPXY2
        tzQKpQM51Ob0l5Q9KogS59xHhoxtZpggHz1S3QJvyeBcioUFmclXfBbapgjN8jcrlSgXIt
        oT/VOmKAH5o+MYzavNjM9+BmVlxChOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-g5-bnk4lPtWkgb_f0xc5dw-1; Thu, 09 Jul 2020 05:37:43 -0400
X-MC-Unique: g5-bnk4lPtWkgb_f0xc5dw-1
Received: by mail-wr1-f72.google.com with SMTP id j3so1549095wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 02:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vZkZGfD7uhGw3aCbwlHuBrGlMvsJLTE0nJJY8zr08K0=;
        b=rASlQlL8LyCmbf0uaUX6mWi2YzGf5Kay0vcV8JfxV/ko6mwQ2H0Xlao5uxeFf5j5S6
         E9JtJSZ7nJqHK8G9/CoCeFVU+I+l9KwjFvbN8U7S97G1FwVth8tbdr79t6S+kJvLyBXG
         ZBNsbo7vkOF20A3zw7o1HlpWLVny5bFapkQtpMCvJ/rj8SDYX16WnBTIOj6gPADKmPpc
         Fi3EuQ6E11ZIPNwmkpoRIV5YX/i9rcNqMDCugXvC5LDHKEVmvjJ4li+dJFExDq5wHxfj
         VoXVyxhn2kkyDpFsgpKVahcskB3/lNRFgsrgA6CogBJ5IySjQ75MYJ0aMVJiUMEDrGIs
         D9Zw==
X-Gm-Message-State: AOAM533DMGnM8B5kTOIoJb6b1mBj+JbubHaASLSd0WgzgMXTdjgPvZzH
        fOFWqIaq8iP+FTCYeHuUsszU8Ll9X0xJyjG0hdN5RvhpVHH7PBXuc8QpZqQ+bxbGF1JLuZUi/Y2
        vivgHU6UwostGhwhEw4EQtCbM
X-Received: by 2002:adf:fd8e:: with SMTP id d14mr62388107wrr.202.1594287462649;
        Thu, 09 Jul 2020 02:37:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsB7+szqf5rMRlotUrNNWYyOY5QqqyygFQfXJIgIgWNl9g8ybRGwWmy9MiscFM9mSBYt3iVg==
X-Received: by 2002:adf:fd8e:: with SMTP id d14mr62388080wrr.202.1594287462420;
        Thu, 09 Jul 2020 02:37:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id a4sm5012609wrg.80.2020.07.09.02.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 02:37:41 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] Refactor handling flow of KVM_SET_CPUID*
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200708065054.19713-1-xiaoyao.li@intel.com>
 <55ce27bc-7ff7-3552-0e2d-ce69c66fd68e@redhat.com>
 <e6432b0d-c509-28e0-7720-a4a0e22ea4d9@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5c0b6dc-518a-8963-0c0e-ad55189bd356@redhat.com>
Date:   Thu, 9 Jul 2020 11:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e6432b0d-c509-28e0-7720-a4a0e22ea4d9@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 06:27, Xiaoyao Li wrote:
> On 7/8/2020 8:10 PM, Paolo Bonzini wrote:
>> On 08/07/20 08:50, Xiaoyao Li wrote:
>>> This serial is the extended version of
>>> https://lkml.kernel.org/r/20200528151927.14346-1-xiaoyao.li@intel.com
>>>
>>> First two patches are bug fixing, and the others aim to refactor the
>>> flow
>>> of SET_CPUID* as:
>>>
>>> 1. cpuid check: check if userspace provides legal CPUID settings;
>>>
>>> 2. cpuid update: Update some special CPUID bits based on current vcpu
>>>                   state, e.g., OSXSAVE, OSPKE, ...
>>>
>>> 3. update vcpu model: Update vcpu model (settings) based on the final
>>> CPUID
>>>                        settings.
>>>
>>> v3:
>>>   - Add a note in KVM api doc to state the previous CPUID configuration
>>>     is not reliable if current KVM_SET_CPUID* fails [Jim]
>>>   - Adjust Patch 2 to reduce code churn [Sean]
>>>   - Commit message refine to add more justification [Sean]
>>>   - Add a new patch (7)
>>>
>>> v2:
>>> https://lkml.kernel.org/r/20200623115816.24132-1-xiaoyao.li@intel.com
>>>   - rebase to kvm/queue: a037ff353ba6 ("Merge branch 'kvm-master'
>>> into HEAD")
>>>   - change the name of kvm_update_state_based_on_cpuid() to
>>>     kvm_update_vcpu_model() [Sean]
>>>   - Add patch 5 to rename kvm_x86_ops.cpuid_date() to
>>>     kvm_x86_ops.update_vcpu_model()
>>>
>>> v1:
>>> https://lkml.kernel.org/r/20200529085545.29242-1-xiaoyao.li@intel.com
>>>
>>> Xiaoyao Li (8):
>>>    KVM: X86: Reset vcpu->arch.cpuid_nent to 0 if SET_CPUID* fails
>>>    KVM: X86: Go on updating other CPUID leaves when leaf 1 is absent
>>>    KVM: X86: Introduce kvm_check_cpuid()
>>>    KVM: X86: Split kvm_update_cpuid()
>>>    KVM: X86: Rename cpuid_update() to update_vcpu_model()
>>>    KVM: X86: Move kvm_x86_ops.update_vcpu_model() into
>>>      kvm_update_vcpu_model()
>>>    KVM: lapic: Use guest_cpuid_has() in kvm_apic_set_version()
>>>    KVM: X86: Move kvm_apic_set_version() to kvm_update_vcpu_model()
>>>
>>>   Documentation/virt/kvm/api.rst  |   4 ++
>>>   arch/x86/include/asm/kvm_host.h |   2 +-
>>>   arch/x86/kvm/cpuid.c            | 107 ++++++++++++++++++++------------
>>>   arch/x86/kvm/cpuid.h            |   3 +-
>>>   arch/x86/kvm/lapic.c            |   4 +-
>>>   arch/x86/kvm/svm/svm.c          |   4 +-
>>>   arch/x86/kvm/vmx/nested.c       |   2 +-
>>>   arch/x86/kvm/vmx/vmx.c          |   4 +-
>>>   arch/x86/kvm/x86.c              |   1 +
>>>   9 files changed, 81 insertions(+), 50 deletions(-)
>>>
>>
>> Queued patches 1/2/3/7/8, thanks.
> 
> Paolo,
> 
> I notice that you queued patch 8 into kvm/queue branch as
> commit 84dd4897524e "KVM: X86: Move kvm_apic_set_version() to
> kvm_update_vcpu_model()"
> 
> Can you change the subject of that commit to "KVM: X86: Move
> kvm_apic_set_version() to kvm_update_cpuid()" ?

Good catch, thanks.

Paolo

