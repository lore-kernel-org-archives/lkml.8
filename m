Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A25C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7783020838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGMMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:12:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42995 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgBGMMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:12:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so1915542otd.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 04:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TH2XU7HlZZKnVSPgk65RYPPovOJAS6giPBLXk0YuFnk=;
        b=WfTHZb2yF2mPR5napvIumLiyhP6yY1VHc+49drk+2ZSSn3rNmWmr73sb6QblK9bs4E
         IdawPGLNQ9Fbw0TjZZsjPU9vLYTV/MpYJiLe312savk6sZUjzdYQfGVXx60NTaS5/yD3
         UYYTZpLVYZ/e0VpJWs5POpqpfAld0Lr3sJO1z8ktjBZcgkOjcl3wiucK9uJR72YpWGSA
         QtmpWOaM2/PH06uPzBY+orDHPEyZGpULvMl+hf9OeEFFxFBpS/THNkKgyZlUSSC1yniW
         xwOiMIJBdsdcgA9Mxb5gROGU6YVQh2j2N3eMMrG9tzRyJ8LE0ID7allJC4VjbMyI/9zr
         2RwA==
X-Gm-Message-State: APjAAAWrgHUtsd5dk0UC7d6nxHtOUVS3dgbROdk05iV4F9bJUx6RIDpk
        DKAXwH65jNSHJelBssHRqef6En8lamej767cSKk=
X-Google-Smtp-Source: APXvYqyYv2JPMW2IncEaOUc3UDZx/ZcH+Fkg5yQsT9yyJq/tt6erASZtXBIGND1rPdEoV1wLWpsmoA+x8tOM6MEMeKI=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr2475651otm.297.1581077525251;
 Fri, 07 Feb 2020 04:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20200131124531.623136425@infradead.org> <20200131125403.882175409@infradead.org>
 <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com> <20200207113417.GG14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200207113417.GG14914@hirez.programming.kicks-ass.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Feb 2020 13:11:54 +0100
Message-ID: <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
Subject: Re: [PATCH -v2 08/10] m68k,mm: Extend table allocator for multiple sizes
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

On Fri, Feb 7, 2020 at 12:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Feb 07, 2020 at 11:56:40AM +0100, Geert Uytterhoeven wrote:
> > On Fri, Jan 31, 2020 at 1:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > In addition to the PGD/PMD table size (128*4) add a PTE table size
> > > (64*4) to the table allocator. This completely removes the pte-table
> > > overhead compared to the old code, even for dense tables.
> >
> > Thanks for your patch!
> >
> > > Notes:
> > >
> > >  - the allocator gained a list_empty() check to deal with there not
> > >    being any pages at all.
> > >
> > >  - the free mask is extended to cover more than the 8 bits required
> > >    for the (512 byte) PGD/PMD tables.
> >
> > Being an mm-illiterate, I don't understand the relation between the number
> > of bits and the size (see below).
>
> If the table translates 7 bits of the address, it will have 1<<7 entries.
>
> > >  - NR_PAGETABLE accounting is restored.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > WARNING: Missing Signed-off-by: line by nominal patch author 'Peter
> > Zijlstra <peterz@infradead.org>'
> > (in all patches)
> >
> > I can fix that (the From?) up while applying.
>
> I'm not sure where that warning comes from, but if you feel it needs
> fixing, sure. I normally only add the (Intel) thing to the SoB. I've so
> far never had complaints about that.

Checkpatch doesn't like this.

> > > --- a/arch/m68k/mm/motorola.c
> > > +++ b/arch/m68k/mm/motorola.c
> > > @@ -72,24 +72,35 @@ void mmu_page_dtor(void *page)
> > >     arch/sparc/mm/srmmu.c ... */
> > >
> > >  typedef struct list_head ptable_desc;
> > > -static LIST_HEAD(ptable_list);
> > > +
> > > +static struct list_head ptable_list[2] = {
> > > +       LIST_HEAD_INIT(ptable_list[0]),
> > > +       LIST_HEAD_INIT(ptable_list[1]),
> > > +};
> > >
> > >  #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->lru))
> > >  #define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
> > > -#define PD_MARKBITS(dp) (*(unsigned char *)&PD_PAGE(dp)->index)
> > > +#define PD_MARKBITS(dp) (*(unsigned int *)&PD_PAGE(dp)->index)
> > > +
> > > +static const int ptable_shift[2] = {
> > > +       7+2, /* PGD, PMD */
> > > +       6+2, /* PTE */
> > > +};
> > >
> > > -#define PTABLE_SIZE (PTRS_PER_PMD * sizeof(pmd_t))
> > > +#define ptable_size(type) (1U << ptable_shift[type])
> > > +#define ptable_mask(type) ((1U << (PAGE_SIZE / ptable_size(type))) - 1)
> >
> > So this is 0xff for PGD and PMD, like before, and 0xffff for PTE.
> > Why the latter value?
>
> The PGD/PMD being 7 bits are sizeof(unsigned long) << 7, or 512 bytes
> big. In one 4k page, there fit 8 such entries. 0xFF is 8 bits set, one
> for each of the 8 512 byte fragments.
>
> For the PTE tables, which are 6 bit and of sizeof(unsigned long) << 6,
> or 256 bytes, we can fit 16 in one 4k page, resulting in 0xFFFF.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
