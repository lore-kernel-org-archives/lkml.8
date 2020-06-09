Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB55C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CDF20760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591721475;
	bh=xymI/tLTEKoILAM/HormIMwHsrmGg7Ok1E9P6gQAM1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FKehkHIOWs7xx5DUZmqxZykNv5wj3sWzduG5MKmjJ7VGRP3MMmaX7/c87GWkvMrOR
	 CC0L623vP+kMar9P9RDaVX8gG5h2wnbNInaRftz+wMP5pOsH7cWhZyg80euizupnzT
	 Yh7Hfh6NbJLpCtDDU4dXsvMEiSXQVJiOt3GB36cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgFIQvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731061AbgFIQvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:51:09 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2AC20737;
        Tue,  9 Jun 2020 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591721468;
        bh=xymI/tLTEKoILAM/HormIMwHsrmGg7Ok1E9P6gQAM1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yoLBFn2r17siUg+uiUZsPxEqiZYXs7ivvfJSpmEaxbeCoPl4rnaxNEYaSvFZpMrBd
         wSjMvNVq8d6V72BYMr77k8m/PL+lHtaSqyK+15B8D1V49tlqU1s5GAjTjhPyyOwIyw
         WRmNQxOHABSwfIiOtJWnhjMTW1+zdn2puHGVTEy8=
Date:   Tue, 9 Jun 2020 09:51:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Message-ID: <20200609165107.GA228564@gmail.com>
References: <20200609060137.143501-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609060137.143501-1-daeho43@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 03:01:37PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a new ioctl to send discard commands or/and zero out
> to whole data area of a regular file for security reason.

With this ioctl available, what is the exact procedure to write and then later
securely erase a file on f2fs?  In particular, how can the user prevent f2fs
from making multiple copies of file data blocks as part of garbage collection?

> +static int f2fs_secure_erase(struct block_device *bdev, block_t block,
> +					block_t len, u32 flags)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +	sector_t sector = SECTOR_FROM_BLOCK(block);
> +	sector_t nr_sects = SECTOR_FROM_BLOCK(len);
> +	int ret = 0;
> +
> +	if (!q)
> +		return -ENXIO;

Why can the request_queue be NULL here?

> +
> +	if (flags & F2FS_TRIM_FILE_DISCARD)
> +		ret = blkdev_issue_discard(bdev, sector, nr_sects, GFP_NOFS,
> +						blk_queue_secure_erase(q) ?
> +						BLKDEV_DISCARD_SECURE : 0);
> +
> +	if (!ret && flags & F2FS_TRIM_FILE_ZEROOUT)
> +		ret = blkdev_issue_zeroout(bdev, sector, nr_sects, GFP_NOFS, 0);
> +
> +	return ret;
> +}
> +
> +static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct address_space *mapping = inode->i_mapping;
> +	struct block_device *prev_bdev = NULL;
> +	loff_t file_size;
> +	pgoff_t index, pg_start = 0, pg_end;
> +	block_t prev_block = 0, len = 0;
> +	u32 flags;
> +	int ret = 0;
> +
> +	if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode) ||
> +			f2fs_compressed_file(inode))
> +		return -EINVAL;

Is it valid to check f2fs_is_atomic_file() and f2fs_compressed_file() outside of
inode_lock()?

> +
> +	if (f2fs_readonly(sbi->sb))
> +		return -EROFS;

Isn't this redundant with mnt_want_write_file()?

Also, shouldn't write access to the file be required, i.e.
(filp->f_mode & FMODE_WRITE)?  Then the f2fs_readonly() and
mnt_want_write_file() checks would be unnecessary.

> +
> +	if (f2fs_lfs_mode(sbi))
> +		return -EOPNOTSUPP;

Doesn't this check have to be serialized with remount?

> +
> +	if (get_user(flags, (u32 __user *)arg))
> +		return -EFAULT;
> +	if (!(flags & F2FS_TRIM_FILE_MASK))
> +		return -EINVAL;

Need to reject unknown flags:

	if (flags & ~F2FS_TRIM_FILE_MASK)
		return -EINVAL;

> +
> +	if (flags & F2FS_TRIM_FILE_DISCARD && !f2fs_hw_support_discard(sbi))
> +		return -EOPNOTSUPP;
> +
> +	ret = mnt_want_write_file(filp);
> +	if (ret)
> +		return ret;
> +
> +	inode_lock(inode);
> +
> +	file_size = i_size_read(inode);
> +	if (!file_size)
> +		goto err;

->i_size is stable while holding inode_lock().  So just use ->i_size instead of
i_size_read().

> +	pg_end = (pgoff_t)round_up(file_size, PAGE_SIZE) >> PAGE_SHIFT;

This can be simplified to:

	pg_end = DIV_ROUND_UP(file_size, PAGE_SIZE);


- Eric
