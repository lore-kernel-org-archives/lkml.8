Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E50C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8069B206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaNF3VOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgGIGAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgGIGAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:00:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CD2C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 23:00:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so1004489ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 23:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZameAAM/OSypxl5eP4NQC+AzJS4YHSZiv1p46+Z9Tu4=;
        b=OaNF3VOdLYAgncGOKs3FAJDYtt5qRwg8iNuVkRLTGMOU+ZRBomDs37eiMoB9nLPry1
         iMcFV7ScGdRdWR+pqyLq5EGwH94XI8ALEW9hfxpmY4Qp0eYUOYmiuNzpwSL3asQDTF+c
         KEFRquXoq/Ppw59TGdgMMaiDVdb3XmoQyxFqb+/qMcyMsmrhGIrqFnIt+g/Aeg+I0XZq
         6iODt0uMPESEZVyI2uY8Tdc1ICfQQbN8yKSS1pPXu5pz9M2HsjZP0YIHw2Ejaqbm9VoA
         SfVjlxeLl57D7n9B/SHGR4F9LYavnspGhADKGFuWg/OxmYvWt7/Sy2jGDm4BWBaSRTyX
         xB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZameAAM/OSypxl5eP4NQC+AzJS4YHSZiv1p46+Z9Tu4=;
        b=tgn0iYa8jlf/9SHp9M3RsiunRAqIrTRZDTeec2lKTlcVBpvUNKE7zY2gQofZ6JHanw
         OB3ls+IRY0WCqTJPddvTaI9myEBSu3shZBxmsDLM2XbwuCDD0lUf4d818uVAW062iib2
         3E8wNY9O/w8ejvACUZrEoTojJAW3oRVBCEMDuFMEsPa+/Gx8i9qT0ZZxr4qc18Kg4kct
         9qDFBkq4X2fhGixN8eVXBzLQzrVpR8j0ffqM/2xATMWbLXWIRQzjz0l5EZTzHrP3T1h/
         egLCFYtOxQXrTMo/eQP0MOQNOhV8WLRYRR+soKQIEzEy9wPFiWzpwZDV6NTJWH8mDCtO
         tbig==
X-Gm-Message-State: AOAM531Po4nGBy8GnlFqhYBmBC6EJT20ab7Z+V0X2+aU/WjIKkuadkZh
        uuNJ2Oag/OpkXq6jGTJaPECnQcqodD1qSXTuhXQ=
X-Google-Smtp-Source: ABdhPJwS4iUBMzQ++c1xWQ+RhU6P+J3sMzp3kDtGIUi47HzW2BW3zK2H7U/IYo3JsZV2EzZjK/mtWIBigfFUM7ztPDU=
X-Received: by 2002:a2e:8954:: with SMTP id b20mr33948652ljk.262.1594274434661;
 Wed, 08 Jul 2020 23:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200709015739.1653668-1-daeho43@gmail.com> <619af72b-2f8a-4a84-f73e-ac49989ba79f@huawei.com>
 <20200709053943.GA352648@google.com>
In-Reply-To: <20200709053943.GA352648@google.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 9 Jul 2020 15:00:23 +0900
Message-ID: <CACOAw_xD08m8p3Hzy-QQJCGUZMgR-3K33hTESGDVESRcaHFyqg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: ignore when len of range in
 f2fs_sec_trim_file is zero
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can add it~

2020=EB=85=84 7=EC=9B=94 9=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 2:39, Ja=
egeuk Kim <jaegeuk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 07/09, Chao Yu wrote:
> > On 2020/7/9 9:57, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > When end_addr comes to zero, it'll trigger different behaviour.
> > > To prevent this, we need to ignore the case of that range.len is
> > > zero in the function.
> > >
> > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > ---
> > >  fs/f2fs/file.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 368c80f8e2a1..98b0a8dbf669 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -3813,15 +3813,14 @@ static int f2fs_sec_trim_file(struct file *fi=
lp, unsigned long arg)
> > >     file_start_write(filp);
> > >     inode_lock(inode);
> > >
> > > -   if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> > > +   if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
> > > +                   range.start >=3D inode->i_size) {
> > >             ret =3D -EINVAL;
> > >             goto err;
> > >     }
> > >
> > > -   if (range.start >=3D inode->i_size) {
> > > -           ret =3D -EINVAL;
> > > +   if (range.len =3D=3D 0)
> > >             goto err;
> > > -   }
> > >
> > >     if (inode->i_size - range.start < range.len) {
> > >             ret =3D -E2BIG;
> >
> > How about the case trimming last partial written block?
> >
> > i_size =3D 8000
> > range.start =3D 4096
> > range.len =3D 4096
> >
> > Do we need to roundup(isize, PAGE_SIZE) before comparison?
>
> If we want to trim whole file, do we need to give the exact i_size?
> Wouldn't it be better to give trim(0, -1)?
>
> >
> > Thanks,
> >
> > >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
