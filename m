Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0447E208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4eQtvbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgE0MIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:08:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57056 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726019AbgE0MH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590581247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JAOHEe2wXSlGLrnZFjFSmf34no8sDZWkhmsgq7pa2Tg=;
        b=J4eQtvbB3Xhn7/xzdQaxIOYIgtJxbkcX+I9w9bZ88xz36u2mbPyHYb+hjs1+BqxL1mpynq
        G6JeYI6JgyF6pNtNSn5tNFakgfl9/i05XvKD1+8K1uUWHjFOZxMO30qu4jTpQK9CssYwpb
        xQ26bfMy0j4vwJ5/1KYgS94e2sCvtgw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-HFbeU3i8OOODhlReMkqDzA-1; Wed, 27 May 2020 08:07:25 -0400
X-MC-Unique: HFbeU3i8OOODhlReMkqDzA-1
Received: by mail-ej1-f69.google.com with SMTP id ng1so8789981ejb.22
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JAOHEe2wXSlGLrnZFjFSmf34no8sDZWkhmsgq7pa2Tg=;
        b=IOl7oWJDe2gWi6szje3B2O2t3i5NnYGeW+P4k5Wqh+gXhcFfgXKYN4Q0HIbl4/uUIR
         s+PDwO2WT0gzillqlOxVQLa9OciZqXerlQ07CfH/E/m4hTkB/jun1yngAVNVtcLELJbk
         RMdnrng9xj87oLbc/v5AiQr8CpBkOtCD+2vaS7EO4dcMA4xh716dmPl4U63lro9PJTbi
         CBj7s/GLTeAEy+JZwzPSaHTOQoRTltMbIGCNnmny2dED/ZxD7GFLWbXhRmYwyaCsY4mx
         atDdxP0iSJUdyLEdkgogm6iO2x92BkkT1JdsebQfP4i0YB8s+O4AkBl/FWOLRlsEF0vx
         LKog==
X-Gm-Message-State: AOAM531SCgp5WYxPONypqo80onBSDGstlJXNYSy72xLzJLF8+ZAg+t+p
        o6Y5vrMXj6YDndnc7/hA3i0aLsygfmEvnQ0FqSYfU1EuQByHST/XvTJfydeFEEKsITRnZn/W3Ou
        qLl8ZtguS/+I+Pv0Xcc99Bcjr
X-Received: by 2002:aa7:c6d1:: with SMTP id b17mr6119048eds.39.1590581244333;
        Wed, 27 May 2020 05:07:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPap1r2d6pve9ph5mq6UFpBkvveZ3/UVhwnGQUVfRWhjg9EfMvArNZv5Ea+DHovL+LUMT1dw==
X-Received: by 2002:aa7:c6d1:: with SMTP id b17mr6119007eds.39.1590581243987;
        Wed, 27 May 2020 05:07:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id gl19sm2526817ejb.34.2020.05.27.05.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 05:07:23 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Set mmio_value to '0' if reserved #PF can't
 be generated
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200527084909.23492-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f88b71bb-74aa-9ff1-7aab-918d9f0a4a82@redhat.com>
Date:   Wed, 27 May 2020 14:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200527084909.23492-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/20 10:49, Sean Christopherson wrote:
> Set the mmio_value to '0' instead of simply clearing the present bit to
> squash a benign warning in kvm_mmu_set_mmio_spte_mask() that complains
> about the mmio_value overlapping the lower GFN mask on systems with 52
> bits of PA space.
> 
> Opportunistically clean up the code and comments.
> 
> Fixes: 608831174100 ("KVM: x86: only do L1TF workaround on affected processors")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Queued, thanks (with Cc: to stable).

Paolo

> Thanks for the excuse to clean up kvm_set_mmio_spte_mask(), been wanting a
> reason to fix that mess for a few months now :-).
> 
>  arch/x86/kvm/mmu/mmu.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 2df0f347655a4..aab90f4079ea9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6136,25 +6136,16 @@ static void kvm_set_mmio_spte_mask(void)
>  	u64 mask;
>  
>  	/*
> -	 * Set the reserved bits and the present bit of an paging-structure
> -	 * entry to generate page fault with PFER.RSV = 1.
> +	 * Set a reserved PA bit in MMIO SPTEs to generate page faults with
> +	 * PFEC.RSVD=1 on MMIO accesses.  64-bit PTEs (PAE, x86-64, and EPT
> +	 * paging) support a maximum of 52 bits of PA, i.e. if the CPU supports
> +	 * 52-bit physical addresses then there are no reserved PA bits in the
> +	 * PTEs and so the reserved PA approach must be disabled.
>  	 */
> -
> -	/*
> -	 * Mask the uppermost physical address bit, which would be reserved as
> -	 * long as the supported physical address width is less than 52.
> -	 */
> -	mask = 1ull << 51;
> -
> -	/* Set the present bit. */
> -	mask |= 1ull;
> -
> -	/*
> -	 * If reserved bit is not supported, clear the present bit to disable
> -	 * mmio page fault.
> -	 */
> -	if (shadow_phys_bits == 52)
> -		mask &= ~1ull;
> +	if (shadow_phys_bits < 52)
> +		mask = BIT_ULL(51) | PT_PRESENT_MASK;
> +	else
> +		mask = 0;
>  
>  	kvm_mmu_set_mmio_spte_mask(mask, mask, ACC_WRITE_MASK | ACC_USER_MASK);
>  }



