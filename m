Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F74FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0977206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQ8hdHb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHNCcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgHNCcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:32:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00CEC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 19:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Ox16uoz56iRpNNmrHLVdorDlsngwDtbNSjDHVTS/d4=; b=eQ8hdHb09rNm971hs2RNIMGwb+
        2mDzvLNKMzGSYZf4E7xmYQJ6qw0bQd9KELKQDf61OdCMP706HXYeTzN0QE9jveIhmZj/yWwMglCki
        xyd8/VRrrGaIPwPOJG3Ido8al1GNQSMvk7jgK6xZ9VA9/XwRuu3Q5tpoTA2H1nXm+8MUH2E9+yxuX
        tuqU1zTsXLHsSNKe9EJlKDRCv7xPfKXpv6WeZU6VT4EA2MH0QybWJ28HgmgvqVZ6fQqxWBvujaQwM
        y9h/rQZyGnbDrjfy3Jt+YxsFYlFPMAows2sHKaA6/Wj1otYTXXIFpQEg6odOpjAjra1K7uz0pSHNd
        58FtSJIw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6PVc-0002Et-0e; Fri, 14 Aug 2020 02:31:56 +0000
Date:   Fri, 14 Aug 2020 03:31:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Roman Gushchin <klamm@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm : update ra->ra_pages if it's NOT equal to
 bdi->ra_pages
Message-ID: <20200814023155.GU17456@casper.infradead.org>
References: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20200814014355.GS17456@casper.infradead.org>
 <20200814020700.GT17456@casper.infradead.org>
 <CAGWkznEkTeTq4-wPKBcNsF2vF5SVaFc3xoZmceKSwg34vpkqbg@mail.gmail.com>
 <CAGWkznGUBp+dHk3NugBzfftObosjH7Gg4s8C-AwkQBr5fM6-gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGUBp+dHk3NugBzfftObosjH7Gg4s8C-AwkQBr5fM6-gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 10:26:23AM +0800, Zhaoyang Huang wrote:
> On Fri, Aug 14, 2020 at 10:20 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > On Fri, Aug 14, 2020 at 10:07 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Aug 14, 2020 at 02:43:55AM +0100, Matthew Wilcox wrote:
> > > > On Fri, Aug 14, 2020 at 09:30:11AM +0800, Zhaoyang Huang wrote:
> > > > > file->f_ra->ra_pages will remain the initialized value since it opend, which may
> > > > > be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
> > > > > echo xxx > /sys/block/dm/queue/read_ahead_kb).So sync ra->ra_pages to the
> > > > > updated value when sync read.
> > > >
> > > > It still ignores the work done by shrink_readahead_size_eio()
> > > > and fadvise(POSIX_FADV_SEQUENTIAL).
> > >
> > > ... by the way, if you're trying to update one particular file's readahead
> > > state, you can just call fadvise(POSIX_FADV_NORMAL) on it.
> > >
> > > If you want to update every open file's ra_pages by writing to sysfs,
> > > then just no.  We don't do that.
> > No, What I want to fix is the file within one process's context  keeps
> > using the initialized value when it is opened and not sync with new
> > value when bdi->ra_pages changes.
> So you mean it is just the desired behavior as having the opened file
> use the initialized value even if bdi->ra_pages changed via sysfs?

That's right.  If that's not the behaviour you want, call
fadvise(POSIX_FADV_NORMAL).

> > >
> > > You haven't said what problem you're facing, so I really can't be more
> > > helpful.
