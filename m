Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03339C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD94E207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIkGpQEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgFKLEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgFKLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:04:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D96C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:04:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x18so6389793lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HOyBjTncuqvGbo6jK4VgUI/uepdibkQyKeO+d404glI=;
        b=oIkGpQEWC2i5Nx7Nhw/XbjmUEc89v+JhPOyJ/99PR3+oE1oho9/HMQ7duNN1aKWKGM
         6NhFsi1RFyIPTUCQ3cGQr5K72wwNmAs4DLPkv7jX4X3g5dL8aa2O+81nZFSc8qeCovYb
         O67aRsqE/twL8YAKP6LJk8CfC0urkkQDQ5aYy3GyFCP3nASvV7OfQyOoPx+QP7p7wtRz
         QehwfpFDTcHPC33XfG/Tox4tLs1g6dwEGsGxdtQd55SflT5Hw4BSv+/z4aXXdUALEbOz
         Fn6MH7J+uNOXh3kKYoJ7adwaFFoSY7nK/xFAe9EX4Y0LZhbDdL6MQRpcTOL89wBN0JoE
         Q++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HOyBjTncuqvGbo6jK4VgUI/uepdibkQyKeO+d404glI=;
        b=sj8Z8ozEhoiyMcNPEC+0D3hJCt2Kv9i1QkZ8zAD950Tati8kfFFvJvOnY5XB28rDjF
         TSDghkLJqIBOSJWj7vFX4lJ38ascAwVqu8CgyywKvm55j2d/ItmQcTTnXOK4hRgTgRjh
         TenOnEBLzJttlUXnDzgVXaYDEhdhUODnRPbl+535Shi83TMZG/6GvkOXQJmIpMK6olUt
         Jj+iJTgqMFtPjugxHh/9wCXq0DEA6Cx8DUA27Tlm4k8Pu93t3aNqaBnuuG+41YFwD0TB
         7kfYz22SByLqzqjwmRHlAO81p8aiX2coRHetMuU9/Vfqx8mDtatTtZNfrrZolhGOgSA7
         poUQ==
X-Gm-Message-State: AOAM530iJP55ymK9P0V7M61a3jYA+05hIFgzHpc5pySvUL4NFwo68iwq
        szjovfG2WI4ATLeSFTjTRu1yO2xsk+8mTPzlmtg=
X-Google-Smtp-Source: ABdhPJxaSoZfIoH7IIwupldqcyXVdwn0L/dbt1AJL+XeLCFsSYFlBRJH+duKitFMIMW6XEdibVJTIknemh09lpznkvU=
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr4240602ljj.166.1591873457834;
 Thu, 11 Jun 2020 04:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200611031652.200401-1-daeho43@gmail.com> <2eeaf889-da2c-0dac-c60b-fc5e68f2d402@huawei.com>
In-Reply-To: <2eeaf889-da2c-0dac-c60b-fc5e68f2d402@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 11 Jun 2020 20:04:06 +0900
Message-ID: <CACOAw_zyNFMYC3pTK3dT4yRgqp+-6yy3m2E64dkDkpNFKZicfQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 11=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 5:56, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/6/11 11:16, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added a new ioctl to send discard commands or/and zero out
> > to whole data area of a regular file for security reason.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/f2fs.h |   8 +++
> >  fs/f2fs/file.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 151 insertions(+)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index c812fb8e2d9c..ca139fac5a73 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -434,6 +434,7 @@ static inline bool __has_cursum_space(struct f2fs_j=
ournal *journal,
> >                                       _IOR(F2FS_IOCTL_MAGIC, 18, __u64)
> >  #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS                             \
> >                                       _IOR(F2FS_IOCTL_MAGIC, 19, __u64)
> > +#define F2FS_IOC_SEC_TRIM_FILE               _IOW(F2FS_IOCTL_MAGIC, 20=
, __u32)
> >
> >  #define F2FS_IOC_GET_VOLUME_NAME     FS_IOC_GETFSLABEL
> >  #define F2FS_IOC_SET_VOLUME_NAME     FS_IOC_SETFSLABEL
> > @@ -453,6 +454,13 @@ static inline bool __has_cursum_space(struct f2fs_=
journal *journal,
> >  #define F2FS_GOING_DOWN_METAFLUSH    0x3     /* going down with meta f=
lush */
> >  #define F2FS_GOING_DOWN_NEED_FSCK    0x4     /* going down to trigger =
fsck */
> >
> > +/*
> > + * Flags used by F2FS_IOC_SEC_TRIM_FILE
> > + */
> > +#define F2FS_TRIM_FILE_DISCARD               0x1     /* send discard c=
ommand */
> > +#define F2FS_TRIM_FILE_ZEROOUT               0x2     /* zero out */
> > +#define F2FS_TRIM_FILE_MASK          0x3
> > +
> >  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
> >  /*
> >   * ioctl commands in 32 bit emulation
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index dfa1ac2d751a..ba9b7ec5d6bf 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3749,6 +3749,146 @@ static int f2fs_reserve_compress_blocks(struct =
file *filp, unsigned long arg)
> >       return ret;
> >  }
> >
> > +static int f2fs_secure_erase(struct block_device *bdev, block_t block,
> > +                                     block_t len, u32 flags)
> > +{
> > +     struct request_queue *q =3D bdev_get_queue(bdev);
> > +     sector_t sector =3D SECTOR_FROM_BLOCK(block);
> > +     sector_t nr_sects =3D SECTOR_FROM_BLOCK(len);
> > +     int ret =3D 0;
> > +
> > +     if (!q)
> > +             return -ENXIO;
> > +
> > +     if (flags & F2FS_TRIM_FILE_DISCARD)
> > +             ret =3D blkdev_issue_discard(bdev, sector, nr_sects, GFP_=
NOFS,
> > +                                             blk_queue_secure_erase(q)=
 ?
> > +                                             BLKDEV_DISCARD_SECURE : 0=
);
> > +
> > +     if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT))
> > +             ret =3D blkdev_issue_zeroout(bdev, sector, nr_sects, GFP_=
NOFS, 0);
> > +
> > +     return ret;
> > +}
> > +
> > +static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
> > +{
> > +     struct inode *inode =3D file_inode(filp);
> > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > +     struct address_space *mapping =3D inode->i_mapping;
> > +     struct block_device *prev_bdev =3D NULL;
> > +     pgoff_t index, pg_start =3D 0, pg_end;
> > +     block_t prev_block =3D 0, len =3D 0;
> > +     u32 flags;
> > +     int ret =3D 0;
> > +
> > +     if (!(filp->f_mode & FMODE_WRITE))
> > +             return -EBADF;
> > +
> > +     if (get_user(flags, (u32 __user *)arg))
> > +             return -EFAULT;
> > +     if (flags =3D=3D 0 || (flags & ~F2FS_TRIM_FILE_MASK))
> > +             return -EINVAL;
> > +
> > +     if ((flags & F2FS_TRIM_FILE_DISCARD) && !f2fs_hw_support_discard(=
sbi))
> > +             return -EOPNOTSUPP;
> > +
> > +     file_start_write(filp);
>
> Now, I'm a little confused about when we need to call __mnt_want_write_fi=
le(),
> you know, vfs_write() still will call this function when updating time.
> - __generic_file_write_iter
>  - file_update_time
>   - __mnt_want_write_file
>
> And previously, f2fs ioctl uses mnt_{want,drop}_write_file() whenever the=
re is
> any updates on fs/file, if Eric is correct, we need to clean up most of i=
octl
> interface as well.

I also saw most filesytem codes use just mnt_{want,drop}_write_file()
and actually it doesn't affect code working. It's a matter of doing a
redundant job or not.
AFAIUI, if the file is not open for writing (FMODE_WRITE), we have to
call mnt_want_write_file() to increase mnt_writers.
In this case, we already checked it has FMODE_WRITE flag.

>
> > +     inode_lock(inode);
> > +
> > +     if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode) ||
> > +                     f2fs_compressed_file(inode)) {
> > +             ret =3D -EINVAL;
> > +             goto err;
> > +     }
> > +
> > +     if (!inode->i_size)
> > +             goto err;
> > +     pg_end =3D DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
> > +
> > +     ret =3D f2fs_convert_inline_inode(inode);
> > +     if (ret)
> > +             goto err;
> > +
> > +     down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > +     down_write(&F2FS_I(inode)->i_mmap_sem);
> > +
> > +     ret =3D filemap_write_and_wait(mapping);
> > +     if (ret)
> > +             goto out;
> > +
> > +     truncate_inode_pages(mapping, 0);
> > +
> > +     for (index =3D pg_start; index < pg_end;) {
> > +             struct dnode_of_data dn;
> > +             unsigned int end_offset;
> > +
> > +             set_new_dnode(&dn, inode, NULL, NULL, 0);
> > +             ret =3D f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> > +             if (ret)
>
> if (ret =3D=3D -ENOENT) {
>         index =3D f2fs_get_next_page_offset(&dn, index);
>         continue;
> }

Got it.

>
> > +                     goto out;
> > +
> > +             end_offset =3D ADDRS_PER_PAGE(dn.node_page, inode);
> > +             if (pg_end < end_offset + index)
> > +                     end_offset =3D pg_end - index;
> > +
> > +             for (; dn.ofs_in_node < end_offset;
> > +                             dn.ofs_in_node++, index++) {
> > +                     struct block_device *cur_bdev;
> > +                     block_t blkaddr =3D f2fs_data_blkaddr(&dn);
> > +
> > +                     if (__is_valid_data_blkaddr(blkaddr)) {
> > +                             if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inod=
e),
> > +                                     blkaddr, DATA_GENERIC_ENHANCE)) {
> > +                                     ret =3D -EFSCORRUPTED;
> > +                                     goto out;
>
>
> if we goto out label here, we will miss to call f2fs_put_dnode()?
>

Oops, I missed this, when I changed the code flow. Thanks!

> > +                             }
> > +                     } else
>
> How about this?
>
> if (!__is_valid_data_blkaddr())
>         continue;
>
> if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), blkaddr, DATA_GENERIC_ENHANC=
E)) {
>         ret =3D -EFSCORRUPTED;
>         goto out;
> }
>

Looks better.

> > +                             continue;
> > +
> > +                     cur_bdev =3D f2fs_target_device(sbi, blkaddr, NUL=
L);
> > +                     if (f2fs_is_multi_device(sbi)) {
> > +                             int i =3D f2fs_target_device_index(sbi, b=
lkaddr);
> > +
> > +                             blkaddr -=3D FDEV(i).start_blk;
> > +                     }
> > +
> > +                     if (len) {
> > +                             if (prev_bdev =3D=3D cur_bdev &&
> > +                                     blkaddr =3D=3D prev_block + len) =
{
> > +                                     len++;
> > +                             } else {
> > +                                     ret =3D f2fs_secure_erase(prev_bd=
ev,
> > +                                                     prev_block, len, =
flags);
> > +                                     if (ret)
> > +                                             goto out;
>
> Ditto,

Got it.
