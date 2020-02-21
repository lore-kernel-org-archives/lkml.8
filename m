Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6342AC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E1A24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIpZPdVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgBUNUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:20:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21172 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728086AbgBUNUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582291247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V45FPE8E/uSpIv1R1RMAVvbVJqCO9c9QhM88Z/L7IQI=;
        b=KIpZPdVDzq24mU96yfjTo9tDyfyQtHZ1MKWslRUY/IFkzs+g579CK/jK3S/8ieXwvlqWjC
        GX8mM2Ly5rslWweW2Sf+m9DE6PHNyDkOsk+ZucS1hyxTi+8Ir59oHObX154Mw1D5k5YGBG
        M2UxrIauZ48/M8/0xLdOesrRPlooyXo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-o9VmbEVUNvKM4rDz8O3h_g-1; Fri, 21 Feb 2020 08:20:45 -0500
X-MC-Unique: o9VmbEVUNvKM4rDz8O3h_g-1
Received: by mail-wm1-f71.google.com with SMTP id y7so564697wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V45FPE8E/uSpIv1R1RMAVvbVJqCO9c9QhM88Z/L7IQI=;
        b=jDHsZF/S4bTztt+qEPJcbVPECT07RmIuCaHSbyUh1A+Pc3hYA2CKxbALGi4QJIV8QD
         Q7H3ePGXDtxFbF4pCDreF5EMP21DqHuZQghRz676d3vK9MU7H+4hroqhyNfxKhXaWoj4
         KiPLGXBwbfm0PWK+rSfgy4Y7PPcBlnJxWMfxsgUpXvb8R7BMHVawtT543lDJ4LWKTmUj
         ZpnZBdEkKkcFw29jX9Wzm4ta/tAHc9+ctrW0auV89977MELg8mWp8Kii1OK0Hix1Stqm
         53V1iTCTBU56b9vxNnVMMgN7iCdblm6REQZ1qbLj3zhyr62B2gFegO8ocLpW3mEvXm6w
         RGjA==
X-Gm-Message-State: APjAAAUWQ15L7Z4QRbNOaMH8Q7FhgXdJBRDZf1zKQ+UadxTTymXGft6z
        n+y6+O7s7jbT51KtKN/LTE6CZ+BzwKKNoj3JO7w8wDKiWEhg1bN55eY5M2dQWwvno01i0/1d6WX
        l8WrKqYsvbv+8Vgi9e+sjEHcl
X-Received: by 2002:a05:6000:1208:: with SMTP id e8mr51009108wrx.351.1582291244365;
        Fri, 21 Feb 2020 05:20:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXgzt5blvA3I2e+h/HOQivRsOOnvHTyqfqBCG2YxfjYwz0b8N/EbQuo8Mp5i1XvX2dQVzGhg==
X-Received: by 2002:a05:6000:1208:: with SMTP id e8mr51009081wrx.351.1582291244058;
        Fri, 21 Feb 2020 05:20:44 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id m9sm3971187wrx.55.2020.02.21.05.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 05:20:43 -0800 (PST)
Subject: Re: [PATCH 00/10] KVM: x86: Clean up VMX's TLB flushing code
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200220204356.8837-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <efb07c80-58ab-c3ce-1fed-832475190add@redhat.com>
Date:   Fri, 21 Feb 2020 14:20:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200220204356.8837-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/20 21:43, Sean Christopherson wrote:
> This series is technically x86 wide, but it only superficially affects
> SVM, the motivation and primary touchpoints are all about VMX.
> 
> The goal of this series to ultimately clean up __vmx_flush_tlb(), which,
> for me, manages to be extremely confusing despite being only ten lines of
> code.
> 
> The most confusing aspect of __vmx_flush_tlb() is that it is overloaded
> for multiple uses:
> 
>  1) TLB flushes in response to a change in KVM's MMU
> 
>  2) TLB flushes during nested VM-Enter/VM-Exit when VPID is enabled
> 
>  3) Guest-scoped TLB flushes for paravirt TLB flushing
> 
> Handling (2) and (3) in the same flow as (1) is kludgy, because the rules
> for (1) are quite different than the rules for (2) and (3).  They're all
> squeezed into __vmx_flush_tlb() via the @invalidate_gpa param, which means
> "invalidate gpa mappings", not "invalidate a specific gpa"; it took me
> forever and a day to realize that.
> 
> To clean things up, handle (2) by directly calling vpid_sync_context()
> instead of bouncing through __vmx_flush_tlb(), and handle (3) via a
> dedicated kvm_x86_ops hook.  This allows for a less tricky implementation
> of vmx_flush_tlb() for (1), and (hopefully) clarifies the rules for what
> mappings must be invalidated when.
> 
> Sean Christopherson (10):
>   KVM: VMX: Use vpid_sync_context() directly when possible
>   KVM: VMX: Move vpid_sync_vcpu_addr() down a few lines
>   KVM: VMX: Handle INVVPID fallback logic in vpid_sync_vcpu_addr()
>   KVM: VMX: Fold vpid_sync_vcpu_{single,global}() into
>     vpid_sync_context()
>   KVM: nVMX: Use vpid_sync_vcpu_addr() to emulate INVVPID with address
>   KVM: x86: Move "flush guest's TLB" logic to separate kvm_x86_ops hook
>   KVM: VMX: Clean up vmx_flush_tlb_gva()
>   KVM: x86: Drop @invalidate_gpa param from kvm_x86_ops' tlb_flush()
>   KVM: VMX: Drop @invalidate_gpa from __vmx_flush_tlb()
>   KVM: VMX: Fold __vmx_flush_tlb() into vmx_flush_tlb()
> 
>  arch/x86/include/asm/kvm_host.h |  8 +++++++-
>  arch/x86/kvm/mmu/mmu.c          |  2 +-
>  arch/x86/kvm/svm.c              | 14 ++++++++++----
>  arch/x86/kvm/vmx/nested.c       | 12 ++++--------
>  arch/x86/kvm/vmx/ops.h          | 32 +++++++++-----------------------
>  arch/x86/kvm/vmx/vmx.c          | 26 +++++++++++++++++---------
>  arch/x86/kvm/vmx/vmx.h          | 19 ++++++++++---------
>  arch/x86/kvm/x86.c              |  8 ++++----
>  8 files changed, 62 insertions(+), 59 deletions(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

