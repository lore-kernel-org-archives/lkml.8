Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7DBC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD55620757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586456168;
	bh=F6A6L95TfXC9Im6RVIrucsqTA1aJkk1UedJweoXMcSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=02ZChTfdccFPD8XmdQp6GA+StgDKDpin2hGpyY9w/+4U7T9byg33sownQCvRWgGEa
	 FVb3BcRW+YHjDt9qrn32dsPCw4V+POVMA5Oa5go2oqdGhKx8GkI/9q5xLah+CEyssN
	 ZZWu6KGvL66bM+gqg7hyvyZCUpgvw8wst8sh6ZJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDISQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDISQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:16:06 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6A120753;
        Thu,  9 Apr 2020 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586456165;
        bh=F6A6L95TfXC9Im6RVIrucsqTA1aJkk1UedJweoXMcSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xS2XsRgbixRosOGdswcztdxrrAqR+maXoBdL50w69tFnh+onBl9XlwiD/6jJ4qxBE
         AOoS+IXD/fMCgEIfDfuxao9shM7e26y9iWMCWoCDlA8S4XpKdTghLElrP0BXNMq0Xn
         BAn/KfTK1Aj1GN0GRsoqi9/CI53qS+X2IIrdRzxY=
Date:   Thu, 9 Apr 2020 11:16:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-Id: <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
In-Reply-To: <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
References: <20200408014010.80428-1-peterx@redhat.com>
        <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
        <20200409114940.GT21484@bombadil.infradead.org>
        <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020 15:00:20 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:

> On Thu, Apr 9, 2020 at 1:49 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Apr 08, 2020 at 05:47:32PM -0700, Andrew Morton wrote:
> > > On Tue,  7 Apr 2020 21:40:08 -0400 Peter Xu <peterx@redhat.com> wrote:
> > >
> > > > The two patches should fix below syzbot reports:
> > > >
> > > >   BUG: unable to handle kernel paging request in kernel_get_mempolicy
> > > >   https://lore.kernel.org/lkml/0000000000002b25f105a2a3434d@google.com/
> > > >
> > > >   WARNING: bad unlock balance in __get_user_pages_remote
> > > >   https://lore.kernel.org/lkml/00000000000005c65d05a2b90e70@google.com/
> > >
> > > (Is there an email address for the syzbot operators?)
> >
> > I'd suggest syzkaller-bugs@googlegroups.com (added to the Cc).
> 
> syzkaller@googlegroups.com is a better one.
> syzkaller-bugs@googlegroups.com plays more of an LKML role.
> 
> > But there's a deeper problem in that we don't have anywhere to stash
> > that kind of information in the kernel tree right now.  Perhaps a special
> > entry in the MAINTAINERS file for bot operators?  Or one entry per bot?
> 
> I don't mind adding syzkaller. Some time ago I wanted to contact
> KernelCI, CKI, LKFT, 0-day owners, finding relevant lists wasn't
> impossible, but for some it was hard.
> 
> For syzkaller it would be:
> 
> https://github.com/google/syzkaller/issues for bugs/feature requests.
> syzkaller@googlegroups.com for discussions.

OK, thanks.  A MAINTAINERS entry would be great.

Could I please direct attention back to my original question regarding
the problems we've recently discovered in 4426e945df58 ("mm/gup: allow
VM_FAULT_RETRY for multiple times") and 71335f37c5e8 ("mm/gup: allow to
react to fatal signals")?

> sysbot does test linux-next, yet these patches sat in linux-next for a
> month without a peep, but all hell broke loose when they hit Linus's
> tree.  How could this have happened?
> 
> Possibly I've been carrying a later patch which fixed all this up, but
> I'm not seeing anything like that.  Nothing at all against mm/gup.c.

