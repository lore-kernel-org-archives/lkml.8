Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B75C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF9A2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTMUJL1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGJRtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:49:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45485 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726925AbgGJRtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594403360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8skaqGTk5JWFYcMCx79b8PjRTPc7uwqsKaqnXb086c=;
        b=UTMUJL1APFAg5cKhgKewKJCYQHGt5FC16M5wExBYFC6lO7wqPpWJbyrez0mQ6sJiI5QfJ4
        R06nvYsNlTUIUS6WQ9PlHMQZQY/unfb0Rq7pB2lELfH/nO9v1lckopCDVoBLRM41Oh2f+n
        IqudGM1Po8ScfZnuGhH/MgjJY4IXJB0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-v8tARVyLNIKUXoVSR8Y9zA-1; Fri, 10 Jul 2020 13:49:16 -0400
X-MC-Unique: v8tARVyLNIKUXoVSR8Y9zA-1
Received: by mail-wm1-f72.google.com with SMTP id e15so7512808wme.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i8skaqGTk5JWFYcMCx79b8PjRTPc7uwqsKaqnXb086c=;
        b=ieJ+xWgCPsjoXYAFDH9oH6LzqVjSvqd7cz1zR2NSeDnshRGky4VLcT7b8X18LL3VBB
         dnGjVIWetRBiWAWcZpTL47aGjwTyI8nFb2IPn78oqyMf3PEwYnmbYz36wa17lpPPgY68
         qgpmy9Ef5ReKyBjSlgApLSmUKZmqD9W6b0wfYWz6IoSYMueHuuoo8GNfDJ2oWnMXi77P
         6qLrdMnh+dhYp5set9yRPgOVgAql60sqngkCRcqJh3wY/fKAa8NRIpHNRg6De8G8+wQ4
         YAjO4eMIo1DzrO3Ip3+0FbSvZJ4ywHXdoEyTSEfMnvIVR7QB4o5H94fKRSAh0CCU8v1o
         H9fg==
X-Gm-Message-State: AOAM532WqPpnvjgOn5AccS+TeeqioeIfo1X9LXgJqVcaYPbPIrVF805s
        4qckqoZjDyk2G9H2//pw7VvzT6DMnXhSbYKFO/kpX5oeF/2XuUTU5jjkLGvsKiC06ItZf7tgZ2y
        /3ua8ECedwK03g9f0yIehBuVU
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr65955338wrr.23.1594403355207;
        Fri, 10 Jul 2020 10:49:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1k4Z/HC2xOW2byTdcoqA3nGl0QmInMyVJgEqZHNe9e4FF2iQC9BpfLasqatd32CNLr07h7A==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr65955322wrr.23.1594403354989;
        Fri, 10 Jul 2020 10:49:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id b184sm11082300wmc.20.2020.07.10.10.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:49:14 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Mohammed Gamal <mgamal@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org
References: <20200710154811.418214-1-mgamal@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <69f44e48-4609-ff64-56a9-ce72e1f483fa@redhat.com>
Date:   Fri, 10 Jul 2020 19:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710154811.418214-1-mgamal@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 17:48, Mohammed Gamal wrote:
> When EPT is enabled, KVM does not really look at guest physical
> address size. Address bits above maximum physical memory size are reserved.
> Because KVM does not look at these guest physical addresses, it currently
> effectively supports guest physical address sizes equal to the host.
> 
> This can be problem when having a mixed setup of machines with 5-level page
> tables and machines with 4-level page tables, as live migration can change
> MAXPHYADDR while the guest runs, which can theoretically introduce bugs.
> 
> In this patch series we add checks on guest physical addresses in EPT
> violation/misconfig and NPF vmexits and if needed inject the proper
> page faults in the guest.
> 
> A more subtle issue is when the host MAXPHYADDR is larger than that of the
> guest. Page faults caused by reserved bits on the guest won't cause an EPT
> violation/NPF and hence we also check guest MAXPHYADDR and add PFERR_RSVD_MASK
> error code to the page fault if needed.
> 
> ----
> 
> Changes from v2:
> - Drop support for this feature on AMD processors after discussion with AMD
> 
> 
> Mohammed Gamal (5):
>   KVM: x86: Add helper functions for illegal GPA checking and page fault
>     injection
>   KVM: x86: mmu: Move translate_gpa() to mmu.c
>   KVM: x86: mmu: Add guest physical address check in translate_gpa()
>   KVM: VMX: Add guest physical address check in EPT violation and
>     misconfig
>   KVM: x86: SVM: VMX: Make GUEST_MAXPHYADDR < HOST_MAXPHYADDR support
>     configurable
> 
> Paolo Bonzini (4):
>   KVM: x86: rename update_bp_intercept to update_exception_bitmap
>   KVM: x86: update exception bitmap on CPUID changes
>   KVM: VMX: introduce vmx_need_pf_intercept
>   KVM: VMX: optimize #PF injection when MAXPHYADDR does not match
> 
>  arch/x86/include/asm/kvm_host.h | 10 ++------
>  arch/x86/kvm/cpuid.c            |  2 ++
>  arch/x86/kvm/mmu.h              |  6 +++++
>  arch/x86/kvm/mmu/mmu.c          | 12 +++++++++
>  arch/x86/kvm/svm/svm.c          | 22 +++++++++++++---
>  arch/x86/kvm/vmx/nested.c       | 28 ++++++++++++--------
>  arch/x86/kvm/vmx/vmx.c          | 45 +++++++++++++++++++++++++++++----
>  arch/x86/kvm/vmx/vmx.h          |  6 +++++
>  arch/x86/kvm/x86.c              | 29 ++++++++++++++++++++-
>  arch/x86/kvm/x86.h              |  1 +
>  include/uapi/linux/kvm.h        |  1 +
>  11 files changed, 133 insertions(+), 29 deletions(-)
> 

Queued, thanks (I'll look at it more closely when I'm back, but at least
people can play with it).

Paolo

