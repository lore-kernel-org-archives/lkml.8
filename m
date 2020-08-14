Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89118C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BC820715
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TTWFAdtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHNDTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 23:19:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF2C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 20:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rBYMDlxTiytCZOnej5NOe0TEBJStDGeKuKqn0WaGAj0=; b=TTWFAdtBK1+bVftJ/OqF/azC0M
        pqwZT+TlfShXxbamW3IjWAiZT++8tBBVcF34m3c1uuD1E7agFUdKic/Se9Riy8MVEV/m01ARuxYnk
        p61gMHbgTozzBo5D+nQNqCWR2g0z7dYyeAsxRnlckMaUuRNf64dgUsVASm01f8xouKRVxNHicMqqr
        xoGcDB/Vvaj6sPkQ0HZpXyxJ+3hf2+g4KXbgZ1ExvbpH6cSEqk07SwoIy77xShnHvPucQxDdbn+4m
        fHHrCxz2e7dldytvaIQWEeePy62h6tiMJAz9OnWwUwW5JBXw6ALSQMsxpKBaDrdepp3v1G9ttkheO
        MgjXM1VQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6QFd-0004tP-NA; Fri, 14 Aug 2020 03:19:29 +0000
Date:   Fri, 14 Aug 2020 04:19:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <klamm@yandex-team.ru>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm : update ra->ra_pages if it's NOT equal to
 bdi->ra_pages
Message-ID: <20200814031929.GV17456@casper.infradead.org>
References: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20200814014355.GS17456@casper.infradead.org>
 <20200814020700.GT17456@casper.infradead.org>
 <CAGWkznEkTeTq4-wPKBcNsF2vF5SVaFc3xoZmceKSwg34vpkqbg@mail.gmail.com>
 <20200813193307.d5597367b7964d95f63e4580@linux-foundation.org>
 <CAGWkznFwDnrSqt68oMp+rcNFT_EgN3ke7-e0Tb1xfXreVXgHYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznFwDnrSqt68oMp+rcNFT_EgN3ke7-e0Tb1xfXreVXgHYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 10:45:37AM +0800, Zhaoyang Huang wrote:
> On Fri, Aug 14, 2020 at 10:33 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 14 Aug 2020 10:20:11 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > > On Fri, Aug 14, 2020 at 10:07 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Fri, Aug 14, 2020 at 02:43:55AM +0100, Matthew Wilcox wrote:
> > > > > On Fri, Aug 14, 2020 at 09:30:11AM +0800, Zhaoyang Huang wrote:
> > > > > > file->f_ra->ra_pages will remain the initialized value since it opend, which may
> > > > > > be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
> > > > > > echo xxx > /sys/block/dm/queue/read_ahead_kb).So sync ra->ra_pages to the
> > > > > > updated value when sync read.
> > > > >
> > > > > It still ignores the work done by shrink_readahead_size_eio()
> > > > > and fadvise(POSIX_FADV_SEQUENTIAL).
> > > >
> > > > ... by the way, if you're trying to update one particular file's readahead
> > > > state, you can just call fadvise(POSIX_FADV_NORMAL) on it.
> > > >
> > > > If you want to update every open file's ra_pages by writing to sysfs,
> > > > then just no.  We don't do that.
> > > No, What I want to fix is the file within one process's context  keeps
> > > using the initialized value when it is opened and not sync with new
> > > value when bdi->ra_pages changes.
> >
> > So you're saying that
> >
> >         echo xxx > /sys/block/dm/queue/read_ahead_kb
> >
> > does not affect presently-open files, and you believe that it should do
> > so?
> >
> > I guess that could be a reasonable thing to want - it's reasonable for
> > a user to expect that writing to a global tunable will take immediate
> > global effect.  I guess.
> >
> > But as Matthew says, it would help if you were to explain why this is
> > needed.  In full detail.  What operational problems is the present
> > implementation causing?
> The real scenario is some system(like android) will turbo read during
> startup via expanding the readahead window and then set it back to
> normal(128kb as usual). However, some files in the system process
> context will keep to be opened since it is opened up and has no chance
> to sync with the updated value as it is almost impossible to change
> the files attached to the inode(processes are unaware of these
> things). we have to fix it from a kernel perspective.

OK, this is a much more useful description of the problem, thank you!

I can think of two possibilities here.  One is that maybe our readahead
heuristics just don't work on modern phone hardware.  Perhaps we need
to ramp up more aggressively by default.

The other is that maybe it really is just a "boost at startup" kind
of situation and so we should support _that_.  Some interface where
we can set a ra_boost, and then do:

	if (ra_boost)
		newsize *= 2;

in get_init_ra_size().

