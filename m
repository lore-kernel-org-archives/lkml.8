Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFCCC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E116620838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGK65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:58:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34338 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBGK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:58:56 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so1586068oig.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 02:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlWmAKNVj5dvuafMqzMVgnMvFP7XXln5tSxgE2a8QTA=;
        b=X4sXAWIlGiB7R96xUD598eggTEqLQtxHolJiJOA84oGymg3li6fRhdVJGoTzcnqQ8a
         kbep1cOPRx7QwW/EgHsy7OMaDfFYNoNIdSNr0GLKLi/1y8QFoBaSUw6gKj9CVYhDifmv
         FL3lbHUuVGNoeTN9Nnl0VR1uGCZ5T53gIuYB8Qivys/rjaUTC9xpXWIWuV2twtbefsQo
         vxz1aqLveY49GGqX92TkQHDEOdEhr+5dpLEd+/K/6WNWc1ZY2PHLE8tYFFfXlAql05vU
         Luq7xep+ip6HiuBnn0Kpj5p7WiiCGNRaMejh00x0C7SMcUxwSplymp22iUj1+wcshjRo
         d8jQ==
X-Gm-Message-State: APjAAAUZr0Op4HuRddbxagZfgaOyQyULG21eWLADzmssjnwPKNeRdm/j
        fSoIpfG7ys7fgMM0BVc2aTwFu0Q1fXVVo8mjv8o=
X-Google-Smtp-Source: APXvYqw314+cwlH3iHyW2XWK9TYYfJ+GcZAJnc1R38slc6frr4UWK+8kpOFhkF35Ez/ZDEfz7vki8eTJf9/YOKQ3c3U=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr1728279oia.102.1581073136290;
 Fri, 07 Feb 2020 02:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20200131124531.623136425@infradead.org> <20200131125403.938797587@infradead.org>
In-Reply-To: <20200131125403.938797587@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Feb 2020 11:58:42 +0100
Message-ID: <CAMuHMdUxwz4X+SYCCWCMNAw2nNTMUXWPWrxJ+X9mYC_tirvN=A@mail.gmail.com>
Subject: Re: [PATCH -v2 09/10] m68k,mm: Fully initialize the page-table allocator
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi Peter,

Thanks for your patch!

On Fri, Jan 31, 2020 at 1:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Also iterate the PMD tables to populate the PTE table allocator. This
> also fully replaces the previous zero_pgtable hack.

As no code is being removed in this patch, does this mean this case was
broken since "[PATCH 06/10] m68k,mm: Improve kernel_page_table()"?

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/m68k/mm/init.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> --- a/arch/m68k/mm/init.c
> +++ b/arch/m68k/mm/init.c
> @@ -120,7 +120,7 @@ void free_initmem(void)
>  static inline void init_pointer_tables(void)
>  {
>  #if defined(CONFIG_MMU) && !defined(CONFIG_SUN3) && !defined(CONFIG_COLDFIRE)
> -       int i;
> +       int i, j;
>
>         /* insert pointer tables allocated so far into the tablelist */
>         init_pointer_table(kernel_pg_dir, TABLE_PGD);
> @@ -133,6 +133,17 @@ static inline void init_pointer_tables(v
>
>                 pmd_dir = (pmd_t *)pgd_page_vaddr(kernel_pg_dir[i]);
>                 init_pointer_table(pmd_dir, TABLE_PMD);
> +
> +               for (j = 0; j < PTRS_PER_PMD; j++) {
> +                       pmd_t *pmd = &pmd_dir[j];
> +                       pte_t *pte_dir;
> +
> +                       if (!pmd_present(*pmd))
> +                               continue;
> +
> +                       pte_dir = (pte_t *)__pmd_page(*pmd);
> +                       init_pointer_table(pte_dir, TABLE_PTE);
> +               }
>         }
>  #endif
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
