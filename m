Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D20BC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF4121569
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AcSbf+qL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAVVKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:10:45 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39327 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVVKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:10:44 -0500
Received: by mail-pj1-f67.google.com with SMTP id e11so124772pjt.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 13:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=ZZ5b/mbw3dSCyUguJZVK2QM63WHkMGA0/u35MRIw+xo=;
        b=AcSbf+qLCffvaX4kcM1u5cVFg+cBUsitPXNatz5Wa6KDwXvW7JR5WCRlauiNarwGB7
         X/H8QHOJgkc0KBiefkxrqD2Wae1KQFGYDmWaNUVMZv92Mih36aGxQa6uab1nBj1zrWUQ
         +UpXKEJYfYlMZNOP5fe3TrnGtTh0PkfKZ6BbKsSaZebpAkpA0f9TbN81pW1ljDXTpDRc
         slhSxDKxsLwHJUnzxJy3UZ5FiEteukbKEGck4ekSTbTc6zQvPDqJDKciMZvX4V2Xm0nI
         H9jDW8YteqOIPm5qeEkt72/Z6li3gKjBa2pXWEOG0Uk8u/SnR8vAIdKJF5xYwgc0u1CY
         92bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=ZZ5b/mbw3dSCyUguJZVK2QM63WHkMGA0/u35MRIw+xo=;
        b=ZAjCj4ZJPRlQViZRuI3js309LQ9Q6aHQ8HZg6FGtE5VlDqF17WLv6rF5ygWVhbyvTb
         iXw9ZpLmXTVpmGMa/mvhEmBNykxG139I6/vV7vxf8DvrcIIf+M/Ij6+RW0CGz9f25kwh
         CkaaWS1SxBqIs9mlQgdjI46oxbpx30+oEI0FZavlZSmwDUsX/pwZAuX6i1TccaopmLHJ
         dMSnxHSLxnqxrxxSxXuAqNrMIUsfc70rkMt6Cy6yCgdFmLDC8nQ4PTBqa8xub/6Tw38V
         JC3xmQR4EAbfmYMqf4VtesJH0oc42bjsLJk2xrHqrHjm5YOkP2YSYNvLEFdRkK7er5Y0
         vLvg==
X-Gm-Message-State: APjAAAWU8LMkOgkIYn0+iL8l+pGr2hHMzB8Qb82CtIyfoHRMu6shWzhk
        kqn/m6k4PKeOI3lmzGQNdubg+w==
X-Google-Smtp-Source: APXvYqyiMjJjx4+M2c+l5PuDg1Zs6KN09ZjpVrB0NHD80xS86SqEekFcZ2I63XFxierDqP2vpSymDQ==
X-Received: by 2002:a17:902:b087:: with SMTP id p7mr13443167plr.10.1579727443858;
        Wed, 22 Jan 2020 13:10:43 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id v4sm47906316pfn.181.2020.01.22.13.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 13:10:43 -0800 (PST)
Date:   Wed, 22 Jan 2020 13:10:43 -0800 (PST)
X-Google-Original-Date: Wed, 22 Jan 2020 13:07:04 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH 1/2] riscv: mm: add support for CONFIG_DEBUG_VIRTUAL
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
To:     zong.li@sifive.com
In-Reply-To: <20200102031240.44484-2-zong.li@sifive.com>
References: <20200102031240.44484-2-zong.li@sifive.com>
  <20200102031240.44484-1-zong.li@sifive.com>
Message-ID: <mhng-417aaf14-a772-4b99-b9cc-71ab1608d28a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jan 2020 19:12:39 PST (-0800), zong.li@sifive.com wrote:
> This patch implements CONFIG_DEBUG_VIRTUAL to do additional checks on
> virt_to_phys and __pa_symbol calls. virt_to_phys used for linear mapping
> check, and __pa_symbol used for kernel symbol check. In current RISC-V,
> kernel image maps to linear mapping area. If CONFIG_DEBUG_VIRTUAL is
> disable, these two functions calculate the offset on the address feded
> directly without any checks.
>
> The result of test_debug_virtual as follows:
>
> [    0.358456] ------------[ cut here ]------------
> [    0.358738] virt_to_phys used for non-linear address: (____ptrval____) (0xffffffd000000000)
> [    0.359174] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/physaddr.c:16 __virt_to_phys+0x3c/0x50
> [    0.359409] Modules linked in:
> [    0.359630] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc3-00002-g5133c5c0ca13 #57
> [    0.359861] epc: ffffffe000253d1a ra : ffffffe000253d1a sp : ffffffe03aa87da0
> [    0.360019]  gp : ffffffe000ae03b0 tp : ffffffe03aa88000 t0 : ffffffe000af2660
> [    0.360175]  t1 : 0000000000000064 t2 : 00000000000000b7 s0 : ffffffe03aa87dc0
> [    0.360330]  s1 : ffffffd000000000 a0 : 000000000000004f a1 : 0000000000000000
> [    0.360492]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffe000a84358
> [    0.360672]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
> [    0.360876]  s2 : ffffffe000ae0600 s3 : ffffffe00000fc7c s4 : ffffffe0000224b0
> [    0.361067]  s5 : ffffffe000030890 s6 : ffffffe000022470 s7 : 0000000000000008
> [    0.361267]  s8 : ffffffe0000002c4 s9 : ffffffe000ae0640 s10: ffffffe000ae0630
> [    0.361453]  s11: 0000000000000000 t3 : 0000000000000000 t4 : 000000000001e6d0
> [    0.361636]  t5 : ffffffe000ae0a18 t6 : ffffffe000aee54e
> [    0.361806] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
> [    0.362056] ---[ end trace aec0bf78d4978122 ]---
> [    0.362404] PA: 0xfffffff080200000 for VA: 0xffffffd000000000
> [    0.362607] PA: 0x00000000baddd2d0 for VA: 0xffffffe03abdd2d0
>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Thanks.  Looks like patch 2 landed in Linus' tree as part of 5.5, but this one
didn't.  I've taken it on to for-next.

> ---
>  arch/riscv/Kconfig            |  1 +
>  arch/riscv/include/asm/page.h | 16 +++++++++++++--
>  arch/riscv/mm/Makefile        |  2 ++
>  arch/riscv/mm/physaddr.c      | 37 +++++++++++++++++++++++++++++++++++
>  4 files changed, 54 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/mm/physaddr.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d8efbaa78d67..7f268816be5b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -57,6 +57,7 @@ config RISCV
>  	select GENERIC_ARCH_TOPOLOGY if SMP
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_MMIOWB
> +	select ARCH_HAS_DEBUG_VIRTUAL
>  	select HAVE_EBPF_JIT if 64BIT
>  	select EDAC_SUPPORT
>  	select ARCH_HAS_GIGANTIC_PAGE
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index ac699246ae7e..8ca1930caa44 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -100,8 +100,20 @@ extern unsigned long pfn_base;
>  extern unsigned long max_low_pfn;
>  extern unsigned long min_low_pfn;
>
> -#define __pa(x)		((unsigned long)(x) - va_pa_offset)
> -#define __va(x)		((void *)((unsigned long) (x) + va_pa_offset))
> +#define __pa_to_va_nodebug(x)	((void *)((unsigned long) (x) + va_pa_offset))
> +#define __va_to_pa_nodebug(x)	((unsigned long)(x) - va_pa_offset)
> +
> +#ifdef CONFIG_DEBUG_VIRTUAL
> +extern phys_addr_t __virt_to_phys(unsigned long x);
> +extern phys_addr_t __phys_addr_symbol(unsigned long x);
> +#else
> +#define __virt_to_phys(x)	__va_to_pa_nodebug(x)
> +#define __phys_addr_symbol(x)	__va_to_pa_nodebug(x)
> +#endif /* CONFIG_DEBUG_VIRTUAL */
> +
> +#define __pa_symbol(x)	__phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
> +#define __pa(x)		__virt_to_phys((unsigned long)(x))
> +#define __va(x)		((void *)__pa_to_va_nodebug((phys_addr_t)(x)))
>
>  #define phys_to_pfn(phys)	(PFN_DOWN(phys))
>  #define pfn_to_phys(pfn)	(PFN_PHYS(pfn))
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index a1bd95c8047a..7de157ecfb77 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -15,3 +15,5 @@ ifeq ($(CONFIG_MMU),y)
>  obj-$(CONFIG_SMP) += tlbflush.o
>  endif
>  obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
> +
> +obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
> new file mode 100644
> index 000000000000..e8e4dcd39fed
> --- /dev/null
> +++ b/arch/riscv/mm/physaddr.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/types.h>
> +#include <linux/mmdebug.h>
> +#include <linux/mm.h>
> +#include <asm/page.h>
> +#include <asm/sections.h>
> +
> +phys_addr_t __virt_to_phys(unsigned long x)
> +{
> +	phys_addr_t y = x - PAGE_OFFSET;
> +
> +	/*
> +	 * Boundary checking aginst the kernel linear mapping space.
> +	 */
> +	WARN(y >= KERN_VIRT_SIZE,
> +	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
> +	     (void *)x, (void *)x);
> +
> +	return __va_to_pa_nodebug(x);
> +}
> +EXPORT_SYMBOL(__virt_to_phys);
> +
> +phys_addr_t __phys_addr_symbol(unsigned long x)
> +{
> +	unsigned long kernel_start = (unsigned long)PAGE_OFFSET;
> +	unsigned long kernel_end = (unsigned long)_end;
> +
> +	/*
> +	 * Boundary checking aginst the kernel image mapping.
> +	 * __pa_symbol should only be used on kernel symbol addresses.
> +	 */
> +	VIRTUAL_BUG_ON(x < kernel_start || x > kernel_end);
> +
> +	return __va_to_pa_nodebug(x);
> +}
> +EXPORT_SYMBOL(__phys_addr_symbol);
