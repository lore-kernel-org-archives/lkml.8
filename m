Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA52C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B36522BF5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgGTBCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:02:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbgGTBCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:02:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CFE385BE9EFF70C4390E;
        Mon, 20 Jul 2020 09:02:49 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 20 Jul
 2020 09:02:43 +0800
Subject: Re: [PATCH v2] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20200718061500.3542710-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e6b7d789-bbac-a414-b6dc-f55b53b6cd5f@huawei.com>
Date:   Mon, 20 Jul 2020 09:02:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200718061500.3542710-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/18 14:15, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a new ioctl to send discard commands or/and zero out
> to selected data area of a regular file for security reason.
> 
> The way of handling range.len of F2FS_IOC_SEC_TRIM_FILE:
> 1. Added -1 value support for range.len to secure trim the whole blocks
>    starting from range.start regardless of i_size.
> 2. If the end of the range passes over the end of file, it means until
>    the end of file (i_size).
> 3. ignored the case of that range.len is zero to prevent the function
>    from making end_addr zero and triggering different behaviour of
>    the function.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> Changes in v2:

v6...though it's trivial...

>  - Support zeroout for encrypted files
> ---
>  fs/f2fs/f2fs.h |  15 ++++
>  fs/f2fs/file.c | 195 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 210 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f29eb1f94f57..bdfb331b6519 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -434,6 +434,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
>  #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
>  					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
> +#define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
> +						struct f2fs_sectrim_range)
>  
>  #define F2FS_IOC_GET_VOLUME_NAME	FS_IOC_GETFSLABEL
>  #define F2FS_IOC_SET_VOLUME_NAME	FS_IOC_SETFSLABEL
> @@ -453,6 +455,13 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  #define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
>  #define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
>  
> +/*
> + * Flags used by F2FS_IOC_SEC_TRIM_FILE
> + */
> +#define F2FS_TRIM_FILE_DISCARD		0x1	/* send discard command */
> +#define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
> +#define F2FS_TRIM_FILE_MASK		0x3
> +
>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>  /*
>   * ioctl commands in 32 bit emulation
> @@ -488,6 +497,12 @@ struct f2fs_flush_device {
>  	u32 segments;		/* # of segments to flush */
>  };
>  
> +struct f2fs_sectrim_range {
> +	u64 start;
> +	u64 len;
> +	u64 flags;
> +};
> +
>  /* for inline stuff */
>  #define DEF_INLINE_RESERVED_SIZE	1
>  static inline int get_extra_isize(struct inode *inode);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 1af37f3b3309..e0a4a95fbad7 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -21,6 +21,7 @@
>  #include <linux/uuid.h>
>  #include <linux/file.h>
>  #include <linux/nls.h>
> +#include <linux/sched/signal.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> @@ -3759,6 +3760,197 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>  	return ret;
>  }
>  
> +static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
> +		pgoff_t off, block_t block, block_t len, u32 flags)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +	sector_t sector = SECTOR_FROM_BLOCK(block);
> +	sector_t nr_sects = SECTOR_FROM_BLOCK(len);
> +	int ret = 0;
> +
> +	if (!q)
> +		return -ENXIO;
> +
> +	if (flags & F2FS_TRIM_FILE_DISCARD)
> +		ret = blkdev_issue_discard(bdev, sector, nr_sects, GFP_NOFS,
> +						blk_queue_secure_erase(q) ?
> +						BLKDEV_DISCARD_SECURE : 0);
> +
> +	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT)) {
> +		if (IS_ENCRYPTED(inode))
> +			ret = fscrypt_zeroout_range(inode, off, block, len);
> +		else
> +			ret = blkdev_issue_zeroout(bdev, sector, nr_sects,
> +					GFP_NOFS, 0);
> +	}
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
> +	struct f2fs_sectrim_range range;
> +	pgoff_t index, pg_end, prev_index = 0;
> +	block_t prev_block = 0, len = 0;
> +	loff_t end_addr;
> +	bool to_end = false;
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

Why not checking condition here? encryption and multidevice status is stable.

> +
> +	file_start_write(filp);
> +	inode_lock(inode);
> +
> +	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
> +			range.start >= inode->i_size) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if ((range.flags & F2FS_TRIM_FILE_ZEROOUT) &&
> +			IS_ENCRYPTED(inode) && f2fs_is_multi_device(sbi)) {
> +		ret = -EOPNOTSUPP;
> +		goto err;
> +	}
> +
> +	if (range.len == 0)
> +		goto err;
> +
> +	if (inode->i_size - range.start > range.len) {
> +		end_addr = range.start + range.len;
> +	} else {
> +		end_addr = range.len == (u64)-1 ?
> +			sbi->sb->s_maxbytes : inode->i_size;
> +		to_end = true;
> +	}
> +
> +	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
> +			(!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE))) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	index = F2FS_BYTES_TO_BLK(range.start);
> +	pg_end = DIV_ROUND_UP(end_addr, F2FS_BLKSIZE);
> +
> +	ret = f2fs_convert_inline_inode(inode);
> +	if (ret)
> +		goto err;
> +
> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
> +
> +	ret = filemap_write_and_wait_range(mapping, range.start,
> +			to_end ? LLONG_MAX : end_addr - 1);
> +	if (ret)
> +		goto out;
> +
> +	truncate_inode_pages_range(mapping, range.start,
> +			to_end ? -1 : end_addr - 1);
> +
> +	while (index < pg_end) {
> +		struct dnode_of_data dn;
> +		pgoff_t end_offset, count;
> +		int i;
> +
> +		set_new_dnode(&dn, inode, NULL, NULL, 0);
> +		ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> +		if (ret) {
> +			if (ret == -ENOENT) {
> +				index = f2fs_get_next_page_offset(&dn, index);
> +				continue;
> +			}
> +			goto out;
> +		}
> +
> +		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
> +		count = min(end_offset - dn.ofs_in_node, pg_end - index);
> +		for (i = 0; i < count; i++, index++, dn.ofs_in_node++) {
> +			struct block_device *cur_bdev;
> +			block_t blkaddr = f2fs_data_blkaddr(&dn);
> +
> +			if (!__is_valid_data_blkaddr(blkaddr))
> +				continue;
> +
> +			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
> +						DATA_GENERIC_ENHANCE)) {
> +				ret = -EFSCORRUPTED;
> +				f2fs_put_dnode(&dn);
> +				goto out;
> +			}
> +
> +			cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
> +			if (f2fs_is_multi_device(sbi)) {
> +				int di = f2fs_target_device_index(sbi, blkaddr);
> +
> +				blkaddr -= FDEV(di).start_blk;
> +			}
> +
> +			if (len) {
> +				if (prev_bdev == cur_bdev &&
> +						index == prev_index + len &&
> +						blkaddr == prev_block + len) {
> +					len++;
> +				} else {
> +					ret = f2fs_secure_erase(prev_bdev,
> +						inode, prev_index, prev_block,
> +						len, range.flags);
> +					if (ret) {
> +						f2fs_put_dnode(&dn);
> +						goto out;
> +					}
> +
> +					len = 0;
> +				}
> +			}
> +
> +			if (!len) {
> +				prev_bdev = cur_bdev;
> +				prev_index = index;
> +				prev_block = blkaddr;
> +				len = 1;
> +			}
> +		}
> +
> +		f2fs_put_dnode(&dn);
> +
> +		if (fatal_signal_pending(current)) {
> +			ret = -EINTR;
> +			goto out;
> +		}
> +		cond_resched();
> +	}
> +
> +	if (len)
> +		ret = f2fs_secure_erase(prev_bdev, inode, prev_index,
> +				prev_block, len, range.flags);
> +out:
> +	up_write(&F2FS_I(inode)->i_mmap_sem);
> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +err:
> +	inode_unlock(inode);
> +	file_end_write(filp);
> +
> +	return ret;
> +}
> +
>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> @@ -3845,6 +4037,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return f2fs_release_compress_blocks(filp, arg);
>  	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
>  		return f2fs_reserve_compress_blocks(filp, arg);
> +	case F2FS_IOC_SEC_TRIM_FILE:
> +		return f2fs_sec_trim_file(filp, arg);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -4014,6 +4208,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case F2FS_IOC_GET_COMPRESS_BLOCKS:
>  	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
>  	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
> +	case F2FS_IOC_SEC_TRIM_FILE:
>  		break;
>  	default:
>  		return -ENOIOCTLCMD;
> 
