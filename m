Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9145BC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AC724679
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c828E5gI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgB0FUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:20:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50487 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB0FUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:20:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so2040132wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 21:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRUomU+bV2SOpdsn8/iRmEqp1CEgdv1ytb+AACa2I0I=;
        b=c828E5gIXTNAiWYgr1MB+lkstnQjrPJ813k5XRVz+mgF0gwTkviaDg7XlYSGHACYny
         PWpHK0QGLiFiifN0fzw+ZYScLxuxCRCfm3i2o9/W5fz5UbNoWFkSylhjWrTpwTFM8oW3
         9KKUbRd8dc0thUdzBlzwuTyjTkT54w7DDLb/20OJZbW1JTXQSefeisvOdBlm6WGr2vE/
         qhTMhluCGTrIN7QGiWNLafbTbUYCNMyqsRNT6aSCFA32XpqC+30EvxuKKTSvcJ9QhErW
         0ElvapIFllTlg6ArnqraKz+rlxN+cwbQJ4zO8lhCGz6w9fQqkVIgNVMLSKkNrS/T/w/X
         OQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRUomU+bV2SOpdsn8/iRmEqp1CEgdv1ytb+AACa2I0I=;
        b=sYJjCKxjZBvAohmARHroKILZy8cCI2nF1IIzpTnfbT5EzfnQY2/VMddscabuHUW9Va
         4wTorjv80MNnxt+9xmeIS4FvNwZ/5ICuxPHXy+orcnhYaye07/Svb7Rcnd/RtOfLeqAK
         JyQeW6l1maoyKtCOBcQHJvi1jTPe7JMsSuSz7w0ZWEX8U/nNVE1R/xt/pjgw/kVg5N4K
         jvk/4WgIgYlCqkw/J74Zglxd+K0MPzPr3V33hijsb21Bfm4h6svi/r1d+bfJmvc8ht2P
         2YilOgN+2WkEEUjp0wv55yh4ibEHKUbozdJxVdnD3gzINCWq5Uh/HzIQR/qOfiuPRaJA
         4mVg==
X-Gm-Message-State: APjAAAWNSgXpkONFah31iiQwtkKK8/Yz5Dykz0XVwPi7O1mEkNW7vA8T
        n1IBda8hf9pDpEChT4OouFeoaHDHTMCRrvvvy2fET+Zz
X-Google-Smtp-Source: APXvYqxBBFCGYpxJw4lRfGMd/7mLgy6Dsw6ADJp5vKNhBG7IP+DE8drjcjO7XlJJzKtiwVtBH2+EwDvoA1DVWT6KL7o=
X-Received: by 2002:a1c:a505:: with SMTP id o5mr2825734wme.78.1582780834981;
 Wed, 26 Feb 2020 21:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20200227151143.6a6edaf9@canb.auug.org.au>
In-Reply-To: <20200227151143.6a6edaf9@canb.auug.org.au>
From:   Arjun Roy <arjunroy@google.com>
Date:   Wed, 26 Feb 2020 21:20:23 -0800
Message-ID: <CAOFY-A3a8QbwJJgQxVzraD10_UsztmCAGLz=AmPYbJp_=BVkDA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 8:11 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm tree, today's linux-next build (sparc defconfig)
> failed like this:
>
> In file included from include/linux/list.h:9:0,
>                  from include/linux/smp.h:12,
>                  from include/linux/kernel_stat.h:5,
>                  from mm/memory.c:42:
> mm/memory.c: In function 'insert_pages':
> mm/memory.c:1523:41: error: implicit declaration of function 'pte_index'; did you mean 'page_index'? [-Werror=implicit-function-declaration]
>    remaining_pages_total, PTRS_PER_PTE - pte_index(addr));
>                                          ^
> include/linux/kernel.h:842:40: note: in definition of macro '__typecheck'
>    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>                                         ^
> include/linux/kernel.h:866:24: note: in expansion of macro '__safe_cmp'
>   __builtin_choose_expr(__safe_cmp(x, y), \
>                         ^~~~~~~~~~
> include/linux/kernel.h:934:27: note: in expansion of macro '__careful_cmp'
>  #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
>                            ^~~~~~~~~~~~~
> mm/memory.c:1522:26: note: in expansion of macro 'min_t'
>   pages_to_write_in_pmd = min_t(unsigned long,
>                           ^~~~~
>
> Caused by patch
>
>   "mm/memory.c: add vm_insert_pages()"
>
> sparc32 does not implement pte_index at all :-(
>
> I have added the following patch for today.  This may not be correct
> or enough.
>

Thank you for the patch. I still do not have much/any knowledge about
sparc in Linux, so will have to defer to those who know more. :(

-Arjun

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 27 Feb 2020 14:57:49 +1100
> Subject: [PATCH] arch/sparc: add a definition of pte_index for the 32 bit kernel
>
> This is now needed for vm_insert_pages()
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/sparc/include/asm/pgtable_32.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
> index 6d6f44c0cad9..dc7a4d69cb18 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -326,6 +326,8 @@ static inline pmd_t *pmd_offset(pud_t * dir, unsigned long address)
>  }
>
>  /* Find an entry in the third-level page table.. */
> +#define pte_index(address)     \
> +        ((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
>  pte_t *pte_offset_kernel(pmd_t * dir, unsigned long address);
>
>  /*
> --
> 2.25.0
>
> --
> Cheers,
> Stephen Rothwell
