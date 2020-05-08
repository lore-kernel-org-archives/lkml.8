Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FEAC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672CA206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7/6rRT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgEHG65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbgEHG65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:58:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD932C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:58:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f18so512481lja.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pUqYbbEhhoBOpMJg82tH9U5Nj13y9+Ar796jHBZ0iuk=;
        b=G7/6rRT9CAiKUhr1x2HJR1bBbUhx1FptG/OWbT6gPV4TchFejkTo8f/6hlCk2kNdGE
         NmNuSEztMvkKfI3NVQtmFm9WJID7r8OpPqDf2/mV0/YFYY6H+RDGU55qfEU1L47jhIZp
         qHkHz5jggUJmn0Tddvy/C21A/otqQ9CLoZFG6NiphUkV4tfAwr3G4tnN6Ph0bvw0o0Kn
         6NBNrfLsGfVexLXDWyKyVG2L5RzaYMC4gH4g/cg8ruCX5rcJ1H0JuVb+5nAt8Q67WCSF
         miMHIMejlC7lFiV8E++ShTzwcy7qjRMba2rw5JhQliDfIal61viSDQBgiF52TusRnKmf
         b6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pUqYbbEhhoBOpMJg82tH9U5Nj13y9+Ar796jHBZ0iuk=;
        b=G7gwU78i74BIZgYd1v2gylSC+ntUsX9fLNVXfO0Elae5aZ43nsFOUM7j6Cf19cdaT1
         yniUUvPaSMq8slSfpuEkfIOqWdJjaiItd236cskJTone+PvmR/qFMpSIbTfVvSfdPPdE
         zEHtRbrE6K3q1TUZFzOMPxyigEjdgYDgrq5p9/HYYnlbeDEC17IHaAtg8l139f21ZjlS
         zH4WCywQJ/FKWGurVyoUA/7usqfcte+FoPMgv0QdjoBBVR7b6s5fWegnc/GoZWuSZQJa
         P60/qp8AiS0+GsuNA91F1FCb64naIYf+vS/iridfKRxyghCWa9J5pu8Mj16t6kz0qOKD
         BieQ==
X-Gm-Message-State: AOAM531p/YtMFS1qFhy9DxHrVAvjrjUcdE6D1WaZkuXjfYrnpBJWRiAd
        uTsSVTiqLja3rxm87jTLVddbN5Avcjis2wVPSIj9isGyI8M=
X-Google-Smtp-Source: ABdhPJwYWccUNn8mMSZ9PrPSekN5RKemxE9AXxFxPy++X/nS71r2ozelfd1MrjkXAO62Yp0Cn2rbD/LEiYRGAGcUuUQ=
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr681437ljj.136.1588921135090;
 Thu, 07 May 2020 23:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200508042506.143395-1-daeho43@gmail.com> <4dfb73d9-03a0-bb2f-a112-1dd42db4d7bb@huawei.com>
In-Reply-To: <4dfb73d9-03a0-bb2f-a112-1dd42db4d7bb@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 8 May 2020 15:58:44 +0900
Message-ID: <CACOAw_z0BU3t7V+BN7TvaO96GckwNh2SRLreGxO60EDbMb_epw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove race condition in releasing cblocks
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

I moved checking i_compr_blocks phrase after calling inode_lock()
already, because we should check this after writing pages.

So, if it fails to check i_compr_blocks, we need to call inode_unlock().

Am I missing something?

2020=EB=85=84 5=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:50, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/5/8 12:25, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Now, if writing pages and releasing compress blocks occur
> > simultaneously, and releasing cblocks is executed more than one time
> > to a file, then total block count of filesystem and block count of the
> > file could be incorrect and damaged.
> >
> > We have to execute releasing compress blocks only one time for a file
> > without being interfered by writepages path.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/file.c | 31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 4aab4b42d8ba..a92bc51b9b28 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3488,6 +3488,7 @@ static int f2fs_release_compress_blocks(struct fi=
le *filp, unsigned long arg)
> >       pgoff_t page_idx =3D 0, last_idx;
> >       unsigned int released_blocks =3D 0;
> >       int ret;
> > +     int writecount;
> >
> >       if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
> >               return -EOPNOTSUPP;
>
> Before inode_lock(), there is one case we may jump to out label, in
> this case, we may unlock inode incorrectly.
>
>         if (!F2FS_I(inode)->i_compr_blocks)
>                 goto out;
>
> > -
> > -     inode_unlock(inode);
> >  out:
> > +     inode_unlock(inode);
> > +
> >       mnt_drop_write_file(filp);
>
> Thanks,
