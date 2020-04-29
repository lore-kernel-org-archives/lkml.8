Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB5EC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBDF208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rR8i7Yuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgD2Mxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgD2Mxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:53:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DBAC03C1AD;
        Wed, 29 Apr 2020 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uNki6MLM9DcEC3Z6w0/BdO3E8oDPkiulVgaVGz6CEjA=; b=rR8i7Yuho3v8Xo9oVTGli9rVu9
        Jz34o2MyuO9n3Y7GQP9UTU/qq2SvL3vXOAKUiLRv8a4GAvaovtN4A022s0iNsME3XwtZaYMp33E+9
        gumxm8EdWWYbFcacSyNuZVPeJTTX1MJBeqA7UwqgIInWyt7QRXedZk/sDJENU4ZQJ1gAy888djzl5
        Jh9E5hYF6YCh5zEPhXv6fuROU+5Dd5ACbWOIesC9snKyCPZpNOo5v9SG3WNUXVSMDDkpr8ANu9uGg
        7H0EIj6Es5jQrhs3tVJrjMfiAnBAxzK4rHlkJVBz06+D9wgq5WQpWmwpuYO7942aWU4uXZqcm+H0F
        BbI5RfQA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmDc-000427-9q; Wed, 29 Apr 2020 12:53:40 +0000
Date:   Wed, 29 Apr 2020 05:53:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 2/7] mm: Move pt_mm within struct page
Message-ID: <20200429125340.GR29705@bombadil.infradead.org>
References: <20200428194449.22615-1-willy@infradead.org>
 <20200428194449.22615-3-willy@infradead.org>
 <CAMuHMdUw38VD8WJe5Zbaudnee74ZgLwbfhRwU8Pi9ALitre+_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUw38VD8WJe5Zbaudnee74ZgLwbfhRwU8Pi9ALitre+_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 09:34:02AM +0200, Geert Uytterhoeven wrote:
> > +++ b/include/linux/mm_types.h
> > @@ -149,11 +149,8 @@ struct page {
> >                                         pgtable_t pmd_huge_pte;
> >                                 };
> >                         };
> > -                       unsigned long _pt_pad_2;        /* mapping */
> > -                       union {
> > -                               struct mm_struct *pt_mm; /* x86 pgds only */
> > -                               atomic_t pt_frag_refcount; /* powerpc */
> > -                       };
> > +                       struct mm_struct *pt_mm;
> > +                       atomic_t pt_frag_refcount; /* powerpc */
> 
> So here is now an implicit hole on 64-bit platforms, right?
> Do we have any where alignof(long) != 8?

There's an implicit hole if someone's turned on spinlock debugging and
has split pagetable locks.  Without the need to allocate the spinlock
separately, the ptl will actually move from the same word as 'private'
to the same word as 'index', freeing up 'private' entirely.  I don't
intend to depend on that, but it's not quite as critical to line up the
various members of struct page as it used to be.

