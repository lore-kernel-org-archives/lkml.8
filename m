Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17AFC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7ED208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7Vt+fKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHHKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgEHHKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:10:32 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719AEC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 00:10:32 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b26so601660lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 00:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2yw+Oc8uchfFJIgIKd4NSe1RDuHB+KisGrKNv6yH5RA=;
        b=Z7Vt+fKTr9+acIVGvyZvH5CiGIc3MBcbp/A9lXQO2B9o8peUL7WB+eAOCKpnc/Hx7E
         U0TxWPRhtXjct847b/zjFZ1weI7CA+sLhL1sruoqTt3j7tDfgowAX6IbdyslzeAAX3YW
         zNJIJs6sNl84a+duqXIhg01qa3sOYIfM13ms7Yj32x8kgWhVhMoWDw/uFJswudwYGm+r
         UG5L9Tm4JW43U0F4dPZ2cbc2qVYw3Dvqx/DJW/bMVxQYP5T9D1swj7+eMZA53JwjyNOt
         alXgmT7Ldy0P8Dn9HyjThzu5wmsjrYPK7oWfd1tEODWraOlEexR7kxO/KnjrNULChLKe
         EqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2yw+Oc8uchfFJIgIKd4NSe1RDuHB+KisGrKNv6yH5RA=;
        b=IcKCvRX5RCTI49tT2aLylLy/czYXfvU9Gz6FAJ/aMzAejsKoUvZMn+xgllFbKfiVpq
         20RElLjgT1SfSrWFahnWD8L/FH6wkunstGwndyii2Och7HBwP2Ya8YuIN/ejTT1FZfrq
         FSVIJs355mP53h1pKT+UM88nFeI9P+9vUiXs+SAoWeS/NdzYzHUByKT1ZPpCHgHCj/Nb
         dxVsFqxEfdOPlBMIOBoJfEh7wX1R4ArVWFzdEtSsD6XssTt5SY0o6Y+Eoh3KbAl2Gc15
         oVEdhiafE78B0eUshelXKtYLrxqw1/QSD3WPJUi+CbNe/QeDedogOAzgZ1PfKaIGzmSW
         /0TQ==
X-Gm-Message-State: AOAM531X3WzJIIr6Dvp2S6lC4GtEq+h/eYfBncguShnlsXuCl00jfpUo
        PK+af0HeQpKphKFHMPuKgDbre8nOhpbs0gbgReOrvimoCn4=
X-Google-Smtp-Source: ABdhPJxOcTrF/byKHU6n4YHPBzrVb4Xxz4SiDR92+jxZTyozhU/KXjsxPuhGTHTqKyEOSugpwjbyZGBxbyDISSmGGL8=
X-Received: by 2002:a05:6512:3b2:: with SMTP id v18mr912384lfp.140.1588921830813;
 Fri, 08 May 2020 00:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200508042506.143395-1-daeho43@gmail.com> <4dfb73d9-03a0-bb2f-a112-1dd42db4d7bb@huawei.com>
 <CACOAw_z0BU3t7V+BN7TvaO96GckwNh2SRLreGxO60EDbMb_epw@mail.gmail.com> <cd08c824-c5d3-9603-7a81-a48cb191ac99@huawei.com>
In-Reply-To: <cd08c824-c5d3-9603-7a81-a48cb191ac99@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 8 May 2020 16:10:19 +0900
Message-ID: <CACOAw_xx-ZsVgEEb3D9Zu+2gWLZb9UjE3p8sDZbTNywcu2yBPA@mail.gmail.com>
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

Oops,

I will re-check it.

Thanks,

2020=EB=85=84 5=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:09, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/5/8 14:58, Daeho Jeong wrote:
> > I moved checking i_compr_blocks phrase after calling inode_lock()
> > already, because we should check this after writing pages.
> >
> > So, if it fails to check i_compr_blocks, we need to call inode_unlock()=
.
> >
> > Am I missing something?
>
> After applying this patch, I get this:
>
>         ret =3D mnt_want_write_file(filp);
>         if (ret)
>                 return ret;
>
>         if (!F2FS_I(inode)->i_compr_blocks)
>                 goto out;
>
>         f2fs_balance_fs(F2FS_I_SB(inode), true);
>
>         inode_lock(inode);
>
> >
> > 2020=EB=85=84 5=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:50=
, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On 2020/5/8 12:25, Daeho Jeong wrote:
> >>> From: Daeho Jeong <daehojeong@google.com>
> >>>
> >>> Now, if writing pages and releasing compress blocks occur
> >>> simultaneously, and releasing cblocks is executed more than one time
> >>> to a file, then total block count of filesystem and block count of th=
e
> >>> file could be incorrect and damaged.
> >>>
> >>> We have to execute releasing compress blocks only one time for a file
> >>> without being interfered by writepages path.
> >>>
> >>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>> ---
> >>>  fs/f2fs/file.c | 31 ++++++++++++++++++++++++-------
> >>>  1 file changed, 24 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>> index 4aab4b42d8ba..a92bc51b9b28 100644
> >>> --- a/fs/f2fs/file.c
> >>> +++ b/fs/f2fs/file.c
> >>> @@ -3488,6 +3488,7 @@ static int f2fs_release_compress_blocks(struct =
file *filp, unsigned long arg)
> >>>       pgoff_t page_idx =3D 0, last_idx;
> >>>       unsigned int released_blocks =3D 0;
> >>>       int ret;
> >>> +     int writecount;
> >>>
> >>>       if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
> >>>               return -EOPNOTSUPP;
> >>
> >> Before inode_lock(), there is one case we may jump to out label, in
> >> this case, we may unlock inode incorrectly.
> >>
> >>         if (!F2FS_I(inode)->i_compr_blocks)
> >>                 goto out;
> >>
> >>> -
> >>> -     inode_unlock(inode);
> >>>  out:
> >>> +     inode_unlock(inode);
> >>> +
> >>>       mnt_drop_write_file(filp);
> >>
> >> Thanks,
> > .
> >
