Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B0C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C7520771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EA0i9u30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgDGQwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:52:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37844 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgDGQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:52:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id r4so2002907pgg.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XdpEvu/+95xIShI6Rp2COGtZvHM0bAFV7GQvKx62Gs0=;
        b=EA0i9u30tm1f2Ej2aVKmBwDRg1IBGCFcdx21Hv7s3kXdOrLZJuJ1D/ZdXDQs/QBbgb
         1/GXe7WfDGMMsaifJm47HJ/Dh8uz8Qp4Wc9WG84NVc0eYMAWlg1lcktW4yh1y3s2Zyyn
         850xxVOwP6EgwlERe6UCpP2D6q3KonIPQllN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XdpEvu/+95xIShI6Rp2COGtZvHM0bAFV7GQvKx62Gs0=;
        b=RdSzWpgMtKil3HRk4FNi4K0UQdH39/d1XOUAzApKNKqGu9lbS3T8kVjaNHC8rHg7TN
         YbVZTMx4fzt3yWUPcznSHJLPWs23RB0CZIuAfJ05ShPSz/tqq9cGWNqiSqVMQgjGTPYE
         bLOF46nqB+ZQEVXXZ4CcxKcw60RmS3P9kutySaTw4ThjYwyEvxDCO7Dd/hdmG+Ehg4Xq
         G2snHTjJZ2GoinftbHhAZVRDDqifhXnW5xa5w+TWN/nI4L3VHL9DQV4BjaVrEMkJVO/q
         bbIjxQpp3/PjOfFbuHr97hEPMGmN+9PpnlQRzWTYWJx0y8HExCWT9Dmwo4bpLmuF/7JX
         wHkQ==
X-Gm-Message-State: AGi0PuYTESqGUMWt+p4NJijRdKlbuSdtsttx8P2D8mjOzZsNZ0jHLLSH
        s+8aDP+C1QYXZwy9414+CptDsQ==
X-Google-Smtp-Source: APiQypIV8hKgOD0pMZ/yqWWdr+fv5eUil+grVBWSTBnRIuOI/tazQjBUl4hZZzgrr6ZSxIV/KIeMUQ==
X-Received: by 2002:a63:89c1:: with SMTP id v184mr3044992pgd.333.1586278323003;
        Tue, 07 Apr 2020 09:52:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v38sm2123966pjb.1.2020.04.07.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 09:52:02 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:52:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        David.Laight@aculab.com, dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/4] module: Expose load_info to arch module loader code
Message-ID: <202004070951.40A8E7B278@keescook>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.198738828@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407111007.198738828@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 01:02:37PM +0200, Peter Zijlstra wrote:
> From: Jessica Yu <jeyu@kernel.org>
> 
> The x86 module loader wants to check the value of a modinfo flag
> (sld_safe), before proceeding to scan the module text for VMX
> instructions. Unfortunately the arch module code currently does not have
> access to load_info, but we can easily expose that via moduleloader.h,
> which every arch module code must already include.
> 
> Signed-off-by: Jessica Yu <jeyu@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200406160420.14407-1-jeyu@kernel.org
> ---
> 
>  include/linux/moduleloader.h | 20 ++++++++++++++++++++
>  kernel/module-internal.h     | 23 -----------------------
>  kernel/module_signing.c      |  2 +-
>  3 files changed, 21 insertions(+), 24 deletions(-)
> 
> Index: linux-2.6/include/linux/moduleloader.h
> ===================================================================
> --- linux-2.6.orig/include/linux/moduleloader.h
> +++ linux-2.6/include/linux/moduleloader.h
> @@ -6,6 +6,26 @@
>  #include <linux/module.h>
>  #include <linux/elf.h>
>  
> +struct load_info {
> +	const char *name;
> +	/* pointer to module in temporary copy, freed at end of load_module() */
> +	struct module *mod;
> +	Elf_Ehdr *hdr;
> +	unsigned long len;
> +	Elf_Shdr *sechdrs;
> +	char *secstrings, *strtab;
> +	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
> +	struct _ddebug *debug;
> +	unsigned int num_debug;
> +	bool sig_ok;
> +#ifdef CONFIG_KALLSYMS
> +	unsigned long mod_kallsyms_init_off;
> +#endif
> +	struct {
> +		unsigned int sym, str, mod, vers, info, pcpu;
> +	} index;
> +};
> +
>  /* These may be implemented by architectures that need to hook into the
>   * module loader code.  Architectures that don't need to do anything special
>   * can just rely on the 'weak' default hooks defined in kernel/module.c.
> Index: linux-2.6/kernel/module-internal.h
> ===================================================================
> --- linux-2.6.orig/kernel/module-internal.h
> +++ linux-2.6/kernel/module-internal.h
> @@ -5,27 +5,4 @@
>   * Written by David Howells (dhowells@redhat.com)
>   */
>  
> -#include <linux/elf.h>
> -#include <asm/module.h>
> -
> -struct load_info {
> -	const char *name;
> -	/* pointer to module in temporary copy, freed at end of load_module() */
> -	struct module *mod;
> -	Elf_Ehdr *hdr;
> -	unsigned long len;
> -	Elf_Shdr *sechdrs;
> -	char *secstrings, *strtab;
> -	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
> -	struct _ddebug *debug;
> -	unsigned int num_debug;
> -	bool sig_ok;
> -#ifdef CONFIG_KALLSYMS
> -	unsigned long mod_kallsyms_init_off;
> -#endif
> -	struct {
> -		unsigned int sym, str, mod, vers, info, pcpu;
> -	} index;
> -};
> -
>  extern int mod_verify_sig(const void *mod, struct load_info *info);
> Index: linux-2.6/kernel/module_signing.c
> ===================================================================
> --- linux-2.6.orig/kernel/module_signing.c
> +++ linux-2.6/kernel/module_signing.c
> @@ -8,11 +8,11 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/module.h>
> +#include <linux/moduleloader.h>
>  #include <linux/module_signature.h>
>  #include <linux/string.h>
>  #include <linux/verification.h>
>  #include <crypto/public_key.h>
> -#include "module-internal.h"
>  
>  /*
>   * Verify the signature on a module.
> 
> 

-- 
Kees Cook
