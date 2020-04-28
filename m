Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F102BC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6DA206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m03V7Bqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgD1OHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgD1OHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:07:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF47C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:07:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k12so17352043qtm.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fy9ivS8QPPwiuCK+doJtcNxxWhUNoFRKbiicEk8ESXs=;
        b=m03V7Bqnrzc7u1hOHNegLX/D6uRA6iSn20RxNU8QvJ1QFKsSaD70QJ6n/s/UyarsFJ
         rS4XcjYTl/K8wPVQmsqZcwGaYD4DEF96z+keAqbELkFqDS54ADd792WseZXN6fmhZjdK
         D2hC44IoUKWdnBAHvC5M60WEYESwUu1VZofGFOKhASI+hQkhe9zsHZWNSdgUyJHHj9IU
         jBU0JJsSzE8KiMpymNT5HJRvRE8knYzVWS+0PdOCFmaciO0iQSVK5de5Rbf3CztawIBI
         CdsaCr46/lqDnOLgGy9KBM4Sz16Nusr1wxAiubc5Qq7sqPrR7bFG3qVDFZzxPdIE6WuI
         tBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fy9ivS8QPPwiuCK+doJtcNxxWhUNoFRKbiicEk8ESXs=;
        b=pA8BFrTpV30uPcxDd4QAlF31FUBTei5kVZacjAAUcFQ9CgE+0Jh57c1oKsTfKxKHBH
         deyKxeIgB2ZrHJxpzM8JLrVM8pDhvG7GNj6xslZYbLpkiLVr0HqTnFBk2DKR12rBfKa2
         4+YaQDPCSkCghNvRyyQgCxrbM/sAbNFw7obBG4ApFOC39OflM/mKKSeb9oCCuQmI5/CS
         qWK2z7SaTuetp9hIp0n0UqHp7LxSDk67gL4GMVjP/V5fmr2nhuEzE8gNLZ6LEIVAS4HH
         WFLxc1Yrq0tRUY3sF521oW1h8rWUmY9ivSCU6ESgA2EihH3oHt6yL9+aXqGdjtJsVjoA
         m6PQ==
X-Gm-Message-State: AGi0PuYcZPGAq3qDBVGwobToRjZsJxWnFf/Yz6zPqwvEpBkuYHIqDnbS
        BO7IJUqxvkbzgxNRLIckXohJ39j3s+c=
X-Google-Smtp-Source: APiQypL8JVVgXn1Z0K37nLLf+jtFxuaUMdsGklwooOQS8IA68vzDHPI0GpgPkHQUdRDPsQEeiTjwEQ==
X-Received: by 2002:ac8:65cc:: with SMTP id t12mr28186660qto.310.1588082850656;
        Tue, 28 Apr 2020 07:07:30 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id 29sm13492497qkr.109.2020.04.28.07.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 07:07:29 -0700 (PDT)
Subject: Re: [PATCH 1/3] KVM: x86/mmu: Tweak PSE hugepage handling to avoid 2M
 vs 4M conundrum
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200428005422.4235-1-sean.j.christopherson@intel.com>
 <20200428005422.4235-2-sean.j.christopherson@intel.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <3e60b34b-e160-2052-3066-c29867ccef64@google.com>
Date:   Tue, 28 Apr 2020 10:07:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428005422.4235-2-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 8:54 PM, Sean Christopherson wrote:
> Change the PSE hugepage handling in walk_addr_generic() to fire on any
> page level greater than PT_PAGE_TABLE_LEVEL, a.k.a. PG_LEVEL_4K.  PSE
> paging only has two levels, so "== 2" and "> 1" are functionally the
> seam, i.e. this is a nop.
   ^ s/seam/same/

Barret

> 
> A future patch will drop KVM's PT_*_LEVEL enums in favor of the kernel's
> PG_LEVEL_* enums, at which point "walker->level == PG_LEVEL_2M" is
> semantically incorrect (though still functionally ok).
> 
> No functional change intended.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>   arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index efec7d27b8c5..ca39bd315f70 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -436,7 +436,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>   	gfn = gpte_to_gfn_lvl(pte, walker->level);
>   	gfn += (addr & PT_LVL_OFFSET_MASK(walker->level)) >> PAGE_SHIFT;
>   
> -	if (PTTYPE == 32 && walker->level == PT_DIRECTORY_LEVEL && is_cpuid_PSE36())
> +	if (PTTYPE == 32 && walker->level > PT_PAGE_TABLE_LEVEL && is_cpuid_PSE36())
>   		gfn += pse36_gfn_delta(pte);
>   
>   	real_gpa = mmu->translate_gpa(vcpu, gfn_to_gpa(gfn), access, &walker->fault);
> 

