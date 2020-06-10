Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE7AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BB32076A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591758936;
	bh=SlgmI87PFCqpmWyL9oK6/1jzu0E4iRMFU98Dj5JFzPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rqu3gJqVPcDicTGiq5InSxdDvCyGGEJr6xIhJWe4+h//sn4N3FLdm1EHZkTp3MLrE
	 YL87rZAbaxYlRK6OhUzKffcEe4KO1zgMhtfnD6B1vBa2fVDKFouXXyvHkzqAZyzgTe
	 hEUV8GlqU8Mfyk5T6tzT7x2917y+6EM/SUFex7EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFJDPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgFJDPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:15:34 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB39120734;
        Wed, 10 Jun 2020 03:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591758934;
        bh=SlgmI87PFCqpmWyL9oK6/1jzu0E4iRMFU98Dj5JFzPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGn/k6VCSvgI9gagRwQGxde4UvqpAnwNzadx5W5FnLiHaKMibfIa1whJni7Yuukf6
         Yg89/3q/gjzQjPvbzpKoBTCUnvKdBFtFa9107I73VjK5386bqB5DTtf7iaiBB66f9+
         lW7mknkH+OpciUhADsGqY0//X/zo7c9gZRBmGLJo=
Date:   Tue, 9 Jun 2020 20:15:32 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Message-ID: <20200610031532.GA6286@sol.localdomain>
References: <20200609060137.143501-1-daeho43@gmail.com>
 <20200609165107.GA228564@gmail.com>
 <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:05:46AM +0900, Daeho Jeong wrote:
> > > Added a new ioctl to send discard commands or/and zero out
> > > to whole data area of a regular file for security reason.
> >
> > With this ioctl available, what is the exact procedure to write and then later
> > securely erase a file on f2fs?  In particular, how can the user prevent f2fs
> > from making multiple copies of file data blocks as part of garbage collection?
> >
> 
> To prevent the file data from garbage collecting, the user needs to
> use pinfile ioctl and fallocate system call after creating the file.
> The sequence is like below.
> 1. create an empty file
> 2. pinfile
> 3. fallocate()

Is that persistent?  So the file will never be moved afterwards?

Is there a place where this is (or should be) documented?

> > > +
> > > +     if (f2fs_readonly(sbi->sb))
> > > +             return -EROFS;
> >
> > Isn't this redundant with mnt_want_write_file()?
> >
> > Also, shouldn't write access to the file be required, i.e.
> > (filp->f_mode & FMODE_WRITE)?  Then the f2fs_readonly() and
> > mnt_want_write_file() checks would be unnecessary.
> >
> 
> Using FMODE_WRITE is more proper for this case, since we're going to
> modify the data. But I think mnt_want_write_file() is still required
> to prevent the filesystem from freezing or something else.

Right, the freezing check is actually still necessary.  But getting write access
to the mount is not necessary.  I think you should use file_start_write() and
file_end_write(), like vfs_write() does.

> >
> > > +
> > > +     if (get_user(flags, (u32 __user *)arg))
> > > +             return -EFAULT;
> > > +     if (!(flags & F2FS_TRIM_FILE_MASK))
> > > +             return -EINVAL;
> >
> > Need to reject unknown flags:
> >
> >         if (flags & ~F2FS_TRIM_FILE_MASK)
> >                 return -EINVAL;
> 
> I needed a different thing here. This was to check neither discard nor
> zeroing out are not here. But we still need to check unknown flags,
> too.
> The below might be better.
> if (!flags || flags & ~F2FS_TRIM_FILE_MASK)
>        return -EINVAL;

Sure, but please put parentheses around the second clause:

	if (flags == 0 || (flags & ~F2FS_TRIM_FILE_MASK))
		return -EINVAL;

- Eric
