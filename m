Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C758EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88818206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGAj3sSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgFIBai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFIBah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 21:30:37 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22336C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 18:30:36 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so22951899ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 18:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bTGJr1OaiuLxqBb3Yzwxjfa8x3YWsORu9fZMWrzKhxE=;
        b=WGAj3sSHXvdYUWCy8x1VK9B0OdHO1ijFz93LW+uoOUgyZheN+ZDR6ba4QuyCdt4Fas
         ARFdaMf6pl2vDHlLY2EfwEEwGH/jlT1q7VG0kazuFg/ESkBvYaiCIVIyAJ0Usl4OZhoe
         lwURKHRxuy6JeTcS3hwY6VN1yvlUYjv4ZmVabhSsxBb6BmxtivcjinQPdu3Sre1d/nA0
         JUeDsaa0gmEXYGiq+iDbkjvm7A497as9PnDKmB0hCVPHN1RG8RFTt7zn1NFQe1ga2sXm
         lkrEbBoVx4sKwpR4IYwemgREPdoDwKlyZW3wZ0zZPTTiqmEcggzgfzWj4i2pg66IOoiR
         0uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bTGJr1OaiuLxqBb3Yzwxjfa8x3YWsORu9fZMWrzKhxE=;
        b=OBJK1Dwk0q/zFVQyPv4Gpv69ymn3Oa8g801lG3sbF9ArUFSWHKejvSgN2wvRMZGXJi
         0KJbaIbdGl3JdMY6WvjWXd+S7YbAHvJAQf9AZ01TN3FHJyF24vuUZ4SojXeZYTS56ffO
         X4ibugtv662z8mpKpnQX0PptJS9T7xHKcX/cyG54KpZcKGKRaNobZqLrYO6437GR+0yy
         QAA8ZXjbA1hyKzCyDas1yiqFPo/X/x617HIndvdVu7CrRvX8X8TqwBc9zAcKK73msqfY
         F1UvbXwtiFMN6c37qQ+qRjV2qQTrwbS5aMgZhEeOhiwKz+p837/isTmqkDH7qpENxmXs
         6gyA==
X-Gm-Message-State: AOAM532xTnZZ9oCLJ4c2h8/c4kVKvYIX+q4YV3RWlAljPrn5g2t5eb+Z
        e6rxd/vJP5Bm/TuaHk7GT5LyB7mPFeR7ZZtJd/w=
X-Google-Smtp-Source: ABdhPJwvBiXRFBn4tiFHaaoKqGFpn3mugWn5Txv+qTw/eX5AcQY6FU2mYx1z5ET60UcxuGoF8GrtavelrEr1wGw7nJE=
X-Received: by 2002:a05:651c:1022:: with SMTP id w2mr13176507ljm.262.1591666234259;
 Mon, 08 Jun 2020 18:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200605042746.201180-1-daeho43@gmail.com> <fd9bd76c-1864-2cfc-bf86-ef705c8a407d@huawei.com>
 <CACOAw_yw+zczoWpNvYz_UHRYjr8BS+xKK=7_BKi0_0wEhp8Lvg@mail.gmail.com>
 <36d3c98e-24bb-988c-57a3-82730cc75cbc@huawei.com> <CACOAw_wVEw3+Kyz2HvvanhhP2_-xQy9wjfpDt5G0ahXM8o-V-Q@mail.gmail.com>
 <3eade7bf-ce66-e502-24e7-e3a1e548dd77@huawei.com> <20200608130734.GB200855@google.com>
 <69510409-791a-f955-a6c6-0b81607cf197@huawei.com>
In-Reply-To: <69510409-791a-f955-a6c6-0b81607cf197@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 9 Jun 2020 10:30:23 +0900
Message-ID: <CACOAw_wAYCmpzRA=uXWFSTNrsMFcctJ7Ee1HUf0HmjfTFmPFdw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_TRIM_FILE ioctl
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the discussion, I'll add a flag to select discard and/or zero out.
We need to send the discard first between those, because we'll send
the discard to a zero-ed new block, if we zero out first.

2020=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 10:16, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/6/8 21:07, Jaegeuk Kim wrote:
> > On 06/08, Chao Yu wrote:
> >> On 2020/6/8 15:19, Daeho Jeong wrote:
> >>> Yes, I agree with you about each vendor has different implementation =
on discard.
> >>> So, we might be gonna use the combination of zeroing and send discard=
s
> >>> for a more
> >>> secure solution. :)
> >>
> >> IIRC, current solution is:
> >>
> >> - pin file
> >> - get all block addresses of file
> >> - write zero to block addresses
> >> - issue discard
> >>
> >> Is that correct?
> >>
> >> Could we handle those logic (zero out & discard) in new interface
> >> (may be named as {F2FS,EXT4}_IOC_SEC_TRIM_FILE)? then userspace logic
> >> could be quite simple later, and also memcpy could be avoid to make
> >> destruction process more efficient.
> >
> > What about adding a flag to determine calling unmap and/or zero out?
>
> Better. :)
>
> Thanks,
>
> >
> >>
> >> Just raw proposal. :)
> >>
> >> Thanks,
> >>
> >>> I think we still need a discard interface to unmap from the mapping
> >>> table of the storage device side.
> >>>
> >>> Thanks,
> >>>
> >>> 2020=EB=85=84 6=EC=9B=94 8=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 3:=
57, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>>>
> >>>> On 2020/6/8 11:36, Daeho Jeong wrote:
> >>>>> Yes, this is for security key destruction.
> >>>>>
> >>>>> AFAIK, discard will unmap the data block and, after done it,
> >>>>> we can read either zero data or garbage data from that block depend=
ing
> >>>>> on eMMC/UFS.
> >>>>
> >>>> Since spec didn't restrict how vendor implement the erase interface,=
 so
> >>>> in order to enhance performance of discard interface, vendor could i=
mplement
> >>>> it as an async one, which may not zero mapping entry(L1 table), inst=
ead, it
> >>>> could set related bitmap to invalid that mapping entry, than later i=
f device
> >>>> allow user to access that invalid mapping entry, key info may be exp=
losed,
> >>>>
> >>>> It's completely up to how vendor implement the interface, so I think=
 there is
> >>>> still risk to use discard.
> >>>>
> >>>> Thanks,
> >>>>
> >>>>> In a view point of read data, it might be the same with zeroing the=
 data block.
> >>>>> However, since we can even unmap that block, I believe discard is
> >>>>> safer than zeroing out.
> >>>>>
> >>>>> 2020=EB=85=84 6=EC=9B=94 8=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 =
11:46, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>>>>>
> >>>>>> On 2020/6/5 12:27, Daeho Jeong wrote:
> >>>>>>> From: Daeho Jeong <daehojeong@google.com>
> >>>>>>>
> >>>>>>> Added a new ioctl to send discard commands to whole data area of
> >>>>>>> a regular file for security reason.
> >>>>>>
> >>>>>> I guess this interface is introduced for security key destruction,=
 if I'm
> >>>>>> right, however, IIRC, discard(erase) semantics in eMMC/UFS spec wo=
n't
> >>>>>> guarantee that data which was discard could be zeroed out, so afte=
r discard,
> >>>>>> the key still have risk of exposure. So instead, should we use sb_=
issue_zeroout()?
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>>
> >>>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>>>>>> ---
> >>>>>>>  fs/f2fs/f2fs.h |   1 +
> >>>>>>>  fs/f2fs/file.c | 129 +++++++++++++++++++++++++++++++++++++++++++=
++++++
> >>>>>>>  2 files changed, 130 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>>>>> index c812fb8e2d9c..9ae81d0fefa0 100644
> >>>>>>> --- a/fs/f2fs/f2fs.h
> >>>>>>> +++ b/fs/f2fs/f2fs.h
> >>>>>>> @@ -434,6 +434,7 @@ static inline bool __has_cursum_space(struct =
f2fs_journal *journal,
> >>>>>>>                                       _IOR(F2FS_IOCTL_MAGIC, 18, =
__u64)
> >>>>>>>  #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS                        =
     \
> >>>>>>>                                       _IOR(F2FS_IOCTL_MAGIC, 19, =
__u64)
> >>>>>>> +#define F2FS_IOC_TRIM_FILE           _IO(F2FS_IOCTL_MAGIC, 20)
> >>>>>>>
> >>>>>>>  #define F2FS_IOC_GET_VOLUME_NAME     FS_IOC_GETFSLABEL
> >>>>>>>  #define F2FS_IOC_SET_VOLUME_NAME     FS_IOC_SETFSLABEL
> >>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>>>>> index dfa1ac2d751a..58507bb5649c 100644
> >>>>>>> --- a/fs/f2fs/file.c
> >>>>>>> +++ b/fs/f2fs/file.c
> >>>>>>> @@ -3749,6 +3749,132 @@ static int f2fs_reserve_compress_blocks(s=
truct file *filp, unsigned long arg)
> >>>>>>>       return ret;
> >>>>>>>  }
> >>>>>>>
> >>>>>>> +static int f2fs_trim_file(struct file *filp)
> >>>>>>> +{
> >>>>>>> +     struct inode *inode =3D file_inode(filp);
> >>>>>>> +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >>>>>>> +     struct address_space *mapping =3D inode->i_mapping;
> >>>>>>> +     struct bio *bio =3D NULL;
> >>>>>>> +     struct block_device *prev_bdev =3D NULL;
> >>>>>>> +     loff_t file_size;
> >>>>>>> +     pgoff_t index, pg_start =3D 0, pg_end;
> >>>>>>> +     block_t prev_block =3D 0, len =3D 0;
> >>>>>>> +     int ret =3D 0;
> >>>>>>> +
> >>>>>>> +     if (!f2fs_hw_support_discard(sbi))
> >>>>>>> +             return -EOPNOTSUPP;
> >>>>>>> +
> >>>>>>> +     if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode) |=
|
> >>>>>>> +                     f2fs_compressed_file(inode))
> >>>>>>> +             return -EINVAL;
> >>>>>>> +
> >>>>>>> +     if (f2fs_readonly(sbi->sb))
> >>>>>>> +             return -EROFS;
> >>>>>>> +
> >>>>>>> +     ret =3D mnt_want_write_file(filp);
> >>>>>>> +     if (ret)
> >>>>>>> +             return ret;
> >>>>>>> +
> >>>>>>> +     inode_lock(inode);
> >>>>>>> +
> >>>>>>> +     file_size =3D i_size_read(inode);
> >>>>>>> +     if (!file_size)
> >>>>>>> +             goto err;
> >>>>>>> +     pg_end =3D (pgoff_t)round_up(file_size, PAGE_SIZE) >> PAGE_=
SHIFT;
> >>>>>>> +
> >>>>>>> +     ret =3D f2fs_convert_inline_inode(inode);
> >>>>>>> +     if (ret)
> >>>>>>> +             goto err;
> >>>>>>> +
> >>>>>>> +     down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>>>>>> +     down_write(&F2FS_I(inode)->i_mmap_sem);
> >>>>>>> +
> >>>>>>> +     ret =3D filemap_write_and_wait(mapping);
> >>>>>>> +     if (ret)
> >>>>>>> +             goto out;
> >>>>>>> +
> >>>>>>> +     truncate_inode_pages(mapping, 0);
> >>>>>>> +
> >>>>>>> +     for (index =3D pg_start; index < pg_end;) {
> >>>>>>> +             struct dnode_of_data dn;
> >>>>>>> +             unsigned int end_offset;
> >>>>>>> +
> >>>>>>> +             set_new_dnode(&dn, inode, NULL, NULL, 0);
> >>>>>>> +             ret =3D f2fs_get_dnode_of_data(&dn, index, LOOKUP_N=
ODE);
> >>>>>>> +             if (ret)
> >>>>>>> +                     goto out;
> >>>>>>> +
> >>>>>>> +             end_offset =3D ADDRS_PER_PAGE(dn.node_page, inode);
> >>>>>>> +             if (pg_end < end_offset + index)
> >>>>>>> +                     end_offset =3D pg_end - index;
> >>>>>>> +
> >>>>>>> +             for (; dn.ofs_in_node < end_offset;
> >>>>>>> +                             dn.ofs_in_node++, index++) {
> >>>>>>> +                     struct block_device *cur_bdev;
> >>>>>>> +                     block_t blkaddr =3D f2fs_data_blkaddr(&dn);
> >>>>>>> +
> >>>>>>> +                     if (__is_valid_data_blkaddr(blkaddr)) {
> >>>>>>> +                             if (!f2fs_is_valid_blkaddr(F2FS_I_S=
B(inode),
> >>>>>>> +                                     blkaddr, DATA_GENERIC_ENHAN=
CE)) {
> >>>>>>> +                                     ret =3D -EFSCORRUPTED;
> >>>>>>> +                                     goto out;
> >>>>>>> +                             }
> >>>>>>> +                     } else
> >>>>>>> +                             continue;
> >>>>>>> +
> >>>>>>> +                     cur_bdev =3D f2fs_target_device(sbi, blkadd=
r, NULL);
> >>>>>>> +                     if (f2fs_is_multi_device(sbi)) {
> >>>>>>> +                             int i =3D f2fs_target_device_index(=
sbi, blkaddr);
> >>>>>>> +
> >>>>>>> +                             blkaddr -=3D FDEV(i).start_blk;
> >>>>>>> +                     }
> >>>>>>> +
> >>>>>>> +                     if (len) {
> >>>>>>> +                             if (prev_bdev =3D=3D cur_bdev &&
> >>>>>>> +                                     blkaddr =3D=3D prev_block +=
 len) {
> >>>>>>> +                                     len++;
> >>>>>>> +                             } else {
> >>>>>>> +                                     ret =3D __blkdev_issue_disc=
ard(prev_bdev,
> >>>>>>> +                                             SECTOR_FROM_BLOCK(p=
rev_block),
> >>>>>>> +                                             SECTOR_FROM_BLOCK(l=
en),
> >>>>>>> +                                             GFP_NOFS, 0, &bio);
> >>>>>>> +                                     if (ret)
> >>>>>>> +                                             goto out;
> >>>>>>> +> +                                  len =3D 0;
> >>>>>>> +                             }
> >>>>>>> +                     }
> >>>>>>> +
> >>>>>>> +                     if (!len) {
> >>>>>>> +                             prev_bdev =3D cur_bdev;
> >>>>>>> +                             prev_block =3D blkaddr;
> >>>>>>> +                             len =3D 1;
> >>>>>>> +                     }
> >>>>>>> +             }
> >>>>>>> +
> >>>>>>> +             f2fs_put_dnode(&dn);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     if (len)
> >>>>>>> +             ret =3D __blkdev_issue_discard(prev_bdev,
> >>>>>>> +                                     SECTOR_FROM_BLOCK(prev_bloc=
k),
> >>>>>>> +                                     SECTOR_FROM_BLOCK(len),
> >>>>>>> +                                     GFP_NOFS, 0, &bio);
> >>>>>>> +out:
> >>>>>>> +     if (bio) {
> >>>>>>> +             ret =3D submit_bio_wait(bio);
> >>>>>>> +             bio_put(bio);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     up_write(&F2FS_I(inode)->i_mmap_sem);
> >>>>>>> +     up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>>>>>> +err:
> >>>>>>> +     inode_unlock(inode);
> >>>>>>> +     mnt_drop_write_file(filp);
> >>>>>>> +
> >>>>>>> +     return ret;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned lo=
ng arg)
> >>>>>>>  {
> >>>>>>>       if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> >>>>>>> @@ -3835,6 +3961,8 @@ long f2fs_ioctl(struct file *filp, unsigned=
 int cmd, unsigned long arg)
> >>>>>>>               return f2fs_release_compress_blocks(filp, arg);
> >>>>>>>       case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
> >>>>>>>               return f2fs_reserve_compress_blocks(filp, arg);
> >>>>>>> +     case F2FS_IOC_TRIM_FILE:
> >>>>>>> +             return f2fs_trim_file(filp);
> >>>>>>>       default:
> >>>>>>>               return -ENOTTY;
> >>>>>>>       }
> >>>>>>> @@ -4004,6 +4132,7 @@ long f2fs_compat_ioctl(struct file *file, u=
nsigned int cmd, unsigned long arg)
> >>>>>>>       case F2FS_IOC_GET_COMPRESS_BLOCKS:
> >>>>>>>       case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
> >>>>>>>       case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
> >>>>>>> +     case F2FS_IOC_TRIM_FILE:
> >>>>>>>               break;
> >>>>>>>       default:
> >>>>>>>               return -ENOIOCTLCMD;
> >>>>>>>
> >>>>> .
> >>>>>
> >>> .
> >>>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> >
