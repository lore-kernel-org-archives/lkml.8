Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E20C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511C221D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIFk3q/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgBZPXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:23:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727023AbgBZPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582730610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4ucQrDY+iQOfed8DTaG5mdXUDW/n4hSrzqLX+ul7io=;
        b=jIFk3q/2Ur7jU4zv1jX3PHq5qPtAwjxJ+ChsXXe/wmKiBbLKMcO/UZPY+tpZutmj0v1mcc
        yy5g4JkvVWW6HuU++bucWgPokCxxYzcoD+qMaJxuF/cNBV4yAl1JKu5i0Rsj/lUMWPjSb/
        bcuae3yLHG2SrzI3FBG2FGOg+lzxvr0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-olc9cvn0O362vQYypbsjgA-1; Wed, 26 Feb 2020 10:23:28 -0500
X-MC-Unique: olc9cvn0O362vQYypbsjgA-1
Received: by mail-wr1-f70.google.com with SMTP id f10so245037wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=k4ucQrDY+iQOfed8DTaG5mdXUDW/n4hSrzqLX+ul7io=;
        b=t2JgXQP4s5rsH2KhoUDZxwPxjPZqrcmh6cz38XUYv672kC8paeq4KlGCW4sYD4V+hq
         FOs47Eo/QjyWEyZ/pMpu8Ugyo2j8nr0w5vt0P8+91yn/rgsrVktjGhDd26gDGE5cZ6wO
         99nBT8O0qnrEtelTxwyRAgffU2Dko19o36ABjdEWMk1w4CrKlwaDJmUF6m4H3zEsuQ38
         O96f5qVMRLMnbg0rGaj2Dagac5huqNmP3RYwMoVEYh5Px6dYEsZiWgs3O6i10TosV8de
         gbJe7VRlDTlimYol/j0CTXDvbzYRBboUSHXbJFc2XyBnH3mLfqpAoe/GQOV3oCPv5Hol
         D17g==
X-Gm-Message-State: APjAAAWv2jFuY7aRQDaNiKCS00884B+06pP0G31KxGVdEPx0VLOO/Zmt
        oDOhtry5g6vrNsrQVJWsLOYzk51KUPWx4uzv5Dt/4+AnLf1tM1olqlPgP53o2X2B56pIptAU5M6
        exoV6ylgYce3zTp1nMMwBFYwm
X-Received: by 2002:adf:a285:: with SMTP id s5mr6439607wra.118.1582730605676;
        Wed, 26 Feb 2020 07:23:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyy/7n4R6zrNnUx6owfpYEWU1qQMIdGRDXzWekMmbc65pA/gD75QqCNxkxzeVMLZ081R7pK+A==
X-Received: by 2002:adf:a285:: with SMTP id s5mr6439577wra.118.1582730605395;
        Wed, 26 Feb 2020 07:23:25 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g7sm3560478wrq.21.2020.02.26.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:23:24 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] KVM: x86: Move emulation-only helpers to emulate.c
In-Reply-To: <20200218232953.5724-4-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com> <20200218232953.5724-4-sean.j.christopherson@intel.com>
Date:   Wed, 26 Feb 2020 16:23:23 +0100
Message-ID: <87blpljrtg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move ctxt_virt_addr_bits() and emul_is_noncanonical_address() from x86.h
> to emulate.c.  This eliminates all references to struct x86_emulate_ctxt
> from x86.h, and sets the stage for a future patch to stop including
> kvm_emulate.h in asm/kvm_host.h.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/emulate.c | 11 +++++++++++
>  arch/x86/kvm/x86.h     | 11 -----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index ddbc61984227..1e394cb190ce 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -673,6 +673,17 @@ static void set_segment_selector(struct x86_emulate_ctxt *ctxt, u16 selector,
>  	ctxt->ops->set_segment(ctxt, selector, &desc, base3, seg);
>  }
>  
> +static inline u8 ctxt_virt_addr_bits(struct x86_emulate_ctxt *ctxt)
> +{
> +	return (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_LA57) ? 57 : 48;
> +}
> +
> +static inline bool emul_is_noncanonical_address(u64 la,
> +						struct x86_emulate_ctxt *ctxt)
> +{
> +	return get_canonical(la, ctxt_virt_addr_bits(ctxt)) != la;
> +}
> +
>  /*
>   * x86 defines three classes of vector instructions: explicitly
>   * aligned, explicitly unaligned, and the rest, which change behaviour
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 3624665acee4..8409842a25d9 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -149,11 +149,6 @@ static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
>  	return kvm_read_cr4_bits(vcpu, X86_CR4_LA57) ? 57 : 48;
>  }
>  
> -static inline u8 ctxt_virt_addr_bits(struct x86_emulate_ctxt *ctxt)
> -{
> -	return (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_LA57) ? 57 : 48;
> -}
> -
>  static inline u64 get_canonical(u64 la, u8 vaddr_bits)
>  {
>  	return ((int64_t)la << (64 - vaddr_bits)) >> (64 - vaddr_bits);
> @@ -164,12 +159,6 @@ static inline bool is_noncanonical_address(u64 la, struct kvm_vcpu *vcpu)
>  	return get_canonical(la, vcpu_virt_addr_bits(vcpu)) != la;
>  }
>  
> -static inline bool emul_is_noncanonical_address(u64 la,
> -						struct x86_emulate_ctxt *ctxt)
> -{
> -	return get_canonical(la, ctxt_virt_addr_bits(ctxt)) != la;
> -}
> -
>  static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
>  					gva_t gva, gfn_t gfn, unsigned access)
>  {

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

