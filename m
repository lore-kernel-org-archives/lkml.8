Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B8EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F212177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CeVpMLF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgHGJw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:52:26 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:50481 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgHGJwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:52:25 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5f638ce4
        for <linux-kernel@vger.kernel.org>;
        Fri, 7 Aug 2020 09:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=jHXcrZ97Q570/AtX6P6IATl6PTE=; b=CeVpML
        F5oWN3sLB1ftZhe6CaCcV2VNLGaYjGtfXqpWsgctvZT5ior0c32UebT0MqPhSVA/
        tkH0clSjumgfwAYVpFZ81CGp7Brbw15eS7hcpxumFQRSM6Fp/lHcPX/r+nvdWjet
        D+ufvGl6laMTd1oXWhwI/7aXn3efSUe3not7JO/TP0yGiepoVr+q7zIeq0urHYz9
        yizLhxK+Vri+wBVj95hv2lDSPiJFH3OLGc91gbw+2PlzjgDyS3/aAdNw8bggMCqn
        1sVVa2VSgkrLwYudMwMPfEgWdSlDf413Y0UH04VvwetBUW4qeFWYw12Mo5FuBANW
        tJZr/IIMfXOuOpuQ==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 33151408 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 7 Aug 2020 09:27:39 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id k23so1286268iom.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:52:22 -0700 (PDT)
X-Gm-Message-State: AOAM5307bI7/Y40panEPkSx4l54GJEsenOEMyswLxLEMWbJlXsex1PKu
        a6fQ9ymLh8eTofi8yY5OF23q6KETDKsgWUQ0PV8=
X-Google-Smtp-Source: ABdhPJy3V605feOT5+5TKU4+CnasPliUWlXHkez8VK4HT0wXUw6hLsGToFNAT8a41z5LvKF1Xc3/kk6y7A7LqQl/erk=
X-Received: by 2002:a05:6638:250f:: with SMTP id v15mr3907264jat.75.1596793941897;
 Fri, 07 Aug 2020 02:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200807084013.7090-1-joro@8bytes.org>
In-Reply-To: <20200807084013.7090-1-joro@8bytes.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 7 Aug 2020 11:52:09 +0200
X-Gmail-Original-Message-ID: <CAHmME9rPfsMJ_btZecWrJN=R6FqAFmjDzCC_tMGk01+R6gJAPw@mail.gmail.com>
Message-ID: <CAHmME9rPfsMJ_btZecWrJN=R6FqAFmjDzCC_tMGk01+R6gJAPw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/64: Do not dereference non-present PGD entries
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 10:40 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> The code for preallocate_vmalloc_pages() was written under the
> assumption that the p4d_offset() and pud_offset() functions will perform
> present checks before dereferencing the parent entries.
>
> This assumption is wrong an leads to a bug in the code which causes the
> physical address found in the PGD be used as a page-table page, even if
> the PGD is not present.
>
> So the code flow currently is:
>
>         pgd = pgd_offset_k(addr);
>         p4d = p4d_offset(pgd, addr);
>         if (p4d_none(*p4d))
>                 p4d = p4d_alloc(&init_mm, pgd, addr);
>
> This lacks a check for pgd_none() at least, the correct flow would be:
>
>         pgd = pgd_offset_k(addr);
>         if (pgd_none(*pgd))
>                 p4d = p4d_alloc(&init_mm, pgd, addr);
>         else
>                 p4d = p4d_offset(pgd, addr);
>
> But this is the same flow that the p4d_alloc() and the pud_alloc()
> functions use internally, so there is no need to duplicate them.
>
> Remove the p?d_none() checks from the function and just call into
> p4d_alloc() and pud_alloc() to correctly pre-allocate the PGD entries.
>
> Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for vmalloc area")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/mm/init_64.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 3f4e29a78f2b..449e071240e1 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1253,28 +1253,23 @@ static void __init preallocate_vmalloc_pages(void)
>                 p4d_t *p4d;
>                 pud_t *pud;
>
> -               p4d = p4d_offset(pgd, addr);
> -               if (p4d_none(*p4d)) {
> -                       /* Can only happen with 5-level paging */
> -                       p4d = p4d_alloc(&init_mm, pgd, addr);
> -                       if (!p4d) {
> -                               lvl = "p4d";
> -                               goto failed;
> -                       }
> -               }
> +               lvl = "p4d";
> +               p4d = p4d_alloc(&init_mm, pgd, addr);
> +               if (!p4d)
> +                       goto failed;
>
> +               /*
> +                * With 5-level paging the P4D level is not folded. So the PGDs
> +                * are now populated and there is no need to walk down to the
> +                * PUD level.
> +                */
>                 if (pgtable_l5_enabled())
>                         continue;
>
> -               pud = pud_offset(p4d, addr);
> -               if (pud_none(*pud)) {
> -                       /* Ends up here only with 4-level paging */
> -                       pud = pud_alloc(&init_mm, p4d, addr);
> -                       if (!pud) {
> -                               lvl = "pud";
> -                               goto failed;
> -                       }
> -               }
> +               lvl = "pud";
> +               pud = pud_alloc(&init_mm, p4d, addr);
> +               if (!pud)
> +                       goto failed;
>         }
>
>         return;
> --
> 2.26.2


This appears to fix the issue, so:

Tested-by: Jason A. Donenfeld <Jason@zx2c4.com>
