Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E853C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6A020DD4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNOifc9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGMXef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:34:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2E2C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 16:34:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so20190888ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 16:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iPlwZLEf957rsHoErr6aojVCP3wiKliM72hie8kI42o=;
        b=oNOifc9X4sWNDauS/C1cyTPlb4XXtVA/IlPIL5DBGvUI8zsqO9kih58dutNwTGGCFu
         qpYPHW1jSfNVIocTrNz3sUyPUEqzA75EyLJNpsHnUGRcm73LyU0vhYMFiKuAb5p22FRT
         3oIyCIlASG92CIDyPhCoaAq+rkP+m706kONTW9Tael4sHbFyimyhbw+ptfe0FDJOi5j2
         jBLiIS/jsCMWTvMuo2jNHmM9LbZnwuF09+lHYyAnzNKZ1h7vg051svc7Wy78kA6fe4tF
         7GGIUnttld8+52xJfK4IJ8M2U+Sd6XaFtbp7OUWLE3KLTnWKDoPSv8LBLxrfUBBZkK5A
         4CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iPlwZLEf957rsHoErr6aojVCP3wiKliM72hie8kI42o=;
        b=QS7Urt2AePtKGuFSqz8Rnh6jtRKT/1+yg5SKz690v3Ha6TRNndfCi5oskRxtRg/QKz
         h6TNOAiOO86s9XfSQj2RFLEjCG93xgA8w7vLW/67bb0YY+2T3ZSC/IHiwqUmjjkMdJ4N
         o+orVfNK1RwuwwwuNubJ1Y49nanKqsdYP5A187CjGa/QK/yT0+9waO1dkak/jyN6D2TE
         yGOtUkbie0v1ziBDXZN4IqeDi5WHZ7WhIbiUfiK9jKADOLvbqkWUmWFEOHvjHCpqeaRr
         jqj5SwsrHApTIRTuDBkiZUpG3jJ0OIF/F5w6XmJOR5m3grkyW5rztk2bHvVWqpl0PcoZ
         lMig==
X-Gm-Message-State: AOAM531DJGaS/6ooDIWy5C7ftZDGJeggDi+x2+Z40uI1awY/vq8y0RUj
        v9wKzAjjxjufoJf6ecbkcrb8qA4jVTgXeNo5NcI=
X-Google-Smtp-Source: ABdhPJwpaXJtycdwke2vzHT5yegJx5MA1ubzpxr7J8dvz7p0GZolC7Tp90ky1cfIZC1pdyAJbsbZvcVTpRdHFiKFS0w=
X-Received: by 2002:a2e:8954:: with SMTP id b20mr964793ljk.262.1594683272671;
 Mon, 13 Jul 2020 16:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200713031252.3873546-1-daeho43@gmail.com> <20200713181152.GC2910046@google.com>
In-Reply-To: <20200713181152.GC2910046@google.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 14 Jul 2020 08:34:21 +0900
Message-ID: <CACOAw_y2A6qLMCAt5UBNYvKp4AJrrYFm4_0ShC-Os3J5zzMg4Q@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: change the way of handling range.len in F2FS_IOC_SEC_TRIM_FILE
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's correct~ :)

2020=EB=85=84 7=EC=9B=94 14=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 3:11, J=
aegeuk Kim <jaegeuk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Daeho,
>
> Please take a look at this.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?=
h=3Ddev&id=3D35245180459aebf6d70fde88a538f0400a794aa6
>
> Thanks,
>
> On 07/13, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
> >  1. Added -1 value support for range.len to secure trim the whole block=
s
> >     starting from range.start regardless of i_size.
> >  2. If the end of the range passes over the end of file, it means until
> >     the end of file (i_size).
> >  3. ignored the case of that range.len is zero to prevent the function
> >     from making end_addr zero and triggering different behaviour of
> >     the function.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > Changes in v2:
> >  - Changed -1 range.len option to mean the whole blocks starting from
> >    range.start regardless of i_size
> > ---
> >  fs/f2fs/file.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 368c80f8e2a1..2485841e3b2d 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3792,7 +3792,7 @@ static int f2fs_sec_trim_file(struct file *filp, =
unsigned long arg)
> >       pgoff_t index, pg_end;
> >       block_t prev_block =3D 0, len =3D 0;
> >       loff_t end_addr;
> > -     bool to_end;
> > +     bool to_end =3D false;
> >       int ret =3D 0;
> >
> >       if (!(filp->f_mode & FMODE_WRITE))
> > @@ -3813,23 +3813,23 @@ static int f2fs_sec_trim_file(struct file *filp=
, unsigned long arg)
> >       file_start_write(filp);
> >       inode_lock(inode);
> >
> > -     if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> > +     if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
> > +                     range.start >=3D inode->i_size) {
> >               ret =3D -EINVAL;
> >               goto err;
> >       }
> >
> > -     if (range.start >=3D inode->i_size) {
> > -             ret =3D -EINVAL;
> > +     if (range.len =3D=3D 0)
> >               goto err;
> > -     }
> >
> > -     if (inode->i_size - range.start < range.len) {
> > -             ret =3D -E2BIG;
> > -             goto err;
> > +     if (inode->i_size - range.start > range.len) {
> > +             end_addr =3D range.start + range.len;
> > +     } else {
> > +             end_addr =3D range.len =3D=3D (u64)-1 ?
> > +                     sbi->sb->s_maxbytes : inode->i_size;
> > +             to_end =3D true;
> >       }
> > -     end_addr =3D range.start + range.len;
> >
> > -     to_end =3D (end_addr =3D=3D inode->i_size);
> >       if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
> >                       (!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE)))=
 {
> >               ret =3D -EINVAL;
> > @@ -3846,7 +3846,8 @@ static int f2fs_sec_trim_file(struct file *filp, =
unsigned long arg)
> >       down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >       down_write(&F2FS_I(inode)->i_mmap_sem);
> >
> > -     ret =3D filemap_write_and_wait_range(mapping, range.start, end_ad=
dr - 1);
> > +     ret =3D filemap_write_and_wait_range(mapping, range.start,
> > +                     to_end ? LLONG_MAX : end_addr - 1);
> >       if (ret)
> >               goto out;
> >
> > --
> > 2.27.0.383.g050319c2ae-goog
