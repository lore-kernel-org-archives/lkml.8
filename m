Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B1C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF442077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjVxTefA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgAJLhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:37:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727457AbgAJLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578656251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76m53pUJPKenCfreNve7yHZLtshh6/Zahkzk34fOo/I=;
        b=QjVxTefAHW5PE7uy/eBXsApOL2lnlzOVyD8d127DHv/KUB1Gnc3OctX3fap1VVB/Bbu2YU
        BGzimATSh/SUhF38o0Zag+5j8roe4AeUY4PmgqqqRmoPypMuFdhPLsDwmDQ/qmSZJaCOt3
        T0GQti8AZm6Dh1upihu2QY/k2IfBlWc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-4DXaV5QHNSKobTWLKJr7Dw-1; Fri, 10 Jan 2020 06:37:30 -0500
X-MC-Unique: 4DXaV5QHNSKobTWLKJr7Dw-1
Received: by mail-wm1-f69.google.com with SMTP id o24so340358wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 03:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=76m53pUJPKenCfreNve7yHZLtshh6/Zahkzk34fOo/I=;
        b=VZzA84K6M1cF0bIiQ4xDcmVyQrgPnjgAhxzrP41DERFGd7tCkgKi4czroA7bGC6FCZ
         G+q3lwjnqRryKR1zdoIeqrEZGK9VUUn5MYDu9EXPba0xoaucoE4IDs1gSHL6e65Eggxz
         eANQsQNtllL5hV+9yfxn/hJNONfAZ7rpWRBaSZ4uAezKT6NmDuccwPyonUl+Y3LYSnqm
         lNqXC8Kp9lolo6tE8D38vOncLtpBHn6oJxRQIUcfXeFGDZQW0MEkp+FNqgLdb3tFmceQ
         0sseiG06pQnu2X9y0+boEYArvXmkfS52jNvT4T/5i67OrgMwxLzFrHjPtsiWpsi0JSIM
         PQZw==
X-Gm-Message-State: APjAAAWnq75WPrvdyqG/UR4LiiwGEdQEV+/ZMG8pKKZ0tzgZf5tC3KAd
        AFdhncFJN2XAn6TVACvJcltzts7L15yg0etsS44W3Mom0fdzmGJL4VrcZqT4Zwt4NosIPhnQsDz
        GgqC3jimEXT4XbJB2pato1BJj
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3842866wmi.146.1578656249316;
        Fri, 10 Jan 2020 03:37:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDc5FlpbuWuff9YpQyMSPaLD6LxiRK9JTxjtF2CP+lcs8+cvCxt6hMG5Lh95dJo9f7RWcgHQ==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3842839wmi.146.1578656249097;
        Fri, 10 Jan 2020 03:37:29 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l19sm1902242wmj.12.2020.01.10.03.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 03:37:28 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 1/2] KVM: x86/mmu: Reorder the reserved bit check in prefetch_invalid_gpte()
In-Reply-To: <20200109230640.29927-2-sean.j.christopherson@intel.com>
References: <20200109230640.29927-1-sean.j.christopherson@intel.com> <20200109230640.29927-2-sean.j.christopherson@intel.com>
Date:   Fri, 10 Jan 2020 12:37:27 +0100
Message-ID: <87a76vr18o.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the !PRESENT and !ACCESSED checks in FNAME(prefetch_invalid_gpte)
> above the call to is_rsvd_bits_set().  For a well behaved guest, the
> !PRESENT and !ACCESSED are far more likely to evaluate true than the
> reserved bit checks, and they do not require additional memory accesses.
>
> Before:
>  Dump of assembler code for function paging32_prefetch_invalid_gpte:
>    0x0000000000044240 <+0>:     callq  0x44245 <paging32_prefetch_invalid_gpte+5>
>    0x0000000000044245 <+5>:     mov    %rcx,%rax
>    0x0000000000044248 <+8>:     shr    $0x7,%rax
>    0x000000000004424c <+12>:    and    $0x1,%eax
>    0x000000000004424f <+15>:    lea    0x0(,%rax,4),%r8
>    0x0000000000044257 <+23>:    add    %r8,%rax
>    0x000000000004425a <+26>:    mov    %rcx,%r8
>    0x000000000004425d <+29>:    and    0x120(%rsi,%rax,8),%r8
>    0x0000000000044265 <+37>:    mov    0x170(%rsi),%rax
>    0x000000000004426c <+44>:    shr    %cl,%rax
>    0x000000000004426f <+47>:    and    $0x1,%eax
>    0x0000000000044272 <+50>:    or     %rax,%r8
>    0x0000000000044275 <+53>:    jne    0x4427c <paging32_prefetch_invalid_gpte+60>
>    0x0000000000044277 <+55>:    test   $0x1,%cl
>    0x000000000004427a <+58>:    jne    0x4428a <paging32_prefetch_invalid_gpte+74>
>    0x000000000004427c <+60>:    mov    %rdx,%rsi
>    0x000000000004427f <+63>:    callq  0x44080 <drop_spte>
>    0x0000000000044284 <+68>:    mov    $0x1,%eax
>    0x0000000000044289 <+73>:    retq
>    0x000000000004428a <+74>:    xor    %eax,%eax
>    0x000000000004428c <+76>:    and    $0x20,%ecx
>    0x000000000004428f <+79>:    jne    0x44289 <paging32_prefetch_invalid_gpte+73>
>    0x0000000000044291 <+81>:    mov    %rdx,%rsi
>    0x0000000000044294 <+84>:    callq  0x44080 <drop_spte>
>    0x0000000000044299 <+89>:    mov    $0x1,%eax
>    0x000000000004429e <+94>:    jmp    0x44289 <paging32_prefetch_invalid_gpte+73>
>  End of assembler dump.
>
> After:
>  Dump of assembler code for function paging32_prefetch_invalid_gpte:
>    0x0000000000044240 <+0>:     callq  0x44245 <paging32_prefetch_invalid_gpte+5>
>    0x0000000000044245 <+5>:     test   $0x1,%cl
>    0x0000000000044248 <+8>:     je     0x4424f <paging32_prefetch_invalid_gpte+15>
>    0x000000000004424a <+10>:    test   $0x20,%cl
>    0x000000000004424d <+13>:    jne    0x4425d <paging32_prefetch_invalid_gpte+29>
>    0x000000000004424f <+15>:    mov    %rdx,%rsi
>    0x0000000000044252 <+18>:    callq  0x44080 <drop_spte>
>    0x0000000000044257 <+23>:    mov    $0x1,%eax
>    0x000000000004425c <+28>:    retq
>    0x000000000004425d <+29>:    mov    %rcx,%rax
>    0x0000000000044260 <+32>:    mov    (%rsi),%rsi
>    0x0000000000044263 <+35>:    shr    $0x7,%rax
>    0x0000000000044267 <+39>:    and    $0x1,%eax
>    0x000000000004426a <+42>:    lea    0x0(,%rax,4),%r8
>    0x0000000000044272 <+50>:    add    %r8,%rax
>    0x0000000000044275 <+53>:    mov    %rcx,%r8
>    0x0000000000044278 <+56>:    and    0x120(%rsi,%rax,8),%r8
>    0x0000000000044280 <+64>:    mov    0x170(%rsi),%rax
>    0x0000000000044287 <+71>:    shr    %cl,%rax
>    0x000000000004428a <+74>:    and    $0x1,%eax
>    0x000000000004428d <+77>:    mov    %rax,%rcx
>    0x0000000000044290 <+80>:    xor    %eax,%eax
>    0x0000000000044292 <+82>:    or     %rcx,%r8
>    0x0000000000044295 <+85>:    je     0x4425c <paging32_prefetch_invalid_gpte+28>
>    0x0000000000044297 <+87>:    mov    %rdx,%rsi
>    0x000000000004429a <+90>:    callq  0x44080 <drop_spte>
>    0x000000000004429f <+95>:    mov    $0x1,%eax
>    0x00000000000442a4 <+100>:   jmp    0x4425c <paging32_prefetch_invalid_gpte+28>
>  End of assembler dump.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/paging_tmpl.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index b53bed3c901c..1fde6a1c506d 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -175,9 +175,6 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
>  				  struct kvm_mmu_page *sp, u64 *spte,
>  				  u64 gpte)
>  {
> -	if (is_rsvd_bits_set(vcpu->arch.mmu, gpte, PT_PAGE_TABLE_LEVEL))
> -		goto no_present;
> -
>  	if (!FNAME(is_present_gpte)(gpte))
>  		goto no_present;
>  
> @@ -186,6 +183,9 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
>  	    !(gpte & PT_GUEST_ACCESSED_MASK))
>  		goto no_present;
>  
> +	if (is_rsvd_bits_set(vcpu->arch.mmu, gpte, PT_PAGE_TABLE_LEVEL))
> +		goto no_present;
> +
>  	return false;
>  
>  no_present:

FWIW,
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

