Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAE9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4EC82063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2dPs3jE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgGHMKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:10:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57490 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728896AbgGHMKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594210229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gdi2UbJBJuu6JYx/nUObEDZIDgGFSVB4CBfepRfkmlo=;
        b=F2dPs3jE5vh/aNDK0nIR6MKbbYNJYTttqA2tGOxp/FcCZpw0rUTCyLjrHnHyNZsXd0vEoM
        sLBo6HzBKexjZ9sWh/SJ9z3mokTj8o4vQ7CK3pSnDnOvdgtS4FvdkdbDUwdiEAwTNdHT/A
        cWK6MBeX/FKR0v5J36fkM+YQwKsJM5I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-JnxNWSrPPsOV5rpDTi8EWQ-1; Wed, 08 Jul 2020 08:10:25 -0400
X-MC-Unique: JnxNWSrPPsOV5rpDTi8EWQ-1
Received: by mail-wr1-f70.google.com with SMTP id c6so32622148wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gdi2UbJBJuu6JYx/nUObEDZIDgGFSVB4CBfepRfkmlo=;
        b=R8U6vWlqtTPywkSL8ocMEwx/YuqyFurA9kUzEUmr65O2QVOgZJrwIRnjvX3kMvwfbB
         mMzuFT91oxyb8YezmvUJsFEb6rSFbGGM8yNJz/AiCIJB/Ql2TWHBkKEsIe8Yyfgr5sIb
         d0LY7uiP6mNuuoC6c4W78MDMifPCKGWq1M7scrz3oEXlj4sHYlFkRjVwGU9kpmHi80hx
         L/H2qdpYl6Ey6toSKfv/+t43zDrOpuYXL5PY8biwSz208qWU6boIggcBkvXsHEtu1V99
         C+5wYlPqQruS/ZTnZtomQvOo6/5xe+twkkrEC8ntXUL2Cbj19Q8AsYW+GUJJL1Tli6+c
         IaUQ==
X-Gm-Message-State: AOAM532b7LlW8vnLz+aSY3XWLcZsZ934vOmbXpsIAtCzbFwr7BO6hPxj
        /drLbYjAfWLOjRNRtV4vw1VzMCxU04rToQ+QgK8Om50oa4aWFKwc2uQdpSEWoNjcRWAkxxgnRKp
        xHRPO8oDPjzrr38C5EoryHbpY
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr59902305wrt.5.1594210224383;
        Wed, 08 Jul 2020 05:10:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycDGuCTbVScWdZ8BMWhOLTWcYfXhmWtqLlk6irp7YWRr/BpzK+7dnLvhE3faLT0FGeK7f2QQ==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr59902286wrt.5.1594210224146;
        Wed, 08 Jul 2020 05:10:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id s8sm5290162wru.38.2020.07.08.05.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 05:10:23 -0700 (PDT)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55ce27bc-7ff7-3552-0e2d-ce69c66fd68e@redhat.com>
Date:   Wed, 8 Jul 2020 14:10:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708065054.19713-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 08:50, Xiaoyao Li wrote:
> This serial is the extended version of
> https://lkml.kernel.org/r/20200528151927.14346-1-xiaoyao.li@intel.com
> 
> First two patches are bug fixing, and the others aim to refactor the flow
> of SET_CPUID* as:
> 
> 1. cpuid check: check if userspace provides legal CPUID settings;
> 
> 2. cpuid update: Update some special CPUID bits based on current vcpu
>                  state, e.g., OSXSAVE, OSPKE, ...
> 
> 3. update vcpu model: Update vcpu model (settings) based on the final CPUID
>                       settings. 
> 
> v3:
>  - Add a note in KVM api doc to state the previous CPUID configuration
>    is not reliable if current KVM_SET_CPUID* fails [Jim]
>  - Adjust Patch 2 to reduce code churn [Sean]
>  - Commit message refine to add more justification [Sean]
>  - Add a new patch (7)
> 
> v2:
> https://lkml.kernel.org/r/20200623115816.24132-1-xiaoyao.li@intel.com
>  - rebase to kvm/queue: a037ff353ba6 ("Merge branch 'kvm-master' into HEAD")
>  - change the name of kvm_update_state_based_on_cpuid() to
>    kvm_update_vcpu_model() [Sean]
>  - Add patch 5 to rename kvm_x86_ops.cpuid_date() to
>    kvm_x86_ops.update_vcpu_model()
> 
> v1:
> https://lkml.kernel.org/r/20200529085545.29242-1-xiaoyao.li@intel.com
> 
> Xiaoyao Li (8):
>   KVM: X86: Reset vcpu->arch.cpuid_nent to 0 if SET_CPUID* fails
>   KVM: X86: Go on updating other CPUID leaves when leaf 1 is absent
>   KVM: X86: Introduce kvm_check_cpuid()
>   KVM: X86: Split kvm_update_cpuid()
>   KVM: X86: Rename cpuid_update() to update_vcpu_model()
>   KVM: X86: Move kvm_x86_ops.update_vcpu_model() into
>     kvm_update_vcpu_model()
>   KVM: lapic: Use guest_cpuid_has() in kvm_apic_set_version()
>   KVM: X86: Move kvm_apic_set_version() to kvm_update_vcpu_model()
> 
>  Documentation/virt/kvm/api.rst  |   4 ++
>  arch/x86/include/asm/kvm_host.h |   2 +-
>  arch/x86/kvm/cpuid.c            | 107 ++++++++++++++++++++------------
>  arch/x86/kvm/cpuid.h            |   3 +-
>  arch/x86/kvm/lapic.c            |   4 +-
>  arch/x86/kvm/svm/svm.c          |   4 +-
>  arch/x86/kvm/vmx/nested.c       |   2 +-
>  arch/x86/kvm/vmx/vmx.c          |   4 +-
>  arch/x86/kvm/x86.c              |   1 +
>  9 files changed, 81 insertions(+), 50 deletions(-)
> 

Queued patches 1/2/3/7/8, thanks.

Paolo

