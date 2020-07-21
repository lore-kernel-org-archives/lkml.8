Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E4AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE5A207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Co9/0eJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgGUAVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGUAVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:21:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE1BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fdAHbX0dv/Do17AwhRlUboAs/IVQysOkwB9uhIN83/c=; b=Co9/0eJChJlv5VWl9j+o3g66BO
        WHJjIzX+YqUX8XvniVwgmiX3DTD+E3jqTB7HWk7RYNXuFDtB9CS3Lxo4uJABLj2kK0ejh0ZbxpLZx
        30xWnG+GMKgH1s28c8sElSXwLgwdpIc0WFPRfmrg5Poe0BuuugQ4d3DE2AGU21W39JCfmFeIdTUMh
        Lxw1WZBco/NyQPqkE0roHaoveO76Jwz/lu/3pLOrVnavtfDYr/SnsJ3lrybmMdiOq+1YTEF1bQVj5
        u4QyJSXj9Xen/soPjNzNB5fXEss0fZgO/wwKns53RfK5zZOAtsteXLvuxltlCCkEPhWIMhP6sD0mq
        rYzDTcOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxg2V-0004xy-Tb; Tue, 21 Jul 2020 00:21:47 +0000
Date:   Tue, 21 Jul 2020 01:21:47 +0100
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
Message-ID: <20200721002147.GA15516@casper.infradead.org>
References: <000000000000bc4fd705a6e090e2@google.com>
 <0000000000004c38cd05aad1d13f@google.com>
 <20200720165144.93189f7825bd28e234a42cb8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720165144.93189f7825bd28e234a42cb8@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 04:51:44PM -0700, Andrew Morton wrote:
> On Sun, 19 Jul 2020 14:10:19 -0700 syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com> wrote:
> 
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    4c43049f Add linux-next specific files for 20200716
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12c56087100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2c76d72659687242
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c48f34012b06c4ac67dd
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1344abeb100000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com
> 
> Thanks.
> 
> __handle_mm_fault
>   ->pmd_migration_entry_wait
>     ->migration_entry_to_page
> 
> stumbled onto an unlocked page.
> 
> I don't immediately see a cause.  Perhaps Matthew's "THP prep patches",
> perhaps something else.

That's interesting.  I'm currently chasing that signature too.  Of course,
almost anything can cause this.

What I do have in my tree is a patch to turn that WARN_ON into a
VM_BUG_ON_PAGE and what I see is not just an unlocked page, but one
that's been freed.

> Is it possible to perform a bisection?

My testing (xfstests with the full THP patch set) takes about 45 minutes
to hit this bug usually.  Sometimes two hours.  I haven't tried running
it against fewer patches because I thought it was related to having THPs
smaller than PMD size in the page cache.

I don't think it is my patches because they're essentially just a rename.
But of course, I've been wrong before ...
