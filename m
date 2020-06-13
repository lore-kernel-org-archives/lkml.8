Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD4820739
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAz0iEo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFMN3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgFMN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:29:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D1C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:29:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so3210055pge.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FgD7trK9UXai91vKASUg9drm0IS6CWPS1x1rvWXbOqI=;
        b=YAz0iEo0hPYKJp7OqcrKcUh3QZ6NVMIfb8JNmJQexYFLcsQkcfe4oxjTldEqzp1vko
         o/MMzJRE9NB1XlzFvR6IHPhztJaGV/ZhEZsqJgnRPvX/HupGJlunL51IFW5HotEA3YuB
         qH2io2BRmD/6UGpmHm6GvXQaTLExnDvJtSkRYRsRAyNvY3ti8b1eAl0EnwgKxvU1qBY8
         Jimb0i7fRhLucW3TTviZB0t+bhCGvrMheIWKAmsTYW6DAvHvBKa0DEtBhyKHJTP0EWzj
         bijLfnxKVWKqQ+CsboOhnIEVkNwJMkpCYpm6zQ6mxTI9OtHC92qxpeRP9nNal0Y+VMeI
         JFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FgD7trK9UXai91vKASUg9drm0IS6CWPS1x1rvWXbOqI=;
        b=kXAhjv7FUtDRFT/CJAM5YXlk7uVN1/PY0huJNnT9VpzuYJurqubfUh8CyjtQDI/YcJ
         2p82htTwnLNEOdhCFztJYu5XXryUo1n6yLoVJnXd81xE6W9afTrHP+QgIMxMMBTr/UCJ
         pPgh4jTdGnZwq/jNNlbOIA7Y8AFaXRR4bPPV47sO7WuVJKjfzPDHyfZk3GvQ6uFopwMX
         PKtI4Sh4T1HMbMTHjTR0ljIjtPpoczXnWN7sZLBaxAT1sXHzfhV3f1oF4QkP8pomB8ry
         obi4wSf0WEy4pGpPJ19UIapIN15dXM5UMti6csy1LCPnNkIzYsmBo63CSgS3NYg3grie
         IUbA==
X-Gm-Message-State: AOAM530vhq/dXVtKJEtNqgUpQUJjczFhfzB+oqXzsB4Qy3y+lwlSEkew
        wu4DM8ZECotI3cEIC+FUo20=
X-Google-Smtp-Source: ABdhPJzRhgcSz+npSCAV/H07NPbuJdcfBHWW62k9iaNoNkiA7BP5w79gXw1gi9vcc51wgZllbwjPcA==
X-Received: by 2002:a62:3582:: with SMTP id c124mr11627890pfa.298.1592054973085;
        Sat, 13 Jun 2020 06:29:33 -0700 (PDT)
Received: from localhost ([49.207.210.132])
        by smtp.gmail.com with ESMTPSA id p19sm8996514pff.116.2020.06.13.06.29.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Jun 2020 06:29:32 -0700 (PDT)
Date:   Sat, 13 Jun 2020 18:59:30 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <20200613132930.GA4005@afzalpc>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAHp75VfRxDH-UE+O7_9W4zyBzPt2+3LeV-=C4iZq2PLwPEbhBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfRxDH-UE+O7_9W4zyBzPt2+3LeV-=C4iZq2PLwPEbhBw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 13, 2020 at 02:08:11PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 12, 2020 at 1:20 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> > +// Started from arch/um/kernel/skas/uaccess.c
> 
> Does it mean you will deduplicate it there?

What i meant was, that file was taken as a template & nothing more, at
same time i wanted to give credit to that file, i will explicitly
mention it next time.

It is not meant to deduplicate it. Functionality here is completely
different.

In the case here, there would be different virtual address mapping
that CPU will be see once in Kernel as compared to user mode.

Here a facility is provided to access the user page, when the
current virtual address mapping of the CPU excludes it. This
is for providing full 4G virtual address to both user & kernel on
32bit ARM to avoid using highmem or reduce the impact of highmem,
i.e. so that Kernel can address till 4GiB (almost) as lowmem.

Here assumption is that user mapping is not a subset of virtual
address mapped by CPU, but a separate one. Upon Kernel entry ttbr0
is changed to Kernel lowmem, while upon Kernel exit is changed back to
user pages (ttbrx in ARM, iiuc, equivalent to cr3 in x86)

Now realize that i am unable to put coherently the problem being
attempted to solve here to a person not familiar w/ the issue
w/o taking considerable time. If above explanation is not enough,
i will try to explain later in a better way.

> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +#include <linux/highmem.h>
> > +#include <linux/mm.h>
> 
> Perhaps ordered?

will take care

> > +static int do_op_one_page(unsigned long addr, int len,
> > +                int (*op)(unsigned long addr, int len, void *arg), void *arg,
> > +                struct page *page)
> 
> Maybe typedef for the func() ?

will take care

> > +{
> > +       int n;
> > +
> > +       addr = (unsigned long) kmap_atomic(page) + (addr & ~PAGE_MASK);
> 
> I don't remember about this one...

i am not following you here, for my case !CONFIG_64BIT case in that
file was required, hence only it was picked (or rather not deleted)

> > +       size = min(PAGE_ALIGN(addr) - addr, (unsigned long) len);
> 
> ...but here seems to me you can use helpers (offset_in_page() or how
> it's called).

i was not aware of it, will use it as required.

> 
> Also consider to use macros like PFN_DOWN(), PFN_UP(), etc in your code.

Okay

> 
> > +       remain = len;
> > +       if (size == 0)
> > +               goto page_boundary;
> > +
> > +       n = do_op_one_page(addr, size, op, arg, *pages);
> > +       if (n != 0) {
> 
> > +               remain = (n < 0 ? remain : 0);
> 
> Why duplicate three times (!) this line, if you can move it to under 'out'?

yes better to move there

> 
> > +               goto out;
> > +       }
> > +
> > +       pages++;
> > +       addr += size;
> > +       remain -= size;
> > +
> > +page_boundary:
> > +       if (remain == 0)
> > +               goto out;
> > +       while (addr < ((addr + remain) & PAGE_MASK)) {
> > +               n = do_op_one_page(addr, PAGE_SIZE, op, arg, *pages);
> > +               if (n != 0) {
> > +                       remain = (n < 0 ? remain : 0);
> > +                       goto out;
> > +               }
> > +
> > +               pages++;
> > +               addr += PAGE_SIZE;
> > +               remain -= PAGE_SIZE;
> > +       }
> 
> Sounds like this can be refactored to iterate over pages rather than addresses.

Okay, i will check

> > +static int copy_chunk_from_user(unsigned long from, int len, void *arg)
> > +{
> > +       unsigned long *to_ptr = arg, to = *to_ptr;
> > +
> > +       memcpy((void *) to, (void *) from, len);
> 
> What is the point in the casting to void *?

The reason it was there was because of copy-paste :), passing unsigned
long as 'void *' or 'const void *' requires casting right ?, or you
meant something else ?

now i checked removing the cast, compiler is abusing me :), says
'makes pointer from integer without a cast'

> > +       num_pages = DIV_ROUND_UP((unsigned long)from + n, PAGE_SIZE) -
> > +                                (unsigned long)from / PAGE_SIZE;
> 
> PFN_UP() ?

Okay

> I think you can clean up the code a bit after you will get the main
> functionality working.

Yes, surely, intention was to post proof-of-concept ASAP, perhaps
contents will change drastically in next version so that any
resemblence of arch/um/kernel/skas/uaccess.c might not be there.

Regards
afzal
