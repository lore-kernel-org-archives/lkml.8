Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE62C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD49220737
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SBnpFUS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbgGVSqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgGVSqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:46:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F2AC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=UAynzvCxjL3e4O0zfl0v4z4iStqmtrLNJAuOr6Xesjw=; b=SBnpFUS8yKoHh5j6ZcPUJLn32/
        YQWBaHtL8hm06vHgJv37IYOA82d/qf8lR0oIhfcax3bd4bYql6oTLP7iBVhKhc92n+6wlHtC5VE2o
        ehWeIkjudWdJjyBymFeuZjPlSThvAJ4LF/EKEcJWvLUq4lqizk70jJ1WgvAfO5rqly9+DPWW4UzKW
        qKJzohyWKwcO2SF4bn4hUg/XSKOJ33jUVQlKmtNIarQWT+g/AoHOG4A5z03XpEG5dCoaqISNul/rv
        H28i/H2hfYUBHKlBURq2FYZzbKpWGmqRNnvfoAfRxR9zsyTObnR3neQr1G7Afhxh/rmalkKBtUUS8
        n53FhGdw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyJlE-0001xL-MK; Wed, 22 Jul 2020 18:46:36 +0000
Date:   Wed, 22 Jul 2020 19:46:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] XArray for 5.8
Message-ID: <20200722184636.GQ15516@casper.infradead.org>
References: <20200722141151.GO15516@casper.infradead.org>
 <CAHk-=whC-GKFoBGRSnTnD6VxL_J+5xs4BzEhEfyhGMcT8Mga7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whC-GKFoBGRSnTnD6VxL_J+5xs4BzEhEfyhGMcT8Mga7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:40:13AM -0700, Linus Torvalds wrote:
> On Wed, Jul 22, 2020 at 7:11 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > XArray updates for 5.8
> >
> >  - Fix the test suite after introduction of the local_lock
> 
> What? No.
> 
> Now you broke the actual kernel build:
> 
>   In file included from ./include/linux/local_lock.h:5,
>                    from ./include/linux/radix-tree.h:14,
>                    from ./include/linux/idr.h:15,
>                    from lib/idr.c:5:
>   ./include/linux/local_lock_internal.h: In function ‘local_lock_acquire’:
>   ./include/linux/local_lock_internal.h:41:13: error: ‘current’
> undeclared (first use in this function)
>      41 |  l->owner = current;
>         |             ^~~~~~~
>   ./include/linux/local_lock_internal.h:41:13: note: each undeclared
> identifier is reported only once for each function it appears in
> 
> How the hell did you not see this, and why did you think it was a good
> idea to mess with kernel headers and make them alphabetically ordered?

Ah, crap.  I was building without CONFIG_DEBUG_LOCK_ALLOC, so I didn't
see this.

But I think the real problem is that local_lock_internal.h doesn't include
<linux/sched.h>.  Header files shouldn't depend on other headers to be
included first.

> Headers need to be ordered by _contents_, not by some "sort alphabetically".
> 
> Do you sort your bookcases by color and size of the book too?

By author, typically ;-)
