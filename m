Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB98C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9572068F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="NvYNY7Tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgG2TVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgG2TVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:21:49 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B24C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:21:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so13658543ljn.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZB6PqXVrz5GUUQAY9WM4ELYLz3J+vdSWXq2TsK1v6aU=;
        b=NvYNY7TwAHE2N/ztzbEOeXlqyE8Ct0z//l5AqDWdFoebYVzAAAisxuVl1LYnrhFaP9
         lt4vBjxoB99WzZCaQgX9EoOZHPQIR6Y4Q+PMf23n8g8F2/wif32elAL6TqUhMmen8nqk
         2pN//ZNApPQ8iq62+NZltVFiTa1Ug/aCH2kPkNILiRBCCTvWVtqRo1W56PeNxUh45j9C
         7oYNTU/BbHnLx+4qL0RmNbNTSqEweRnfoNaBjoW7+TxJM35+WpO9koDL9nuB0DsMb/Gl
         OL9m9orWWZ6GeaFaLycpDFVCXtSph3dbg2w91SfhYJJwQOSECZLSk3Y6lr3ByCdnAOEp
         LVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZB6PqXVrz5GUUQAY9WM4ELYLz3J+vdSWXq2TsK1v6aU=;
        b=UFNDTwUranuQdbZF8reSh8F7oC6wxiaeB6tJGxTGDug/Lt4oJSLPSo28pltqPsvWPc
         Xs1x4+G5GYZr9NIj+TjAPI4DsGYhEQs30noNOPnJ8+fSwZNXPg7RsLe0+Z9wLsQLAZSE
         i/Prvv+bAebYhVP6mE0gGoCkGEbcXRJc+KPAAt8QclgxRyAQkfAPR/WKNr4UfFQ0qFj9
         KyNE4LsPgXqyIRNsw7HleuTj30QQtg3uFKtRAv6CTYSYzFLpJQrGSPoICjX5sjSMhlET
         dt9KOsuvpV0cpelaKK5zCmCNUdyxTEqJW2yB7jUrwnZ4L3Aa5WGA9wSRF1n4a78g8r/B
         /eKg==
X-Gm-Message-State: AOAM531+MeWCQMpq1Y9Cmdt4GaUQ+w42SUuwadFpVKma0eYtN6bOniRJ
        JFt3QusiH3/e3TVNPHVN7nWcAw==
X-Google-Smtp-Source: ABdhPJxSltwjqakPgGLG7TuTTZyBu1uQYyCDPFqqePN9f/1Af2GHYnLAyCp3C/2nts02DT+NXMfKsw==
X-Received: by 2002:a2e:95c5:: with SMTP id y5mr14773121ljh.34.1596050507849;
        Wed, 29 Jul 2020 12:21:47 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r22sm558638ljc.25.2020.07.29.12.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:21:46 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2AC73102152; Wed, 29 Jul 2020 22:21:51 +0300 (+03)
Date:   Wed, 29 Jul 2020 22:21:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20200729192151.eyghcfysfzaf2ijg@box>
References: <000000000000bc4fd705a6e090e2@google.com>
 <0000000000004c38cd05aad1d13f@google.com>
 <20200720165144.93189f7825bd28e234a42cb8@linux-foundation.org>
 <20200723073744.5268-1-hdanton@sina.com>
 <20200724111311.rcjqigtjqpkenxg6@box>
 <20200726164904.GG23808@casper.infradead.org>
 <20200727103140.xycdx6ctecomqsoe@box>
 <20200727120310.GJ23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727120310.GJ23808@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 01:03:10PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 27, 2020 at 01:31:40PM +0300, Kirill A. Shutemov wrote:
> > On Sun, Jul 26, 2020 at 05:49:04PM +0100, Matthew Wilcox wrote:
> > > On Fri, Jul 24, 2020 at 02:13:11PM +0300, Kirill A. Shutemov wrote:
> > > > On Thu, Jul 23, 2020 at 03:37:44PM +0800, Hillf Danton wrote:
> > > > > 
> > > > > On Tue, 21 Jul 2020 14:11:31 +0300 Kirill A. Shutemov wrote:
> > > > > > On Mon, Jul 20, 2020 at 04:51:44PM -0700, Andrew Morton wrote:
> > > > > > > On Sun, 19 Jul 2020 14:10:19 -0700 syzbot wrote:
> > > > > > > 
> > > > > > > > syzbot has found a reproducer for the following issue on:
> > > > > > > > 
> > > > > > > > HEAD commit:    4c43049f Add linux-next specific files for 20200716
> > > > > > > > git tree:       linux-next
> > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12c56087100000
> > > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2c76d72659687242
> > > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=c48f34012b06c4ac67dd
> > > > > > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1344abeb100000
> > > > > > > > 
> > > > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > > > Reported-by: syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com
> > > > > > > 
> > > > > > > Thanks.
> > > > > > > 
> > > > > > > __handle_mm_fault
> > > > > > >   ->pmd_migration_entry_wait
> > > > > > >     ->migration_entry_to_page
> > > > > > > 
> > > > > > > stumbled onto an unlocked page.
> > > > > > > 
> > > > > > > I don't immediately see a cause.  Perhaps Matthew's "THP prep patches",
> > > > > > > perhaps something else.
> > > > > > > 
> > > > > > > Is it possible to perform a bisection?
> > > > > > 
> > > > > > Maybe it's related to the new lock_page_async()?
> > > > > 
> > > > > Or is there likely the window that after copy_huge_pmd() the src pmd migrate
> > > > > entry is removed and the page unlocked but the dst is not?
> > > > 
> > > > No.
> > > > 
> > > > copy_huge_pmd() runs with exclusive mmap_lock on the source side and
> > > > destination side is not running yet.
> > > 
> > > The one I'm hitting is huge related though.
> > > 
> > > I added this debug:
> > > 
> > > +++ b/include/linux/swapops.h
> > > @@ -165,8 +165,9 @@ static inline struct page *device_private_entry_to_page(swp_entry_t entry)
> > >  #ifdef CONFIG_MIGRATION
> > >  static inline swp_entry_t make_migration_entry(struct page *page, int write)
> > >  {
> > > -       BUG_ON(!PageLocked(compound_head(page)));
> > > +       VM_BUG_ON_PAGE(!PageLocked(page), page);
> > >  
> > > +if (PageCompound(page)) printk("pfn %lx order %d\n", page_to_pfn(page), thp_order(thp_head(page)));
> > >         return swp_entry(write ? SWP_MIGRATION_WRITE : SWP_MIGRATION_READ,
> > >                         page_to_pfn(page));
> > >  }
> > > @@ -194,7 +195,11 @@ static inline struct page *migration_entry_to_page(swp_entry_t entry)
> > >          * Any use of migration entries may only occur while the
> > >          * corresponding page is locked
> > >          */
> > > -       BUG_ON(!PageLocked(compound_head(p)));
> > > +       if (!PageLocked(p)) {
> > > +               dump_page(p, "not locked");
> > > +               printk("swap entry %d.%lx\n", swp_type(entry), swp_offset(entry));
> > > +               BUG();
> > > +       }
> > >         return p;
> > >  }
> > >  
> > > 
> > > and got useful output (while running generic/086):
> > > 
> > > 1457 086 (20181): drop_caches: 3
> > > 1457 page:00000000a216ae9a refcount:2 mapcount:0 mapping:000000009ba7bfed index:0x2227 pfn:0x229e7
> > > 1457 aops:def_blk_aops ino:0
> > > 1457 flags: 0x4000000000002030(lru|active|private)
> > > 1457 raw: 4000000000002030 fffff5b4416b5a48 fffff5b4408a7988 ffff9e9c34848578
> > > 1457 raw: 0000000000002227 ffff9e9bd18f0d00 00000002ffffffff 0000000000000000
> > > 1457 page dumped because: not locked
> > > 1457 swap entry 30.229e7
> > > 1457 ------------[ cut here ]------------
> > > 1457 kernel BUG at include/linux/swapops.h:201!
> > > 1457 invalid opcode: 0000 [#1] SMP PTI
> > > 1457 CPU: 3 PID: 646 Comm: check Kdump: loaded Tainted: G        W         5.8.0-rc6-00067-gd8b18bdf9870-dirty #355
> > > 1457 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > > 1457 RIP: 0010:__migration_entry_wait+0x109/0x110
> > > [...]
> > > 
> > > Looking back in the trace, I see:
> > > 
> > > ...
> > > 1457 pfn 229e5 order 9
> > > 1457 pfn 229e6 order 9
> > > 1457 pfn 229e7 order 9
> > > 1457 pfn 229e8 order 9
> > > 1457 pfn 229e9 order 9
> > > ...
> > > 
> > > so I would say we have a refcount problem.  I've probably made it worse by
> > > creating more THPs, but I don't think I'm the originator of the problem.
> > > 
> > > I know very little about the migration code today.  I suspect I'm going
> > > to have to learn about it next week.
> > 
> > It would be interesting to know if the migration entires ever got removed
> > for pfn. I mean if remove_migration_pte() got called for it.
> > 
> > It can be rmap issue too. Maybe it misses PMD on remove_migration_ptes()
> > or something.
> 
> It's not mapped with a PMD.  I tweaked my debugging slightly:
> 
>  static inline swp_entry_t make_migration_entry(struct page *page, int write)
>  {
> -       BUG_ON(!PageLocked(compound_head(page)));
> +       VM_BUG_ON_PAGE(!PageLocked(page), page);
>  
> +if (PageHead(page)) dump_page(page, "make entry");
> +if (PageTail(page)) printk("pfn %lx order %d\n", page_to_pfn(page), thp_order(thp_head(page)));
> 
> 1523 page:0000000006f62206 refcount:490 mapcount:1 mapping:0000000000000000 index:0x562b12a00 pfn:0x1dc00
> 1523 head:0000000006f62206 order:9 compound_mapcount:0 compound_pincount:0
> 1523 anon flags: 0x400000000009003d(locked|uptodate|dirty|lru|active|head|swapbacked)
> 1523 raw: 400000000009003d ffffecfd41301308 ffffecfd41b08008 ffff9e9971c00059
> 1523 raw: 0000000562b12a00 0000000000000000 000001ea00000000 0000000000000000
> 1523 page dumped because: make entry
> 1523 pfn 1dc01 order 9
> 1523 pfn 1dc02 order 9
> 1523 pfn 1dc03 order 9
> ...
> 
> Notice that it's an anonymous page, so it's not related to my work.

I don't have much hope, but could you try if the patch below would blow
up?

Could you share the setup you use to trigger the issue? I want try it
myself.

diff --git a/mm/migrate.c b/mm/migrate.c
index 40cd7016ae6f..c3148e1261d0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -215,6 +215,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 	pte_t pte;
 	swp_entry_t entry;
 
+	VM_BUG_ON_PAGE(PageTail(pvmw.page), pvmw.page);
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	while (page_vma_mapped_walk(&pvmw)) {
 		if (PageKsm(page))
-- 
 Kirill A. Shutemov
