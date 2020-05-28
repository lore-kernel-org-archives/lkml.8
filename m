Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F4AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61CF207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmEKr4AO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbgE1L5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:57:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59161 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388749AbgE1L4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590666990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yiz5dSOYdlV7/pPCeIEVuYRNWj51QSmz3pq/ju45gCA=;
        b=AmEKr4AOy6SBsHOIfvGUroLhAqyXc0piACz7y0G6LoJihaZky311F5hjm+wJ94kPrp6e9W
        fLC+iGarMMFCGLTEmls3zETQJNXed65sbC4/iTBKg+GYEzUYheNJaJFDf+4IyOyPYbeDvy
        PetcSFYSdixlFQVp9ydQj/A4A1ezy/I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-ITXCLVSGPSu_fTKCNMsLRw-1; Thu, 28 May 2020 07:56:29 -0400
X-MC-Unique: ITXCLVSGPSu_fTKCNMsLRw-1
Received: by mail-wr1-f71.google.com with SMTP id c14so2672277wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yiz5dSOYdlV7/pPCeIEVuYRNWj51QSmz3pq/ju45gCA=;
        b=YTG+mLOb2jJksFmFPe/VcIMPbij32WomY/wIuUupIEaKeyu+owbNmaIj/OLCTx/5vO
         mqG/hkiftwm3cHftD/Pq85nLqmKFNuqKHybNVxy8eIc4v4G1yVJ6bkO9ZpVY8nG4cNO4
         Gxvn+S6hSwSe+cTkWuJUK7+a29BaZviDKoLNm8QMG8wom+GMk2oiatRIyq8g/Ga/75ey
         gI33eGUNOlQyEo+CVfpiOA1Jxaz9jopAfe/XqdpahgUUj9+PD7BxRL0qhJ7qaeRC7MEU
         3ASvPY7sfSvnhBhq4z0U3ts1pKAaEFYLGNyud75H3hSfmQV5/gN6R6krsdhK8P7KhyE2
         e8Xg==
X-Gm-Message-State: AOAM531WstPYzaHI4LwH9L9oxlFj6K+9+VgYlpVxlkxm7RpKNAH1LEi1
        AFY52ptcwVouhe9McF+4oYyDsCQjqrLz/QrttvYQWGbgQuIGToTdajS0TlSAKUHXzJNnBSVRx3y
        a3vXj4d5ZrcqDIfXWqYJFlISp
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr3231830wrt.341.1590666987859;
        Thu, 28 May 2020 04:56:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKuPIf7B5Cz3iHbqwMVjcFt8fJUNDvvngaOdIAtByLGJ+sgSj7uK/BuNlur4kQQFO7KPpNXA==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr3231809wrt.341.1590666987632;
        Thu, 28 May 2020 04:56:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id f2sm6023682wrg.17.2020.05.28.04.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 04:56:27 -0700 (PDT)
Subject: Re: [PATCH] x86/kvm: Remove defunct KVM_DEBUG_FS Kconfig
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200528031121.28904-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <257b0ba7-84e2-89de-3708-1174f5d090be@redhat.com>
Date:   Thu, 28 May 2020 13:56:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200528031121.28904-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/20 05:11, Sean Christopherson wrote:
> Remove KVM_DEBUG_FS, which can easily be misconstrued as controlling
> KVM-as-a-host.  The sole user of CONFIG_KVM_DEBUG_FS was removed by
> commit cfd8983f03c7b ("x86, locking/spinlocks: Remove ticket (spin)lock
> implementation").
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/Kconfig      | 8 --------
>  arch/x86/kernel/kvm.c | 1 -
>  2 files changed, 9 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1197b5596d5ad..0ccf4e76acfe8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -818,14 +818,6 @@ config PVH
>  	  This option enables the PVH entry point for guest virtual machines
>  	  as specified in the x86/HVM direct boot ABI.
>  
> -config KVM_DEBUG_FS
> -	bool "Enable debug information for KVM Guests in debugfs"
> -	depends on KVM_GUEST && DEBUG_FS
> -	---help---
> -	  This option enables collection of various statistics for KVM guest.
> -	  Statistics are displayed in debugfs filesystem. Enabling this option
> -	  may incur significant overhead.
> -
>  config PARAVIRT_TIME_ACCOUNTING
>  	bool "Paravirtual steal time accounting"
>  	depends on PARAVIRT
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 6efe0410fb728..89ba09228eaf5 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -21,7 +21,6 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/kprobes.h>
> -#include <linux/debugfs.h>
>  #include <linux/nmi.h>
>  #include <linux/swait.h>
>  #include <asm/timer.h>
> 

Queued, thanks.

Paolo

