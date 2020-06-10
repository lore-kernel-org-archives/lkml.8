Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA746C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD7320760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG9A+T23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgFJXbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJXbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:31:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63DFC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:31:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so4649819ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tHyLqUmtTTMIbIqoDwVSMrkpYuG5yIqYL6HxByUSF1k=;
        b=XG9A+T23tcxH5dzLrr0ymPt9XR35a61ozhwFwcrizTaPccaz9PvTnfAwC6+xJe1Z32
         bQhAZj7s4dptgCg/IUpHZopInAaxskDR5LI7XPW1MILHn0fk8E+x6zcGc6ilRrbp8SnT
         0VL2rAodo13s6qbJTM69fmuhCZ9qbEVDVdV/2Zz+cB/lML5pIoOSGlF/0d2OEVoYGTCK
         OVIjFc/CcuNMS/VhJcZZ3ZY0cLO0MwTvwS8WkKRkL2HVZXP+3BbcKE7YIkvRBL5UVPwz
         WAZkh9HrMoFlVUtr9z7OnyENLfUF+7/yqwuTBZFZJ9HiNSPWJhV3i4RijqKxyVTSBW1G
         eSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tHyLqUmtTTMIbIqoDwVSMrkpYuG5yIqYL6HxByUSF1k=;
        b=K8pxtCDGhaQ+dMzIAtLnujp9ygLKbzYsndEucc69BytSMFxGijh92oN4IqEAWgd/J+
         Kw9yauoJqfOpLcfZxb9HBdv54nPjtF4a8sLek3TSWY6+poTfyofTU8bStTBwf6NfpMoN
         1FrISzU2hfsLujEJQf6KRPHgC2P7OdvBxCH47lVl2f6xSM2jd+WFXy0Mw9iD9UMNgB7v
         dLKLb1gkt7cLqIKQDbw2YsWPf7aXouPkIL5YgpUBcBz85lefwbdXlnhdf83tohjcbiZS
         +NFHk05EmbkiLjS1/y/V5w6QE1R4e19TWif2Fwy64e5H2Lt5s2u6m57JmTmtN0Md0MWj
         zr7w==
X-Gm-Message-State: AOAM531Yvp+vsyGOK/6TZ2N/lNzpSH04Q7Jq8vJcN9VmWgPxWOCe5cAb
        HfSJRDiGihvni1M2KxeihhN/FzSMSO0Ih7ISBFLmHJXNAflZjw==
X-Google-Smtp-Source: ABdhPJwWUXJSo7FIMR1sitkboYnLRaxiaNIMacyQbEajwe57eYp5VZ0caRZ+BgIp7IlUX8p+8hBglJH8Pks+BRRxhT8=
X-Received: by 2002:a2e:92cf:: with SMTP id k15mr2988702ljh.333.1591831891058;
 Wed, 10 Jun 2020 16:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200609060137.143501-1-daeho43@gmail.com> <20200609165107.GA228564@gmail.com>
 <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com>
 <20200610031532.GA6286@sol.localdomain> <CACOAw_wErOPC=Kf3UU8nFGhWRy84ZnCeJbsyPhSCcXv51B_XxQ@mail.gmail.com>
In-Reply-To: <CACOAw_wErOPC=Kf3UU8nFGhWRy84ZnCeJbsyPhSCcXv51B_XxQ@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 11 Jun 2020 08:31:20 +0900
Message-ID: <CACOAw_zka6d06RxFOUTwEV7B6o8A2-_6FvqWh_A1nJ0+7FU9yQ@mail.gmail.com>
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

> > > > > +
> > > > > +     if (f2fs_readonly(sbi->sb))
> > > > > +             return -EROFS;
> > > >
> > > > Isn't this redundant with mnt_want_write_file()?
> > > >
> > > > Also, shouldn't write access to the file be required, i.e.
> > > > (filp->f_mode & FMODE_WRITE)?  Then the f2fs_readonly() and
> > > > mnt_want_write_file() checks would be unnecessary.
> > > >
> > >
> > > Using FMODE_WRITE is more proper for this case, since we're going to
> > > modify the data. But I think mnt_want_write_file() is still required
> > > to prevent the filesystem from freezing or something else.
> >
> > Right, the freezing check is actually still necessary.  But getting wri=
te access
> > to the mount is not necessary.  I think you should use file_start_write=
() and
> > file_end_write(), like vfs_write() does.

I've checked this again.

But I think mnt_want_write_file() looks better than the combination of
checking FMODE_WRITE and file_start_write(), because
mnt_want_write_file() handles all the things we need.
It checks FMODE_WRITER, which is set in do_dentry_open() when
FMODE_WRITE is already set, and does the stuff that file_start_write()
is doing. This is why the other filesystem system calls use it.

What do you think?

2020=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 12:55, =
Daeho Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > >
> > > To prevent the file data from garbage collecting, the user needs to
> > > use pinfile ioctl and fallocate system call after creating the file.
> > > The sequence is like below.
> > > 1. create an empty file
> > > 2. pinfile
> > > 3. fallocate()
> >
> > Is that persistent?  So the file will never be moved afterwards?
> >
> > Is there a place where this is (or should be) documented?
>
> Yes, this is persistent. F2FS_IOC_SET_PIN_FILE ioctl is to prevent
> file data from moving and being garbage collected, and further update
> to the file will be handled in in-place update manner.
> I don't see any document on this, but you can find the below in
> Documentation/filesystems/f2fs.rst
>
> However, once F2FS receives ioctl(fd, F2FS_IOC_SET_PIN_FILE) in prior to
> fallocate(fd, DEFAULT_MODE), it allocates on-disk blocks addresses having
> zero or random data, which is useful to the below scenario where:
>
>  1. create(fd)
>  2. ioctl(fd, F2FS_IOC_SET_PIN_FILE)
>  3. fallocate(fd, 0, 0, size)
>  4. address =3D fibmap(fd, offset)
>  5. open(blkdev)
>  6. write(blkdev, address)
>
> > Right, the freezing check is actually still necessary.  But getting wri=
te access
> > to the mount is not necessary.  I think you should use file_start_write=
() and
> > file_end_write(), like vfs_write() does.
>
> Yes, agreed.
>
> 2020=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 12:15=
, Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Wed, Jun 10, 2020 at 11:05:46AM +0900, Daeho Jeong wrote:
> > > > > Added a new ioctl to send discard commands or/and zero out
> > > > > to whole data area of a regular file for security reason.
> > > >
> > > > With this ioctl available, what is the exact procedure to write and=
 then later
> > > > securely erase a file on f2fs?  In particular, how can the user pre=
vent f2fs
> > > > from making multiple copies of file data blocks as part of garbage =
collection?
> > > >
> > >
> > > To prevent the file data from garbage collecting, the user needs to
> > > use pinfile ioctl and fallocate system call after creating the file.
> > > The sequence is like below.
> > > 1. create an empty file
> > > 2. pinfile
> > > 3. fallocate()
> >
> > Is that persistent?  So the file will never be moved afterwards?
> >
> > Is there a place where this is (or should be) documented?
> >
> > > > > +
> > > > > +     if (f2fs_readonly(sbi->sb))
> > > > > +             return -EROFS;
> > > >
> > > > Isn't this redundant with mnt_want_write_file()?
> > > >
> > > > Also, shouldn't write access to the file be required, i.e.
> > > > (filp->f_mode & FMODE_WRITE)?  Then the f2fs_readonly() and
> > > > mnt_want_write_file() checks would be unnecessary.
> > > >
> > >
> > > Using FMODE_WRITE is more proper for this case, since we're going to
> > > modify the data. But I think mnt_want_write_file() is still required
> > > to prevent the filesystem from freezing or something else.
> >
> > Right, the freezing check is actually still necessary.  But getting wri=
te access
> > to the mount is not necessary.  I think you should use file_start_write=
() and
> > file_end_write(), like vfs_write() does.
> >
> > > >
> > > > > +
> > > > > +     if (get_user(flags, (u32 __user *)arg))
> > > > > +             return -EFAULT;
> > > > > +     if (!(flags & F2FS_TRIM_FILE_MASK))
> > > > > +             return -EINVAL;
> > > >
> > > > Need to reject unknown flags:
> > > >
> > > >         if (flags & ~F2FS_TRIM_FILE_MASK)
> > > >                 return -EINVAL;
> > >
> > > I needed a different thing here. This was to check neither discard no=
r
> > > zeroing out are not here. But we still need to check unknown flags,
> > > too.
> > > The below might be better.
> > > if (!flags || flags & ~F2FS_TRIM_FILE_MASK)
> > >        return -EINVAL;
> >
> > Sure, but please put parentheses around the second clause:
> >
> >         if (flags =3D=3D 0 || (flags & ~F2FS_TRIM_FILE_MASK))
> >                 return -EINVAL;
> >
> > - Eric
