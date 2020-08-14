Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2385C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B180A20838
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597372391;
	bh=FxQK/+6mDIN7VUxi1zSpDTNLnEzooa/yyKmtwqiTbpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TnHkqbGN4X6HhfCfJKBPFc0JykknLiqlovWvlJM/yAwCAWkHWnaNl/OdsL0zfiAAl
	 dK+kIj0oHobexxI6GW2txmyZm+dHKDjHQAjFh4hly/1iHRCDJiJY682fKAC1owzQf/
	 74UszdW4wIsYIkxQdhBveH17MJSc+zRXOQpVpRRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHNCdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHNCdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:33:09 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44E5C206DA;
        Fri, 14 Aug 2020 02:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597372388;
        bh=FxQK/+6mDIN7VUxi1zSpDTNLnEzooa/yyKmtwqiTbpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NGJsz+9ZX8vAjjWWcMA51rVwnrE+eFQ8Tg14gUTMbBw3s1ZZVe/1gSYPuwej2dS/4
         N2UNHgwmlRf44N7p5JwnJVDyV/ARy7/U6vYyy/t/JTJ0tf70/IgZxcAZ+fXnVBImQq
         c8c8iOd/k41SSxwSKVbsc7s7fnXoK5WvFDJNa6e8=
Date:   Thu, 13 Aug 2020 19:33:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <klamm@yandex-team.ru>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm : update ra->ra_pages if it's NOT equal to
 bdi->ra_pages
Message-Id: <20200813193307.d5597367b7964d95f63e4580@linux-foundation.org>
In-Reply-To: <CAGWkznEkTeTq4-wPKBcNsF2vF5SVaFc3xoZmceKSwg34vpkqbg@mail.gmail.com>
References: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
        <20200814014355.GS17456@casper.infradead.org>
        <20200814020700.GT17456@casper.infradead.org>
        <CAGWkznEkTeTq4-wPKBcNsF2vF5SVaFc3xoZmceKSwg34vpkqbg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 10:20:11 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> On Fri, Aug 14, 2020 at 10:07 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Aug 14, 2020 at 02:43:55AM +0100, Matthew Wilcox wrote:
> > > On Fri, Aug 14, 2020 at 09:30:11AM +0800, Zhaoyang Huang wrote:
> > > > file->f_ra->ra_pages will remain the initialized value since it opend, which may
> > > > be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
> > > > echo xxx > /sys/block/dm/queue/read_ahead_kb).So sync ra->ra_pages to the
> > > > updated value when sync read.
> > >
> > > It still ignores the work done by shrink_readahead_size_eio()
> > > and fadvise(POSIX_FADV_SEQUENTIAL).
> >
> > ... by the way, if you're trying to update one particular file's readahead
> > state, you can just call fadvise(POSIX_FADV_NORMAL) on it.
> >
> > If you want to update every open file's ra_pages by writing to sysfs,
> > then just no.  We don't do that.
> No, What I want to fix is the file within one process's context  keeps
> using the initialized value when it is opened and not sync with new
> value when bdi->ra_pages changes.

So you're saying that

	echo xxx > /sys/block/dm/queue/read_ahead_kb

does not affect presently-open files, and you believe that it should do
so?

I guess that could be a reasonable thing to want - it's reasonable for
a user to expect that writing to a global tunable will take immediate
global effect.  I guess.

But as Matthew says, it would help if you were to explain why this is
needed.  In full detail.  What operational problems is the present
implementation causing?
