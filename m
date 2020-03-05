Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B97BC3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AC320842
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="OjAl2rXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgCEA5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:57:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45640 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCEA5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:57:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id m15so1860066pgv.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 16:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=OiUuzvxK5Q7mHlyfvBqVa9jhnO0Phg0lZf/21N6Saw8=;
        b=OjAl2rXVakx7NgVrpUgJBjQT/9S0X99wn2XiR68XiTA7G1Wxu2BPNx7D34uppO8INK
         M45xO/LgXs4nyI1PjzcDd9i2UwsK+ylrd0Mg11Sps3TqeZaqe7zwshiVqa733M6M4qAY
         ZA7YBTLKX4597zTYlg/M5vJ9iHrYgpLtRMGHKvLPMcpG0xNzl5cZoVGp7SYWp33r/dlg
         jng0BcCzrZftLdzj/+4s8nihXUq6x8JFUnd7U33f4PWNqLtqvUWtfkCdvD6xBvPHDrK1
         6nqxVOq38GXMmBQHX7ang+6gurU1EzhT4P7kjJ/eYnq4mPYTuK1wH1UwQ8iMznFCCE9u
         BnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=OiUuzvxK5Q7mHlyfvBqVa9jhnO0Phg0lZf/21N6Saw8=;
        b=g6ElSiqkqS91rvpiEZToSQqJKfJ30fPo21MUqKGm0KBIfUjbhBwfVo9X4ZZyy8hjnd
         IKctdzHNsKj5U/6o3tuEDdpG5nfpn7DqwISmXuIzB0vkmND9y+fp9KBej7Jync31c89d
         hHJPP2G/GJqZq9X7F+Nz0hcgNYNIf8ChGjcED2X1qwzRK7JqBTV4SOfUoQiIjpZRGn8j
         +fbBv6zN8qGy42MYY39L71mGZ5TdwTisnbCd+EEFfNrMbe0so3tO0S1GMY5Ze6t6r5Gj
         bsGsqgwNJQRRWV3EPkSRuWjj5X36rZJDnWRmSQPKUr1vyTt9vMDk4KZ3Gjco2xw5d5pA
         xCSw==
X-Gm-Message-State: ANhLgQ0re05/3+lpOI5RLlmF0E6bfk6yXKhqRtVqBw/LodfHMlos4SKo
        7YlwNHL3XK0c5SqmHO7wBQ/xPA==
X-Google-Smtp-Source: ADFU+vsy/xn1SOslmWdL/8m6B0y854DKmshEJYcg4LmvwVJkeHKboyiu2oviing2FqUnCvjiXMinrw==
X-Received: by 2002:a63:6cc6:: with SMTP id h189mr4912134pgc.201.1583369863204;
        Wed, 04 Mar 2020 16:57:43 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id jx10sm3879391pjb.33.2020.03.04.16.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 16:57:42 -0800 (PST)
Date:   Wed, 04 Mar 2020 16:57:42 -0800 (PST)
X-Google-Original-Date: Wed, 04 Mar 2020 16:20:36 PST (-0800)
Subject:     Re: [PATCH 1/8] riscv: add ARCH_HAS_SET_MEMORY support
In-Reply-To: <20200217083223.2011-2-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-8d7dc998-025e-41ed-b869-6a439c6eda5f@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:32:16 PST (-0800), zong.li@sifive.com wrote:
> Add set_memory_ro/rw/x/nx architecture hooks to change the page
> attribution.
>
> Use own set_memory.h rather than generic set_memory.h
> (i.e. include/asm-generic/set_memory.h), because we want to add other
> function prototypes here.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/Kconfig                  |   1 +
>  arch/riscv/include/asm/set_memory.h |  17 ++++
>  arch/riscv/mm/Makefile              |   1 +
>  arch/riscv/mm/pageattr.c            | 150 ++++++++++++++++++++++++++++
>  4 files changed, 169 insertions(+)
>  create mode 100644 arch/riscv/include/asm/set_memory.h
>  create mode 100644 arch/riscv/mm/pageattr.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6e81da55b5e4..76ed36543b3a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -60,6 +60,7 @@ config RISCV
>  	select HAVE_EBPF_JIT if 64BIT
>  	select EDAC_SUPPORT
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_SET_MEMORY
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>  	select SPARSEMEM_STATIC if 32BIT
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> new file mode 100644
> index 000000000000..936f08063566
> --- /dev/null
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2019 SiFive
> + */
> +
> +#ifndef _ASM_RISCV_SET_MEMORY_H
> +#define _ASM_RISCV_SET_MEMORY_H
> +
> +/*
> + * Functions to change memory attributes.
> + */
> +int set_memory_ro(unsigned long addr, int numpages);
> +int set_memory_rw(unsigned long addr, int numpages);
> +int set_memory_x(unsigned long addr, int numpages);
> +int set_memory_nx(unsigned long addr, int numpages);
> +
> +#endif /* _ASM_RISCV_SET_MEMORY_H */
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 814e16a8d68a..b94643aee84c 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -10,6 +10,7 @@ obj-y += extable.o
>  obj-$(CONFIG_MMU) += fault.o
>  obj-y += cacheflush.o
>  obj-y += context.o
> +obj-y += pageattr.o
>
>  ifeq ($(CONFIG_MMU),y)
>  obj-$(CONFIG_SMP) += tlbflush.o
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> new file mode 100644
> index 000000000000..fcd59ef2835b
> --- /dev/null
> +++ b/arch/riscv/mm/pageattr.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2019 SiFive
> + */
> +
> +#include <linux/pagewalk.h>
> +#include <asm/pgtable.h>
> +#include <asm/tlbflush.h>
> +#include <asm/bitops.h>
> +
> +struct pageattr_masks {
> +	pgprot_t set_mask;
> +	pgprot_t clear_mask;
> +};
> +
> +static unsigned long set_pageattr_masks(unsigned long val, struct mm_walk *walk)
> +{
> +	struct pageattr_masks *masks = walk->private;
> +	unsigned long new_val = val;
> +
> +	new_val &= ~(pgprot_val(masks->clear_mask));
> +	new_val |= (pgprot_val(masks->set_mask));
> +
> +	return new_val;
> +}
> +
> +static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pgd_t val = READ_ONCE(*pgd);
> +
> +	if (pgd_leaf(val)) {
> +		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
> +		set_pgd(pgd, val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	p4d_t val = READ_ONCE(*p4d);
> +
> +	if (p4d_leaf(val)) {
> +		val = __p4d(set_pageattr_masks(p4d_val(val), walk));
> +		set_p4d(p4d, val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pud_t val = READ_ONCE(*pud);
> +
> +	if (pud_leaf(val)) {
> +		val = __pud(set_pageattr_masks(pud_val(val), walk));
> +		set_pud(pud, val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pmd_t val = READ_ONCE(*pmd);
> +
> +	if (pmd_leaf(val)) {
> +		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
> +		set_pmd(pmd, val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t val = READ_ONCE(*pte);
> +
> +	val = __pte(set_pageattr_masks(pte_val(val), walk));
> +	set_pte(pte, val);
> +
> +	return 0;
> +}
> +
> +static int pageattr_pte_hole(unsigned long addr, unsigned long next,
> +			     int depth, struct mm_walk *walk)
> +{
> +	/* Nothing to do here */
> +	return 0;
> +}
> +
> +const static struct mm_walk_ops pageattr_ops = {
> +	.pgd_entry = pageattr_pgd_entry,
> +	.p4d_entry = pageattr_p4d_entry,
> +	.pud_entry = pageattr_pud_entry,
> +	.pmd_entry = pageattr_pmd_entry,
> +	.pte_entry = pageattr_pte_entry,
> +	.pte_hole = pageattr_pte_hole,
> +};
> +
> +static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
> +			pgprot_t clear_mask)
> +{
> +	int ret;
> +	unsigned long start = addr;
> +	unsigned long end = start + PAGE_SIZE * numpages;
> +	struct pageattr_masks masks = {
> +		.set_mask = set_mask,
> +		.clear_mask = clear_mask
> +	};
> +
> +	if (!numpages)
> +		return 0;
> +
> +	down_read(&init_mm.mmap_sem);
> +	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
> +				     &masks);
> +	up_read(&init_mm.mmap_sem);

There are very few users of _novma, but I think it's correct here.

> +
> +	flush_tlb_kernel_range(start, end);
> +
> +	return ret;
> +}
> +
> +int set_memory_ro(unsigned long addr, int numpages)
> +{
> +	return __set_memory(addr, numpages, __pgprot(_PAGE_READ),
> +			    __pgprot(_PAGE_WRITE));
> +}
> +
> +int set_memory_rw(unsigned long addr, int numpages)
> +{
> +	return __set_memory(addr, numpages, __pgprot(_PAGE_READ | _PAGE_WRITE),
> +			    __pgprot(0));
> +}
> +
> +int set_memory_x(unsigned long addr, int numpages)
> +{
> +	return __set_memory(addr, numpages, __pgprot(_PAGE_EXEC), __pgprot(0));
> +}
> +
> +int set_memory_nx(unsigned long addr, int numpages)
> +{
> +	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
> +}

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
