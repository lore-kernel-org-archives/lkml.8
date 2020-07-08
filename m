Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9A9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 02:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6900620772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 02:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594174707;
	bh=tmDaVR1PNrJoafm9vwgEyEGPyx5FVMi3bRneTLieczc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F+ExbycpiqLsarGSxTQH1SJOBIUiKApQu9jPX4glOwFWOAizdsXIMlwePjCuAPuxk
	 t2Jy3AZitkq/u/gO9NDru9H3nDnETawc4/QuL6bTDL9cF+wbngVCn9sR/fnSQ3gRGT
	 FrCwhO42s2sGr4MhI02dcBiZPkwwYpHOWZ9MzY/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgGHCS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 22:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgGHCSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 22:18:25 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F15720708;
        Wed,  8 Jul 2020 02:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594174705;
        bh=tmDaVR1PNrJoafm9vwgEyEGPyx5FVMi3bRneTLieczc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qm0NEvdHgBIvBYQ0kZRa9x8UC5hkczTLyfUPIZtS4ULBj+sQfa9A5Z27URXj1jJvf
         RUslpdDbm8ypKaJ8FhMNxWW2eq09Q3TCg7uN7eJ6r2DwgffiICQRSzPCAA9mG5rEFg
         QMMPAobt7Sa+Opu8cuWkX8xa0c1cacPM6oF/YtV8=
Date:   Tue, 7 Jul 2020 19:18:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Message-ID: <20200708021823.GJ839@sol.localdomain>
References: <20200618125152.84099-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618125152.84099-1-daeho43@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daeho,

On Thu, Jun 18, 2020 at 09:51:52PM +0900, Daeho Jeong wrote:
> +static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct address_space *mapping = inode->i_mapping;
> +	struct block_device *prev_bdev = NULL;
> +	struct f2fs_sectrim_range range;
> +	pgoff_t index, pg_end;
> +	block_t prev_block = 0, len = 0;
> +	u64 end_addr;
> +	bool to_end;
> +	int ret = 0;
> +
> +	if (!(filp->f_mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (copy_from_user(&range, (struct f2fs_sectrim_range __user *)arg,
> +				sizeof(range)))
> +		return -EFAULT;
> +
> +	if (range.flags == 0 || (range.flags & ~F2FS_TRIM_FILE_MASK) ||
> +			!S_ISREG(inode->i_mode))
> +		return -EINVAL;
> +
> +	if ((range.flags & F2FS_TRIM_FILE_DISCARD) &&
> +			!f2fs_hw_support_discard(sbi))
> +		return -EOPNOTSUPP;
> +
> +	file_start_write(filp);
> +	inode_lock(inode);
> +
> +	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if (inode->i_size == 0)
> +		goto err;
> +
> +	end_addr = range.start + range.len;
> +	if (end_addr > inode->i_size) {
> +		ret = -EINVAL;
> +		goto err;
> +	}

This is missing a check that range.start + range.len doesn't overflow.

- Eric
