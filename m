Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00066C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FB4206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR8s4wI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFJXxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgFJXxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:53:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C71C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:53:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so4687001ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W6SCjDxf22ZPANpZkdg4mqj/y3A2+mTLbWB05CxEliY=;
        b=IR8s4wI+ZHHWWMK7YYOZWyKUNFQ2sn1ZrHgrWtk2z9s4ucWBarBfet9rt/ChY91Dhb
         RvzTJA6x6Q0O+SHEkOKIjRn7KcAtkL5gBb6f7iGH6NGGzmIZW8At1Tj1UZ0v5ufe24Uy
         swpgoYVFQt57qWUvtqBeVcO0gMpkZE+jpRRdD9hTgYEKetwdEhTvhsqyT2ayQyOyK1VP
         8K3rdYayjtifFTNQbuHQcNnYc8amQKuI4wyzN+MshYjvilRFeMFUnEqWdvwoXq66u34n
         nQqSEAOIC0eo7My+Hplf55mSo1dJjJzXJlh6qLEikxa6LY3Dz7ulLgKGveRomG9rorr2
         ptlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W6SCjDxf22ZPANpZkdg4mqj/y3A2+mTLbWB05CxEliY=;
        b=WrTk5B3pwwQtQAtOZ6/nuTVf3G+1/flCPBxclVE0J5KRkRcE4uT69IzOeEhl2XZ83k
         Q24fgqqE1edhonFxM2VYz5W1Hi24pHTCBBRZEYT9PuwyvgxSYiQ68j3Ix11Kw1aBQ5pC
         zZEZ+0v3mUqRGISBlQkhXwEDGf94jZZUtyKPHqNy/PWBE1ug5PmtarXGmvcL2f01QGgX
         TqakCJLQJjteFJg35u5bRkWw4kz9vY1IVmCQ46Jj1Dfe7/SqtiaCcCwdTMgf8dscPYJQ
         bznsxvP7Q98zoz57gO5Vu12TzIWs5VM1/E6pjsGAcLJ0haBdInfOs3wVo2o/DAa1QLAF
         Pgxw==
X-Gm-Message-State: AOAM531+XnLVV9lo9pyCafD9+eZf2coCxHveqxif1c+95bQY72d7hgMm
        +Ovf6IGCB+q3kfF4AlfpxQaIsFTNBgXRNOzHjbTpYTYc+hybWQ==
X-Google-Smtp-Source: ABdhPJyNieO9Eoiv/VP+K1RxJ+gl5WoUSxEqkpph3Eh+wSGglDI0g+Y84lzQ4vFAbgh4/NOcB7XAeBiTLN5QGTUMWFM=
X-Received: by 2002:a2e:a0cc:: with SMTP id f12mr2774888ljm.250.1591833202236;
 Wed, 10 Jun 2020 16:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200609060137.143501-1-daeho43@gmail.com> <20200609165107.GA228564@gmail.com>
 <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com>
 <20200610031532.GA6286@sol.localdomain> <CACOAw_wErOPC=Kf3UU8nFGhWRy84ZnCeJbsyPhSCcXv51B_XxQ@mail.gmail.com>
 <CACOAw_zka6d06RxFOUTwEV7B6o8A2-_6FvqWh_A1nJ0+7FU9yQ@mail.gmail.com>
In-Reply-To: <CACOAw_zka6d06RxFOUTwEV7B6o8A2-_6FvqWh_A1nJ0+7FU9yQ@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 11 Jun 2020 08:53:10 +0900
Message-ID: <CACOAw_yc4hxdyxyO+Lb4MArHek1tP4wxCq0tezWOocgqvK+tqg@mail.gmail.com>
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

> > > > Using FMODE_WRITE is more proper for this case, since we're going t=
o
> > > > modify the data. But I think mnt_want_write_file() is still require=
d
> > > > to prevent the filesystem from freezing or something else.
> > >
> > > Right, the freezing check is actually still necessary.  But getting w=
rite access
> > > to the mount is not necessary.  I think you should use file_start_wri=
te() and
> > > file_end_write(), like vfs_write() does.
>
> I've checked this again.
>
> But I think mnt_want_write_file() looks better than the combination of
> checking FMODE_WRITE and file_start_write(), because
> mnt_want_write_file() handles all the things we need.
> It checks FMODE_WRITER, which is set in do_dentry_open() when
> FMODE_WRITE is already set, and does the stuff that file_start_write()
> is doing. This is why the other filesystem system calls use it.
>
> What do you think?

Hmm, we still need FMODE_WRITE check.
But mnt_want_write_file() looks better, because it'll call
mnt_clone_write() internally, if the file is open for write already.

in ext4/ioctl.c
        case EXT4_IOC_SWAP_BOOT:
        {
                int err;
                if (!(filp->f_mode & FMODE_WRITE))
                        return -EBADF;
                err =3D mnt_want_write_file(filp);
                if (err)
                        return err;2020=EB=85=84 6=EC=9B=94 11=EC=9D=BC (=
=EB=AA=A9) =EC=98=A4=EC=A0=84 8:31, Daeho
Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > > > > > +
> > > > > > +     if (f2fs_readonly(sbi->sb))
> > > > > > +             return -EROFS;
> > > > >
> > > > > Isn't this redundant with mnt_want_write_file()?
> > > > >
> > > > > Also, shouldn't write access to the file be required, i.e.
> > > > > (filp->f_mode & FMODE_WRITE)?  Then the f2fs_readonly() and
> > > > > mnt_want_write_file() checks would be unnecessary.
> > > > >
> > > >
> > > > Using FMODE_WRITE is more proper for this case, since we're going t=
o
> > > > modify the data. But I think mnt_want_write_file() is still require=
d
> > > > to prevent the filesystem from freezing or something else.
> > >
> > > Right, the freezing check is actually still necessary.  But getting w=
rite access
> > > to the mount is not necessary.  I think you should use file_start_wri=
te() and
> > > file_end_write(), like vfs_write() does.
>
> I've checked this again.
>
> But I think mnt_want_write_file() looks better than the combination of
> checking FMODE_WRITE and file_start_write(), because
> mnt_want_write_file() handles all the things we need.
> It checks FMODE_WRITER, which is set in do_dentry_open() when
> FMODE_WRITE is already set, and does the stuff that file_start_write()
> is doing. This is why the other filesystem system calls use it.
>
> What do you think?
>
> 2020=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 12:55=
, Daeho Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > > >
> > > > To prevent the file data from garbage collecting, the user needs to
> > > > use pinfile ioctl and fallocate system call after creating the file=
.
> > > > The sequence is like below.
> > > > 1. create an empty file
> > > > 2. pinfile
> > > > 3. fallocate()
> > >
> > > Is that persistent?  So the file will never be moved afterwards?
> > >
> > > Is there a place where this is (or should be) documented?
> >
> > Yes, this is persistent. F2FS_IOC_SET_PIN_FILE ioctl is to prevent
> > file data from moving and being garbage collected, and further update
> > to the file will be handled in in-place update manner.
> > I don't see any document on this, but you can find the below in
> > Documentation/filesystems/f2fs.rst
> >
> > However, once F2FS receives ioctl(fd, F2FS_IOC_SET_PIN_FILE) in prior t=
o
> > fallocate(fd, DEFAULT_MODE), it allocates on-disk blocks addresses havi=
ng
> > zero or random data, which is useful to the below scenario where:
> >
> >  1. create(fd)
> >  2. ioctl(fd, F2FS_IOC_SET_PIN_FILE)
> >  3. fallocate(fd, 0, 0, size)
> >  4. address =3D fibmap(fd, offset)
> >  5. open(blkdev)
> >  6. write(blkdev, address)
> >
> > > Right, the freezing check is actually still necessary.  But getting w=
rite access
> > > to the mount is not necessary.  I think you should use file_start_wri=
te() and
> > > file_end_write(), like vfs_write() does.
> >
> > Yes, agreed.
> >
> > 2020=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 12:=
15, Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
> > >
> > > On Wed, Jun 10, 2020 at 11:05:46AM +0900, Daeho Jeong wrote:
> > > > > > Added a new ioctl to send discard commands or/and zero out
> > > > > > to whole data area of a regular file for security reason.
> > > > >
> > > > > With this ioctl available, what is the exact procedure to write a=
nd then later
> > > > > securely erase a file on f2fs?  In particular, how can the user p=
revent f2fs
> > > > > from making multiple copies of file data blocks as part of garbag=
e collection?
> > > > >
> > > >
> > > > To prevent the file data from garbage collecting, the user needs to
> > > > use pinfile ioctl and fallocate system call after creating the file=
.
> > > > The sequence is like below.
> > > > 1. create an empty file
> > > > 2. pinfile
> > > > 3. fallocate()
> > >
> > > Is that persistent?  So the file will never be moved afterwards?
> > >
> > > Is there a place where this is (or should be) documented?
> > >
> > > > > > +
> > > > > > +     if (f2fs_readonly(sbi->sb))
> > > > > > +             return -EROFS;
> > > > >
> > > > > Isn't this redundant with mnt_want_write_file()?
> > > > >
> > > > > Also, shouldn't write access to the file be required, i.e.
> > > > > (filp->f_mode & FMODE_WRITE)?  Then the f2fs_readonly() and
> > > > > mnt_want_write_file() checks would be unnecessary.
> > > > >
> > > >
> > > > Using FMODE_WRITE is more proper for this case, since we're going t=
o
> > > > modify the data. But I think mnt_want_write_file() is still require=
d
> > > > to prevent the filesystem from freezing or something else.
> > >
> > > Right, the freezing check is actually still necessary.  But getting w=
rite access
> > > to the mount is not necessary.  I think you should use file_start_wri=
te() and
> > > file_end_write(), like vfs_write() does.
> > >
> > > > >
> > > > > > +
> > > > > > +     if (get_user(flags, (u32 __user *)arg))
> > > > > > +             return -EFAULT;
> > > > > > +     if (!(flags & F2FS_TRIM_FILE_MASK))
> > > > > > +             return -EINVAL;
> > > > >
> > > > > Need to reject unknown flags:
> > > > >
> > > > >         if (flags & ~F2FS_TRIM_FILE_MASK)
> > > > >                 return -EINVAL;
> > > >
> > > > I needed a different thing here. This was to check neither discard =
nor
> > > > zeroing out are not here. But we still need to check unknown flags,
> > > > too.
> > > > The below might be better.
> > > > if (!flags || flags & ~F2FS_TRIM_FILE_MASK)
> > > >        return -EINVAL;
> > >
> > > Sure, but please put parentheses around the second clause:
> > >
> > >         if (flags =3D=3D 0 || (flags & ~F2FS_TRIM_FILE_MASK))
> > >                 return -EINVAL;
> > >
> > > - Eric
