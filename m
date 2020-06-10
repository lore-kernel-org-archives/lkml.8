Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD54BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E51F20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFp/5CtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFJDzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgFJDzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:55:53 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A75AC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 20:55:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 82so613810lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 20:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LyohQNqu19/pcwWiEv/7VNRgqg1PzPVrbL993SF8gqE=;
        b=IFp/5CtLi2alU8l/K+OHxs5bHP8Agi8nfUucQLBFC8sB6hUz8dT0I9bHkwblGtmykz
         K4yalvg3vZIre93sHa8v7QUr8UxUJqiBshgM0WQtYVx4RfRzuoAQTlKlwxy352KEY8I8
         YMavy+SnPdZ3z+weUjY26SRZRgOxOSdgjbpw0NxnBRJpXU3vOTRAijEmDoXorScn47Hx
         6b9ObMQ7yPIlWEadXWsdw02VeNVfmW3duX7gTgX5xJcphMUCaT+ptbNik/7P38P7tNZL
         khtoCm91hoPxdcLdyT7yvWRdXVdTmt0F51+q5AU8p26nPqeit/50Zt4QxK1deKcjNyZn
         DbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LyohQNqu19/pcwWiEv/7VNRgqg1PzPVrbL993SF8gqE=;
        b=sd9d4bBJFHkwQ1Ei1xpOWAGei1q76NZUVbzAud++TRW9tp6vNx//cY+05vdMmzV8mp
         goSGd3iZRusqf64l+XqXWOGzCbNY+82LD2DfXFFxxtbb/7UVGrrEZmpYqZUgQmW9YFp/
         SqjX7Z8hAgMyF8YhPIw41O0VXo3OzOYUs08Y0btgm8YUCpMIsgAX4C/rzfmNzwt5g7IA
         q16TTKBs44sCV1FbPeJSZcrP35DeqU+rxe/3U+uEB6sd7no6eIBpGP68hWxR7vTx65rC
         JZG+IpB6TKLjWsK/JeC6ak53V7Fj/yrneetI2fXWkBqB+Z+nGZEbV5/0r61Y673ZBVib
         hABQ==
X-Gm-Message-State: AOAM531qUNTMSOF5s++oBNZlgBGMztqsquemXTI8zSLUYgXqkbiYVq3d
        E35pcNfcUOxa/0J1AJow4hRwDTqG89b/DB/XrOs=
X-Google-Smtp-Source: ABdhPJyFvJC6hVhB4rAaWYb88C7PfzMZEw1pcHZPrgnRLlbqgobGbXETdY9gOPq/Ea1Ul5AxRba/0bqAg20Tq41W1LU=
X-Received: by 2002:a19:fc15:: with SMTP id a21mr550019lfi.121.1591761351353;
 Tue, 09 Jun 2020 20:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200609060137.143501-1-daeho43@gmail.com> <20200609165107.GA228564@gmail.com>
 <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com> <20200610031532.GA6286@sol.localdomain>
In-Reply-To: <20200610031532.GA6286@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 10 Jun 2020 12:55:40 +0900
Message-ID: <CACOAw_wErOPC=Kf3UU8nFGhWRy84ZnCeJbsyPhSCcXv51B_XxQ@mail.gmail.com>
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

> >
> > To prevent the file data from garbage collecting, the user needs to
> > use pinfile ioctl and fallocate system call after creating the file.
> > The sequence is like below.
> > 1. create an empty file
> > 2. pinfile
> > 3. fallocate()
>
> Is that persistent?  So the file will never be moved afterwards?
>
> Is there a place where this is (or should be) documented?

Yes, this is persistent. F2FS_IOC_SET_PIN_FILE ioctl is to prevent
file data from moving and being garbage collected, and further update
to the file will be handled in in-place update manner.
I don't see any document on this, but you can find the below in
Documentation/filesystems/f2fs.rst

However, once F2FS receives ioctl(fd, F2FS_IOC_SET_PIN_FILE) in prior to
fallocate(fd, DEFAULT_MODE), it allocates on-disk blocks addresses having
zero or random data, which is useful to the below scenario where:

 1. create(fd)
 2. ioctl(fd, F2FS_IOC_SET_PIN_FILE)
 3. fallocate(fd, 0, 0, size)
 4. address =3D fibmap(fd, offset)
 5. open(blkdev)
 6. write(blkdev, address)

> Right, the freezing check is actually still necessary.  But getting write=
 access
> to the mount is not necessary.  I think you should use file_start_write()=
 and
> file_end_write(), like vfs_write() does.

Yes, agreed.

2020=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 12:15, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Jun 10, 2020 at 11:05:46AM +0900, Daeho Jeong wrote:
> > > > Added a new ioctl to send discard commands or/and zero out
> > > > to whole data area of a regular file for security reason.
> > >
> > > With this ioctl available, what is the exact procedure to write and t=
hen later
> > > securely erase a file on f2fs?  In particular, how can the user preve=
nt f2fs
> > > from making multiple copies of file data blocks as part of garbage co=
llection?
> > >
> >
> > To prevent the file data from garbage collecting, the user needs to
> > use pinfile ioctl and fallocate system call after creating the file.
> > The sequence is like below.
> > 1. create an empty file
> > 2. pinfile
> > 3. fallocate()
>
> Is that persistent?  So the file will never be moved afterwards?
>
> Is there a place where this is (or should be) documented?
>
> > > > +
> > > > +     if (f2fs_readonly(sbi->sb))
> > > > +             return -EROFS;
> > >
> > > Isn't this redundant with mnt_want_write_file()?
> > >
> > > Also, shouldn't write access to the file be required, i.e.
> > > (filp->f_mode & FMODE_WRITE)?  Then the f2fs_readonly() and
> > > mnt_want_write_file() checks would be unnecessary.
> > >
> >
> > Using FMODE_WRITE is more proper for this case, since we're going to
> > modify the data. But I think mnt_want_write_file() is still required
> > to prevent the filesystem from freezing or something else.
>
> Right, the freezing check is actually still necessary.  But getting write=
 access
> to the mount is not necessary.  I think you should use file_start_write()=
 and
> file_end_write(), like vfs_write() does.
>
> > >
> > > > +
> > > > +     if (get_user(flags, (u32 __user *)arg))
> > > > +             return -EFAULT;
> > > > +     if (!(flags & F2FS_TRIM_FILE_MASK))
> > > > +             return -EINVAL;
> > >
> > > Need to reject unknown flags:
> > >
> > >         if (flags & ~F2FS_TRIM_FILE_MASK)
> > >                 return -EINVAL;
> >
> > I needed a different thing here. This was to check neither discard nor
> > zeroing out are not here. But we still need to check unknown flags,
> > too.
> > The below might be better.
> > if (!flags || flags & ~F2FS_TRIM_FILE_MASK)
> >        return -EINVAL;
>
> Sure, but please put parentheses around the second clause:
>
>         if (flags =3D=3D 0 || (flags & ~F2FS_TRIM_FILE_MASK))
>                 return -EINVAL;
>
> - Eric
