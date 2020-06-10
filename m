Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BA1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C582074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7LmSP9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFJCGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:05:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2CEC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 19:05:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y11so469017ljm.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 19:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t8PWvQi3BGIPlVJ0bYu6fPI9oshJcDrfP4gzoKTncV8=;
        b=q7LmSP9m8DpNTi5/FTp/2s/VJdX2gHdF+45UTFSfWHYBEGm88O9m8XvT1UeGDhITIA
         XKSOr1dsd0wC5deCN1O0RDGiXlqBiVVNI0hVX4w02UQLsHeI3x2v3CzyyUlFGbdCBL3A
         7VADczN7/MZVlECBGy3A4Cvb9eKQ956hwmBoszXruCs2tLwHWgliV0Wnoy/JjPFL3IoB
         oeseTuxCsbDqYQT4o0rCTZySQ6Pt4uAcRo7+p6snXNTufmhLYhBIGv8jZEK+stTSGezg
         8UK3Hm3nz6MfYn4wmjxmygAvk2Jz95VxA+ZtHg8l+Bwedd4nlvuSoQXEoCOxsknfT8pp
         roqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t8PWvQi3BGIPlVJ0bYu6fPI9oshJcDrfP4gzoKTncV8=;
        b=lYxAkQVMYzss4tUzSaI6KMuuVHn29ksWo7k6pEvshfvuDlqoPbrmXKvptWy8zwlC9Q
         2iHzqScZr1G/Gt9x/rBgeIXj6DLPKjAgxBKNDmp0xZcH+Cu/4yMLZLoAV5fT1YPqj4hT
         YP9WwNe4G6GE3LamTxmzDzxTVn8DNtjhwqtOFELVq7hLQb2yRd93QQKuRdvt3pLFIQ7S
         y8K7ASBhPmv9zO/GAKrBfS5Dpq6//81Szw9pQPDPK5qWpQsqiwwErWbCvljthh48yM2B
         32eYZPswkA8nl6JNKnRsBxPpp97O0AALdNbzOi9/ADKJHdjrtBURCSVjwQGCQZy/oolA
         N65A==
X-Gm-Message-State: AOAM532Llb7wpGAysgnTVvR1Sp9bmleEXuQcdyP/5YqadLUnA/Zjgkws
        GR5bsVTMz9NUjzS4CkqKOW9ihb7O/8cWH4Yh508=
X-Google-Smtp-Source: ABdhPJzqNYgc8TtJ3Q5nQVY633iccdl/cpTmYiJlex+3m42kZSZNrPNsoKgjzoow3SYhldiLSXIpDlOvixTdW3ZtAWw=
X-Received: by 2002:a05:651c:1022:: with SMTP id w2mr566699ljm.262.1591754757022;
 Tue, 09 Jun 2020 19:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200609060137.143501-1-daeho43@gmail.com> <20200609165107.GA228564@gmail.com>
In-Reply-To: <20200609165107.GA228564@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 10 Jun 2020 11:05:46 +0900
Message-ID: <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Added a new ioctl to send discard commands or/and zero out
> > to whole data area of a regular file for security reason.
>
> With this ioctl available, what is the exact procedure to write and then =
later
> securely erase a file on f2fs?  In particular, how can the user prevent f=
2fs
> from making multiple copies of file data blocks as part of garbage collec=
tion?
>

To prevent the file data from garbage collecting, the user needs to
use pinfile ioctl and fallocate system call after creating the file.
The sequence is like below.
1. create an empty file
2. pinfile
3. fallocate()

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
>
> Why can the request_queue be NULL here?
>

This check is copied from __blkdev_issue_discard(), even if
bdev_get_queue() says it doesn't return NULL value.
__blkdev_issue_discard() does the same thing.

> > +
> > +     if (flags & F2FS_TRIM_FILE_DISCARD)
> > +             ret =3D blkdev_issue_discard(bdev, sector, nr_sects, GFP_=
NOFS,
> > +                                             blk_queue_secure_erase(q)=
 ?
> > +                                             BLKDEV_DISCARD_SECURE : 0=
);
> > +
> > +     if (!ret && flags & F2FS_TRIM_FILE_ZEROOUT)
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
> > +     loff_t file_size;
> > +     pgoff_t index, pg_start =3D 0, pg_end;
> > +     block_t prev_block =3D 0, len =3D 0;
> > +     u32 flags;
> > +     int ret =3D 0;
> > +
> > +     if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode) ||
> > +                     f2fs_compressed_file(inode))
> > +             return -EINVAL;
>
> Is it valid to check f2fs_is_atomic_file() and f2fs_compressed_file() out=
side of
> inode_lock()?
>

Right, it's better to move the check after inode_lock().

> > +
> > +     if (f2fs_readonly(sbi->sb))
> > +             return -EROFS;
>
> Isn't this redundant with mnt_want_write_file()?
>
> Also, shouldn't write access to the file be required, i.e.
> (filp->f_mode & FMODE_WRITE)?  Then the f2fs_readonly() and
> mnt_want_write_file() checks would be unnecessary.
>

Using FMODE_WRITE is more proper for this case, since we're going to
modify the data. But I think mnt_want_write_file() is still required
to prevent the filesystem from freezing or something else.

> > +
> > +     if (f2fs_lfs_mode(sbi))
> > +             return -EOPNOTSUPP;
>
> Doesn't this check have to be serialized with remount?

Need to do that, thanks.

>
> > +
> > +     if (get_user(flags, (u32 __user *)arg))
> > +             return -EFAULT;
> > +     if (!(flags & F2FS_TRIM_FILE_MASK))
> > +             return -EINVAL;
>
> Need to reject unknown flags:
>
>         if (flags & ~F2FS_TRIM_FILE_MASK)
>                 return -EINVAL;

I needed a different thing here. This was to check neither discard nor
zeroing out are not here. But we still need to check unknown flags,
too.
The below might be better.
if (!flags || flags & ~F2FS_TRIM_FILE_MASK)
       return -EINVAL;

>
> > +
> > +     if (flags & F2FS_TRIM_FILE_DISCARD && !f2fs_hw_support_discard(sb=
i))
> > +             return -EOPNOTSUPP;
> > +
> > +     ret =3D mnt_want_write_file(filp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     inode_lock(inode);
> > +
> > +     file_size =3D i_size_read(inode);
> > +     if (!file_size)
> > +             goto err;
>
> ->i_size is stable while holding inode_lock().  So just use ->i_size inst=
ead of
> i_size_read().

Yes.

>
> > +     pg_end =3D (pgoff_t)round_up(file_size, PAGE_SIZE) >> PAGE_SHIFT;
>
> This can be simplified to:
>
>         pg_end =3D DIV_ROUND_UP(file_size, PAGE_SIZE);

Cool~ :)

>
>
> - Eric




2020=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:51, E=
ric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Jun 09, 2020 at 03:01:37PM +0900, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added a new ioctl to send discard commands or/and zero out
> > to whole data area of a regular file for security reason.
>
> With this ioctl available, what is the exact procedure to write and then =
later
> securely erase a file on f2fs?  In particular, how can the user prevent f=
2fs
> from making multiple copies of file data blocks as part of garbage collec=
tion?
>
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
>
> Why can the request_queue be NULL here?
>
> > +
> > +     if (flags & F2FS_TRIM_FILE_DISCARD)
> > +             ret =3D blkdev_issue_discard(bdev, sector, nr_sects, GFP_=
NOFS,
> > +                                             blk_queue_secure_erase(q)=
 ?
> > +                                             BLKDEV_DISCARD_SECURE : 0=
);
> > +
> > +     if (!ret && flags & F2FS_TRIM_FILE_ZEROOUT)
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
> > +     loff_t file_size;
> > +     pgoff_t index, pg_start =3D 0, pg_end;
> > +     block_t prev_block =3D 0, len =3D 0;
> > +     u32 flags;
> > +     int ret =3D 0;
> > +
> > +     if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode) ||
> > +                     f2fs_compressed_file(inode))
> > +             return -EINVAL;
>
> Is it valid to check f2fs_is_atomic_file() and f2fs_compressed_file() out=
side of
> inode_lock()?
>
> > +
> > +     if (f2fs_readonly(sbi->sb))
> > +             return -EROFS;
>
> Isn't this redundant with mnt_want_write_file()?
>
> Also, shouldn't write access to the file be required, i.e.
> (filp->f_mode & FMODE_WRITE)?  Then the f2fs_readonly() and
> mnt_want_write_file() checks would be unnecessary.
>
> > +
> > +     if (f2fs_lfs_mode(sbi))
> > +             return -EOPNOTSUPP;
>
> Doesn't this check have to be serialized with remount?
>
> > +
> > +     if (get_user(flags, (u32 __user *)arg))
> > +             return -EFAULT;
> > +     if (!(flags & F2FS_TRIM_FILE_MASK))
> > +             return -EINVAL;
>
> Need to reject unknown flags:
>
>         if (flags & ~F2FS_TRIM_FILE_MASK)
>                 return -EINVAL;
>
> > +
> > +     if (flags & F2FS_TRIM_FILE_DISCARD && !f2fs_hw_support_discard(sb=
i))
> > +             return -EOPNOTSUPP;
> > +
> > +     ret =3D mnt_want_write_file(filp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     inode_lock(inode);
> > +
> > +     file_size =3D i_size_read(inode);
> > +     if (!file_size)
> > +             goto err;
>
> ->i_size is stable while holding inode_lock().  So just use ->i_size inst=
ead of
> i_size_read().
>
> > +     pg_end =3D (pgoff_t)round_up(file_size, PAGE_SIZE) >> PAGE_SHIFT;
>
> This can be simplified to:
>
>         pg_end =3D DIV_ROUND_UP(file_size, PAGE_SIZE);
>
>
> - Eric
