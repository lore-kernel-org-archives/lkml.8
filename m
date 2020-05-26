Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D95EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613D2208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="KopPaZ0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390179AbgEZV6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389342AbgEZV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:58:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F8EC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:58:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x27so13225074lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Px/8eL6gy0y1doNzDdCIOLFBQlXLPgLx7xu3e8vyF/U=;
        b=KopPaZ0IGTL1h5Fa3DgF2keyZ6Sn2lIlcsxrYtdh4+TNEWlO+T6nw+1BBjll6MYrfO
         f8PDIODCbvm1qTVgEq1rgPIX7hHCUjrqO/IrDoxF3m7OjrkSeIsxbl/DzBGYo8OF1PYD
         ZPlesWPJYQFUMojDJE/kXG4UBRWLbRxlHloaBhUDU7J4JRNFgsmTeNGWSfQ3DNL/H4As
         ys0EpIHoVtuVdxYBPB+v4ThmrEC2qjP4nSbz+IF0XZMQbb6dRK9Xs8DZjLsijNv5piAO
         zNrNGYrt21gVlSrIVLMMLBc4nDJOJZO53gLvOr9J8xe81/vjR/o2eJRGaAXGSTLDVIl+
         Gdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Px/8eL6gy0y1doNzDdCIOLFBQlXLPgLx7xu3e8vyF/U=;
        b=reNRsAePkJ8lGxQB/KsvmKc+F3bGIrAst1MpN4+HIy2iCelUH/BV0aUpYyWJ4WEqzk
         iF/uYuySrS4I7N/9HUMheBrlRIiJKi7BJV9d9LqcX1BKpBQCy2k5N2KY6wjMl5IPBO2K
         +m+WastLcZnSPiEtRA4A0g4V2DxOIEnwK+2dZKyyRzQIJ/al8SUmBsRjpn2kgyh5vMcJ
         9VpgaOfeLRl8Pt9ukC9q9YcXrw1B20CK9rtFYJLI5Aa0YbRGj2lSywuBzZe3jHzYiHgN
         2pAvU7c6BnSAZPWxiPchfTBbtwrpjNOMeZ6awnPO684KxfC1miMl3WLpl8ZU+Bgzom8H
         SoXA==
X-Gm-Message-State: AOAM5302440lPuY8osSab1DPKIcEcmzxSrTiXf8FjpXXFFjzj7icWaG+
        EE568BatxFhfT2bvUkyMKbUaqg==
X-Google-Smtp-Source: ABdhPJzbUfKEuw57QLKjh/yXbdltLDPSM/7zrh/Fka2lvyAmkVwKa3CcSlUVTDJWG//BpUp+anU9MQ==
X-Received: by 2002:a19:8b06:: with SMTP id n6mr1434644lfd.66.1590530313005;
        Tue, 26 May 2020 14:58:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l8sm226720ljc.59.2020.05.26.14.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:58:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0F32410230F; Wed, 27 May 2020 00:58:34 +0300 (+03)
Date:   Wed, 27 May 2020 00:58:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC 10/16] KVM: x86: Enabled protected memory extension
Message-ID: <20200526215834.zhlm5xjekzk5efrn@box>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
 <20200522125214.31348-11-kirill.shutemov@linux.intel.com>
 <20200526061609.GE13247@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526061609.GE13247@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:16:09AM +0300, Mike Rapoport wrote:
> On Fri, May 22, 2020 at 03:52:08PM +0300, Kirill A. Shutemov wrote:
> > Wire up hypercalls for the feature and define VM_KVM_PROTECTED.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/Kconfig     | 1 +
> >  arch/x86/kvm/cpuid.c | 3 +++
> >  arch/x86/kvm/x86.c   | 9 +++++++++
> >  include/linux/mm.h   | 4 ++++
> >  4 files changed, 17 insertions(+)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 58dd44a1b92f..420e3947f0c6 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -801,6 +801,7 @@ config KVM_GUEST
> >  	select ARCH_CPUIDLE_HALTPOLL
> >  	select X86_MEM_ENCRYPT_COMMON
> >  	select SWIOTLB
> > +	select ARCH_USES_HIGH_VMA_FLAGS
> >  	default y
> >  	---help---
> >  	  This option enables various optimizations for running under the KVM
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index 901cd1fdecd9..94cc5e45467e 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -714,6 +714,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
> >  			     (1 << KVM_FEATURE_POLL_CONTROL) |
> >  			     (1 << KVM_FEATURE_PV_SCHED_YIELD);
> >  
> > +		if (VM_KVM_PROTECTED)
> > +			entry->eax |=(1 << KVM_FEATURE_MEM_PROTECTED);
> > +
> >  		if (sched_info_on())
> >  			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
> >  
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index c17e6eb9ad43..acba0ac07f61 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -7598,6 +7598,15 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
> >  		kvm_sched_yield(vcpu->kvm, a0);
> >  		ret = 0;
> >  		break;
> > +	case KVM_HC_ENABLE_MEM_PROTECTED:
> > +		ret = kvm_protect_all_memory(vcpu->kvm);
> > +		break;
> > +	case KVM_HC_MEM_SHARE:
> > +		ret = kvm_protect_memory(vcpu->kvm, a0, a1, false);
> > +		break;
> > +	case KVM_HC_MEM_UNSHARE:
> > +		ret = kvm_protect_memory(vcpu->kvm, a0, a1, true);
> > +		break;
> >  	default:
> >  		ret = -KVM_ENOSYS;
> >  		break;
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 4f7195365cc0..6eb771c14968 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -329,7 +329,11 @@ extern unsigned int kobjsize(const void *objp);
> >  # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
> >  #endif
> >  
> > +#if defined(CONFIG_X86_64) && defined(CONFIG_KVM)
> 
> This would be better spelled as ARCH_WANTS_PROTECTED_MEMORY, IMHO.

Sure. I though it's good enough for RFC :)

> > +#define VM_KVM_PROTECTED VM_HIGH_ARCH_4
> 
> Maybe this should be VM_HIGH_ARCH_5 so that powerpc could enable this
> feature eventually?

Okay-okay.

-- 
 Kirill A. Shutemov
