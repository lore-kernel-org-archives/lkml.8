Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE60C4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2E424680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0Mn0wyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgBZRiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:38:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51521 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgBZRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582738693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIvcJetTmqzJRCF3gD6AW+GFXpGbWVjJD/mid1Qq4MM=;
        b=J0Mn0wyCTuH7+5B9M+G8ChJNIA7Ttdfma0nYtxklvGXK60hAZ8UouckjOIk/TtQnGgQ2Z3
        hhT7HRPTQf0FKImOhgFcAB3Q03CHpQFt7fmSNX80lUZnRQcvpmd4UYGsiGbIlrw3NvBmqO
        Tka3sAgpyilY38GSKeGA80d5D8jJXDc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-C7lfgIwTNzGVnYVYsDoBvA-1; Wed, 26 Feb 2020 12:38:12 -0500
X-MC-Unique: C7lfgIwTNzGVnYVYsDoBvA-1
Received: by mail-wr1-f70.google.com with SMTP id m15so56209wrs.22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JIvcJetTmqzJRCF3gD6AW+GFXpGbWVjJD/mid1Qq4MM=;
        b=AaCC4PddhMJUlz2VemF9PxzIe8XQHRERtk5gFWMFZukUQ8/WtNSZfb4z9hbX+j9OvV
         f3YDvuJvUSDfXQEUHr3j4yYMflTUVZ0BV8dKfmQyOhxvyac1C3IQfYjOxUhAK90gbGg5
         UnVj/StBfyTqSUCsuGNuQoMRpgs4OrjoGjvi9/s8/GHD0UZJ9fGHhIujuJ8bji6PrsjA
         NqO8ax6iant50WcM6hfoLCQ98M3NfL6tI8XkKRwv230PcHSmKBUukvRkU9MIPgbrT1RC
         yPyv4Wzq1U3eGzVuZ9LQ08rKt2b0cHLQGQpOyYBP9cxZy5FpkWYzLN6c6NP2OlY3loTU
         FoNQ==
X-Gm-Message-State: APjAAAWdHh56cpVa6h0Bba3ZYdEWba7AcMVsGhSkdPWX8zYq1Hkxg45m
        0NrOYoy/WtYlsturaKyhPzttdYlF/HSIElt0pzJ6UFO+2aw79UOq56Z1ThWX4aKWgcMW40NcNow
        NtkpZ1rNaVa3ZskWJS1cRZaHv
X-Received: by 2002:adf:cd03:: with SMTP id w3mr6741586wrm.191.1582738690459;
        Wed, 26 Feb 2020 09:38:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrY86IU6qo6nd3QByKKtzOkBd7TWA9gnCHxcFLnRePpBlQv+dnI0/gyCoFAKIAUZZdreP2kg==
X-Received: by 2002:adf:cd03:: with SMTP id w3mr6741568wrm.191.1582738690226;
        Wed, 26 Feb 2020 09:38:10 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z1sm3649957wmf.42.2020.02.26.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:38:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/13] KVM: x86: Move kvm_emulate.h into KVM's private directory
In-Reply-To: <20200218232953.5724-10-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com> <20200218232953.5724-10-sean.j.christopherson@intel.com>
Date:   Wed, 26 Feb 2020 18:38:08 +0100
Message-ID: <87tv3di70f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Now that the emulation context is dynamically allocated and not embedded
> in struct kvm_vcpu, move its header, kvm_emulate.h, out of the public
> asm directory and into KVM's private x86 directory.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h             | 5 ++++-
>  arch/x86/kvm/emulate.c                      | 2 +-
>  arch/x86/{include/asm => kvm}/kvm_emulate.h | 0
>  arch/x86/kvm/mmu/mmu.c                      | 1 +
>  arch/x86/kvm/x86.c                          | 1 +
>  arch/x86/kvm/x86.h                          | 1 +
>  6 files changed, 8 insertions(+), 2 deletions(-)
>  rename arch/x86/{include/asm => kvm}/kvm_emulate.h (100%)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e069f71667b1..0dfe11f30d7f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -182,7 +182,10 @@ enum exit_fastpath_completion {
>  	EXIT_FASTPATH_SKIP_EMUL_INS,
>  };
>  
> -#include <asm/kvm_emulate.h>
> +struct x86_emulate_ctxt;

Not this patchset's problem (and particular forward declaration is
likely needed), but 

$ grep 'struct x86_emulate_ctxt' arch/x86/include/asm/kvm_host.h
struct x86_emulate_ctxt;
	struct x86_emulate_ctxt *emulate_ctxt;
struct x86_emulate_ctxt;

The second forward declaration is not needed and this patch (or
patchset) may be a good place to get rid of it)

> +struct x86_exception;
> +enum x86_intercept;
> +enum x86_intercept_stage;
>  
>  #define KVM_NR_MEM_OBJS 40
>  
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 1e394cb190ce..0bceb3f71220 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -20,7 +20,7 @@
>  
>  #include <linux/kvm_host.h>
>  #include "kvm_cache_regs.h"
> -#include <asm/kvm_emulate.h>
> +#include "kvm_emulate.h"
>  #include <linux/stringify.h>
>  #include <asm/fpu/api.h>
>  #include <asm/debugreg.h>
> diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> similarity index 100%
> rename from arch/x86/include/asm/kvm_emulate.h
> rename to arch/x86/kvm/kvm_emulate.h
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 7011a4e54866..d9064be28089 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -19,6 +19,7 @@
>  #include "mmu.h"
>  #include "x86.h"
>  #include "kvm_cache_regs.h"
> +#include "kvm_emulate.h"
>  #include "cpuid.h"
>  
>  #include <linux/kvm_host.h>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5ab7d4283185..370af9fe0f5b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -22,6 +22,7 @@
>  #include "i8254.h"
>  #include "tss.h"
>  #include "kvm_cache_regs.h"
> +#include "kvm_emulate.h"
>  #include "x86.h"
>  #include "cpuid.h"
>  #include "pmu.h"
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 8409842a25d9..f3c6e55eb5d9 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -5,6 +5,7 @@
>  #include <linux/kvm_host.h>
>  #include <asm/pvclock.h>
>  #include "kvm_cache_regs.h"
> +#include "kvm_emulate.h"
>  
>  #define KVM_DEFAULT_PLE_GAP		128
>  #define KVM_VMX_DEFAULT_PLE_WINDOW	4096

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

