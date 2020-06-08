Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398C0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD812072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfvXlBqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgFHMpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgFHMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:45:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14226C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 05:45:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so20255799ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jzpwZIs21vgWMgzLRWTdRCD+4V2c/HdXo7ytExTp1p0=;
        b=OfvXlBqVHW93KxdBmi/XOW9YMBvcVKWRCmX9JhajQXJsUkJjTqe+RohWTnrYx2H1Av
         H3uq9QnjB/XO3+LGEH3Re/cD3sjqDFKOpNJnv8Nnb9cqdVBbvQJQXQqiqAnD43phmK+v
         nA7q7sMrPIaSJUEHES5fW7asxbox4O2vCZhosOMWAFN4nyT69k/Q6MIYO4uIbGu1Xes0
         kuicAD/guDkNMYty9A/Vva03DpgILeQ35yxqZrH2sSg6TDMlB4HOT0stJYKV801VxuAf
         4/k8dGWIAfyxW6Az3kvMjgSznJVCfi/0CLFweL7bQ4QERjnXlXfgfXkl64DoOkkBpUpW
         7w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jzpwZIs21vgWMgzLRWTdRCD+4V2c/HdXo7ytExTp1p0=;
        b=KIP7ub3SZaDtzO20piGo/t9IVTju2PiQRrQB1wuCPp9NfsOVAYXJEfG6wHa9uQW7gv
         LuHrNLvB0Xmjwse5NEwgKxLpMhsu/88m3WsrUhPc9YWNHNraT2vbx5kaII9Cj40ShxKn
         zOqKb/BdSRzresc9DUzbvGph0hmsmyADr48my88LmWX1f/orYs4wcNSyZrtQOMmVbTBV
         bFD7AQJlN0n1yxe5mVvUepxevkpStHwLTVRXwwOn2JpWWI9BQZ7X+WTArSLyK1dQD/XA
         SyfQdMKuB+zoeuGSJSnLcQHRvqDnzViALepTayHFi+pay3bf4LJABy1h/R6yxpnLCsml
         0QWw==
X-Gm-Message-State: AOAM532z42tXhY6P02d5G799TERnVUxbiZg82jDH8BIceNSi2zGbjmoR
        aHktrU1b4iACGbl/wReaN8F5XoYbNOYNIZoLlNo=
X-Google-Smtp-Source: ABdhPJxDGRk+IjcOvR1N4M6hRYIG1Rk/t49++3n6mFS/rHB/11yhOo3LhE3CjOtSiJUVGkQWlQNNXv0v+9K5x0LlNxY=
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr6121320ljj.166.1591620305479;
 Mon, 08 Jun 2020 05:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200605042746.201180-1-daeho43@gmail.com> <fd9bd76c-1864-2cfc-bf86-ef705c8a407d@huawei.com>
 <CACOAw_yw+zczoWpNvYz_UHRYjr8BS+xKK=7_BKi0_0wEhp8Lvg@mail.gmail.com>
 <36d3c98e-24bb-988c-57a3-82730cc75cbc@huawei.com> <CACOAw_wVEw3+Kyz2HvvanhhP2_-xQy9wjfpDt5G0ahXM8o-V-Q@mail.gmail.com>
 <3eade7bf-ce66-e502-24e7-e3a1e548dd77@huawei.com>
In-Reply-To: <3eade7bf-ce66-e502-24e7-e3a1e548dd77@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 8 Jun 2020 21:44:54 +0900
Message-ID: <CACOAw_wmbVZwaWwgeL7xZ8xEGS6Nui22=3bqbaeWSSEBg6-cjQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_TRIM_FILE ioctl
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

> >> Since spec didn't restrict how vendor implement the erase interface, s=
o
> >> in order to enhance performance of discard interface, vendor could imp=
lement
> >> it as an async one, which may not zero mapping entry(L1 table), instea=
d, it
> >> could set related bitmap to invalid that mapping entry, than later if =
device
> >> allow user to access that invalid mapping entry, key info may be explo=
sed,

Is it possible to access the old data of the block which has been
discarded already?
Since FTL already sets the related bitmap to invalid even in the async
way, I thought
there is no way to access old data using the same logical address.
It's already invalidated.
Have you seen any storage vendor allowing this? It's awful.


2020=EB=85=84 6=EC=9B=94 8=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:43, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/6/8 15:19, Daeho Jeong wrote:
> > Yes, I agree with you about each vendor has different implementation on=
 discard.
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
> > 2020=EB=85=84 6=EC=9B=94 8=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 3:57=
, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On 2020/6/8 11:36, Daeho Jeong wrote:
> >>> Yes, this is for security key destruction.
> >>>
> >>> AFAIK, discard will unmap the data block and, after done it,
> >>> we can read either zero data or garbage data from that block dependin=
g
> >>> on eMMC/UFS.
> >>
> >> Since spec didn't restrict how vendor implement the erase interface, s=
o
> >> in order to enhance performance of discard interface, vendor could imp=
lement
> >> it as an async one, which may not zero mapping entry(L1 table), instea=
d, it
> >> could set related bitmap to invalid that mapping entry, than later if =
device
> >> allow user to access that invalid mapping entry, key info may be explo=
sed,
> >>
> >> It's completely up to how vendor implement the interface, so I think t=
here is
> >> still risk to use discard.
> >>
> >> Thanks,
> >>
> >>> In a view point of read data, it might be the same with zeroing the d=
ata block.
> >>> However, since we can even unmap that block, I believe discard is
> >>> safer than zeroing out.
> >>>
> >>> 2020=EB=85=84 6=EC=9B=94 8=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 11=
:46, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>>>
> >>>> On 2020/6/5 12:27, Daeho Jeong wrote:
> >>>>> From: Daeho Jeong <daehojeong@google.com>
> >>>>>
> >>>>> Added a new ioctl to send discard commands to whole data area of
> >>>>> a regular file for security reason.
> >>>>
> >>>> I guess this interface is introduced for security key destruction, i=
f I'm
> >>>> right, however, IIRC, discard(erase) semantics in eMMC/UFS spec won'=
t
> >>>> guarantee that data which was discard could be zeroed out, so after =
discard,
> >>>> the key still have risk of exposure. So instead, should we use sb_is=
sue_zeroout()?
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>>>> ---
> >>>>>  fs/f2fs/f2fs.h |   1 +
> >>>>>  fs/f2fs/file.c | 129 +++++++++++++++++++++++++++++++++++++++++++++=
++++
> >>>>>  2 files changed, 130 insertions(+)
> >>>>>
> >>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>>> index c812fb8e2d9c..9ae81d0fefa0 100644
> >>>>> --- a/fs/f2fs/f2fs.h
> >>>>> +++ b/fs/f2fs/f2fs.h
> >>>>> @@ -434,6 +434,7 @@ static inline bool __has_cursum_space(struct f2=
fs_journal *journal,
> >>>>>                                       _IOR(F2FS_IOCTL_MAGIC, 18, __=
u64)
> >>>>>  #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS                          =
   \
> >>>>>                                       _IOR(F2FS_IOCTL_MAGIC, 19, __=
u64)
> >>>>> +#define F2FS_IOC_TRIM_FILE           _IO(F2FS_IOCTL_MAGIC, 20)
> >>>>>
> >>>>>  #define F2FS_IOC_GET_VOLUME_NAME     FS_IOC_GETFSLABEL
> >>>>>  #define F2FS_IOC_SET_VOLUME_NAME     FS_IOC_SETFSLABEL
> >>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>>> index dfa1ac2d751a..58507bb5649c 100644
> >>>>> --- a/fs/f2fs/file.c
> >>>>> +++ b/fs/f2fs/file.c
> >>>>> @@ -3749,6 +3749,132 @@ static int f2fs_reserve_compress_blocks(str=
uct file *filp, unsigned long arg)
> >>>>>       return ret;
> >>>>>  }
> >>>>>
> >>>>> +static int f2fs_trim_file(struct file *filp)
> >>>>> +{
> >>>>> +     struct inode *inode =3D file_inode(filp);
> >>>>> +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >>>>> +     struct address_space *mapping =3D inode->i_mapping;
> >>>>> +     struct bio *bio =3D NULL;
> >>>>> +     struct block_device *prev_bdev =3D NULL;
> >>>>> +     loff_t file_size;
> >>>>> +     pgoff_t index, pg_start =3D 0, pg_end;
> >>>>> +     block_t prev_block =3D 0, len =3D 0;
> >>>>> +     int ret =3D 0;
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
> >>>>> +     ret =3D mnt_want_write_file(filp);
> >>>>> +     if (ret)
> >>>>> +             return ret;
> >>>>> +
> >>>>> +     inode_lock(inode);
> >>>>> +
> >>>>> +     file_size =3D i_size_read(inode);
> >>>>> +     if (!file_size)
> >>>>> +             goto err;
> >>>>> +     pg_end =3D (pgoff_t)round_up(file_size, PAGE_SIZE) >> PAGE_SH=
IFT;
> >>>>> +
> >>>>> +     ret =3D f2fs_convert_inline_inode(inode);
> >>>>> +     if (ret)
> >>>>> +             goto err;
> >>>>> +
> >>>>> +     down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>>>> +     down_write(&F2FS_I(inode)->i_mmap_sem);
> >>>>> +
> >>>>> +     ret =3D filemap_write_and_wait(mapping);
> >>>>> +     if (ret)
> >>>>> +             goto out;
> >>>>> +
> >>>>> +     truncate_inode_pages(mapping, 0);
> >>>>> +
> >>>>> +     for (index =3D pg_start; index < pg_end;) {
> >>>>> +             struct dnode_of_data dn;
> >>>>> +             unsigned int end_offset;
> >>>>> +
> >>>>> +             set_new_dnode(&dn, inode, NULL, NULL, 0);
> >>>>> +             ret =3D f2fs_get_dnode_of_data(&dn, index, LOOKUP_NOD=
E);
> >>>>> +             if (ret)
> >>>>> +                     goto out;
> >>>>> +
> >>>>> +             end_offset =3D ADDRS_PER_PAGE(dn.node_page, inode);
> >>>>> +             if (pg_end < end_offset + index)
> >>>>> +                     end_offset =3D pg_end - index;
> >>>>> +
> >>>>> +             for (; dn.ofs_in_node < end_offset;
> >>>>> +                             dn.ofs_in_node++, index++) {
> >>>>> +                     struct block_device *cur_bdev;
> >>>>> +                     block_t blkaddr =3D f2fs_data_blkaddr(&dn);
> >>>>> +
> >>>>> +                     if (__is_valid_data_blkaddr(blkaddr)) {
> >>>>> +                             if (!f2fs_is_valid_blkaddr(F2FS_I_SB(=
inode),
> >>>>> +                                     blkaddr, DATA_GENERIC_ENHANCE=
)) {
> >>>>> +                                     ret =3D -EFSCORRUPTED;
> >>>>> +                                     goto out;
> >>>>> +                             }
> >>>>> +                     } else
> >>>>> +                             continue;
> >>>>> +
> >>>>> +                     cur_bdev =3D f2fs_target_device(sbi, blkaddr,=
 NULL);
> >>>>> +                     if (f2fs_is_multi_device(sbi)) {
> >>>>> +                             int i =3D f2fs_target_device_index(sb=
i, blkaddr);
> >>>>> +
> >>>>> +                             blkaddr -=3D FDEV(i).start_blk;
> >>>>> +                     }
> >>>>> +
> >>>>> +                     if (len) {
> >>>>> +                             if (prev_bdev =3D=3D cur_bdev &&
> >>>>> +                                     blkaddr =3D=3D prev_block + l=
en) {
> >>>>> +                                     len++;
> >>>>> +                             } else {
> >>>>> +                                     ret =3D __blkdev_issue_discar=
d(prev_bdev,
> >>>>> +                                             SECTOR_FROM_BLOCK(pre=
v_block),
> >>>>> +                                             SECTOR_FROM_BLOCK(len=
),
> >>>>> +                                             GFP_NOFS, 0, &bio);
> >>>>> +                                     if (ret)
> >>>>> +                                             goto out;
> >>>>> +> +                                  len =3D 0;
> >>>>> +                             }
> >>>>> +                     }
> >>>>> +
> >>>>> +                     if (!len) {
> >>>>> +                             prev_bdev =3D cur_bdev;
> >>>>> +                             prev_block =3D blkaddr;
> >>>>> +                             len =3D 1;
> >>>>> +                     }
> >>>>> +             }
> >>>>> +
> >>>>> +             f2fs_put_dnode(&dn);
> >>>>> +     }
> >>>>> +
> >>>>> +     if (len)
> >>>>> +             ret =3D __blkdev_issue_discard(prev_bdev,
> >>>>> +                                     SECTOR_FROM_BLOCK(prev_block)=
,
> >>>>> +                                     SECTOR_FROM_BLOCK(len),
> >>>>> +                                     GFP_NOFS, 0, &bio);
> >>>>> +out:
> >>>>> +     if (bio) {
> >>>>> +             ret =3D submit_bio_wait(bio);
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
> >>>>>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long=
 arg)
> >>>>>  {
> >>>>>       if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> >>>>> @@ -3835,6 +3961,8 @@ long f2fs_ioctl(struct file *filp, unsigned i=
nt cmd, unsigned long arg)
> >>>>>               return f2fs_release_compress_blocks(filp, arg);
> >>>>>       case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
> >>>>>               return f2fs_reserve_compress_blocks(filp, arg);
> >>>>> +     case F2FS_IOC_TRIM_FILE:
> >>>>> +             return f2fs_trim_file(filp);
> >>>>>       default:
> >>>>>               return -ENOTTY;
> >>>>>       }
> >>>>> @@ -4004,6 +4132,7 @@ long f2fs_compat_ioctl(struct file *file, uns=
igned int cmd, unsigned long arg)
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
