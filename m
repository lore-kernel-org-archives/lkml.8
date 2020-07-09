Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0463BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D1B2070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz+n6Iv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGIEPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgGIEPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 00:15:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71461C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 21:15:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g2so374263lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 21:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xDk1ZHF1bMnWFPlFovEjZecEcOKh7UBQd7WZyIXM1mQ=;
        b=Zz+n6Iv90qbX2LLt1L1X0f49gNMpYaHpesM+xr7jYmBUxaW+HFN0lPNlmasFBxdxuK
         +gncMdXlSnR4UiJdWhr4J85WOlmhCxqxbbCR0S1DgjAMEYMRdtqb1Mzb54xDUVSLAfS7
         yCluwZZ9h+ezgrajYs0fWwbQu/wxFBR6Wh99XmGnRa9q9zmPXKLs1ayNINnS4kZs6cj3
         LxPixzkYmsL9mxM4syOXkS7kOQ1dtvg8x/cXhFf1pIVlqSH6z3GGbGc6dCebtdIamEOC
         FtHJ+mFyjRuyYgoEGMCTajyci09Wa9uAC76mLWjO7/JooP8AhR9GfrFJzkubT3NWAeb7
         7rKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xDk1ZHF1bMnWFPlFovEjZecEcOKh7UBQd7WZyIXM1mQ=;
        b=TNnfzcYYiSThFCZJ8icugzHOjfzGC4b1LexNU5YUUwdwHiG0bWw/tHaxgaUIXbuMYD
         vBUTbituwE3OhvIhfrSQLR/4H21vYXW8f9A6yiotmm2VB+bHfVO3N1Ky9fYOXC6fe2mX
         ZFK7naIe95Nlo3A9KeIFg1yw8if5slvQ5gCq15V3vcsyx3Kih7EdDmEr9uEXrOzEcFZ2
         usGGeTYkc5a1rS+8NYzdS2fv2mVncorZzx5aAXRQrJLo5df7+yeLIUoCSrcrffDKMISV
         PcLNUVygl7pWwDl+xgm4s2L83PfHarh0umrw8OTxYYO4DpHtMXKDhrIVkN23h579yTs5
         y/8g==
X-Gm-Message-State: AOAM530xoxtSUVqCLZ5GPvTr1LVpmafo4mwddkv0PC+W9mW5BIltKmry
        v8OVnfyvnzZ45yeKbZbGlL8lise2+NjuwBu2F428sAcLPGcv2Ivs
X-Google-Smtp-Source: ABdhPJyAG61hK3KeNkBxu+KrPK1uEtZq51mJTOtlJ1WejkUa0oUSsYxdEmxuIChtmYimHLfFEPWpxQjFLRFDjrvokHw=
X-Received: by 2002:a19:e61a:: with SMTP id d26mr33048773lfh.96.1594268146758;
 Wed, 08 Jul 2020 21:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200709015739.1653668-1-daeho43@gmail.com> <619af72b-2f8a-4a84-f73e-ac49989ba79f@huawei.com>
In-Reply-To: <619af72b-2f8a-4a84-f73e-ac49989ba79f@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 9 Jul 2020 13:15:35 +0900
Message-ID: <CACOAw_x7GkM0os2xo+2CX+pysCBb6QbWxxr0jC3C703iFQi+1A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: ignore when len of range in
 f2fs_sec_trim_file is zero
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

I thought it's better to treat this as the error case, since the range
already passed out of the i_size range.
If we allow that, the user needs to send the range parameter being
aligned like start:0 and len: roundup(i_size, PAGE_SIZE), even if he
or she wants to erase the whole file.

2020=EB=85=84 7=EC=9B=94 9=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 12:05, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/7/9 9:57, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > When end_addr comes to zero, it'll trigger different behaviour.
> > To prevent this, we need to ignore the case of that range.len is
> > zero in the function.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/file.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 368c80f8e2a1..98b0a8dbf669 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3813,15 +3813,14 @@ static int f2fs_sec_trim_file(struct file *filp=
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
> >       if (inode->i_size - range.start < range.len) {
> >               ret =3D -E2BIG;
>
> How about the case trimming last partial written block?
>
> i_size =3D 8000
> range.start =3D 4096
> range.len =3D 4096
>
> Do we need to roundup(isize, PAGE_SIZE) before comparison?
>
> Thanks,
>
> >
