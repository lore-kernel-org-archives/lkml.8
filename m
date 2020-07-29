Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B31C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA3F2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lsbByIIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgG2WMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:12:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DF0C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V9hNvKU0nUvM/cMB0PUli9eVmGS/Xrmr6zdndz6gark=; b=lsbByIIszIZiMk1R2EQg6j9FqC
        xkUCM/4U5q1xIZWxraQj1CUgq3zfn3J7QJPn2NvzRWXIAnYf13DHTAxdyROef1DKSVk1FApAUZ4dG
        NP2ZKeOGlwn01q/4sp+RX7MEdbQM8AugpMWcYlxXKSw/+Cu9cKG3/nBFttgQgmZA8PObRsVTTs4SA
        c3f9ItMVn7Zz8zVZuzQHP24XXkEmviN806dHzm2e8Q2iu35pCovyuUJcyvfnpAkf5EPyfPQumagCV
        3DEWw/1ZAL+ebgfm4PZh4biuzmEMwPJPNMhb1B/8hTeFIpNieibfpb0G8P3cDgeZB536O9oWZAAeN
        bqr0k0fw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0uIP-0000k9-EU; Wed, 29 Jul 2020 22:11:45 +0000
Date:   Wed, 29 Jul 2020 23:11:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hillf Danton <hdanton@sina.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: kernel BUG at include/linux/swapops.h:LINE!
Message-ID: <20200729221133.GZ23808@casper.infradead.org>
References: <000000000000bc4fd705a6e090e2@google.com>
 <0000000000004c38cd05aad1d13f@google.com>
 <20200720165144.93189f7825bd28e234a42cb8@linux-foundation.org>
 <20200723073744.5268-1-hdanton@sina.com>
 <20200724111311.rcjqigtjqpkenxg6@box>
 <20200726164904.GG23808@casper.infradead.org>
 <20200727103140.xycdx6ctecomqsoe@box>
 <20200727120310.GJ23808@casper.infradead.org>
 <20200729192151.eyghcfysfzaf2ijg@box>
 <20200729195432.GY23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729195432.GY23808@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 08:54:32PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 29, 2020 at 10:21:51PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Jul 27, 2020 at 01:03:10PM +0100, Matthew Wilcox wrote:
> > > > It would be interesting to know if the migration entires ever got removed
> > > > for pfn. I mean if remove_migration_pte() got called for it.
> > > > 
> > > > It can be rmap issue too. Maybe it misses PMD on remove_migration_ptes()
> > > > or something.
> > > 
> > > It's not mapped with a PMD.  I tweaked my debugging slightly:
> > > 
> > >  static inline swp_entry_t make_migration_entry(struct page *page, int write)
> > >  {
> > > -       BUG_ON(!PageLocked(compound_head(page)));
> > > +       VM_BUG_ON_PAGE(!PageLocked(page), page);
> > >  
> > > +if (PageHead(page)) dump_page(page, "make entry");
> > > +if (PageTail(page)) printk("pfn %lx order %d\n", page_to_pfn(page), thp_order(thp_head(page)));
> > > 
> > > 1523 page:0000000006f62206 refcount:490 mapcount:1 mapping:0000000000000000 index:0x562b12a00 pfn:0x1dc00
> > > 1523 head:0000000006f62206 order:9 compound_mapcount:0 compound_pincount:0
> > > 1523 anon flags: 0x400000000009003d(locked|uptodate|dirty|lru|active|head|swapbacked)
> > > 1523 raw: 400000000009003d ffffecfd41301308 ffffecfd41b08008 ffff9e9971c00059
> > > 1523 raw: 0000000562b12a00 0000000000000000 000001ea00000000 0000000000000000
> > > 1523 page dumped because: make entry
> > > 1523 pfn 1dc01 order 9
> > > 1523 pfn 1dc02 order 9
> > > 1523 pfn 1dc03 order 9
> > > ...
> > > 
> > > Notice that it's an anonymous page, so it's not related to my work.
> > 
> > I don't have much hope, but could you try if the patch below would blow
> > up?
> 
> Running it now.  Results probably in twenty minutes.

It didn't blow up.  I added a dump_stack() after the call to dump_page()
and got this ...

2922 page:0000000085a5c107 refcount:474 mapcount:1 mapping:0000000000000000 index:0x559e98a00 pfn:0x35200
2922 head:0000000085a5c107 order:9 compound_mapcount:0 compound_pincount:0
2922 anon flags: 0x400000000009003d(locked|uptodate|dirty|lru|active|head|swapbacked)
2922 raw: 400000000009003d ffffe8e5c1bbaf48 ffffe8e5c046ee88 ffffa2e7f3787ec9
2922 raw: 0000000559e98a00 0000000000000000 000001da00000000 0000000000000000
2922 page dumped because: make entry
2922 CPU: 5 PID: 23471 Comm: dd Kdump: loaded Tainted: G        W         5.8.0-rc6-00067-gd8b18bdf9870-dirty #358
2922 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
2922 Call Trace:
2922  dump_stack+0x5e/0x7a
2922  try_to_unmap_one+0x846/0x860
2922  rmap_walk_anon+0x13d/0x2a0
2922  rmap_walk_locked+0x23/0x30
2922  try_to_unmap+0x64/0xbc
2922  split_huge_page_to_list+0x188/0xdb0
2922  deferred_split_scan+0x148/0x240
2922  shrink_slab.constprop.0+0x198/0x330
2922  shrink_node+0x1a8/0x440
2922  try_to_free_pages+0x18f/0x480
2922  __alloc_pages_slowpath.constprop.0+0x297/0xca0
2922  __alloc_pages_nodemask+0x1ba/0x1e0
2922  pagecache_get_page+0xd8/0x330
2922  grab_cache_page_write_begin+0x1c/0x40
2922  iomap_write_begin+0x2d6/0x6d0
2922  iomap_write_actor+0x8b/0x1c0
2922  iomap_apply+0xe3/0x310
2922  iomap_file_buffered_write+0x5c/0x80
2922  xfs_file_buffered_aio_write+0xbd/0x310
2922  xfs_file_write_iter+0xa8/0xc0
2922  new_sync_write+0xf5/0x170
2922  vfs_write+0x191/0x1e0

I think that's interesting because it's not trying to allocate a huge
page itself (I didn't touch the write_begin path).  Rather, I presume
the additional memory pressure from allocating huge pages is causing
anonymous pages to be split to free up memory.

It survived all the way to generic/224 this run, but I don't think
that's relevant.
