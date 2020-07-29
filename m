Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDF7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C1320656
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mhxY2fy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgG2Typ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Typ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:54:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1664C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GGS573IhCZS2mOBQQ1tjPGeTS9xau0FB27cV2ohvdvQ=; b=mhxY2fy8WfWqpCc53TmJurRGOq
        FY53GgRdECDEss0yx1Fqcw3gb8ys3LHbAVecHiiyN/yj3sv5nXSJzyDHPudqc/Hx+g/Dky+7N5Q7g
        v/dBw46bA88egYez7lQAziFu+gRAUBwCwlTq7B6GT+bW10gCUlXnHbgRagMuouJe+3fbiIzhg0+m+
        rXxxw0VGFqUvabNPgmbl+XZZiOzkrVefT4xDXXJrxOA/nNpSgzo1GpzNlrHNsM7K4dG1SQsKkHnBc
        m3LBPnYAE9ZBrBy1R4CQ5PVv3UDsJoSr3StSf5Stm225boH5Djj4cviOvAVo1khsASgZ0dP+6lc1l
        L2bIO+Eg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0s9o-0001md-Ap; Wed, 29 Jul 2020 19:54:32 +0000
Date:   Wed, 29 Jul 2020 20:54:32 +0100
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
Message-ID: <20200729195432.GY23808@casper.infradead.org>
References: <000000000000bc4fd705a6e090e2@google.com>
 <0000000000004c38cd05aad1d13f@google.com>
 <20200720165144.93189f7825bd28e234a42cb8@linux-foundation.org>
 <20200723073744.5268-1-hdanton@sina.com>
 <20200724111311.rcjqigtjqpkenxg6@box>
 <20200726164904.GG23808@casper.infradead.org>
 <20200727103140.xycdx6ctecomqsoe@box>
 <20200727120310.GJ23808@casper.infradead.org>
 <20200729192151.eyghcfysfzaf2ijg@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729192151.eyghcfysfzaf2ijg@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:21:51PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jul 27, 2020 at 01:03:10PM +0100, Matthew Wilcox wrote:
> > > It would be interesting to know if the migration entires ever got removed
> > > for pfn. I mean if remove_migration_pte() got called for it.
> > > 
> > > It can be rmap issue too. Maybe it misses PMD on remove_migration_ptes()
> > > or something.
> > 
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
> > 1523 pfn 1dc01 order 9
> > 1523 pfn 1dc02 order 9
> > 1523 pfn 1dc03 order 9
> > ...
> > 
> > Notice that it's an anonymous page, so it's not related to my work.
> 
> I don't have much hope, but could you try if the patch below would blow
> up?

Running it now.  Results probably in twenty minutes.

> Could you share the setup you use to trigger the issue? I want try it
> myself.

Head commit d8b18bdf9870b131802d641f5e7f32ddc53dcce3 which you can find
in http://git.infradead.org/users/willy/pagecache.git

I'm using Kent Overstreet's ktest as the base:
https://github.com/koverstreet/ktest

from the root of the kernel tree, I type:
$ ../ktest/build-test-kernel run ../ktest/tests/xfs.ktest 

xfs.ktest is not in Kent's repo:

#!/bin/bash

require-kernel-config XFS_FS
require-kernel-config XFS_QUOTA XFS_POSIX_ACL XFS_RT XFS_ONLINE_SCRUB
require-kernel-config XFS_ONLINE_REPAIR XFS_DEBUG XFS_ASSERT_FATAL
require-kernel-config QUOTA

require-lib xfstests.sh

run_tests()
{
    run_xfstests xfs "$@"
}

I think that's all you'll need to get going.
