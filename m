Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66631C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4499A20656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgFKIyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:54:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726824AbgFKIyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:54:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65612551640846479A75;
        Thu, 11 Jun 2020 16:54:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 11 Jun
 2020 16:54:45 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200611031652.200401-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2eeaf889-da2c-0dac-c60b-fc5e68f2d402@huawei.com>
Date:   Thu, 11 Jun 2020 16:54:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200611031652.200401-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/11 11:16, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a new ioctl to send discard commands or/and zero out
> to whole data area of a regular file for security reason.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/f2fs.h |   8 +++
>  fs/f2fs/file.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c812fb8e2d9c..ca139fac5a73 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -434,6 +434,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
>  #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
>  					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
> +#define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20, __u32)
>  
>  #define F2FS_IOC_GET_VOLUME_NAME	FS_IOC_GETFSLABEL
>  #define F2FS_IOC_SET_VOLUME_NAME	FS_IOC_SETFSLABEL
> @@ -453,6 +454,13 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
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
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index dfa1ac2d751a..ba9b7ec5d6bf 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3749,6 +3749,146 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>  	return ret;
>  }
>  
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
> +
> +	if (flags & F2FS_TRIM_FILE_DISCARD)
> +		ret = blkdev_issue_discard(bdev, sector, nr_sects, GFP_NOFS,
> +						blk_queue_secure_erase(q) ?
> +						BLKDEV_DISCARD_SECURE : 0);
> +
> +	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT))
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
> +	pgoff_t index, pg_start = 0, pg_end;
> +	block_t prev_block = 0, len = 0;
> +	u32 flags;
> +	int ret = 0;
> +
> +	if (!(filp->f_mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (get_user(flags, (u32 __user *)arg))
> +		return -EFAULT;
> +	if (flags == 0 || (flags & ~F2FS_TRIM_FILE_MASK))
> +		return -EINVAL;
> +
> +	if ((flags & F2FS_TRIM_FILE_DISCARD) && !f2fs_hw_support_discard(sbi))
> +		return -EOPNOTSUPP;
> +
> +	file_start_write(filp);

Now, I'm a little confused about when we need to call __mnt_want_write_file(),
you know, vfs_write() still will call this function when updating time.
- __generic_file_write_iter
 - file_update_time
  - __mnt_want_write_file

And previously, f2fs ioctl uses mnt_{want,drop}_write_file() whenever there is
any updates on fs/file, if Eric is correct, we need to clean up most of ioctl
interface as well.

> +	inode_lock(inode);
> +
> +	if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode) ||
> +			f2fs_compressed_file(inode)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if (!inode->i_size)
> +		goto err;
> +	pg_end = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
> +
> +	ret = f2fs_convert_inline_inode(inode);
> +	if (ret)
> +		goto err;
> +
> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
> +
> +	ret = filemap_write_and_wait(mapping);
> +	if (ret)
> +		goto out;
> +
> +	truncate_inode_pages(mapping, 0);
> +
> +	for (index = pg_start; index < pg_end;) {
> +		struct dnode_of_data dn;
> +		unsigned int end_offset;
> +
> +		set_new_dnode(&dn, inode, NULL, NULL, 0);
> +		ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> +		if (ret)

if (ret == -ENOENT) {
	index = f2fs_get_next_page_offset(&dn, index);
	continue;
}

> +			goto out;
> +
> +		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
> +		if (pg_end < end_offset + index)
> +			end_offset = pg_end - index;
> +
> +		for (; dn.ofs_in_node < end_offset;
> +				dn.ofs_in_node++, index++) {
> +			struct block_device *cur_bdev;
> +			block_t blkaddr = f2fs_data_blkaddr(&dn);
> +
> +			if (__is_valid_data_blkaddr(blkaddr)) {
> +				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> +					blkaddr, DATA_GENERIC_ENHANCE)) {
> +					ret = -EFSCORRUPTED;
> +					goto out;


if we goto out label here, we will miss to call f2fs_put_dnode()?

> +				}
> +			} else

How about this?

if (!__is_valid_data_blkaddr())
	continue;

if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), blkaddr, DATA_GENERIC_ENHANCE)) {
	ret = -EFSCORRUPTED;
	goto out;
}

> +				continue;
> +
> +			cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
> +			if (f2fs_is_multi_device(sbi)) {
> +				int i = f2fs_target_device_index(sbi, blkaddr);
> +
> +				blkaddr -= FDEV(i).start_blk;
> +			}
> +
> +			if (len) {
> +				if (prev_bdev == cur_bdev &&
> +					blkaddr == prev_block + len) {
> +					len++;
> +				} else {
> +					ret = f2fs_secure_erase(prev_bdev,
> +							prev_block, len, flags);
> +					if (ret)
> +						goto out;

Ditto,

Thanks,

> +
> +					len = 0;
> +				}
> +			}
> +
> +			if (!len) {
> +				prev_bdev = cur_bdev;
> +				prev_block = blkaddr;
> +				len = 1;
> +			}
> +		}
> +
> +		f2fs_put_dnode(&dn);
> +	}
> +
> +	if (len)
> +		ret = f2fs_secure_erase(prev_bdev, prev_block, len, flags);
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
> @@ -3835,6 +3975,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return f2fs_release_compress_blocks(filp, arg);
>  	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
>  		return f2fs_reserve_compress_blocks(filp, arg);
> +	case F2FS_IOC_SEC_TRIM_FILE:
> +		return f2fs_sec_trim_file(filp, arg);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -4004,6 +4146,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case F2FS_IOC_GET_COMPRESS_BLOCKS:
>  	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
>  	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
> +	case F2FS_IOC_SEC_TRIM_FILE:
>  		break;
>  	default:
>  		return -ENOIOCTLCMD;
> 
