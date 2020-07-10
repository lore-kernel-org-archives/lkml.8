Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41323C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0FD20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiLdpIIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGJDR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGJDR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:17:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D6FC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 20:17:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r19so4734786ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 20:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TLUcgfD3vzj9e3+8HCJonIEbZ+/i+9gPCbAcc/AaAoA=;
        b=OiLdpIICkkdCExTqxehNMdW0XGdYvLF283Yg/MiIIyL6LH6V/AF3qDNbEGFpM4BgEL
         THMtJENwHsN5Xkl3lVtkh+XrShOrvqGvhLo1/CIGqWi9Im8FPgaYdrw1+uap0axzIbWb
         t5kjTyXP9yOdStfM+G0kzZpBOzXx4S0YG/bYM/VooVLvLLl1UJmw1FwlDv9sN+xz/v+3
         g17yc9mJURCJ7zpvsU+LBr/ku0k6gk11bR0x8iVYQTwhsJjsImi8M1WqhxFI1RXpes3r
         zsklDNjVE+8dfs9DymIY5ddzL337f2pFAqgszwLG7STArcA1wH6LZzpJ+D/NR8L2QevP
         ZGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TLUcgfD3vzj9e3+8HCJonIEbZ+/i+9gPCbAcc/AaAoA=;
        b=D84GwlhB8nj39sf++SyIO7T6jNLMUjby3AkjOnEhGBuFm8ucmkXS8FDNCzZXI7Lv1i
         m1JKJ7mvz1nCJsRm2aNsqWmfpk+d4WTPSdDLf269B7L29gJLOXI5pMWPLmzn3mT2Aoy2
         mc7W0rvzjzIyoJvVNe7CIrJxt0chguRTuXnelxgWBxK2p0LJEIN4sf0NGKnwvpFx39Fw
         vZu9mlc4GY08BFuv3XlqnyTYvM1GVkjPw0sVLEOzZ3FXZNAqnvl6mjUA++bqWvdW7sMR
         pUfU+BRHf2Wh/2hIH1ze3KLfpEqnciLAzJAgYN4J80JvZlZh7e9SJOCytdeCbY/j/yYL
         6efw==
X-Gm-Message-State: AOAM531ldeZfgH58kFpf99RK98WqVktSz+hzs/dQ2mX0jmfr8/U/1cii
        EYCFHn+YrOe8xEmztNjRe/HF9ro3deO21pPvK2VoYkffmpPmDg==
X-Google-Smtp-Source: ABdhPJy2fEwacppAg+xY6cPAq454tX4tcJA5yUCm12WfM5rTh2UOBmq08fJgr37rqprJPJfZ6ePDPuOVwEh5bkGqF34=
X-Received: by 2002:a2e:7c07:: with SMTP id x7mr28142677ljc.166.1594351077346;
 Thu, 09 Jul 2020 20:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200710021505.2405872-1-daeho43@gmail.com> <20200710030246.GA545837@google.com>
In-Reply-To: <20200710030246.GA545837@google.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 10 Jul 2020 12:17:46 +0900
Message-ID: <CACOAw_yJvQgDsLRd0-iJqXN06wDXmC3_OqKgKey7p=WeqxzMFA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change the way of handling range.len in F2FS_IOC_SEC_TRIM_FILE
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

1. The valid data will be within i_size.
2. All the trim operations will be done in a unit of block, even if
i_size is not aligned with BLKSIZE like the below.

        index =3D F2FS_BYTES_TO_BLK(range.start);
        pg_end =3D DIV_ROUND_UP(end_addr, F2FS_BLKSIZE);     <=3D BLKSIZE a=
ligned

Are you worried about the case that sudden power-off occurs while a
file is being truncated?
ex) 1GB file is being truncated to 4KB -> sudden power-off ->
i_size(4KB), i_blocks(maybe somewhere between 4KB and 1GB)

2020=EB=85=84 7=EC=9B=94 10=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 12:02, =
Jaegeuk Kim <jaegeuk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 07/10, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
> >  1. Added -1 value support for range.len to signify the end of file.
> >  2. If the end of the range passes over the end of file, it means until
> >     the end of file.
> >  3. ignored the case of that range.len is zero to prevent the function
> >     from making end_addr zero and triggering different behaviour of
> >     the function.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/file.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 368c80f8e2a1..1c4601f99326 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3813,21 +3813,19 @@ static int f2fs_sec_trim_file(struct file *filp=
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
> > -     }
> > -     end_addr =3D range.start + range.len;
> > +     if (range.len =3D=3D (u64)-1 || inode->i_size - range.start < ran=
ge.len)
> > +             end_addr =3D inode->i_size;
>
> Hmm, what if there are blocks beyond i_size? Do we need to check i_blocks=
 for
> ending criteria?
>
> > +     else
> > +             end_addr =3D range.start + range.len;
> >
> >       to_end =3D (end_addr =3D=3D inode->i_size);
> >       if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
> > --
> > 2.27.0.383.g050319c2ae-goog
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
