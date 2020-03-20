Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC8C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D116820767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmSfes3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgCTVYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:24:01 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52777 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTVYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:24:01 -0400
Received: by mail-pj1-f67.google.com with SMTP id ng8so3056251pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=X/c8paRwLZjm2U0/5wiR8BCzpWAXOizbkJkAGz1/xTY=;
        b=FmSfes3fzmDsxSDf9OY3G5hCUjwK5b8FM/PgWRhGkPg+DeLtF37pFoTd3rxKuwRYor
         ZCG6EBLl0CqtWgB3EdHZkzQk6pM2lbakxbB1mYU135Wm5BVhHt1Iz4pyKDxPIMg4ZCun
         8YLRN13LNT6V5rDbTkeJNTL0ZLKid/Pypuew9XtXwAj1kr6LqqvGg/kaXs1xPqC1Hz09
         DUCHFkfuoOBZkvFw2+KKaJJjzlrXzzkQr2q3KcQkX8xxl+zD7eIbz0GyzuAeL5sD2lMm
         FOHpJsqjzxYtysFc+O4sRpPPoFB2Xl/6In0xHpPy2UEf3iOoJdjtgODqaD3nCxRGPeFj
         C8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=X/c8paRwLZjm2U0/5wiR8BCzpWAXOizbkJkAGz1/xTY=;
        b=Yr42ylg0vR5OoPoEr4RbsByod1Hs/O1k17HBptJD1MWUJ70PFpcihVXQYAYaL5WCyg
         F9TJP7t1UgTDkhGBX0C20YodYqNlPvzkR1TZlIWQ4qNo+VhnvJiRbp3BWqtf9rdubJMI
         hQ/Fw3QHkLhlXiGX6f2m3eABejG68zHpYacm5RZQ1cNhmvjHMJLK9/Cqud1T76mY5ikk
         vftQ2JArNlfv7J8NPK7k7pWjG9KV2+yjSeoiy8+0Gyf4zU5R8y23375HRMMyrute1gZ0
         9Qv8YhZIR5JSwmKIjEI4RJlp87ZBUQZ8wGtF4z3gO70ocAepinUsT/Byyg6DHZE2Z5OB
         hiDA==
X-Gm-Message-State: ANhLgQ01D+86ctu4oIiNPE1J/qD4LIeUoGE6ApfEHg1xPnys1ZEQxgpl
        olIQZ9I7bnXnx8RDSgCHzx0LvA==
X-Google-Smtp-Source: ADFU+vuFnCFN+GyTb1nOC+QI3RpAP+BeUX9VfNuO7G0qK7pWfbChQ4USVqOp6comwU1r9y51yS8kBw==
X-Received: by 2002:a17:90a:a791:: with SMTP id f17mr12242960pjq.22.1584739440181;
        Fri, 20 Mar 2020 14:24:00 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h11sm6340185pfq.56.2020.03.20.14.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:23:59 -0700 (PDT)
Date:   Fri, 20 Mar 2020 14:23:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com
cc:     x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 62/70] x86/kvm: Add KVM specific VMMCALL handling under
 SEV-ES
In-Reply-To: <20200319091407.1481-63-joro@8bytes.org>
Message-ID: <alpine.DEB.2.21.2003201423230.205664@chino.kir.corp.google.com>
References: <20200319091407.1481-1-joro@8bytes.org> <20200319091407.1481-63-joro@8bytes.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020, Joerg Roedel wrote:

> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Implement the callbacks to copy the processor state required by KVM to
> the GHCB.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> [ jroedel@suse.de: - Split out of a larger patch
>                    - Adapt to different callback functions ]
> Co-developed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/kvm.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 6efe0410fb72..0e3fc798d719 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -34,6 +34,8 @@
>  #include <asm/hypervisor.h>
>  #include <asm/tlb.h>
>  #include <asm/cpuidle_haltpoll.h>
> +#include <asm/ptrace.h>
> +#include <asm/svm.h>
>  
>  static int kvmapf = 1;
>  
> @@ -729,13 +731,34 @@ static void __init kvm_init_platform(void)
>  	x86_platform.apic_post_init = kvm_apic_init;
>  }
>  
> +#if defined(CONFIG_AMD_MEM_ENCRYPT)
> +static void kvm_sev_es_hcall_prepare(struct ghcb *ghcb, struct pt_regs *regs)
> +{
> +	/* RAX and CPL are already in the GHCB */
> +	ghcb_set_rbx(ghcb, regs->bx);
> +	ghcb_set_rcx(ghcb, regs->cx);
> +	ghcb_set_rdx(ghcb, regs->dx);
> +	ghcb_set_rsi(ghcb, regs->si);

Is it possible to check the hypercall from RAX and only copy the needed 
regs or is there a requirement that they must all be copied 
unconditionally?

> +}
> +
> +static bool kvm_sev_es_hcall_finish(struct ghcb *ghcb, struct pt_regs *regs)
> +{
> +	/* No checking of the return state needed */
> +	return true;
> +}
> +#endif
> +
>  const __initconst struct hypervisor_x86 x86_hyper_kvm = {
> -	.name			= "KVM",
> -	.detect			= kvm_detect,
> -	.type			= X86_HYPER_KVM,
> -	.init.guest_late_init	= kvm_guest_init,
> -	.init.x2apic_available	= kvm_para_available,
> -	.init.init_platform	= kvm_init_platform,
> +	.name				= "KVM",
> +	.detect				= kvm_detect,
> +	.type				= X86_HYPER_KVM,
> +	.init.guest_late_init		= kvm_guest_init,
> +	.init.x2apic_available		= kvm_para_available,
> +	.init.init_platform		= kvm_init_platform,
> +#if defined(CONFIG_AMD_MEM_ENCRYPT)
> +	.runtime.sev_es_hcall_prepare	= kvm_sev_es_hcall_prepare,
> +	.runtime.sev_es_hcall_finish	= kvm_sev_es_hcall_finish,
> +#endif
>  };
>  
>  static __init int activate_jump_labels(void)
> -- 
> 2.17.1
> 
> 
