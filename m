Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD7CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72AA2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJtoShZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGOEHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgGOEHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:07:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82356C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 21:07:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j11so984225ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XculN1N44Fa+jOc1RfTadTGol/qQarf597qWYxyeyDo=;
        b=qJtoShZnOkain8+1JMHD56VTyN8dkAQ1B1KWI1k68Aq/6YJprxm4zSNyHIGoh9FNv7
         WnLAEssl7f1WNS2ZdnQtrAY3Ei+btc3GpSYpCnJ1/BbwoN4FA5LbgNDspCJ7MFhSuNc3
         Uf7FjVKCdoACWL03epHUxPqDQSQB6iMwzsie8HUz+Q6LyiULWn/54wPrttkps2lbfPjR
         vz3qcQb5BHgal0a2ch+OpsdZHi5N3Dj4Ux8CpRucZKhn5whjZ1tZM71e60/buMV6GbFf
         7s4VQM/1QrtCoNtsZQnwDx4+Ux3ZYM7DRoXyVCFbnA3U4RLjJhqjD7GI9HtfabMhXtxK
         o60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XculN1N44Fa+jOc1RfTadTGol/qQarf597qWYxyeyDo=;
        b=gqXzIpr7iL0Nqn4x4FPJ43ELI6RyqvrhLa8LRnQK+BD6XS3wKK66Ar7vVpxQh2QNzv
         8SHCZRKMZayZRhgeHa//23D8ZYkqHeMbP23KbawTqjs6DcXjZlMS/Cd/anMOwVAG2OMa
         amXZfRSF/dKxXuUg3NIWLTUpuvZt4EkJt3fS+LLqHYb3iWgrgFZvTGOfjYbwZfW/nJmc
         FyYxKxGI4reM3Yfnh5+Oo3cvZCJjeKDVqy2YA0aWzOppipXZ6RDOQ6+hMaV0gJxt8vQg
         jvTmZmOM8qW251kHN7Q6ZgX9kRlazS8v/jnuZTipdoC0+FdId3D4cxs+lrGGwbsNUivm
         cb3g==
X-Gm-Message-State: AOAM5337PRLFBKy62M8zSvH3Is6R+wjkt7PQZOYvo0U6dJqibCRy6Nir
        Td+DX1n6V2wZeo98jPM5jKVMTi+NW3MXPGNZr/g=
X-Google-Smtp-Source: ABdhPJw823tPINXmultV+mPN9c1KKxUKc93Tc/K6297nyUADoVUrqv4A2KSnLF2f/XNnQyEZGTMFphn3bL2JIBNHWZQ=
X-Received: by 2002:a2e:b0ed:: with SMTP id h13mr3566466ljl.250.1594786027862;
 Tue, 14 Jul 2020 21:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200713031252.3873546-1-daeho43@gmail.com> <20200713181152.GC2910046@google.com>
 <3b02263d-a5e1-136c-40ed-514d34e4c895@huawei.com>
In-Reply-To: <3b02263d-a5e1-136c-40ed-514d34e4c895@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 15 Jul 2020 13:06:56 +0900
Message-ID: <CACOAw_wBD_ourGJSdRTDM-wzeH97aGE966QDB6bpjiyXRrh47A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: change the way of handling range.len
 in F2FS_IOC_SEC_TRIM_FILE
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We could use fscrypt_zeroout_range() for an encrypted file.
But, one problem is fscrypt_zeroout_range() assumes that filesystems
only use a single block device.
It means it doesn't receive bdev as a parameter.
How about changing the interface of fscrypt_zeroout_range() first and using=
 it?

2020=EB=85=84 7=EC=9B=94 14=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:36, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/7/14 2:11, Jaegeuk Kim wrote:
> > Hi Daeho,
> >
> > Please take a look at this.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit=
/?h=3Ddev&id=3D35245180459aebf6d70fde88a538f0400a794aa6
>
> I'm curious about what will happen if we call
> sec_trim_file(F2FS_TRIM_FILE_ZEROOUT) on an encrypted file, will
> it use zero bits covering encrypted data on disk?
>
> Thanks,
>
> >
> > Thanks,
> >
> > On 07/13, Daeho Jeong wrote:
> >> From: Daeho Jeong <daehojeong@google.com>
> >>
> >> Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
> >>  1. Added -1 value support for range.len to secure trim the whole bloc=
ks
> >>     starting from range.start regardless of i_size.
> >>  2. If the end of the range passes over the end of file, it means unti=
l
> >>     the end of file (i_size).
> >>  3. ignored the case of that range.len is zero to prevent the function
> >>     from making end_addr zero and triggering different behaviour of
> >>     the function.
> >>
> >> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >> ---
> >> Changes in v2:
> >>  - Changed -1 range.len option to mean the whole blocks starting from
> >>    range.start regardless of i_size
> >> ---
> >>  fs/f2fs/file.c | 23 ++++++++++++-----------
> >>  1 file changed, 12 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index 368c80f8e2a1..2485841e3b2d 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -3792,7 +3792,7 @@ static int f2fs_sec_trim_file(struct file *filp,=
 unsigned long arg)
> >>      pgoff_t index, pg_end;
> >>      block_t prev_block =3D 0, len =3D 0;
> >>      loff_t end_addr;
> >> -    bool to_end;
> >> +    bool to_end =3D false;
> >>      int ret =3D 0;
> >>
> >>      if (!(filp->f_mode & FMODE_WRITE))
> >> @@ -3813,23 +3813,23 @@ static int f2fs_sec_trim_file(struct file *fil=
p, unsigned long arg)
> >>      file_start_write(filp);
> >>      inode_lock(inode);
> >>
> >> -    if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> >> +    if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
> >> +                    range.start >=3D inode->i_size) {
> >>              ret =3D -EINVAL;
> >>              goto err;
> >>      }
> >>
> >> -    if (range.start >=3D inode->i_size) {
> >> -            ret =3D -EINVAL;
> >> +    if (range.len =3D=3D 0)
> >>              goto err;
> >> -    }
> >>
> >> -    if (inode->i_size - range.start < range.len) {
> >> -            ret =3D -E2BIG;
> >> -            goto err;
> >> +    if (inode->i_size - range.start > range.len) {
> >> +            end_addr =3D range.start + range.len;
> >> +    } else {
> >> +            end_addr =3D range.len =3D=3D (u64)-1 ?
> >> +                    sbi->sb->s_maxbytes : inode->i_size;
> >> +            to_end =3D true;
> >>      }
> >> -    end_addr =3D range.start + range.len;
> >>
> >> -    to_end =3D (end_addr =3D=3D inode->i_size);
> >>      if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
> >>                      (!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE)))=
 {
> >>              ret =3D -EINVAL;
> >> @@ -3846,7 +3846,8 @@ static int f2fs_sec_trim_file(struct file *filp,=
 unsigned long arg)
> >>      down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>      down_write(&F2FS_I(inode)->i_mmap_sem);
> >>
> >> -    ret =3D filemap_write_and_wait_range(mapping, range.start, end_ad=
dr - 1);
> >> +    ret =3D filemap_write_and_wait_range(mapping, range.start,
> >> +                    to_end ? LLONG_MAX : end_addr - 1);
> >>      if (ret)
> >>              goto out;
> >>
> >> --
> >> 2.27.0.383.g050319c2ae-goog
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> >
