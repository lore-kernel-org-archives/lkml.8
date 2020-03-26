Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBCCC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA8120719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="GtxD/Ymy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCZGLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:11:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39286 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCZGLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:11:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id a9so5656499wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVoY4lXNG7Gme6In75qZRg7QM7A7s34V74dfLUTDGcs=;
        b=GtxD/Ymy4a3u/qavJ6N3vSmF7WFooVCXwwer/gGsgIPEbvwmYrmqd0jJOeFyK52yIp
         RYQQ9dWaTIwuPTjfLV5Aa576UprjHLL0LCIF11YkWNScM9z+iMHBYJkKJqBM1xWVoaka
         Z/t8ltbj3yaMwq6HuMCBhzhpEMcccMnSneBQe0EnsRUPOW556BNfnl0HKyU/I8RP/kwr
         +/1ONxRdmVeD9Kq8veipry4nQ7tVTGcZdndYVOmXtprTTjQnruexgiFBFI3KSOJ4laCa
         TTD0ceety+MZBlbTIRbyFEQ/+RkliIqQyGJ2h+LrK03xlt55jWZySMS9CbQevndt12w0
         PiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVoY4lXNG7Gme6In75qZRg7QM7A7s34V74dfLUTDGcs=;
        b=tENNAWVG/neGPxbCVgK3Dpole9YqIGL27gBbB4AYk+p1nRldOUPm15qMx7LOKdQyWW
         GP9uwoscWaPcDCUQR43EKACIJi+OahtfP1zDjljYUe5pRW0lANhjsQK5h8oGBuK57qA/
         TzOkBgSZo/8p1c4ggx8CzrS27yGomA9Bzj8cMPsBAPmao34ieaixHopnDsa0MXEQT3Sb
         62XZW6zMYXW7+ri0k2x8lWB/11qM91cnI53DWpGojE1etrCub+yEvhh9nKd/zSxqaQsm
         lK3yczG6QIWnI4kHmaHuD/Uuyl49x7TRnxz6gvKN8plbkvGf0rmrgmnNP7KdX6RPTjlc
         T9ag==
X-Gm-Message-State: ANhLgQ3QuZsvli/oqysSPpg9R1XeqvJtpLrGpZpsKwl6A+bkEPbiKLTr
        pyPRTzioYJFlaflBnr3SkcEIWodRHEXV07T6/b9n/A==
X-Google-Smtp-Source: ADFU+vsqhAlYdX+RsBSOloOfGm9U+XspxBQnGbxpbbZtXLQIswfFSd9oqt4deDJoTKHdqXuonoUnouk920iaT6bCSFA=
X-Received: by 2002:a1c:6385:: with SMTP id x127mr1306256wmb.141.1585203069267;
 Wed, 25 Mar 2020 23:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200322110028.18279-1-alex@ghiti.fr> <20200322110028.18279-2-alex@ghiti.fr>
In-Reply-To: <20200322110028.18279-2-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 26 Mar 2020 11:40:56 +0530
Message-ID: <CAAhSdy2OJp244wpgjxiY1ViYCnsMBmT3XA79X+D21fVTWZRhPA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 4:31 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> There is no need to compare at compile time MAX_EARLY_MAPPING_SIZE value
> with PGDIR_SIZE since MAX_EARLY_MAPPING_SIZE is set to 128MB which is less
> than PGDIR_SIZE that is equal to 1GB: that allows to simplify early_pmd
> definition.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/init.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 238bd0033c3f..18bbb426848e 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -247,13 +247,7 @@ static void __init create_pte_mapping(pte_t *ptep,
>
>  pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
> -
> -#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
> -#define NUM_EARLY_PMDS         1UL
> -#else
> -#define NUM_EARLY_PMDS         (1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
> -#endif
> -pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> +pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>
>  static pmd_t *__init get_pmd_virt(phys_addr_t pa)
>  {
> @@ -267,14 +261,12 @@ static pmd_t *__init get_pmd_virt(phys_addr_t pa)
>
>  static phys_addr_t __init alloc_pmd(uintptr_t va)
>  {
> -       uintptr_t pmd_num;
> -
>         if (mmu_enabled)
>                 return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>
> -       pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
> -       BUG_ON(pmd_num >= NUM_EARLY_PMDS);
> -       return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
> +       BUG_ON((va - PAGE_OFFSET) >> PGDIR_SHIFT);
> +
> +       return (uintptr_t)early_pmd;
>  }
>
>  static void __init create_pmd_mapping(pmd_t *pmdp,
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
