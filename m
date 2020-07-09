Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19347C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3F620708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594273190;
	bh=u4VGfYmxoQQo8VoSbT3epFWuRgc3syhk7PNc7fYiTNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dfXBvBowLlKVOGLQT7q+M9UWo1PTOM17EvxfGSOyidfDpbyDu/di4taCLvhqztA/s
	 9zxwZHV4Noy/YX/4wI5VDUA/zpSjuVz2urrNQuIBQsxnInRJ1rsRJfVqmSx4OmmRCR
	 1EOkwXUJEZV3BtVk3vkySEm1v046rAiTlMB3DnIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgGIFjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgGIFjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:39:44 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E301B20657;
        Thu,  9 Jul 2020 05:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594273184;
        bh=u4VGfYmxoQQo8VoSbT3epFWuRgc3syhk7PNc7fYiTNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjm7KOItMNWn+yWPSIAoI2JEoMgXWBvZ4eFFL0SdpUT2G0k2HiFsYfQ3Ix4QMXbz0
         1Xr6jRWPWqbWETfjvqy1NqHaupnEclhSr6yGCVR+x90g+svQ4ZcgPH1tj+vmsCKA3L
         LrQH2XCEI6C+PtLzu7s7PLYexvW7eN2CCBHN8ysI=
Date:   Wed, 8 Jul 2020 22:39:43 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: ignore when len of range in
 f2fs_sec_trim_file is zero
Message-ID: <20200709053943.GA352648@google.com>
References: <20200709015739.1653668-1-daeho43@gmail.com>
 <619af72b-2f8a-4a84-f73e-ac49989ba79f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619af72b-2f8a-4a84-f73e-ac49989ba79f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09, Chao Yu wrote:
> On 2020/7/9 9:57, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > When end_addr comes to zero, it'll trigger different behaviour.
> > To prevent this, we need to ignore the case of that range.len is
> > zero in the function.
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/file.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 368c80f8e2a1..98b0a8dbf669 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3813,15 +3813,14 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
> >  	file_start_write(filp);
> >  	inode_lock(inode);
> >  
> > -	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> > +	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
> > +			range.start >= inode->i_size) {
> >  		ret = -EINVAL;
> >  		goto err;
> >  	}
> >  
> > -	if (range.start >= inode->i_size) {
> > -		ret = -EINVAL;
> > +	if (range.len == 0)
> >  		goto err;
> > -	}
> >  
> >  	if (inode->i_size - range.start < range.len) {
> >  		ret = -E2BIG;
> 
> How about the case trimming last partial written block?
> 
> i_size = 8000
> range.start = 4096
> range.len = 4096
> 
> Do we need to roundup(isize, PAGE_SIZE) before comparison?

If we want to trim whole file, do we need to give the exact i_size?
Wouldn't it be better to give trim(0, -1)?

> 
> Thanks,
> 
> > 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
