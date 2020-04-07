Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488DAC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1636220768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586225737;
	bh=/7+kFSdsBEBC6Khz6wgfGcdiDBnwpU8sm/wk9IKrNdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yOzOpODpvTkDLZAc1hbH1XBWIU4HOQ1gYPHRYswygEFmAnZPqh+3rDZsoFZnQn9uN
	 8kNg/dqHs14gaRUDrYVa164D35SOZ4gR1f3/22c1YEi2l5mUI7vPYhaX+8VSXJRqqk
	 Fo1YXytanRu66HrbuaUdoudQRPGqVXtAliz80dFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDGCPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 22:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgDGCPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:15:35 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D26B9206C0;
        Tue,  7 Apr 2020 02:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586225735;
        bh=/7+kFSdsBEBC6Khz6wgfGcdiDBnwpU8sm/wk9IKrNdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ODXcvNL2jbO13NOwHqociXoDhYkqguNgR0GmvcDGbbKd4KCYfAQMA4Fn0hFKfrESP
         +lDX3yUUD2Z6JXwcm9G+mW/aODZw0tRJj9UFxxCiNaJiZ9YuUXo0dloG9V//CzuU92
         kRZkyeDQqICTwKgehE1ygM7VVa2iuRLBa5BiuAeE=
Date:   Mon, 6 Apr 2020 19:15:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     syzbot <syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com>,
        bgeffon@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Subject: Re: BUG: unable to handle kernel paging request in
 kernel_get_mempolicy
Message-Id: <20200406191534.aafd8f74406c242ba1a42549@linux-foundation.org>
In-Reply-To: <20200407015535.GC48345@xz-x1>
References: <0000000000002b25f105a2a3434d@google.com>
        <20200407004745.GA48345@xz-x1>
        <20200406183941.38a2e52026e42dbfde239a56@linux-foundation.org>
        <20200407015535.GC48345@xz-x1>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 21:55:35 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Mon, Apr 06, 2020 at 06:39:41PM -0700, Andrew Morton wrote:
> > On Mon, 6 Apr 2020 20:47:45 -0400 Peter Xu <peterx@redhat.com> wrote:
> > 
> > > >From 23800bff6fa346a4e9b3806dc0cfeb74498df757 Mon Sep 17 00:00:00 2001
> > > From: Peter Xu <peterx@redhat.com>
> > > Date: Mon, 6 Apr 2020 20:40:13 -0400
> > > Subject: [PATCH] mm/mempolicy: Allow lookup_node() to handle fatal signal
> > > 
> > > lookup_node() uses gup to pin the page and get node information.  It
> > > checks against ret>=0 assuming the page will be filled in.  However
> > > it's also possible that gup will return zero, for example, when the
> > > thread is quickly killed with a fatal signal.  Teach lookup_node() to
> > > gracefully return an error -EFAULT if it happens.
> > > 
> > > ...
> > >
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -902,7 +902,10 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
> > >  
> > >  	int locked = 1;
> > >  	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> > > -	if (err >= 0) {
> > > +	if (err == 0) {
> > > +		/* E.g. GUP interupted by fatal signal */
> > > +		err = -EFAULT;
> > > +	} else if (err > 0) {
> > >  		err = page_to_nid(p);
> > >  		put_page(p);
> > >  	}
> > 
> > Doh.  Thanks.
> > 
> > Should it have been -EINTR?
> 
> It looks ok to me too.  I was returning -EFAULT to follow the same
> value as get_vaddr_frames() (which is the other caller of
> get_user_pages_locked()).  So far the only path that I found can
> trigger this is when there's a fatal signal pending right after the
> gup.  If so, the userspace won't have a chance to see the -EINTR (or
> whatever we return) anyways.

Yup.  I guess we're a victim of get_user_pages()'s screwy return value
conventions - the caller cannot distinguish between invalid-addr and
fatal-signal.

Which makes one wonder why lookup_node() ever worked.  What happens if
get_mempolicy(MPOL_F_NODE) is passed a wild userspace address?

