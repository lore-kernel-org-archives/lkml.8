Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D73BC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 03:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C26206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 03:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588649040;
	bh=fGAHGaEt2j3gLtKzmqvCyvgyxN3s0CESFCq+IQi+R54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MG4rJqoE6t9/aEslJmiFFrbkqZ8R6NFIwRiVCJC6xySmkDZv/A9ZYIDW61Zdu7U5k
	 C0eoooxuNDAeE+tw1DaBupavyIqY6dso7Ig5d4JQw5ivrGIDczUh7AGRwrNjGKo1kW
	 OZJfLS3xuTUoWy638IchYoShnNZrtjlK0RbTRjho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgEEDX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 23:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgEEDX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 23:23:59 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B2820663;
        Tue,  5 May 2020 03:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588649038;
        bh=fGAHGaEt2j3gLtKzmqvCyvgyxN3s0CESFCq+IQi+R54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JTgWWppOLTMzQME6ZKTNNccGCOrFdc11JW6VwM5LEfQfqml0Rth1qPIbdQ5MR5bSo
         EIzDc2+5BBb9Z/jR1WUTsVshIm1s0J6h9qO+hejNhHBGc5CfnFfNUl/H0HYW6AruCu
         ZjROhd+Md9S7OMFSAY+KVrfTENh0/1x/CxGY2SD8=
Date:   Mon, 4 May 2020 20:23:58 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant check in
 f2fs_force_buffered_io
Message-ID: <20200505032358.GA136485@google.com>
References: <20200504143538.159967-1-jaegeuk@kernel.org>
 <b18c4be5-b56d-6b6e-3f99-d2fe05d330eb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b18c4be5-b56d-6b6e-3f99-d2fe05d330eb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05, Chao Yu wrote:
> On 2020-5-4 22:35, Jaegeuk Kim wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > We already checked whether the file is compressed or not in
> > f2fs_post_read_required(). So removed f2fs_compressed_file()
> > in f2fs_force_buffered_io().
> 
> Agreed, since I have sent similar patch before:
> 
> https://lkml.org/lkml/2020/3/24/1819

Heh, as I couldn't find yours, I was actually waiting for you to point out. :)

> 
> Just want to know what's the change of backport concern now.

Old ICE support had to decouple f2fs_post_read_required() and
f2fs_forced_buffered_io(). Now, I decide to manage this as we
need to manage this for one kernel version only.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 6b7b963641696..01a00fc808361 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -4064,8 +4064,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
> >  		return true;
> >  	if (f2fs_is_multi_device(sbi))
> >  		return true;
> > -	if (f2fs_compressed_file(inode))
> > -		return true;
> >  	/*
> >  	 * for blkzoned device, fallback direct IO to buffered IO, so
> >  	 * all IOs can be serialized by log-structured write.
> > 
