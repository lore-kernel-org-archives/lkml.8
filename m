Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71454C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4855F2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PH/J2Afm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgGUCOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUCOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:14:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B8DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 19:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W3Whq0VMGEfbWzT64X+GmmnV7xR1Aj5wCM1jsNMxHBM=; b=PH/J2AfmYn5tmaL14rs1lgEflz
        dPea72AhZomOFw+IqosbYe/rca8ShnXoeJwy45RX+14txjAZXaCKtfmskakMSfsTqY4MoO91hLk5C
        cfFM32PYUty6SWyxhRxeT2F4/EqKNwZDuKCaoWt8Pt+tOWMtVdGumDvJq+nSDUg74R79qnSCX1jlB
        0HPLpbNUz7RWOy+E5UKEhcMBcDGQEOFcV3o24edtBA5G3U2iolvftpEHcWRcst9zy1WNiGsfFwRnl
        QOdIhCiarzGxO8aBNTxH7lhgRfZCjkP5zYtSdFCJ+zuV3s4UOeqG8KpR63uQsDwIJ/qpTgD7bgTKZ
        kR6z94OA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxhnu-0002CG-09; Tue, 21 Jul 2020 02:14:50 +0000
Date:   Tue, 21 Jul 2020 03:14:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: kernel BUG at include/linux/swapops.h:LINE!
Message-ID: <20200721021449.GC15516@casper.infradead.org>
References: <000000000000bc4fd705a6e090e2@google.com>
 <0000000000004c38cd05aad1d13f@google.com>
 <20200720165144.93189f7825bd28e234a42cb8@linux-foundation.org>
 <20200721002147.GA15516@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721002147.GA15516@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 01:21:47AM +0100, Matthew Wilcox wrote:
> On Mon, Jul 20, 2020 at 04:51:44PM -0700, Andrew Morton wrote:
> > On Sun, 19 Jul 2020 14:10:19 -0700 syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com> wrote:
> > 
> > > syzbot has found a reproducer for the following issue on:
> > > 
> > > HEAD commit:    4c43049f Add linux-next specific files for 20200716
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12c56087100000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2c76d72659687242
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c48f34012b06c4ac67dd
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1344abeb100000
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com
> > 
> > Thanks.
> > 
> > __handle_mm_fault
> >   ->pmd_migration_entry_wait
> >     ->migration_entry_to_page
> > 
> > stumbled onto an unlocked page.
> > 
> > I don't immediately see a cause.  Perhaps Matthew's "THP prep patches",
> > perhaps something else.
> 
> That's interesting.  I'm currently chasing that signature too.  Of course,
> almost anything can cause this.
> 
> What I do have in my tree is a patch to turn that WARN_ON into a
> VM_BUG_ON_PAGE and what I see is not just an unlocked page, but one
> that's been freed.

Here's an example crash:

1404 086 (25392): drop_caches: 3
1404 page:00000000c8b7c292 refcount:0 mapcount:-128 mapping:0000000000000000 index:0x1 pfn:0xac20
1404 flags: 0x4000000000000000()
1404 raw: 4000000000000000 fffff7b501775808 fffff7b501ab7008 0000000000000000
1404 raw: 0000000000000001 0000000000000005 00000000ffffff7f 0000000000000000
1404 page dumped because: VM_BUG_ON_PAGE(!PageLocked(p))

(that's generic/086 for what it's worth, but you have to run
through a number of other tests in order to hit it; even starting at
generic/08[0123456] isn't enough to hit it, and it doesn't always hit)

A mapcount of -128 indicates PageBuddy, but I've also seen a mapcount of 0
indicating it's still on the per-cpu freelist.
