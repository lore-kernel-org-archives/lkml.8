Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0762077D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593550598;
	bh=SyHZ0Wo0kdMmXhB3HauNfjbw3rcUtpXH44TVKsmAjGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qoXDrgu7773q7m+Z9mrOUIEGXVCPBTpG5euUJq+cFin89jhe5xCzgUzfg3qacGIuk
	 y0RMUWJlsdI0TgKaQqApG+d+WtIMbEUBi2k9UB3OVAYxh36PKE+u4yDnbei7i5JkWF
	 uWKZUUTdCwNHW02eFmD3+BTnG1rciqg8gxhkCK7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgF3U4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgF3U4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:56:36 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F32E22074D;
        Tue, 30 Jun 2020 20:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593550596;
        bh=SyHZ0Wo0kdMmXhB3HauNfjbw3rcUtpXH44TVKsmAjGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poiy4WZ9FK2/3ySDGGwENxJRuNeC9b7nRe7aM8hJoJXADIW3NillTF248reYglom8
         0+ZuFTxbRjkkQjnv+ejTW5FXps36eGS/0zvgIlkiu8CDtqvPzWWSp08v4sfnRsVBJk
         InH2N6wr38soyV1bleIvfSlOAcFHCPDb6YcWj1aA=
Date:   Tue, 30 Jun 2020 13:56:35 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid readahead race condition
Message-ID: <20200630205635.GB1396584@google.com>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
 <20200629150323.GA3293033@google.com>
 <20200629202720.GA230664@google.com>
 <20200630204348.GA2504307@ubuntu-s3-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200630204348.GA2504307@ubuntu-s3-xlarge-x86>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30, Nathan Chancellor wrote:
> On Mon, Jun 29, 2020 at 01:27:20PM -0700, Jaegeuk Kim wrote:
> > If two readahead threads having same offset enter in readpages, every read
> > IOs are split and issued to the disk which giving lower bandwidth.
> > 
> > This patch tries to avoid redundant readahead calls.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > v3:
> >  - use READ|WRITE_ONCE
> > v2:
> >   - add missing code to bypass read
> >  
> >  fs/f2fs/data.c  | 18 ++++++++++++++++++
> >  fs/f2fs/f2fs.h  |  1 +
> >  fs/f2fs/super.c |  2 ++
> >  3 files changed, 21 insertions(+)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 995cf78b23c5e..360b4c9080d97 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2296,6 +2296,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
> >  	unsigned nr_pages = rac ? readahead_count(rac) : 1;
> >  	unsigned max_nr_pages = nr_pages;
> >  	int ret = 0;
> > +	bool drop_ra = false;
> >  
> >  	map.m_pblk = 0;
> >  	map.m_lblk = 0;
> > @@ -2306,10 +2307,24 @@ static int f2fs_mpage_readpages(struct inode *inode,
> >  	map.m_seg_type = NO_CHECK_TYPE;
> >  	map.m_may_create = false;
> >  
> > +	/*
> > +	 * Two readahead threads for same address range can cause race condition
> > +	 * which fragments sequential read IOs. So let's avoid each other.
> > +	 */
> > +	if (rac && readahead_count(rac)) {
> > +		if (READ_ONCE(F2FS_I(inode)->ra_offset) == readahead_index(rac))
> > +			drop_ra = true;
> > +		else
> > +			WRITE_ONCE(F2FS_I(inode)->ra_offset,
> > +						readahead_index(rac));
> > +	}
> > +
> >  	for (; nr_pages; nr_pages--) {
> >  		if (rac) {
> >  			page = readahead_page(rac);
> >  			prefetchw(&page->flags);
> > +			if (drop_ra)
> > +				goto next_page;
> 
> When CONFIG_F2FS_FS_COMPRESSION is not set (i.e. x86_64 defconfig +
> CONFIG_F2FS_FS=y):
> 
> $ make -skj"$(nproc)" O=out distclean defconfig fs/f2fs/data.o
> ../fs/f2fs/data.c: In function ‘f2fs_mpage_readpages’:
> ../fs/f2fs/data.c:2327:5: error: label ‘next_page’ used but not defined
>  2327 |     goto next_page;
>       |     ^~~~
> ...

Thanks. I pushed the fix for -next.
https://lore.kernel.org/linux-f2fs-devel/1be18397-7fc6-703e-121b-e210e101357f@infradead.org/T/#t

Thanks,

> 
> Cheers,
> Nathan
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
