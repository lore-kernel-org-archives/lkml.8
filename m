Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B13AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E100F20774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591621657;
	bh=WB42G6Tb4c/hJxVzP2PTv/3cpqzVlOE3T/nUkDmSCgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WH9A3ty4vpX4wDHSm5mecYAPD4TAbVmLgfvGhtqiztXEDDAlxMILWl7KXmLFtFym1
	 3Qlfzf9XwZxu/MW0AaPBhUL6+K5NUycTSgeIjHctPw0SUkR9PavxI04Yylhve40zJH
	 f7vU4rlPZ+cNbzbCZBI3WrjjN6ucg1AClL9FUhN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgFHNHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgFHNHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:07:36 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8992076C;
        Mon,  8 Jun 2020 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591621655;
        bh=WB42G6Tb4c/hJxVzP2PTv/3cpqzVlOE3T/nUkDmSCgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=up27qK9dq0dyu3RAw1CCL3tMTsF6AVIa6Twt+CAmjxZp5hKJ6QzCByVPjjgh49wvR
         6ZWiKIYU5+fKvsOwTY+eaWQM2qunLX55Vyt3uyfpdS6SJUCOMJWEjQggm74wrb56B+
         k6qBvMzsxYEu+COmBkFjalENt/u20aSWH0QsXBVY=
Date:   Mon, 8 Jun 2020 06:07:34 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_TRIM_FILE ioctl
Message-ID: <20200608130734.GB200855@google.com>
References: <20200605042746.201180-1-daeho43@gmail.com>
 <fd9bd76c-1864-2cfc-bf86-ef705c8a407d@huawei.com>
 <CACOAw_yw+zczoWpNvYz_UHRYjr8BS+xKK=7_BKi0_0wEhp8Lvg@mail.gmail.com>
 <36d3c98e-24bb-988c-57a3-82730cc75cbc@huawei.com>
 <CACOAw_wVEw3+Kyz2HvvanhhP2_-xQy9wjfpDt5G0ahXM8o-V-Q@mail.gmail.com>
 <3eade7bf-ce66-e502-24e7-e3a1e548dd77@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3eade7bf-ce66-e502-24e7-e3a1e548dd77@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08, Chao Yu wrote:
> On 2020/6/8 15:19, Daeho Jeong wrote:
> > Yes, I agree with you about each vendor has different implementation on discard.
> > So, we might be gonna use the combination of zeroing and send discards
> > for a more
> > secure solution. :)
> 
> IIRC, current solution is:
> 
> - pin file
> - get all block addresses of file
> - write zero to block addresses
> - issue discard
> 
> Is that correct?
> 
> Could we handle those logic (zero out & discard) in new interface
> (may be named as {F2FS,EXT4}_IOC_SEC_TRIM_FILE)? then userspace logic
> could be quite simple later, and also memcpy could be avoid to make
> destruction process more efficient.

What about adding a flag to determine calling unmap and/or zero out?

> 
> Just raw proposal. :)
> 
> Thanks,
> 
> > I think we still need a discard interface to unmap from the mapping
> > table of the storage device side.
> > 
> > Thanks,
> > 
> > 2020년 6월 8일 (월) 오후 3:57, Chao Yu <yuchao0@huawei.com>님이 작성:
> >>
> >> On 2020/6/8 11:36, Daeho Jeong wrote:
> >>> Yes, this is for security key destruction.
> >>>
> >>> AFAIK, discard will unmap the data block and, after done it,
> >>> we can read either zero data or garbage data from that block depending
> >>> on eMMC/UFS.
> >>
> >> Since spec didn't restrict how vendor implement the erase interface, so
> >> in order to enhance performance of discard interface, vendor could implement
> >> it as an async one, which may not zero mapping entry(L1 table), instead, it
> >> could set related bitmap to invalid that mapping entry, than later if device
> >> allow user to access that invalid mapping entry, key info may be explosed,
> >>
> >> It's completely up to how vendor implement the interface, so I think there is
> >> still risk to use discard.
> >>
> >> Thanks,
> >>
> >>> In a view point of read data, it might be the same with zeroing the data block.
> >>> However, since we can even unmap that block, I believe discard is
> >>> safer than zeroing out.
> >>>
> >>> 2020년 6월 8일 (월) 오전 11:46, Chao Yu <yuchao0@huawei.com>님이 작성:
> >>>>
> >>>> On 2020/6/5 12:27, Daeho Jeong wrote:
> >>>>> From: Daeho Jeong <daehojeong@google.com>
> >>>>>
> >>>>> Added a new ioctl to send discard commands to whole data area of
> >>>>> a regular file for security reason.
> >>>>
> >>>> I guess this interface is introduced for security key destruction, if I'm
> >>>> right, however, IIRC, discard(erase) semantics in eMMC/UFS spec won't
> >>>> guarantee that data which was discard could be zeroed out, so after discard,
> >>>> the key still have risk of exposure. So instead, should we use sb_issue_zeroout()?
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>>>> ---
> >>>>>  fs/f2fs/f2fs.h |   1 +
> >>>>>  fs/f2fs/file.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>  2 files changed, 130 insertions(+)
> >>>>>
> >>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>>> index c812fb8e2d9c..9ae81d0fefa0 100644
> >>>>> --- a/fs/f2fs/f2fs.h
> >>>>> +++ b/fs/f2fs/f2fs.h
> >>>>> @@ -434,6 +434,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
> >>>>>                                       _IOR(F2FS_IOCTL_MAGIC, 18, __u64)
> >>>>>  #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS                             \
> >>>>>                                       _IOR(F2FS_IOCTL_MAGIC, 19, __u64)
> >>>>> +#define F2FS_IOC_TRIM_FILE           _IO(F2FS_IOCTL_MAGIC, 20)
> >>>>>
> >>>>>  #define F2FS_IOC_GET_VOLUME_NAME     FS_IOC_GETFSLABEL
> >>>>>  #define F2FS_IOC_SET_VOLUME_NAME     FS_IOC_SETFSLABEL
> >>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>>> index dfa1ac2d751a..58507bb5649c 100644
> >>>>> --- a/fs/f2fs/file.c
> >>>>> +++ b/fs/f2fs/file.c
> >>>>> @@ -3749,6 +3749,132 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
> >>>>>       return ret;
> >>>>>  }
> >>>>>
> >>>>> +static int f2fs_trim_file(struct file *filp)
> >>>>> +{
> >>>>> +     struct inode *inode = file_inode(filp);
> >>>>> +     struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >>>>> +     struct address_space *mapping = inode->i_mapping;
> >>>>> +     struct bio *bio = NULL;
> >>>>> +     struct block_device *prev_bdev = NULL;
> >>>>> +     loff_t file_size;
> >>>>> +     pgoff_t index, pg_start = 0, pg_end;
> >>>>> +     block_t prev_block = 0, len = 0;
> >>>>> +     int ret = 0;
> >>>>> +
> >>>>> +     if (!f2fs_hw_support_discard(sbi))
> >>>>> +             return -EOPNOTSUPP;
> >>>>> +
> >>>>> +     if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode) ||
> >>>>> +                     f2fs_compressed_file(inode))
> >>>>> +             return -EINVAL;
> >>>>> +
> >>>>> +     if (f2fs_readonly(sbi->sb))
> >>>>> +             return -EROFS;
> >>>>> +
> >>>>> +     ret = mnt_want_write_file(filp);
> >>>>> +     if (ret)
> >>>>> +             return ret;
> >>>>> +
> >>>>> +     inode_lock(inode);
> >>>>> +
> >>>>> +     file_size = i_size_read(inode);
> >>>>> +     if (!file_size)
> >>>>> +             goto err;
> >>>>> +     pg_end = (pgoff_t)round_up(file_size, PAGE_SIZE) >> PAGE_SHIFT;
> >>>>> +
> >>>>> +     ret = f2fs_convert_inline_inode(inode);
> >>>>> +     if (ret)
> >>>>> +             goto err;
> >>>>> +
> >>>>> +     down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>>>> +     down_write(&F2FS_I(inode)->i_mmap_sem);
> >>>>> +
> >>>>> +     ret = filemap_write_and_wait(mapping);
> >>>>> +     if (ret)
> >>>>> +             goto out;
> >>>>> +
> >>>>> +     truncate_inode_pages(mapping, 0);
> >>>>> +
> >>>>> +     for (index = pg_start; index < pg_end;) {
> >>>>> +             struct dnode_of_data dn;
> >>>>> +             unsigned int end_offset;
> >>>>> +
> >>>>> +             set_new_dnode(&dn, inode, NULL, NULL, 0);
> >>>>> +             ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> >>>>> +             if (ret)
> >>>>> +                     goto out;
> >>>>> +
> >>>>> +             end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
> >>>>> +             if (pg_end < end_offset + index)
> >>>>> +                     end_offset = pg_end - index;
> >>>>> +
> >>>>> +             for (; dn.ofs_in_node < end_offset;
> >>>>> +                             dn.ofs_in_node++, index++) {
> >>>>> +                     struct block_device *cur_bdev;
> >>>>> +                     block_t blkaddr = f2fs_data_blkaddr(&dn);
> >>>>> +
> >>>>> +                     if (__is_valid_data_blkaddr(blkaddr)) {
> >>>>> +                             if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> >>>>> +                                     blkaddr, DATA_GENERIC_ENHANCE)) {
> >>>>> +                                     ret = -EFSCORRUPTED;
> >>>>> +                                     goto out;
> >>>>> +                             }
> >>>>> +                     } else
> >>>>> +                             continue;
> >>>>> +
> >>>>> +                     cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
> >>>>> +                     if (f2fs_is_multi_device(sbi)) {
> >>>>> +                             int i = f2fs_target_device_index(sbi, blkaddr);
> >>>>> +
> >>>>> +                             blkaddr -= FDEV(i).start_blk;
> >>>>> +                     }
> >>>>> +
> >>>>> +                     if (len) {
> >>>>> +                             if (prev_bdev == cur_bdev &&
> >>>>> +                                     blkaddr == prev_block + len) {
> >>>>> +                                     len++;
> >>>>> +                             } else {
> >>>>> +                                     ret = __blkdev_issue_discard(prev_bdev,
> >>>>> +                                             SECTOR_FROM_BLOCK(prev_block),
> >>>>> +                                             SECTOR_FROM_BLOCK(len),
> >>>>> +                                             GFP_NOFS, 0, &bio);
> >>>>> +                                     if (ret)
> >>>>> +                                             goto out;
> >>>>> +> +                                  len = 0;
> >>>>> +                             }
> >>>>> +                     }
> >>>>> +
> >>>>> +                     if (!len) {
> >>>>> +                             prev_bdev = cur_bdev;
> >>>>> +                             prev_block = blkaddr;
> >>>>> +                             len = 1;
> >>>>> +                     }
> >>>>> +             }
> >>>>> +
> >>>>> +             f2fs_put_dnode(&dn);
> >>>>> +     }
> >>>>> +
> >>>>> +     if (len)
> >>>>> +             ret = __blkdev_issue_discard(prev_bdev,
> >>>>> +                                     SECTOR_FROM_BLOCK(prev_block),
> >>>>> +                                     SECTOR_FROM_BLOCK(len),
> >>>>> +                                     GFP_NOFS, 0, &bio);
> >>>>> +out:
> >>>>> +     if (bio) {
> >>>>> +             ret = submit_bio_wait(bio);
> >>>>> +             bio_put(bio);
> >>>>> +     }
> >>>>> +
> >>>>> +     up_write(&F2FS_I(inode)->i_mmap_sem);
> >>>>> +     up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>>>> +err:
> >>>>> +     inode_unlock(inode);
> >>>>> +     mnt_drop_write_file(filp);
> >>>>> +
> >>>>> +     return ret;
> >>>>> +}
> >>>>> +
> >>>>>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >>>>>  {
> >>>>>       if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> >>>>> @@ -3835,6 +3961,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >>>>>               return f2fs_release_compress_blocks(filp, arg);
> >>>>>       case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
> >>>>>               return f2fs_reserve_compress_blocks(filp, arg);
> >>>>> +     case F2FS_IOC_TRIM_FILE:
> >>>>> +             return f2fs_trim_file(filp);
> >>>>>       default:
> >>>>>               return -ENOTTY;
> >>>>>       }
> >>>>> @@ -4004,6 +4132,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >>>>>       case F2FS_IOC_GET_COMPRESS_BLOCKS:
> >>>>>       case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
> >>>>>       case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
> >>>>> +     case F2FS_IOC_TRIM_FILE:
> >>>>>               break;
> >>>>>       default:
> >>>>>               return -ENOIOCTLCMD;
> >>>>>
> >>> .
> >>>
> > .
> > 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
