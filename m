Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39775C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1930024670
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCIQ5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:57:54 -0400
Received: from foss.arm.com ([217.140.110.172]:54694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgCIQ5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:57:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2E1C1FB;
        Mon,  9 Mar 2020 09:57:53 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 332003F534;
        Mon,  9 Mar 2020 09:57:51 -0700 (PDT)
Date:   Mon, 9 Mar 2020 16:57:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-team@fb.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200309165749.GB4124965@arrakis.emea.arm.com>
References: <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
 <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com>
 <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
 <20200309155945.GA4124965@arrakis.emea.arm.com>
 <20200309160919.GM25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309160919.GM25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 04:09:19PM +0000, Russell King wrote:
> On Mon, Mar 09, 2020 at 03:59:45PM +0000, Catalin Marinas wrote:
> > On Sun, Mar 08, 2020 at 11:58:52AM +0100, Arnd Bergmann wrote:
> > > - revisit CONFIG_VMSPLIT_4G_4G for arm32 (and maybe mips32)
> > >   to see if it can be done, and what the overhead is. This is probably
> > >   more work than the others combined, but also the most promising
> > >   as it allows the most user address space and physical ram to be used.
> > 
> > A rough outline of such support (and likely to miss some corner cases):
> > 
> > 1. Kernel runs with its own ASID and non-global page tables.
> > 
> > 2. Trampoline code on exception entry/exit to handle the TTBR0 switching
> >    between user and kernel.
> > 
> > 3. uaccess routines need to be reworked to pin the user pages in memory
> >    (get_user_pages()) and access them via the kernel address space.
> > 
> > Point 3 is probably the ugliest and it would introduce a noticeable
> > slowdown in certain syscalls.
> 
> We also need to consider that it has implications for the single-kernel
> support; a kernel doing this kind of switching would likely be horrid
> for a kernel supporting v6+ with VIPT aliasing caches.

Good point. I think with VIPT aliasing cache uaccess would have to flush
the cache before/after access, depending on direction.

> Would we be adding a new red line between kernels supporting
> VIPT-aliasing caches (present in earlier v6 implementations) and
> kernels using this system?

get_user_pages() should handle the flush_dcache_page() call and the
latter would dial with the aliases. But this adds heavily to the cost of
the uaccess.

Maybe some trick with temporarily locking the user page table and
copying the user pmd into a dedicated kernel pmd, then accessing the
user via this location. The fault handler would need to figure out the
real user address and I'm not sure how we deal with the page table lock
(or mmap_sem).

An alternative to the above would be to have all uaccess routines in a
trampoline which restores the user pgd but with only a couple of pmds
for mapping the kernel address temporarily. This would avoid the issue
of concurrent modification of the user page tables.

Anyway, I don't think any of the above looks better than highmem.

-- 
Catalin
