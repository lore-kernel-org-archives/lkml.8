Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D880FC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CE1206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD2HeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:34:16 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38954 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgD2HeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:34:15 -0400
Received: by mail-oi1-f196.google.com with SMTP id m10so971865oie.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 00:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyWquW6C3h9yYRPnL8ZX6mVqONgOMsOlS/nbLkzCvR8=;
        b=eIGPu6UV9Tbb+4TcvxcWa0Zp6/mfTk5mm2Z5UxNX7hIJr0nrwAIGwdMFfGKb9HFADs
         7Km/pe5z9Km01z5Uzm10FMg87h5D/9sBMxNkvtwKj+BVbE1R8J8yBCrYBycNoCeq4IlF
         YRYIm4Hvl1voRmQLkwKuX+R9lA7e+eZeFK0iG/xo3QMpSFmcjFfisBH5WeSJcXJ1BQI2
         FoQAnSeWimeflK4CpJe5eya1Si2Tx8Oc9Nd0AsQxLyPiFX6avDVuiHLNJLGPKES7avFt
         aWd0msyFizbivHXDTxpxrxxJTp+rn141Fhp9gzZYcMGfjzeNY0i0kyWkDbzDdAdMfrWR
         sXVw==
X-Gm-Message-State: AGi0PuYDnt8tZ0dPJ/0kJhHtP69Ab5NsPmoC9g8SzGZGaQB0Z7D/LJFo
        3BQR4OG8sAnlNUSs9FqUCMfw4SyYovewUMPyvPE=
X-Google-Smtp-Source: APiQypJAsZR6cJVnPhd52DhYQokiZWeX1PxL/6m2Vvtp1dgHuL2QQU2M5utJVEIEaKuPsXF6mplj99rnUrUZngmlKtw=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr810760oig.54.1588145654121;
 Wed, 29 Apr 2020 00:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200428194449.22615-1-willy@infradead.org> <20200428194449.22615-3-willy@infradead.org>
In-Reply-To: <20200428194449.22615-3-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Apr 2020 09:34:02 +0200
Message-ID: <CAMuHMdUw38VD8WJe5Zbaudnee74ZgLwbfhRwU8Pi9ALitre+_Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm: Move pt_mm within struct page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Tue, Apr 28, 2020 at 9:44 PM Matthew Wilcox <willy@infradead.org> wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Instead of a per-arch word within struct page, use a formerly reserved
> word.  This word is shared with page->mapping, so it must be cleared
> before being freed as it is checked in free_pages().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks for your patch!

> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -149,11 +149,8 @@ struct page {
>                                         pgtable_t pmd_huge_pte;
>                                 };
>                         };
> -                       unsigned long _pt_pad_2;        /* mapping */
> -                       union {
> -                               struct mm_struct *pt_mm; /* x86 pgds only */
> -                               atomic_t pt_frag_refcount; /* powerpc */
> -                       };
> +                       struct mm_struct *pt_mm;
> +                       atomic_t pt_frag_refcount; /* powerpc */

So here is now an implicit hole on 64-bit platforms, right?
Do we have any where alignof(long) != 8?

>  #if ALLOC_SPLIT_PTLOCKS
>                         spinlock_t *ptl;
>  #else

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
