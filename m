Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D41C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD1320679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxBiurAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgFCHGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCHGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:06:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9510CC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:06:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u16so621907lfl.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UFCTIuaj8xz+aKHpreeFlNyCdIKgQpq07UVVXvstL7I=;
        b=UxBiurAZREXPM1HURsDXeYCy3qhAcKEZrySeaFpPyV87adNdAKo0BKKYlwWq2IHwfm
         0yQSrZDcAsHv8HDwYjfllWB/TnnK1+gQYE9/JODt80oWHfaCr74epyYzWYK4UGPOLo6I
         TfpZjUzYdLG8NiurklMPPvLtL5jUecgKiBdluuf9d7aCk5EGzoZqIf2PURl3j+vsdfci
         idmGOrK1kTD/Qdia/QpWXC2sYkeUCZ+KMNfElBydHvXfi+HJyJA/xdNN7SD9CDeLWAPm
         5MaaaYe/msa6giALcnqvYPEplF7GnA9QFk3USsXLxptgYah4UkV3zrwmF0LOvtpEm/5a
         8sqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UFCTIuaj8xz+aKHpreeFlNyCdIKgQpq07UVVXvstL7I=;
        b=Rua2bzyiu2H1Zp8amBghoAVPyVSohPBuIJk1aO1dsW7DgA8iPg1PpJ6smIjUCfqJaD
         3EKnch9x5rCWS+JuFWgdTsgf0w58CVzVR6k3L55bE99JHcQA1CiqDEfR8OGPRHD+G2zR
         A+La628twL3YM2C8yWgEikCSLaYUgPPhTOdMMMrWqVv6fY5J7wP9FFhN5fQEOACYVvNO
         xiA/DG2uZdN0UiZiIIWz854gSR4GR0AfM9LRCampeDuYkobovHSXHcZpGqCu49LgZ8gP
         fiWLr3JS7QyUt/rrnbj24Gww5xrPVutRZo/BnifX3BttT3iB0Q8LRWL60zNZ2GhJOKVT
         YfnQ==
X-Gm-Message-State: AOAM533k8paU1b0TjO+/wRGfflsYntyUyAYwNvQj5RUm5A45Ego2hdMc
        gHBScWNt1SIyX6ni/QXT6qrzmyEA78CtIL9PdGo=
X-Google-Smtp-Source: ABdhPJxAvNz3NC+UHfmFFv9r88vxizSW78ZxovGrxdKJJEDiA7ur1ngsxO6bJfwsgg9V7vZjf/WF1eyiGNzGnOsEkEs=
X-Received: by 2002:a19:fc15:: with SMTP id a21mr1641142lfi.121.1591167987856;
 Wed, 03 Jun 2020 00:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200601030347.112984-1-daeho43@gmail.com> <daed6176-fb7d-bd4d-9662-735cc3cda2e0@huawei.com>
In-Reply-To: <daed6176-fb7d-bd4d-9662-735cc3cda2e0@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 3 Jun 2020 16:06:15 +0900
Message-ID: <CACOAw_xgcevW9-xKHq-siDa-1i-Nap+rQQOpZ9LWyfbGkEmV=g@mail.gmail.com>
Subject: Re: [PATCH] f2fs: protect new segment allocation in expand_inode_data
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

Oh, thanks for notification!

2020=EB=85=84 6=EC=9B=94 3=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:59, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/6/1 11:03, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Found a new segemnt allocation without f2fs_lock_op() in
> > expand_inode_data(). So, when we do fallocate() for a pinned file
> > and trigger checkpoint very frequently and simultaneously. F2FS gets
> > stuck in the below code of do_checkpoint() forever.
> >
> >   f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
> >   /* Wait for all dirty meta pages to be submitted for IO */
> >                                                 <=3D if fallocate() her=
e,
> >   f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META); <=3D it'll wait forever=
.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
>
> Daeho,
>
> I guess Jaegeuk could add the tag when merging this patch, we don't have
> to resend the patch if there is no updates on code and message.
>
> Thanks,
>
> > ---
> >  fs/f2fs/file.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index f7de2a1da528..14ace885baa9 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1660,7 +1660,11 @@ static int expand_inode_data(struct inode *inode=
, loff_t offset,
> >
> >               down_write(&sbi->pin_sem);
> >               map.m_seg_type =3D CURSEG_COLD_DATA_PINNED;
> > +
> > +             f2fs_lock_op(sbi);
> >               f2fs_allocate_new_segments(sbi, CURSEG_COLD_DATA);
> > +             f2fs_unlock_op(sbi);
> > +
> >               err =3D f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PR=
E_DIO);
> >               up_write(&sbi->pin_sem);
> >
> >
