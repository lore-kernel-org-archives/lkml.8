Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2392C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DBD20737
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ul2ClHCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD2Bvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 21:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2Bva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:51:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F324C03C1AC;
        Tue, 28 Apr 2020 18:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WbbJxxgU3/2bFydTDSvswBZ7GGGONTFQzERhB4EnAUc=; b=Ul2ClHCmMLDUyloGhXGz54hFzD
        fMR+V0dNgvkNCYvShBkoTv6vBoaB8q70JyqyVLyqXTRrRx8yre3Sj8KAOfTYayVF+xLVzJwcsYB0s
        hjurit9iWN4a5sfT/dChjGHZuP5ERi+QmDTiiNv0kCZTz8PZM16OX32LiQsN4Em+etdl3Yrc30Yxw
        g/FLckZ/pLl7ZUy6rZCNq18s1PAAYOaxZB8Pr4KVT3AKuNvF9uNXhTJRGRiSx6zGLAYTsDr4gk9N0
        skWVoLsycEX4MKtlyewMifsVXMO+sT7X1qmpJQJKOt9VDpJ2AVrLCslMj+PaSe2mIz9EdWa+BzpBC
        gssJLDhA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTbsk-000812-Hw; Wed, 29 Apr 2020 01:51:26 +0000
Date:   Tue, 28 Apr 2020 18:51:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 0/7] Record the mm_struct in the page table pages
Message-ID: <20200429015126.GP29705@bombadil.infradead.org>
References: <20200428194449.22615-1-willy@infradead.org>
 <20200429002624.qkhb362moj6v3vtw@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429002624.qkhb362moj6v3vtw@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 03:26:24AM +0300, Kirill A. Shutemov wrote:
> On Tue, Apr 28, 2020 at 12:44:42PM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Pages which are in use as page tables have some space unused in struct
> > page.  It would be handy to have a pointer to the struct mm_struct that
> > they belong to so that we can handle uncorrectable errors in page tables
> > more gracefully.  There are a few other things we could use it for too,
> > such as checking that the page table entry actually belongs to the task
> > we think it ought to.  This patch series does none of that, but does
> > lay the groundwork for it.
> > 
> > Matthew Wilcox (Oracle) (7):
> 
> How does it work for kernel side of virtual address space?

init_mm

> And your employer may be interested in semantics around
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE :P

I was thinking about that.  Right now, it's only useful for debugging
purposes (as you point out in a later email).  I think it's OK if shared
PMDs aren't supported as well as regular PTEs, just because there are
so few of them that uncorrectable errors are less likely to strike in
those pages.
