Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74229C433EB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BBE2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6jlNw7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgGOGyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgGOGyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:54:50 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4EEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:54:50 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u12so476916lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NTsvJyRsXTYCu8MRJ6uonhEhc3O9bi7P+xqu5XwBB5o=;
        b=E6jlNw7evD92OdJk5WvRgw585l+yKXMvWaIDL63GiT3/WAMzPN4eE8SboE4p7Epj14
         sU6PAnG4/7Ye8TdkAcT58Wjx7FS7ictIISKa5aLBRAjORMP62xOGyWrXsCLBGQ8DtcBp
         V/DtM5Pzze4tWl3X/xsum3CWLm/ci6wglbrTQ/ri8l+qinRrGLxIokZfPwNy5PlcdcCV
         mNHZjzSBPa7YLjoGeYFRBBGwJrdMmVNdn46m8fKLwuE4qpenUY+5LBh8ytrmpjffFsDx
         8dvJtaI4bSFxL1AOSgGpPbV2/eeq3pD99oBRkkpXHT3SdfYAM2ljbZE9XzgDa7gWhDXG
         dsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NTsvJyRsXTYCu8MRJ6uonhEhc3O9bi7P+xqu5XwBB5o=;
        b=VPf1AnFt6+tAF58fSCOxyz88BCGbqug940d3vjkN709vd3UldDkMnCb1OfxHfQB5OP
         QLcgPjCZC7RCE3U5Y/ZswXRkqcfhBiYij5pipPt+BaucSnFmlV7+xvpgT26hrZC3mJ0h
         uqof5lodVZwCyiB5NdlYCs09jM4BFwDkxQv3zwGZRcjQ2F6Reydw52QksotcoVHFFcEX
         oDrLg4CIp/8hzXPaHXeYzC3UjjFjv26b4fNOH2VnjGACp8jqC3GvSSOEdcPFsShilqkO
         uRgZf5g2LR3ZpC7kCi2Pi1Q3CdacvSgmIMcdIfXy5XY9Gls1/BWpmnkHWN9q0UaWk2AD
         kLQw==
X-Gm-Message-State: AOAM532d75bHkSiA4/88+U8n/gT7h8Zft4CKM3Mp4tE0Enx+WjQjsFdN
        NjMXYK7ntKLPor8k3avwELkt9++WWoKOlI4d2rM=
X-Google-Smtp-Source: ABdhPJzaAHirbaV9fE8Gp2p6pOT7v1RRsHPmFc3Dtky4E27NDk/KuiefzTdq7jt3y2ung8PHx/RdWli1iHEKYukdpaE=
X-Received: by 2002:a19:e61a:: with SMTP id d26mr4021628lfh.96.1594796087665;
 Tue, 14 Jul 2020 23:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200713031252.3873546-1-daeho43@gmail.com> <20200713181152.GC2910046@google.com>
 <3b02263d-a5e1-136c-40ed-514d34e4c895@huawei.com> <CACOAw_wBD_ourGJSdRTDM-wzeH97aGE966QDB6bpjiyXRrh47A@mail.gmail.com>
 <f4a594a1-464f-3a74-90cb-fd536bed9962@huawei.com>
In-Reply-To: <f4a594a1-464f-3a74-90cb-fd536bed9962@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 15 Jul 2020 15:54:36 +0900
Message-ID: <CACOAw_w3OWDVXSYHuTEEVv1HaBZir1CWcRAmxOt00MB4vXBKVg@mail.gmail.com>
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

You mean we can support ZEROOUT option only for encrypted files of
non-multidevice f2fs,
and return -EOPNOTSUPP in the multidevice case, right now?

2020=EB=85=84 7=EC=9B=94 15=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:17, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/7/15 12:06, Daeho Jeong wrote:
> > We could use fscrypt_zeroout_range() for an encrypted file.
> > But, one problem is fscrypt_zeroout_range() assumes that filesystems
> > only use a single block device.
> > It means it doesn't receive bdev as a parameter.
> > How about changing the interface of fscrypt_zeroout_range() first and u=
sing it?
>
> Yes, please limited to use fscrypt_zeroout_range() on non-multidevice f2f=
s image
> first, we can add a condition to check that in the beginning of ioctl int=
erface,
> once fscrypt_zeroout_range() accepts bdev as parameter, we can remove tha=
t limitation.
>
> Thanks,
>
> >
> > 2020=EB=85=84 7=EC=9B=94 14=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:3=
6, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On 2020/7/14 2:11, Jaegeuk Kim wrote:
> >>> Hi Daeho,
> >>>
> >>> Please take a look at this.
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/comm=
it/?h=3Ddev&id=3D35245180459aebf6d70fde88a538f0400a794aa6
> >>
> >> I'm curious about what will happen if we call
> >> sec_trim_file(F2FS_TRIM_FILE_ZEROOUT) on an encrypted file, will
> >> it use zero bits covering encrypted data on disk?
> >>
> >> Thanks,
> >>
> >>>
> >>> Thanks,
> >>>
> >>> On 07/13, Daeho Jeong wrote:
> >>>> From: Daeho Jeong <daehojeong@google.com>
> >>>>
> >>>> Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
> >>>>  1. Added -1 value support for range.len to secure trim the whole bl=
ocks
> >>>>     starting from range.start regardless of i_size.
> >>>>  2. If the end of the range passes over the end of file, it means un=
til
> >>>>     the end of file (i_size).
> >>>>  3. ignored the case of that range.len is zero to prevent the functi=
on
> >>>>     from making end_addr zero and triggering different behaviour of
> >>>>     the function.
> >>>>
> >>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>>> ---
> >>>> Changes in v2:
> >>>>  - Changed -1 range.len option to mean the whole blocks starting fro=
m
> >>>>    range.start regardless of i_size
> >>>> ---
> >>>>  fs/f2fs/file.c | 23 ++++++++++++-----------
> >>>>  1 file changed, 12 insertions(+), 11 deletions(-)
> >>>>
> >>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>> index 368c80f8e2a1..2485841e3b2d 100644
> >>>> --- a/fs/f2fs/file.c
> >>>> +++ b/fs/f2fs/file.c
> >>>> @@ -3792,7 +3792,7 @@ static int f2fs_sec_trim_file(struct file *fil=
p, unsigned long arg)
> >>>>      pgoff_t index, pg_end;
> >>>>      block_t prev_block =3D 0, len =3D 0;
> >>>>      loff_t end_addr;
> >>>> -    bool to_end;
> >>>> +    bool to_end =3D false;
> >>>>      int ret =3D 0;
> >>>>
> >>>>      if (!(filp->f_mode & FMODE_WRITE))
> >>>> @@ -3813,23 +3813,23 @@ static int f2fs_sec_trim_file(struct file *f=
ilp, unsigned long arg)
> >>>>      file_start_write(filp);
> >>>>      inode_lock(inode);
> >>>>
> >>>> -    if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) =
{
> >>>> +    if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) |=
|
> >>>> +                    range.start >=3D inode->i_size) {
> >>>>              ret =3D -EINVAL;
> >>>>              goto err;
> >>>>      }
> >>>>
> >>>> -    if (range.start >=3D inode->i_size) {
> >>>> -            ret =3D -EINVAL;
> >>>> +    if (range.len =3D=3D 0)
> >>>>              goto err;
> >>>> -    }
> >>>>
> >>>> -    if (inode->i_size - range.start < range.len) {
> >>>> -            ret =3D -E2BIG;
> >>>> -            goto err;
> >>>> +    if (inode->i_size - range.start > range.len) {
> >>>> +            end_addr =3D range.start + range.len;
> >>>> +    } else {
> >>>> +            end_addr =3D range.len =3D=3D (u64)-1 ?
> >>>> +                    sbi->sb->s_maxbytes : inode->i_size;
> >>>> +            to_end =3D true;
> >>>>      }
> >>>> -    end_addr =3D range.start + range.len;
> >>>>
> >>>> -    to_end =3D (end_addr =3D=3D inode->i_size);
> >>>>      if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
> >>>>                      (!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE)=
)) {
> >>>>              ret =3D -EINVAL;
> >>>> @@ -3846,7 +3846,8 @@ static int f2fs_sec_trim_file(struct file *fil=
p, unsigned long arg)
> >>>>      down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>>>      down_write(&F2FS_I(inode)->i_mmap_sem);
> >>>>
> >>>> -    ret =3D filemap_write_and_wait_range(mapping, range.start, end_=
addr - 1);
> >>>> +    ret =3D filemap_write_and_wait_range(mapping, range.start,
> >>>> +                    to_end ? LLONG_MAX : end_addr - 1);
> >>>>      if (ret)
> >>>>              goto out;
> >>>>
> >>>> --
> >>>> 2.27.0.383.g050319c2ae-goog
> >>>
> >>>
> >>> _______________________________________________
> >>> Linux-f2fs-devel mailing list
> >>> Linux-f2fs-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>> .
> >>>
> > .
> >
