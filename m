Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1937FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56A520884
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591892359;
	bh=wsH+kYUlpHN3cnHucYD34glIdihIFPxxoNjrZUi41cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ottsGjymVfNKOo84zztePH8PV5r0mN/hdjiba6jFlwJaZUbxm0n4UdJTnIbBSG6u7
	 Jx5ZawwG9qxIIXOa0CaKQD1mO0ExPG8v4/U/ZiTS+rPCq1CyaQfyy/eAC8WuKXPbrv
	 uapW2HJL/hV07XqWsAGP0NDBcQAFODj6aDEyCLgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFKQTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgFKQTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:19:16 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21955206DC;
        Thu, 11 Jun 2020 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591892355;
        bh=wsH+kYUlpHN3cnHucYD34glIdihIFPxxoNjrZUi41cM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQsgT8ChS41POrJ2L2DcuW4Puplj8vZ0UDnA2JkwL48aZ46XTeEZm5fx2Q9o2I4/d
         xunID26zloLK1DunIahtFYmMDEJkP4ED/cD3pme+/Bf+P6AoT8fwhmiMRLTA642EAg
         LaoSe/Lf6G4s31j9bhkbo7ypNF39wEVTN9WkHGVE=
Date:   Thu, 11 Jun 2020 09:19:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Message-ID: <20200611161913.GA1152@sol.localdomain>
References: <20200611031652.200401-1-daeho43@gmail.com>
 <2eeaf889-da2c-0dac-c60b-fc5e68f2d402@huawei.com>
 <CACOAw_zyNFMYC3pTK3dT4yRgqp+-6yy3m2E64dkDkpNFKZicfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_zyNFMYC3pTK3dT4yRgqp+-6yy3m2E64dkDkpNFKZicfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 08:04:06PM +0900, Daeho Jeong wrote:
> > > +static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
> > > +{
> > > +     struct inode *inode = file_inode(filp);
> > > +     struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > > +     struct address_space *mapping = inode->i_mapping;
> > > +     struct block_device *prev_bdev = NULL;
> > > +     pgoff_t index, pg_start = 0, pg_end;
> > > +     block_t prev_block = 0, len = 0;
> > > +     u32 flags;
> > > +     int ret = 0;
> > > +
> > > +     if (!(filp->f_mode & FMODE_WRITE))
> > > +             return -EBADF;
> > > +
> > > +     if (get_user(flags, (u32 __user *)arg))
> > > +             return -EFAULT;
> > > +     if (flags == 0 || (flags & ~F2FS_TRIM_FILE_MASK))
> > > +             return -EINVAL;
> > > +
> > > +     if ((flags & F2FS_TRIM_FILE_DISCARD) && !f2fs_hw_support_discard(sbi))
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     file_start_write(filp);
> >
> > Now, I'm a little confused about when we need to call __mnt_want_write_file(),
> > you know, vfs_write() still will call this function when updating time.
> > - __generic_file_write_iter
> >  - file_update_time
> >   - __mnt_want_write_file
> >
> > And previously, f2fs ioctl uses mnt_{want,drop}_write_file() whenever there is
> > any updates on fs/file, if Eric is correct, we need to clean up most of ioctl
> > interface as well.
> 
> I also saw most filesytem codes use just mnt_{want,drop}_write_file()
> and actually it doesn't affect code working. It's a matter of doing a
> redundant job or not.
> AFAIUI, if the file is not open for writing (FMODE_WRITE), we have to
> call mnt_want_write_file() to increase mnt_writers.
> In this case, we already checked it has FMODE_WRITE flag.

If the fd isn't writable (or may not be writable), mnt_want_write_file() is
needed.  That includes all ioctls that operate (or may operate) on directories,
since directories can't be opened for writing.

But when the fd is guaranteed to be writable, incrementing mnt_writers is
pointless.  I'm trying to clean this up in the VFS:
https://lkml.kernel.org/r/20200611160534.55042-1-ebiggers@kernel.org.

mnt_want_write_file() still does the freeze protection, which file_start_write()
achieves more directly.

The only other thing that mnt_want_write_file() does is the check for emergency
remount r/o, which I doubt is very important.  It's racy, so the filesystem
needs to detect it in other places too.

I'm not sure why file_update_time() uses __mnt_want_write_file().  Either it
assumes the fd might not be writable, or it just wants the check for emergency
remount r/o, or it's just a mistake.  Note also that mtime isn't always updated,
so just because file_update_time() calls __mnt_want_write_file() doesn't mean
that write() always calls __mnt_want_write_file().

- Eric
