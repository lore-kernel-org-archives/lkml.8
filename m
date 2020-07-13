Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B0DC433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD292070B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dzJcZTQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgGMCkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGMCkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:40:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D03EC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:40:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so5400500pgm.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jsRkdhqxS3NZSgX5ATVfGNLOv6qqnTr/cmm8NfBgbBE=;
        b=dzJcZTQoWMe2tmnqof+8OvU9bFh9EHwb5yqVnjcAUsuuC2oA3e/7ua+6nqKi2aZwk2
         RPTdokLpU/bejdGXn3l2GZyCyq250gZ2iNQ2Tjuv03asTariQZ1rZMu+7fDvZKTcoLfc
         KaJAQ2o0rHEAT06ffa3dzgaNPeIRCezF73HQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jsRkdhqxS3NZSgX5ATVfGNLOv6qqnTr/cmm8NfBgbBE=;
        b=uVy2jVcUk0o/yzdWPZI0dSDSsy0EE5ou8wpdoftEilihuFBfgCStZmbVtsAU8XNDBB
         NY1dsgQ5r+ofUMXIEmX61YWALE3ypFkcV7y1qNIAgsSCIL+IZFI+FtOE1go5XxqlZeWY
         65GfN9CQjUgsSqI5eDceRz7uyHWVZcRNHDwhgeek10cl+q9bdey1kJ+USWPq0wpnQgw6
         uwjSG4sHBY1tSRMELN2f6gLlE814ZdwfWMbknFDOCEGiH5ct6WY24m0kzEGRR4judzcU
         l7y15SEYZVxzY5WcWVZLEB56927wzuS+CWPy+k9CxgUKd3UlTVYRNOfblUuKaJSLxZdD
         0p2w==
X-Gm-Message-State: AOAM530q/b5SK6zm//tiErN8uiEp8U0Tk+9DnW/Q1nnGGe/RVvYWEtmv
        YzQ4YTJOobd9z5aJfJXYuCkHHw==
X-Google-Smtp-Source: ABdhPJyX+8sNQyWljdeceleZgJhFuJjzYvo/VS87Sp7fA08kQ5NiWlAeKhuViXcWtWotTPnuvfu4fQ==
X-Received: by 2002:aa7:8d02:: with SMTP id j2mr6926476pfe.90.1594607999067;
        Sun, 12 Jul 2020 19:39:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm13085278pfp.7.2020.07.12.19.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 19:39:58 -0700 (PDT)
Date:   Sun, 12 Jul 2020 19:39:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     guoren@kernel.org
Cc:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        bjorn.topel@gmail.com, atish.patra@wdc.com,
        cooper.qu@linux.alibaba.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH v3 2/2] riscv: Enable per-task stack canaries
Message-ID: <202007121939.07FB14D@keescook>
References: <1594397998-10221-1-git-send-email-guoren@kernel.org>
 <1594397998-10221-2-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594397998-10221-2-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 04:19:58PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> This enables the use of per-task stack canary values if GCC has
> support for emitting the stack canary reference relative to the
> value of tp, which holds the task struct pointer in the riscv
> kernel.
> 
> After compare arm64 and x86 implementations, seems arm64's is more
> flexible and readable. The key point is how gcc get the offset of
> stack_canary from gs/el0_sp.
> 
> x86: Use a fix offset from gs, not flexible.
> 
> struct fixed_percpu_data {
> 	/*
> 	 * GCC hardcodes the stack canary as %gs:40.  Since the
> 	 * irq_stack is the object at %gs:0, we reserve the bottom
> 	 * 48 bytes of the irq stack for the canary.
> 	 */
> 	char            gs_base[40]; // :(
> 	unsigned long   stack_canary;
> };
> 
> arm64: Use -mstack-protector-guard-offset & guard-reg
> 	gcc options:
> 	-mstack-protector-guard=sysreg
> 	-mstack-protector-guard-reg=sp_el0
> 	-mstack-protector-guard-offset=xxx
> 
> riscv: Use -mstack-protector-guard-offset & guard-reg
> 	gcc options:
> 	-mstack-protector-guard=tls
> 	-mstack-protector-guard-reg=tp
> 	-mstack-protector-guard-offset=xxx
> 
> Here is riscv gcc's work [1].
> 
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2020-July/549583.html
> 
> In the end, these codes are inserted by gcc before return:
> 
> *  0xffffffe00020b396 <+120>:   ld      a5,1008(tp) # 0x3f0
> *  0xffffffe00020b39a <+124>:   xor     a5,a5,a4
> *  0xffffffe00020b39c <+126>:   mv      a0,s5
> *  0xffffffe00020b39e <+128>:   bnez    a5,0xffffffe00020b61c <_do_fork+766>
>    0xffffffe00020b3a2 <+132>:   ld      ra,136(sp)
>    0xffffffe00020b3a4 <+134>:   ld      s0,128(sp)
>    0xffffffe00020b3a6 <+136>:   ld      s1,120(sp)
>    0xffffffe00020b3a8 <+138>:   ld      s2,112(sp)
>    0xffffffe00020b3aa <+140>:   ld      s3,104(sp)
>    0xffffffe00020b3ac <+142>:   ld      s4,96(sp)
>    0xffffffe00020b3ae <+144>:   ld      s5,88(sp)
>    0xffffffe00020b3b0 <+146>:   ld      s6,80(sp)
>    0xffffffe00020b3b2 <+148>:   ld      s7,72(sp)
>    0xffffffe00020b3b4 <+150>:   addi    sp,sp,144
>    0xffffffe00020b3b6 <+152>:   ret
>    ...
> *  0xffffffe00020b61c <+766>:   auipc   ra,0x7f8
> *  0xffffffe00020b620 <+770>:   jalr    -1764(ra) # 0xffffffe000a02f38 <__stack_chk_fail>
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: cooper <cooper.qu@linux.alibaba.com>
> Cc: cooper <cooper.qu@linux.alibaba.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
> Change v2:
>  - Change to -mstack-protector-guard=tls for gcc final define
>  - Solve compile error by changing position of KBUILD_CFLAGS in
>    Makefile
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/Kconfig                      |  7 +++++++
>  arch/riscv/Makefile                     | 10 ++++++++++
>  arch/riscv/include/asm/stackprotector.h |  3 ++-
>  arch/riscv/kernel/asm-offsets.c         |  3 +++
>  arch/riscv/kernel/process.c             |  2 +-
>  5 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4b0e308..d98ce29 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -394,6 +394,13 @@ config CMDLINE_FORCE
>  
>  endchoice
>  
> +config CC_HAVE_STACKPROTECTOR_TLS
> +	def_bool $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)
> +
> +config STACKPROTECTOR_PER_TASK
> +	def_bool y
> +	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
> +
>  endmenu
>  
>  config BUILTIN_DTB
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index fb6e37d..f5f8ee9 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -68,6 +68,16 @@ KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
>  # architectures.  It's faster to have GCC emit only aligned accesses.
>  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
>  
> +ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> +prepare: stack_protector_prepare
> +stack_protector_prepare: prepare0
> +	$(eval KBUILD_CFLAGS += -mstack-protector-guard=tls		  \
> +				-mstack-protector-guard-reg=tp		  \
> +				-mstack-protector-guard-offset=$(shell	  \
> +			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
> +					include/generated/asm-offsets.h))
> +endif
> +
>  # arch specific predefines for sparse
>  CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
>  
> diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/include/asm/stackprotector.h
> index d95f7b2..a895e07 100644
> --- a/arch/riscv/include/asm/stackprotector.h
> +++ b/arch/riscv/include/asm/stackprotector.h
> @@ -28,6 +28,7 @@ static __always_inline void boot_init_stack_canary(void)
>  	canary &= CANARY_MASK;
>  
>  	current->stack_canary = canary;
> -	__stack_chk_guard = current->stack_canary;
> +	if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
> +		__stack_chk_guard = current->stack_canary;
>  }
>  #endif /* _ASM_RISCV_STACKPROTECTOR_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index 07cb9c1..999b465 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -29,6 +29,9 @@ void asm_offsets(void)
>  	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
>  	OFFSET(TASK_THREAD_SP, task_struct, thread.sp);
>  	OFFSET(TASK_STACK, task_struct, stack);
> +#ifdef CONFIG_STACKPROTECTOR

Should this be CONFIG_STACKPROTECTOR_PER_TASK ?

> +	OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
> +#endif
>  	OFFSET(TASK_TI, task_struct, thread_info);
>  	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
>  	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 6548929..cb4ac65 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -24,7 +24,7 @@
>  
>  register unsigned long gp_in_global __asm__("gp");
>  
> -#ifdef CONFIG_STACKPROTECTOR
> +#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
>  #include <linux/stackprotector.h>
>  unsigned long __stack_chk_guard __read_mostly;
>  EXPORT_SYMBOL(__stack_chk_guard);
> -- 
> 2.7.4
> 

-- 
Kees Cook
