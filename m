Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A42DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CA4206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466237;
	bh=wkackI2rfYcaIhwqNMPcXwmVpxfvX7NY51JrPzFNKm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eiARCpPDHyy71+M6zG3uM3ILFgtERm4OFkJbqcf0f2y6Poth4+np8gDMFGsrtGhCZ
	 Ry8fOXAH/EMEWiK0g+fm/DiUh6WGiIR8j+g+uCT3lz/jl0JLp7ln0F9qxB81ct+GL2
	 zlYnELJgKiMbOixF8nIQOxCHRsZ+6QcT9vVIRSC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391087AbgF2Vag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbgF2SlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:21 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD7F8255E3;
        Mon, 29 Jun 2020 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593455103;
        bh=wkackI2rfYcaIhwqNMPcXwmVpxfvX7NY51JrPzFNKm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Blp8tuH+v0xm4gkhx5A0ISpTqN77nf36qnKbOK9TmxsqaJhHMajqjfDivu7VSTh08
         aAMfNC9mUqwFGKrHwqGjavV7dxtzH2fuRo3vr3RAjjccgO++1NZ0z6FqxKMNjLrUNu
         8x9sfbWrIlUXPrEXqdshhQCQ/Xw0d+XMJG9z9c3w=
Date:   Mon, 29 Jun 2020 11:25:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [PATCH v2] f2fs: avoid readahead race condition
Message-ID: <20200629182502.GF20492@sol.localdomain>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
 <20200629150323.GA3293033@google.com>
 <20200629160934.GA1752982@gmail.com>
 <20200629182414.GA1117827@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629182414.GA1117827@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:24:14AM -0700, Jaegeuk Kim wrote:
> On 06/29, Eric Biggers wrote:
> > On Mon, Jun 29, 2020 at 08:03:23AM -0700, Jaegeuk Kim wrote:
> > > If two readahead threads having same offset enter in readpages, every read
> > > IOs are split and issued to the disk which giving lower bandwidth.
> > > 
> > > This patch tries to avoid redundant readahead calls.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > > v2:
> > >  - add missing code to bypass read
> > > 
> > >  fs/f2fs/data.c  | 18 +++++++++++++++++-
> > >  fs/f2fs/f2fs.h  |  1 +
> > >  fs/f2fs/super.c |  2 ++
> > >  3 files changed, 20 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index d6094b9f3916..9b69a159cc6c 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -2403,6 +2403,7 @@ int f2fs_mpage_readpages(struct address_space *mapping,
> > >  #endif
> > >  	unsigned max_nr_pages = nr_pages;
> > >  	int ret = 0;
> > > +	bool drop_ra = false;
> > >  
> > >  	map.m_pblk = 0;
> > >  	map.m_lblk = 0;
> > > @@ -2413,13 +2414,25 @@ int f2fs_mpage_readpages(struct address_space *mapping,
> > >  	map.m_seg_type = NO_CHECK_TYPE;
> > >  	map.m_may_create = false;
> > >  
> > > +	/*
> > > +	 * Two readahead threads for same address range can cause race condition
> > > +	 * which fragments sequential read IOs. So let's avoid each other.
> > > +	 */
> > > +	if (pages && is_readahead) {
> > > +		page = list_last_entry(pages, struct page, lru);
> > > +		if (F2FS_I(inode)->ra_offset == page_index(page))
> > > +			drop_ra = true;
> > > +		else
> > > +			F2FS_I(inode)->ra_offset = page_index(page);
> > > +	}
> > 
> > This is a data race because ra_offset can be read/written by different threads
> > concurrently.
> > 
> > It either needs locking, or READ_ONCE() and WRITE_ONCE() if races are okay.
> 
> I just wanted to keep zero overhead, since it doesn't matter either cases of
> skipping readahead or not.
> 

Okay, then it should use READ_ONCE() and WRITE_ONCE().

- Eric
