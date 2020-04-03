Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DEDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA535206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="madpdA2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgDCQDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:03:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43225 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:03:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id f206so3663676pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=DTKHsm8Q5bJhu3UTT4PCRZaQwVAbDrF/ulx8WyttahM=;
        b=madpdA2IZsdgOJo7MhH9aIn36WnyTvf608VJNjKU4iQQnucZhT80EAfp8b5iaHLY33
         LSYMLiu30MGYQ2eY6huT6/vbDK2QXwsRGx2IDE0vfuf628W+WPHsUFyRcOyxzWNEkEb/
         cKNLyPO2tHnPFQ0gvQ+EAz+FeGw8lYU4LyeH9kS2XjJgi6fCfhK4gNYNoniPuc2Z9o61
         UmT0irwwMz67xe5HPJeTVth2tZl5jbMI/1MSsKLPl+NPmIckAnS1WRuMKKI333Y2bOMM
         sLiczLpvNYRE+J+kFgg7/AnUK+ylht12j4YFpVxc/15pFgZll6Mpx1TnmpQYNwhU2puc
         Tf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=DTKHsm8Q5bJhu3UTT4PCRZaQwVAbDrF/ulx8WyttahM=;
        b=RWUMDGMOrKRVf0HDml3Bb/FBOfD6UwAgfGq1S1vqBcTmpoxhdGr/1fTzpclRMzInRI
         TxRjv8VFPV+DMAiRgBu9j+80RzD5SuKaaXk3R9aF8UkOiWfHVsPAYQJecmi4T5iEYa7a
         Gjg9OySsOBugJ6XUzqvr0TmWB4OpJ6IfNYfa3+iTce5oGj1JTwbbleWlD20qh4+THDL9
         GnfTXr1ukk/z+phSsOvKiCUOBT67wpXq680+xhsCoANtwouMwT0owVzhvmRneLvTqtNY
         0SYHBOW3VwTkzcGDHLy72Zcfaw0HhIs3pZP7NruhpQvzgb/7oU8tJbcv181BIFzu0gYV
         0QSQ==
X-Gm-Message-State: AGi0PuY/Nb9lPlU7Uz1utHh+6aVldtxYaewaDGsRznriqAZK/a1xHWdH
        bLn0E6MhD5jGge1ibLbAyp2cGQ==
X-Google-Smtp-Source: APiQypLwNtCv00HA9e0S6QvIOb3nB6LJV0niSjYaoe896vIwkyMM8yAXAWSWnXGBB9z28MtkIAFODQ==
X-Received: by 2002:a65:5a87:: with SMTP id c7mr8682833pgt.237.1585929812310;
        Fri, 03 Apr 2020 09:03:32 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l9sm4212358pff.16.2020.04.03.09.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:03:31 -0700 (PDT)
Date:   Fri, 03 Apr 2020 09:03:31 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Apr 2020 09:03:23 PDT (-0700)
Subject:     Re: [PATCH] riscv: mm: synchronize MMU after page table update
In-Reply-To: <20200324054945.26733-1-nickhu@andestech.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        guoren@kernel.org, akpm@linux-foundation.org, rppt@linux.ibm.com,
        nickhu@andestech.com, mark.rutland@arm.com, nylon7@andestech.com,
        alankao@andestech.com, alexios.zavras@intel.com,
        tglx@linutronix.de, npiggin@gmail.com, anup@brainfault.org,
        zong.li@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nickhu@andestech.com
Message-ID: <mhng-3d02c4a1-effd-4074-a3e0-de38c04ec8d7@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Mar 2020 22:49:45 PDT (-0700), nickhu@andestech.com wrote:
> Similar to commit bf587caae305 ("riscv: mm: synchronize MMU after pte change")
>
> For those riscv implementations whose TLB cannot synchronize with dcache,
> an SFENCE.VMA is necessary after page table update.
> This patch fixed two functions:
>
> 1. pgd_alloc
> During fork, a parent process prepares pgd for its child and updates satp
> later, but they may not run on the same core. Adding a remote SFENCE.VMA to
> invalidate TLB in other cores is needed. Thus use flush_tlb_all() instead
> of local_flush_tlb_all() here.
> Similar approaches can be found in arm and csky.
>
> 2. __set_fixmap
> Add a SFENCE.VMA after fixmap pte update.
> Similar approaches can be found in arm and sh.
>
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> Signed-off-by: Nylon Chen <nylon7@andestech.com>
> Cc: Alan Kao <alankao@andestech.com>
> ---
>  arch/riscv/include/asm/pgalloc.h | 1 +
>  arch/riscv/mm/init.c             | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index 3f601ee8233f..071468fa14b7 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -51,6 +51,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  		memcpy(pgd + USER_PTRS_PER_PGD,
>  			init_mm.pgd + USER_PTRS_PER_PGD,
>  			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> +		flush_tlb_all();
>  	}
>  	return pgd;
>  }
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fab855963c73..a7f329503ed0 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -203,8 +203,8 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>  		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
>  	} else {
>  		pte_clear(&init_mm, addr, ptep);
> -		local_flush_tlb_page(addr);
>  	}
> +	local_flush_tlb_page(addr);
>  }
>
>  static pte_t *__init get_pte_virt(phys_addr_t pa)

As a general rule, any fences are supposed to have a comment describing why
they're there.  The generic fences will be caught by checkpatch, but I don't
remember if these are.
