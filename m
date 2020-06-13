Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7B5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 11:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD39C2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 11:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsjC9xGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFMLIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 07:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgFMLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 07:08:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA886C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 04:08:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b5so4393601pgm.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 04:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkGNponpocVT1qAlSBkmbT/0fDQhc4cCY7fZTe5debY=;
        b=WsjC9xGSzAq2ycO61aJjdhojVuKTnafM/X95A418DSCRsZvPhRsolz3MR042xaD4Sn
         SJ6vEycRTKInFJ341dMgo9g7gcm9Unm76q+fGOYo5joX5TKfShKH+SIdKva4htXnH8O+
         zYmYYWIlrOyLkQUr9e+zhO0sNMaWgUlTfFwkOq7Muv/f2yR/rkI/WjFdAcfZzI1cAC6D
         cmaJkB5B9Qahikxs7VCXBowrsYVHekACCvk9LoWZHRQ7Et/6Yc/dapzzVtnk23+fOsPq
         mlmuoofIgjqNz/lX3X7f+l482ofaLT+rrGICKxryQu4r81mGQO3UmlWC0qVI/wCYp92m
         ap9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkGNponpocVT1qAlSBkmbT/0fDQhc4cCY7fZTe5debY=;
        b=PXY9PUHo+Fp5ETtPOC7uotTNrAZfMGWuQxGZJKnGQDhlHWRNGk31ZK3Yw6QyTttocd
         w+nwtkCyEB2+aw6BsKGOkiceRzqcGjs5H2Xa5lfstHifO5G9Wsfze7AikI1nBNv06XJI
         QqXT8QAf/JjbNNOMGylOrvkfR83/I1Miy8xCWpBcAS70q8sl/EfzqyP2B3JwJxVo19u1
         N8tBYgBRATRAEjNBEDPJcNb9ZCwE4Wgbkg/eiOspYw6I+hlq2E7K6C0eusPTNERBmxak
         agPxJ51X5N3EGh7cxLqeNzZpMQZJK01NXMaKWl4xLm+7Axca52YrEt8CYJ7BzJUgSksU
         5sRQ==
X-Gm-Message-State: AOAM530SudfEFoNRPJtTV1pwyIKa9w2WNLWhIR2MwN430GKi1P6UKcUe
        UDqobGgbvlEKVdLESK+7+fuFem09E1U2zaEmrhcgQm5A5E8=
X-Google-Smtp-Source: ABdhPJyKgJAiFYOq1sl/ONbpxVBHe1PqrTuejkwZKkqfgo2Tagov6GnYx5GIt/KxJmpVkqbpin/QvYzrbe7T0VOe8Ko=
X-Received: by 2002:a62:5284:: with SMTP id g126mr9237977pfb.36.1592046508560;
 Sat, 13 Jun 2020 04:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com> <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
In-Reply-To: <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 13 Jun 2020 14:08:11 +0300
Message-ID: <CAHp75VfRxDH-UE+O7_9W4zyBzPt2+3LeV-=C4iZq2PLwPEbhBw@mail.gmail.com>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 1:20 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> copy_{from,to}_user() uaccess helpers are implemented by user page
> pinning, followed by temporary kernel mapping & then memcpy(). This
> helps to achieve user page copy when current virtual address mapping
> of the CPU excludes user pages.
>
> Performance wise, results are not encouraging, 'dd' on tmpfs results,
>
> ARM Cortex-A8, BeagleBone White (256MiB RAM):
> w/o series - ~29.5 MB/s
> w/ series - ~20.5 MB/s
> w/ series & highmem disabled - ~21.2 MB/s
>
> On Cortex-A15(2GiB RAM) in QEMU:
> w/o series - ~4 MB/s
> w/ series - ~2.6 MB/s
>
> Roughly a one-third drop in performance. Disabling highmem improves
> performance only slightly.
>
> 'hackbench' also showed a similar pattern.
>
> uaccess routines using page pinning & temporary kernel mapping is not
> something new, it has been done long long ago by Ingo [1] as part of
> 4G/4G user/kernel mapping implementation on x86, though not merged in
> mainline.
>
> [1] https://lore.kernel.org/lkml/Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain/

Some comments (more related to generic things).

...

> +// Started from arch/um/kernel/skas/uaccess.c

Does it mean you will deduplicate it there?

...

> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/highmem.h>
> +#include <linux/mm.h>

Perhaps ordered?


> +static int do_op_one_page(unsigned long addr, int len,
> +                int (*op)(unsigned long addr, int len, void *arg), void *arg,
> +                struct page *page)

Maybe typedef for the func() ?

> +{
> +       int n;
> +
> +       addr = (unsigned long) kmap_atomic(page) + (addr & ~PAGE_MASK);

I don't remember about this one...

> +       n = (*op)(addr, len, arg);
> +       kunmap_atomic((void *)addr);
> +
> +       return n;
> +}
> +
> +static long buffer_op(unsigned long addr, int len,
> +                     int (*op)(unsigned long, int, void *), void *arg,
> +                     struct page **pages)
> +{
> +       long size, remain, n;
> +

> +       size = min(PAGE_ALIGN(addr) - addr, (unsigned long) len);

...but here seems to me you can use helpers (offset_in_page() or how
it's called).

Also consider to use macros like PFN_DOWN(), PFN_UP(), etc in your code.

> +       remain = len;
> +       if (size == 0)
> +               goto page_boundary;
> +
> +       n = do_op_one_page(addr, size, op, arg, *pages);
> +       if (n != 0) {

> +               remain = (n < 0 ? remain : 0);

Why duplicate three times (!) this line, if you can move it to under 'out'?

> +               goto out;
> +       }
> +
> +       pages++;
> +       addr += size;
> +       remain -= size;
> +
> +page_boundary:
> +       if (remain == 0)
> +               goto out;
> +       while (addr < ((addr + remain) & PAGE_MASK)) {
> +               n = do_op_one_page(addr, PAGE_SIZE, op, arg, *pages);
> +               if (n != 0) {
> +                       remain = (n < 0 ? remain : 0);
> +                       goto out;
> +               }
> +
> +               pages++;
> +               addr += PAGE_SIZE;
> +               remain -= PAGE_SIZE;
> +       }

Sounds like this can be refactored to iterate over pages rather than addresses.

> +       if (remain == 0)
> +               goto out;
> +
> +       n = do_op_one_page(addr, remain, op, arg, *pages);
> +       if (n != 0) {
> +               remain = (n < 0 ? remain : 0);
> +               goto out;
> +       }
> +
> +       return 0;

> +out:
> +       return remain;
> +}

...

> +static int copy_chunk_from_user(unsigned long from, int len, void *arg)
> +{
> +       unsigned long *to_ptr = arg, to = *to_ptr;
> +
> +       memcpy((void *) to, (void *) from, len);

What is the point in the casting to void *?

> +       *to_ptr += len;
> +       return 0;
> +}
> +
> +static int copy_chunk_to_user(unsigned long to, int len, void *arg)
> +{
> +       unsigned long *from_ptr = arg, from = *from_ptr;
> +
> +       memcpy((void *) to, (void *) from, len);
> +       *from_ptr += len;

Ditto.

> +       return 0;
> +}
> +
> +unsigned long gup_kmap_copy_from_user(void *to, const void __user *from, unsigned long n)
> +{
> +       struct page **pages;
> +       int num_pages, ret, i;
> +
> +       if (uaccess_kernel()) {
> +               memcpy(to, (__force void *)from, n);
> +               return 0;
> +       }
> +

> +       num_pages = DIV_ROUND_UP((unsigned long)from + n, PAGE_SIZE) -
> +                                (unsigned long)from / PAGE_SIZE;

PFN_UP() ?

> +       pages = kmalloc_array(num_pages, sizeof(*pages), GFP_KERNEL | __GFP_ZERO);
> +       if (!pages)
> +               goto end;
> +
> +       ret = get_user_pages_fast((unsigned long)from, num_pages, 0, pages);
> +       if (ret < 0)
> +               goto free_pages;
> +
> +       if (ret != num_pages) {
> +               num_pages = ret;
> +               goto put_pages;
> +       }
> +
> +       n = buffer_op((unsigned long) from, n, copy_chunk_from_user, &to, pages);
> +
> +put_pages:
> +       for (i = 0; i < num_pages; i++)
> +               put_page(pages[i]);
> +free_pages:
> +       kfree(pages);
> +end:
> +       return n;
> +}

...

I think you can clean up the code a bit after you will get the main
functionality working.

-- 
With Best Regards,
Andy Shevchenko
