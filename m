Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D76AC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DD52072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582755370;
	bh=VeripGK/vxYAjG3lGkaJNquDoutf0sEon6YG08PU/MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QoewwfspS3rfYqSZHlkyknngDWCPyEj5e7C4epEl1C32PZHfhvFpYGYx4KEVKQd43
	 Lz7yhfDdnbiaRQI5+uRkbVpZCKIgsCWzePftwAXEbzuKhrIymOAhtyMbpRUXjlhFx3
	 XstBbuUNN8bRG61nBMQRRmVlPiKSt66C8RIxQhKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgBZWQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:16:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbgBZWQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:16:09 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0BAC21D7E;
        Wed, 26 Feb 2020 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582755368;
        bh=VeripGK/vxYAjG3lGkaJNquDoutf0sEon6YG08PU/MY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtaZui5loQtHaS+kAM7MahG50OmBOoA/DiKWvlu1K3/C/L8pGnC9FN8J54BxTHMcb
         mVvCodxuB8h908Rh8/JyKzJfBfP0ogdu8sZ/OZ/i2TESA3oqjEVOZ74gwFN5WYxwLw
         pxAz00bP5qlplN4cj7dm1G4j0QxGjE3TWN6ZBizY=
Date:   Wed, 26 Feb 2020 14:16:08 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [RFC PATCH 2/2] f2fs: introduce F2FS_IOC_RELEASE_COMPRESS_BLOCKS
Message-ID: <20200226221608.GA224608@google.com>
References: <20200221100922.16781-1-yuchao0@huawei.com>
 <20200221100922.16781-2-yuchao0@huawei.com>
 <20200224214605.GA77839@google.com>
 <db505852-345d-05d0-4555-437093d2af14@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db505852-345d-05d0-4555-437093d2af14@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25, Chao Yu wrote:
> On 2020/2/25 5:46, Jaegeuk Kim wrote:
> > On 02/21, Chao Yu wrote:
> >> There are still reserved blocks on compressed inode, this patch
> >> introduce a new ioctl to help release reserved blocks back to
> >> filesystem, so that userspace can reuse those freed space.
> > 
> > I thought we can add compressed_blocks into free space, after converting
> > the file to immutable one. Otherwise, this patch is able to corrupt the
> 
> Yes, I remember that.
> 
> So any suggestion on this patch? we can:
> - check immutable flag before releasing space, or
> - we can add immutable flag on compressed inode in this ioctl interface?

Can we add a flag in ioctl for both?
Default is checking immutable, but add a flag to force enabling it.

> 
> Thanks,
> 
> > filesystem very easily.
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/f2fs.h |   6 +++
> >>  fs/f2fs/file.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 134 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 15199df5d40a..468f807fd917 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -427,6 +427,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
> >>  #define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
> >>  #define F2FS_IOC_RESIZE_FS		_IOW(F2FS_IOCTL_MAGIC, 16, __u64)
> >>  #define F2FS_IOC_GET_COMPRESS_BLOCKS	_IOR(F2FS_IOCTL_MAGIC, 17, __u64)
> >> +#define F2FS_IOC_RELEASE_COMPRESS_BLOCKS				\
> >> +					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
> >>  
> >>  #define F2FS_IOC_GET_VOLUME_NAME	FS_IOC_GETFSLABEL
> >>  #define F2FS_IOC_SET_VOLUME_NAME	FS_IOC_SETFSLABEL
> >> @@ -3957,6 +3959,10 @@ static inline void f2fs_i_compr_blocks_update(struct inode *inode,
> >>  {
> >>  	int diff = F2FS_I(inode)->i_cluster_size - blocks;
> >>  
> >> +	/* don't update i_compr_blocks if saved blocks were released */
> >> +	if (!add && !F2FS_I(inode)->i_compr_blocks)
> >> +		return;
> >> +
> >>  	if (add) {
> >>  		F2FS_I(inode)->i_compr_blocks += diff;
> >>  		stat_add_compr_blocks(inode, diff);
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index 235708c892af..613f87151d90 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -557,6 +557,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
> >>  	bool compressed_cluster = false;
> >>  	int cluster_index = 0, valid_blocks = 0;
> >>  	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
> >> +	bool released = !F2FS_I(dn->inode)->i_compr_blocks;
> >>  
> >>  	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
> >>  		base = get_extra_isize(dn->inode);
> >> @@ -595,7 +596,9 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
> >>  			clear_inode_flag(dn->inode, FI_FIRST_BLOCK_WRITTEN);
> >>  
> >>  		f2fs_invalidate_blocks(sbi, blkaddr);
> >> -		nr_free++;
> >> +
> >> +		if (released && blkaddr != COMPRESS_ADDR)
> >> +			nr_free++;
> >>  	}
> >>  
> >>  	if (compressed_cluster)
> >> @@ -3416,6 +3419,127 @@ static int f2fs_get_compress_blocks(struct file *filp, unsigned long arg)
> >>  	return put_user(blocks, (u64 __user *)arg);
> >>  }
> >>  
> >> +static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
> >> +{
> >> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> >> +	unsigned int released_blocks = 0;
> >> +	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
> >> +
> >> +	while (count) {
> >> +		int compr_blocks = 0;
> >> +		block_t blkaddr = f2fs_data_blkaddr(dn);
> >> +		int i;
> >> +
> >> +		if (blkaddr != COMPRESS_ADDR) {
> >> +			dn->ofs_in_node += cluster_size;
> >> +			goto next;
> >> +		}
> >> +
> >> +		for (i = 0; i < cluster_size; i++, dn->ofs_in_node++) {
> >> +			blkaddr = f2fs_data_blkaddr(dn);
> >> +
> >> +			if (__is_valid_data_blkaddr(blkaddr)) {
> >> +				compr_blocks++;
> >> +				if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> >> +							DATA_GENERIC_ENHANCE)))
> >> +					return -EFSCORRUPTED;
> >> +			}
> >> +
> >> +			if (blkaddr != NEW_ADDR)
> >> +				continue;
> >> +
> >> +			dn->data_blkaddr = NULL_ADDR;
> >> +			f2fs_set_data_blkaddr(dn);
> >> +		}
> >> +
> >> +		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, false);
> >> +		dec_valid_block_count(sbi, dn->inode,
> >> +					cluster_size - compr_blocks);
> >> +
> >> +		released_blocks += cluster_size - compr_blocks;
> >> +next:
> >> +		count -= cluster_size;
> >> +	}
> >> +
> >> +	return released_blocks;
> >> +}
> >> +
> >> +static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
> >> +{
> >> +	struct inode *inode = file_inode(filp);
> >> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >> +	pgoff_t page_idx = 0, last_idx;
> >> +	unsigned int released_blocks = 0;
> >> +	int ret;
> >> +
> >> +	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	if (!f2fs_compressed_file(inode))
> >> +		return -EINVAL;
> >> +
> >> +	if (f2fs_readonly(sbi->sb))
> >> +		return -EROFS;
> >> +
> >> +	ret = mnt_want_write_file(filp);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (!F2FS_I(inode)->i_compr_blocks)
> >> +		goto out;
> >> +
> >> +	f2fs_balance_fs(F2FS_I_SB(inode), true);
> >> +
> >> +	inode_lock(inode);
> >> +
> >> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >> +	down_write(&F2FS_I(inode)->i_mmap_sem);
> >> +
> >> +	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> >> +
> >> +	while (page_idx < last_idx) {
> >> +		struct dnode_of_data dn;
> >> +		pgoff_t end_offset, count;
> >> +
> >> +		set_new_dnode(&dn, inode, NULL, NULL, 0);
> >> +		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
> >> +		if (ret) {
> >> +			if (ret == -ENOENT) {
> >> +				page_idx = f2fs_get_next_page_offset(&dn,
> >> +								page_idx);
> >> +				ret = 0;
> >> +				continue;
> >> +			}
> >> +			break;
> >> +		}
> >> +
> >> +		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
> >> +		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
> >> +
> >> +		ret = release_compress_blocks(&dn, count);
> >> +
> >> +		f2fs_put_dnode(&dn);
> >> +
> >> +		if (ret < 0)
> >> +			break;
> >> +
> >> +		page_idx += count;
> >> +		released_blocks += ret;
> >> +	}
> >> +
> >> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >> +	up_write(&F2FS_I(inode)->i_mmap_sem);
> >> +
> >> +	inode_unlock(inode);
> >> +out:
> >> +	mnt_drop_write_file(filp);
> >> +
> >> +	if (!ret)
> >> +		ret = put_user(released_blocks, (u64 __user *)arg);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >>  {
> >>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> >> @@ -3496,6 +3620,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >>  		return f2fs_set_volume_name(filp, arg);
> >>  	case F2FS_IOC_GET_COMPRESS_BLOCKS:
> >>  		return f2fs_get_compress_blocks(filp, arg);
> >> +	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
> >> +		return f2fs_release_compress_blocks(filp, arg);
> >>  	default:
> >>  		return -ENOTTY;
> >>  	}
> >> @@ -3654,6 +3780,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >>  	case F2FS_IOC_GET_VOLUME_NAME:
> >>  	case F2FS_IOC_SET_VOLUME_NAME:
> >>  	case F2FS_IOC_GET_COMPRESS_BLOCKS:
> >> +	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
> >>  		break;
> >>  	default:
> >>  		return -ENOIOCTLCMD;
> >> -- 
> >> 2.18.0.rc1
> > .
> > 
