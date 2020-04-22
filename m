Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947A4C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6BC20724
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ognTxkwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDVCSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDVCSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:18:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88E7C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 19:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=huampyiQ/nfH+0rWduVv/3eKAYSafHdbdxfLLYXUAX8=; b=ognTxkwzauShK1Y06l8uXWZW2Z
        aN2LnetxIUAr6zpPQDdcWn5A7gC0vSkRMgUIClWSnfLQt15emgforT9g23jHpygmGDCZ8oiK+O5o1
        rJHcfts830zd+R+KBYvma+DlOQVDZDuOp11PInp46f8XH5DmN8u0OidGNhvvtDQ1wTZif3Bd3luJM
        HkMZjCWpwmbMJRgBInbiEf27TKwNWxxSljiOvLfQcQYrLGfbSGZde4J6Y699zIqkxwaVCwLYJ+S0n
        9Gqv9G5sWnRWIpBLi3AH3VKHra/vKPEw6CmHYPM6f6sS5coAHW6uMPs9CHCk+E63XyL2YPVHQUdC6
        ywX5ZlMQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR4yQ-0005y7-MS; Wed, 22 Apr 2020 02:18:50 +0000
Date:   Tue, 21 Apr 2020 19:18:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5 09/10] mmap locking API: add mmap_assert_locked
Message-ID: <20200422021850.GS5820@bombadil.infradead.org>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-10-walken@google.com>
 <CANN689FQf3gMTTXr7vwYujvuoVNDHdRFWWwaBQAdhifeE=zBbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689FQf3gMTTXr7vwYujvuoVNDHdRFWWwaBQAdhifeE=zBbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:10:39PM -0700, Michel Lespinasse wrote:
> On Tue, Apr 21, 2020 at 5:14 PM Michel Lespinasse <walken@google.com> wrote:
> > +static inline void mmap_assert_locked(struct mm_struct *mm)
> > +{
> > +       if (IS_ENABLED(CONFIG_LOCKDEP) && debug_locks)
> > +               VM_BUG_ON_MM(!lockdep_is_held(&mm->mmap_sem), mm);
> > +       else
> > +               VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> > +}
> 
> Turns out this function definition does not work for !CONFIG_LOCKDEP
> as lockdep_is_held is not defined in that case.

Oops, sorry.  It only defines

#define lockdep_is_held_type(l, r)              (1)
#define lockdep_assert_held(l)                  do { (void)(l); } while (0)
#define lockdep_assert_held_write(l)    do { (void)(l); } while (0)
#define lockdep_assert_held_read(l)             do { (void)(l); } while (0)
#define lockdep_assert_held_once(l)             do { (void)(l); } while (0)

which seems like an oversight, but not one that you should be fixing.

> The following should work instead:
> 
> static inline void mmap_assert_locked(struct mm_struct *mm)
> {
> #ifdef CONFIG_LOCKDEP
>         if (debug_locks) {
>                 VM_BUG_ON_MM(!lockdep_is_held(&mm->mmap_lock), mm);
>                 return;
>         }
> #endif
>         VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> }

Yes, I agree.
