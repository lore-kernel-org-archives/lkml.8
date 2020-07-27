Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0443CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D4820775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fKUUcjou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgG0NpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgG0NpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:45:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB1C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w3IFzN3dHxTsM6d1vVVpNI9q/Oauc9/cIxmbJnleAH8=; b=fKUUcjouGdOCtKPvq7fa+umPtH
        Ip3H8UImSDIcUah7UMcMXwJsU6623ygbn3SR/tbDfYEKnPIvQVGYQp9d/Pj+BHHMH/aMYEYZTvmfT
        Eqi1UnyZnECIU4auCg+Sl3YY3n2qa4V1aAwfAMmh6xPMuLFCO71rRFUFhmPAnGEQPHr06hczZ7SWs
        y4EeAKJxiAm66IvXqKXGiZuOVg8znkZfbeOsQKZSZYbPIJW+GiuXyWLANjHk5Bibz0Q5jdQFzRLNH
        vVO2PPip/PxRp9Ev9wb6IJUYK1RTdCY3h+CupiXqDVGF18o5YumL051RB7bresygHWaoOw4GndcJB
        o/xZQ7Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k03Qs-0002Oi-Gr; Mon, 27 Jul 2020 13:44:46 +0000
Date:   Mon, 27 Jul 2020 14:44:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Message-ID: <20200727134446.GL23808@casper.infradead.org>
References: <000000000000bc4fd705a6e090e2@google.com>
 <0000000000004c38cd05aad1d13f@google.com>
 <20200720165144.93189f7825bd28e234a42cb8@linux-foundation.org>
 <20200723073744.5268-1-hdanton@sina.com>
 <20200724111311.rcjqigtjqpkenxg6@box>
 <20200726164904.GG23808@casper.infradead.org>
 <20200727103140.xycdx6ctecomqsoe@box>
 <20200727125950.12048-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727125950.12048-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 08:59:50PM +0800, Hillf Danton wrote:
> Can you elaborate on the difference between the two dumps?

You didn't trim anything, so I have no idea which two dumps you mean.

I'll annotate below ...

> > > On Sun, Jul 26, 2020 at 05:49:04PM +0100, Matthew Wilcox wrote:
> > > > 1457 086 (20181): drop_caches: 3
> > > > 1457 page:00000000a216ae9a refcount:2 mapcount:0 mapping:000000009ba7bfed index:0x2227 pfn:0x229e7
> > > > 1457 aops:def_blk_aops ino:0
> > > > 1457 flags: 0x4000000000002030(lru|active|private)
> > > > 1457 raw: 4000000000002030 fffff5b4416b5a48 fffff5b4408a7988 ffff9e9c34848578
> > > > 1457 raw: 0000000000002227 ffff9e9bd18f0d00 00000002ffffffff 0000000000000000
> > > > 1457 page dumped because: not locked
> > > > 1457 swap entry 30.229e7

This is a dump of the page that was found when looking up the migration entry.

> On Mon, 27 Jul 2020 13:03:10 +0100 Matthew Wilcox wrote:
> > It's not mapped with a PMD.  I tweaked my debugging slightly:
> > 
> >  static inline swp_entry_t make_migration_entry(struct page *page, int write)
> >  {
> > -       BUG_ON(!PageLocked(compound_head(page)));
> > +       VM_BUG_ON_PAGE(!PageLocked(page), page);
> >  
> > +if (PageHead(page)) dump_page(page, "make entry");
> > +if (PageTail(page)) printk("pfn %lx order %d\n", page_to_pfn(page), thp_order(thp_head(page)));
> > 
> > 1523 page:0000000006f62206 refcount:490 mapcount:1 mapping:0000000000000000 index:0x562b12a00 pfn:0x1dc00
> > 1523 head:0000000006f62206 order:9 compound_mapcount:0 compound_pincount:0
> > 1523 anon flags: 0x400000000009003d(locked|uptodate|dirty|lru|active|head|swapbacked)
> > 1523 raw: 400000000009003d ffffecfd41301308 ffffecfd41b08008 ffff9e9971c00059
> > 1523 raw: 0000000562b12a00 0000000000000000 000001ea00000000 0000000000000000
> > 1523 page dumped because: make entry

This is dumping the page when we create the entry.

For completeness, here's the page that we find from the same run.

1523 page:00000000a18100e6 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x1ddde
1523 flags: 0x4000000000000000()
1523 raw: 4000000000000000 dead000000000100 dead000000000122 0000000000000000
1523 raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
1523 page dumped because: not locked

(an order-9 page will occupy PFNs 0x1dc00-0x1ddff)

It's clearly been freed and is still sitting on the per-CPU free list.
I've also seen them as PageBuddy and, as in the first example above,
reallocated to a different user.
