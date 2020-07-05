Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10FD20771
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ne2z+qSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgGEGxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEGxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:53:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1DC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 23:53:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so16954147pgk.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 23:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JvxcxMFQ+z/Z7/gkNAcYGUESMgFtHoka8cWR54DipYU=;
        b=Ne2z+qSHN+80RznDWRHc3AjAM2UPBtKQ9brbR1UrCmVSBFo0g+1y5TkhmDMzKmSgZP
         krA9nidCVFf8RpV/grAEtQ9tCrQ+JXhoqMs4C4vp2HruBK/0sSbtoEDTHPNQ99KR+hTG
         eln1fokzVe6vlHGpnsZ9cLvFXydX94tVBLzag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JvxcxMFQ+z/Z7/gkNAcYGUESMgFtHoka8cWR54DipYU=;
        b=DARu1KJEc5hS3PhM9BayuV+ejhFvF7J1nT/PxRYounlaAhOgmoPKWfPGSJYG4Ccyx9
         DwTdExxZWnBCsCcogq1npYqXCwbsdJNM4u5FEMF28QaoD2GtJdetOcg6ehaMzL78+MRZ
         lgWjedlA4/dkEikskAPsJwty4S6Ot6OJBkW79Oc4ZAWRuCDjW8PI4dXr80W2U6ep6Hdl
         L0oGNSZ/VRW3zpvIZL4hJZ9zkLSW+j4+yB4yRAnWSCIFNNrKJ6apsEBNfsHDZW6xkQVx
         own6N9z3HNMBV8/yreJKZdGSZDJPe0tv63AIGyePbwXyJrsgPj4gIm/KUjjJpCGvGZvR
         HokA==
X-Gm-Message-State: AOAM531MQRPXwFipEZ550Mx3G63lnwjcTT/wdPdIUNe+Lhywjye7H4Di
        guKgbuydHptSZmqp3kt2taC3rw==
X-Google-Smtp-Source: ABdhPJwY40cIqTQ8xrh1JWHjeKJiAehtBExz5u9w1b1MIL0amDYYhj6tELrp+Ty0FGCVT9meMhYHaQ==
X-Received: by 2002:a63:725c:: with SMTP id c28mr34562369pgn.156.1593932027330;
        Sat, 04 Jul 2020 23:53:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j8sm16594574pfd.145.2020.07.04.23.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 23:53:46 -0700 (PDT)
Date:   Sat, 4 Jul 2020 23:53:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     guoren@kernel.org
Cc:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        Greentime Hu <green.hu@gmail.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH] riscv: Add STACKPROTECTOR supported
Message-ID: <202007042350.4C153C4F8@keescook>
References: <1593930255-12378-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1593930255-12378-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 06:24:15AM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The -fstack-protector & -fstack-protector-strong features are from
> gcc. The patch only add basic kernel support to stack-protector
> feature and some arch could have its own solution such as
> ARM64_PTR_AUTH.
> 
> After enabling STACKPROTECTOR and STACKPROTECTOR_STRONG, the .text
> size is expanded from  0x7de066 to 0x81fb32 (only 5%) to add canary
> checking code.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Björn Töpel <bjorn.topel@gmail.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig                      |  1 +
>  arch/riscv/include/asm/stackprotector.h | 29 +++++++++++++++++++++++++++++
>  arch/riscv/kernel/process.c             |  6 ++++++
>  3 files changed, 36 insertions(+)
>  create mode 100644 arch/riscv/include/asm/stackprotector.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f927a91..4b0e308 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -63,6 +63,7 @@ config RISCV
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> +	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select IRQ_DOMAIN
>  	select MODULES_USE_ELF_RELA if MODULES
> diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/include/asm/stackprotector.h
> new file mode 100644
> index 00000000..5962f88
> --- /dev/null
> +++ b/arch/riscv/include/asm/stackprotector.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_RISCV_STACKPROTECTOR_H
> +#define _ASM_RISCV_STACKPROTECTOR_H
> +
> +#include <linux/random.h>
> +#include <linux/version.h>
> +
> +extern unsigned long __stack_chk_guard;
> +
> +/*
> + * Initialize the stackprotector canary value.
> + *
> + * NOTE: this must only be called from functions that never return,
> + * and it must always be inlined.
> + */
> +static __always_inline void boot_init_stack_canary(void)
> +{
> +	unsigned long canary;
> +
> +	/* Try to get a semi random initial value. */
> +	get_random_bytes(&canary, sizeof(canary));
> +	canary ^= LINUX_VERSION_CODE;
> +	canary &= CANARY_MASK;

Does riscv have any kind of instruction counters or other trivial timers
that could be mixed in here? (e.g. x86's TSC)

> +
> +	current->stack_canary = canary;
> +	__stack_chk_guard = current->stack_canary;

What's needed for riscv to support a per-task canary? (e.g. x86's TLS or
arm64's register-specific methods)

> +}
> +#endif /* _ASM_RISCV_STACKPROTECTOR_H */
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 824d117..6548929 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -24,6 +24,12 @@
>  
>  register unsigned long gp_in_global __asm__("gp");
>  
> +#ifdef CONFIG_STACKPROTECTOR
> +#include <linux/stackprotector.h>
> +unsigned long __stack_chk_guard __read_mostly;
> +EXPORT_SYMBOL(__stack_chk_guard);
> +#endif
> +
>  extern asmlinkage void ret_from_fork(void);
>  extern asmlinkage void ret_from_kernel_thread(void);
>  
> -- 
> 2.7.4
> 

But yes, as a starting point, better to have a single per-boot global
canary than none at all. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
