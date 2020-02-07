Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54988C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9F520726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pZVR7t9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGLeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:34:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40200 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGLeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bbNKqLeBKsalj59oA0t74eb1uCjNw+Eae9shIiQnYSM=; b=pZVR7t9ZswIQ+reQ+UqSSSsGpZ
        Bl0E03/gHDRzaQbHInHmqGGsgGQofoVGrYsygmCQYgKmn+yRXWl0HkrjY1BLPmTFn6PHkVJWOdJSg
        bFugaTUxEyHxufAQ0YSpy1tSNTva9rnpykalor+N/OSZ91+2pQyUib8EkxqjEUHouXBKan3mX2TEb
        J3WC6WfYcgolhBfoHKLE4X1Dv4Bpht3s00rLaAcm9UxTfJ+zDEK25fP7vAE29PVnpLYU/HEMBnbLO
        wsKHxPJNCbr+JeYrs7/47wazpH25cDIg2FQpmIsDfw6oVlHmrOARZOlSklN27rjMWyXVTIqT/9sDp
        Z+/cxTkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j01ts-0008Jr-5R; Fri, 07 Feb 2020 11:34:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5D843011E8;
        Fri,  7 Feb 2020 12:32:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 951CC2B879078; Fri,  7 Feb 2020 12:34:17 +0100 (CET)
Date:   Fri, 7 Feb 2020 12:34:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH -v2 08/10] m68k,mm: Extend table allocator for multiple
 sizes
Message-ID: <20200207113417.GG14914@hirez.programming.kicks-ass.net>
References: <20200131124531.623136425@infradead.org>
 <20200131125403.882175409@infradead.org>
 <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 11:56:40AM +0100, Geert Uytterhoeven wrote:
> Hoi Peter,
> 
> On Fri, Jan 31, 2020 at 1:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > In addition to the PGD/PMD table size (128*4) add a PTE table size
> > (64*4) to the table allocator. This completely removes the pte-table
> > overhead compared to the old code, even for dense tables.
> 
> Thanks for your patch!
> 
> > Notes:
> >
> >  - the allocator gained a list_empty() check to deal with there not
> >    being any pages at all.
> >
> >  - the free mask is extended to cover more than the 8 bits required
> >    for the (512 byte) PGD/PMD tables.
> 
> Being an mm-illiterate, I don't understand the relation between the number
> of bits and the size (see below).

If the table translates 7 bits of the address, it will have 1<<7 entries.

> >  - NR_PAGETABLE accounting is restored.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> WARNING: Missing Signed-off-by: line by nominal patch author 'Peter
> Zijlstra <peterz@infradead.org>'
> (in all patches)
> 
> I can fix that (the From?) up while applying.

I'm not sure where that warning comes from, but if you feel it needs
fixing, sure. I normally only add the (Intel) thing to the SoB. I've so
far never had complaints about that.

> > --- a/arch/m68k/mm/motorola.c
> > +++ b/arch/m68k/mm/motorola.c
> > @@ -72,24 +72,35 @@ void mmu_page_dtor(void *page)
> >     arch/sparc/mm/srmmu.c ... */
> >
> >  typedef struct list_head ptable_desc;
> > -static LIST_HEAD(ptable_list);
> > +
> > +static struct list_head ptable_list[2] = {
> > +       LIST_HEAD_INIT(ptable_list[0]),
> > +       LIST_HEAD_INIT(ptable_list[1]),
> > +};
> >
> >  #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->lru))
> >  #define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
> > -#define PD_MARKBITS(dp) (*(unsigned char *)&PD_PAGE(dp)->index)
> > +#define PD_MARKBITS(dp) (*(unsigned int *)&PD_PAGE(dp)->index)
> > +
> > +static const int ptable_shift[2] = {
> > +       7+2, /* PGD, PMD */
> > +       6+2, /* PTE */
> > +};
> >
> > -#define PTABLE_SIZE (PTRS_PER_PMD * sizeof(pmd_t))
> > +#define ptable_size(type) (1U << ptable_shift[type])
> > +#define ptable_mask(type) ((1U << (PAGE_SIZE / ptable_size(type))) - 1)
> 
> So this is 0xff for PGD and PMD, like before, and 0xffff for PTE.
> Why the latter value?

The PGD/PMD being 7 bits are sizeof(unsigned long) << 7, or 512 bytes
big. In one 4k page, there fit 8 such entries. 0xFF is 8 bits set, one
for each of the 8 512 byte fragments.

For the PTE tables, which are 6 bit and of sizeof(unsigned long) << 6,
or 256 bytes, we can fit 16 in one 4k page, resulting in 0xFFFF.

