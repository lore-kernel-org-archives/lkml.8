Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653BEC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D0A2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUZzE3iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHaBoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgHaBon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:44:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A130C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 18:44:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m22so4847067ljj.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 18:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h706+DAmJrg5sh57Pkq1WW2thN7Yu0k83T8H0aXE904=;
        b=JUZzE3iHuaN52Pd0n6+xd2yOBu1T7t+Krtojh8MVVgn5hNV+M5YyrmMgbfXarNee8f
         5NM6vAkN7BU17lB403pwcNL1xv8i5k1UxzLFl5dmUwaT5gdot0sHYzp9YAKPxvQJy5Ku
         6kjBHsDcCTuzJP0tLw14GXJdonpPAV52NFuILCqmibsfo2YnyzCct2Q2+tA1gI1uQTUv
         +DClnu3P+YN4qgHo9+wCcg5CzW1DjwD8wh2BZzF/7p3Zr0BCYtQ5J7kNeE7sTukCB+lS
         e3pEGqeJKetSvP0+T+FHzvAIYEbpUbyZJzP5QX9fTiD9czj1Ugc8aw2fhiP97X1xK6Yu
         ITaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h706+DAmJrg5sh57Pkq1WW2thN7Yu0k83T8H0aXE904=;
        b=BEhcT4bh+mdX5jIuFA08SspSvqUNhDUmveXG1VQn9aEWe82wxVoEc7ot27HDjgXea3
         fsM3W3pfyCPnjQ+CdsXVV9M8vTXXnG2FX/pII1mH7zUbuylIBxllhCgXeHWnU2R+Wkpz
         XARhnDPBB7sp5MzLmmgz5QkH4nsJHOGy+CqTyFNrj14fS8YJKKm5cJIw8W51HCcIKOh2
         JWSQkxgr15KKi44hYRxqjf2KFRsxH29D4I2DcFvNwfX/6869FwPozF8dXOxyVV8xhlMT
         qve3mGp5UvnhvIpYigOQV5lZ0xaoaKV2a2IuFec3J3oKlIwMbObOcmnMpX/WnU+3oNSq
         7OlQ==
X-Gm-Message-State: AOAM530dw34ZpcCBobHVQOFylemiU3siRezY37lHZmD2KyeVAIsAOrxO
        4xu3kSxXYyiyabS5VPOpqRDw/iZqG/UEn+DAlj7TzWrWWkw=
X-Google-Smtp-Source: ABdhPJw0xo3aAAWtR5a4/o8THBa+273iGF7tyRcdIuUIsSnOe/pt/Fm7piLxvSwaC31HiVSQkvN5x+vXVI/CeOq8q0A=
X-Received: by 2002:a2e:3615:: with SMTP id d21mr4347179lja.333.1598838281712;
 Sun, 30 Aug 2020 18:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200828054629.583577-1-daeho43@gmail.com> <61996dcd-6db1-13fc-8239-7e684f3ec49e@kernel.org>
 <CACOAw_wc29AROzFhcGyC73i_vYZC1NmHP60uQfP7X-j6y6=kSA@mail.gmail.com> <bd1a8ffa-83ff-b774-9bed-ed68025d0c7a@huawei.com>
In-Reply-To: <bd1a8ffa-83ff-b774-9bed-ed68025d0c7a@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 31 Aug 2020 10:44:30 +0900
Message-ID: <CACOAw_y=O35_SFxdfsVER4+a+n-eE6f48NXF6CsAnj=Ms-dgkA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent compressed file from being
 disabled after releasing cblocks
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I didn't get your point.

So, do you think this patch is ok? And we need to consider that we
need more immutable checks for other cases?
Or you want to remove this immutable check from here and add the check
to each ioctl functions?

2020=EB=85=84 8=EC=9B=94 31=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 10:24, =
Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/8/31 7:42, Daeho Jeong wrote:
> > Do you have any reason not to put this check here?
>
> No, the place is okay to me. :)
>
> > If we do this check outside of here, we definitely make a mistake
> > sooner or later.
>
> I just want to see whether we can cover all cases in where we missed to
> add immutable check condition if necessary.
>
> Thanks,
>
> >
> > 2020=EB=85=84 8=EC=9B=94 30=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 12:=
24, Chao Yu <chao@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On 2020-8-28 13:46, Daeho Jeong wrote:
> >>> From: Daeho Jeong <daehojeong@google.com>
> >>>
> >>> After releasing cblocks, the compressed file can be accidentally
> >>> disabled in compression mode, since it has zero cblocks. As we are
> >>> using IMMUTABLE flag to present released cblocks state, we can add
> >>> IMMUTABLE state check when considering the compressed file disabling.
> >>>
> >>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>> ---
> >>>   fs/f2fs/f2fs.h | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>> index 02811ce15059..14d30740ba03 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -3936,6 +3936,8 @@ static inline u64 f2fs_disable_compressed_file(=
struct inode *inode)
> >>>        if (!f2fs_compressed_file(inode))
> >>>                return 0;
> >>>        if (S_ISREG(inode->i_mode)) {
> >>> +             if (IS_IMMUTABLE(inode))
> >>> +                     return 1;
> >>
> >> It looks most of callers are from ioctl, should we add immutable check=
 in f2fs
> >> ioctl interfaces if necessary? or I missed existed check.
> >>
> >> Thanks,
> >>
> >>>                if (get_dirty_pages(inode))
> >>>                        return 1;
> >>>                if (fi->i_compr_blocks)
> >>>
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
