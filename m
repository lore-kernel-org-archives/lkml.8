Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E86DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A29B2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJZfH/tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgGJE0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 00:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgGJE0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 00:26:31 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E54C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 21:26:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e8so4922855ljb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IDb3g5vxr/qWKzrtnhotFmzcC0SHY54b9+eqVy5+8NQ=;
        b=PJZfH/tmK25TBftSy5/M6juOuRHXquLDyvbKyrrLRCX61V2LqMKbxKpcoMka91bVn2
         k+Xew+QRGh6XCY5DGIJVM1jhssPxW81Rw+9GEfjbVsbpSE5oidFlytX+1nyWKS7DKub+
         vEGQ9XQn+DKAWIPOXI3eciE1yeHB5vu6FvOnwJ3Lv+wEJS57hTVXRA9zwBlOj15dLv5k
         bPhGPitcjicnNfeWeh8o3zJWIBOVy+IcArEePs6bZsNAGaNpWNubf6V1tFgs3FRvUY4u
         fV+mezFb0C8oTUR2oIVee7ZV+lJp4QZv/xxgWhNxHogc4gPTM+2bdZD5HP9JisUIcSZM
         YiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IDb3g5vxr/qWKzrtnhotFmzcC0SHY54b9+eqVy5+8NQ=;
        b=RgDv8cwutPQEqM1DWQ2FSV6abpz9fp6H4ep6Q6EXi2BW1w5hzZr9GCxdoM5iJAIN2C
         EqECDj7BMb4CtuKFFyqYYlCulD+Im02cPRe1GEqBrGY2yrrCs7op1xinVyAWHkD02+bp
         ITqxiAfTpRmbAYyoT3HhUviBOFXM4obQ6dQbcp9c5/fBlGNfv26uwNfBOX0Jxz6MIHLO
         cWFgTsONmHYnUbAOUe8Tr3cUBTGJr50VkLNzqzJBQ+BPzgeT9r96htYPVXduEoyFnqrX
         URmp3J1ZQhBpMHHZ0WKixBzsbPKt0pjiMhNRfGmcSi1dzCcZWXLhiXu5eDyA8UiEEGcM
         DP8w==
X-Gm-Message-State: AOAM532npNOiwzYcDnXnVQAuP+5ucDLYEpT9b84InnEANYKkOyrAavKR
        YiwyiVIafZ0TF4L0BxN3Qq8DeLwGByJbgA0Ax2U=
X-Google-Smtp-Source: ABdhPJyZYWzkEiDKOx6X2h2aclsw1W0QryWEfiD9Zrapu4xZynRTvKmpnMtKBlPxlcfcbigRHcH9uHWHK4tGx4lPbR4=
X-Received: by 2002:a2e:8e68:: with SMTP id t8mr30798793ljk.335.1594355189016;
 Thu, 09 Jul 2020 21:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200710021505.2405872-1-daeho43@gmail.com> <20200710030246.GA545837@google.com>
 <62c9dd7a-5d18-8bb6-8e43-c055fcff51cc@huawei.com> <20200710033100.GE545837@google.com>
 <ede6620c-6fc9-797d-e3ea-e630eb76b309@huawei.com> <20200710035215.GI545837@google.com>
In-Reply-To: <20200710035215.GI545837@google.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 10 Jul 2020 13:26:17 +0900
Message-ID: <CACOAw_zRXYv_Vo2Q2=FnU-DL-fROuFi40xymrRPrJ91v=TFjKQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change the way of handling range.len in F2FS_IOC_SEC_TRIM_FILE
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle that case, I think we need to handle range.len(-1) differently.
When range.len is -1, we need to find out every block belongs to the
inode regardless of i_size and discard it.

2020=EB=85=84 7=EC=9B=94 10=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 12:52, =
Jaegeuk Kim <jaegeuk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 07/10, Chao Yu wrote:
> > On 2020/7/10 11:31, Jaegeuk Kim wrote:
> > > On 07/10, Chao Yu wrote:
> > >> On 2020/7/10 11:02, Jaegeuk Kim wrote:
> > >>> On 07/10, Daeho Jeong wrote:
> > >>>> From: Daeho Jeong <daehojeong@google.com>
> > >>>>
> > >>>> Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
> > >>>>  1. Added -1 value support for range.len to signify the end of fil=
e.
> > >>>>  2. If the end of the range passes over the end of file, it means =
until
> > >>>>     the end of file.
> > >>>>  3. ignored the case of that range.len is zero to prevent the func=
tion
> > >>>>     from making end_addr zero and triggering different behaviour o=
f
> > >>>>     the function.
> > >>>>
> > >>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > >>>> ---
> > >>>>  fs/f2fs/file.c | 16 +++++++---------
> > >>>>  1 file changed, 7 insertions(+), 9 deletions(-)
> > >>>>
> > >>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > >>>> index 368c80f8e2a1..1c4601f99326 100644
> > >>>> --- a/fs/f2fs/file.c
> > >>>> +++ b/fs/f2fs/file.c
> > >>>> @@ -3813,21 +3813,19 @@ static int f2fs_sec_trim_file(struct file =
*filp, unsigned long arg)
> > >>>>          file_start_write(filp);
> > >>>>          inode_lock(inode);
> > >>>>
> > >>>> -        if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(in=
ode)) {
> > >>>> +        if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(in=
ode) ||
> > >>>> +                        range.start >=3D inode->i_size) {
> > >>>>                  ret =3D -EINVAL;
> > >>>>                  goto err;
> > >>>>          }
> > >>>>
> > >>>> -        if (range.start >=3D inode->i_size) {
> > >>>> -                ret =3D -EINVAL;
> > >>>> +        if (range.len =3D=3D 0)
> > >>>>                  goto err;
> > >>>> -        }
> > >>>>
> > >>>> -        if (inode->i_size - range.start < range.len) {
> > >>>> -                ret =3D -E2BIG;
> > >>>> -                goto err;
> > >>>> -        }
> > >>>> -        end_addr =3D range.start + range.len;
> > >>>> +        if (range.len =3D=3D (u64)-1 || inode->i_size - range.sta=
rt < range.len)
> > >>>> +                end_addr =3D inode->i_size;
> > >>
> > >> We can remove 'range.len =3D=3D (u64)-1' condition since later condi=
tion can cover
> > >> this?
> > >>
> > >>>
> > >>> Hmm, what if there are blocks beyond i_size? Do we need to check i_=
blocks for
> > >>
> > >> The blocks beyond i_size will never be written, there won't be any v=
alid message
> > >> there, so we don't need to worry about that.
> > >
> > > I don't think we have a way to guarantee the order of i_size and bloc=
k
> > > allocation in f2fs. See f2fs_write_begin and f2fs_write_end.
> >
> > However, write_begin & write_end are covered by inode_lock, it could no=
t be
> > racy with inode size check in f2fs_sec_trim_file() as it hold inode_loc=
k as
> > well?
>
> Like Daeho said, write_begin -> checkpoint -> power-cut can give bigger i=
_blocks
> than i_size.
>
> >
> > >
> > >>
> > >> Thanks,
> > >>
> > >>> ending criteria?
> > >>>
> > >>>> +        else
> > >>>> +                end_addr =3D range.start + range.len;
> > >>>>
> > >>>>          to_end =3D (end_addr =3D=3D inode->i_size);
> > >>>>          if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
> > >>>> --
> > >>>> 2.27.0.383.g050319c2ae-goog
> > >>>>
> > >>>>
> > >>>>
> > >>>> _______________________________________________
> > >>>> Linux-f2fs-devel mailing list
> > >>>> Linux-f2fs-devel@lists.sourceforge.net
> > >>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > >>>
> > >>>
> > >>> _______________________________________________
> > >>> Linux-f2fs-devel mailing list
> > >>> Linux-f2fs-devel@lists.sourceforge.net
> > >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > >>> .
> > >>>
> > > .
> > >
