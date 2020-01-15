Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD65C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E5E24656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmwaUBXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgAOSUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:20:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729016AbgAOSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579112449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pSzV3135kt1xAEMdD0lnuf56mdsl9W1OFUiXIzWzQw=;
        b=VmwaUBXY0u1nMxOsENfiPG/PzK4+SJO1DIbb1fpvRgOMIRwugr5rASy6C/S7U9LFv/mOVF
        yiXDsLrT9sSsihA2NzVhoCcJbWfwrfS/Mn63gt8UgDAJ3wL4rurNgPHISpGCTv0xuBWUCa
        D5n4WSwQJtsKatrUBXZJv+eowpBrlms=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-j1BpFkHeNQOUTgS9xvM3iQ-1; Wed, 15 Jan 2020 13:20:48 -0500
X-MC-Unique: j1BpFkHeNQOUTgS9xvM3iQ-1
Received: by mail-wr1-f71.google.com with SMTP id i9so8296285wru.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2pSzV3135kt1xAEMdD0lnuf56mdsl9W1OFUiXIzWzQw=;
        b=Y0eqMwjS906lyQei56FVSN+2G+GRre+nZtiNgkHcJO+4MYTkELVISDFGINzpjNeyEn
         zigAKDPygXmmMoj5C7SWf3QXjfubfaQNHQnZHDYb03qPiLH/PTC9llAgaZEyppsL5fS5
         l62SoKmIHnN6k+BUMBZHN60Nnz+cuJ2TDc7Mpk2+xjl/ifrLnPvUJCa9Qn1cLAKOVCeP
         ZbDGGwFHrNotkcLSiXXGYccginDUQoGp0gjZEoIyC1MkuWT/LO63MGQXiUoC2SmnV+JK
         ZqEkf5M/plU+GSM8JQ8aXqIBiLPW14+vymLXw6g5adkPjLo3tkdwrc8V/bQIjIy3mjoG
         54VA==
X-Gm-Message-State: APjAAAXy72cXM7s3+PVC+vdzsAMRaRqYThevHnxlVpkRH3zL4FG4+t8N
        USqqxOFkwdzY5GE8Jq3rWa9t89la/YdLQBvcoF42dqt/vbN2nUTdWwixY+oBev0T+cJrQ4P4A4B
        WW5v5lByFu/Ms3VLkdv4U5z7R
X-Received: by 2002:adf:f10a:: with SMTP id r10mr32616299wro.202.1579112446881;
        Wed, 15 Jan 2020 10:20:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBkPmaHaQlwJtrKOBkm5Wwx2xyAD5D7Reaob9mWT3wqgNC2NGOwvxBa3uDNWP79k3b55/ffA==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr32616279wro.202.1579112446663;
        Wed, 15 Jan 2020 10:20:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id c5sm922497wmb.9.2020.01.15.10.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:20:46 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Apply max PA check for MMIO sptes to 32-bit
 KVM
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200108001210.12913-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2f8c8d5-39d2-6982-a4ae-eeaf4bf42658@redhat.com>
Date:   Wed, 15 Jan 2020 19:20:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108001210.12913-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 01:12, Sean Christopherson wrote:
> Remove the bogus 64-bit only condition from the check that disables MMIO
> spte optimization when the system supports the max PA, i.e. doesn't have
> any reserved PA bits.  32-bit KVM always uses PAE paging for the shadow
> MMU, and per Intel's SDM:
> 
>   PAE paging translates 32-bit linear addresses to 52-bit physical
>   addresses.
> 
> The kernel's restrictions on max physical addresses are limits on how
> much memory the kernel can reasonably use, not what physical addresses
> are supported by hardware.
> 
> Fixes: ce88decffd17 ("KVM: MMU: mmio page fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 7269130ea5e2..d9c07343d979 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6191,7 +6191,7 @@ static void kvm_set_mmio_spte_mask(void)
>  	 * If reserved bit is not supported, clear the present bit to disable
>  	 * mmio page fault.
>  	 */
> -	if (IS_ENABLED(CONFIG_X86_64) && shadow_phys_bits == 52)
> +	if (shadow_phys_bits == 52)
>  		mask &= ~1ull;
>  
>  	kvm_mmu_set_mmio_spte_mask(mask, mask, ACC_WRITE_MASK | ACC_USER_MASK);
> 

Queued, thanks.

Paolo

