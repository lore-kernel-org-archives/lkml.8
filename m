Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71358C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5235720782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kR3os/OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgHaGQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgHaGQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:16:06 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D5C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:16:06 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r69so1874491lff.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wuyLaVxjSrwxIvkp2IxPqXWRy1wwNZaJjHQ7rDHE6R8=;
        b=kR3os/OT6BRC3L4oP5KzyDneUktr1nxy3/N2aC9ju5O2lvshW++Wcl5LxGRycxEpeC
         l3If0m77zrzQbBCI4EVMo0PS+1NLM0jmMcYsTppkdnW54fL7He9omjwKmewfTbtXiJIs
         PT6GzxtZhEGFRt+ubd7UhWXOjvc6BB2Iu+nUULUO63t5TGlodTPq8wPD254dgYiQ0XSB
         DQZiZr9/KOT9Nf1l2XJ8VnRUY3BO2BXgbDOfmCeDbSGZwDoDbFgSZ8p7EPem2SAB8wSd
         2TBffeRyosVALZSchjkcw5i5HxDGVz5v9J9R8cD/jPd87181TKcykcCwsBiWtz9xF+tI
         iNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wuyLaVxjSrwxIvkp2IxPqXWRy1wwNZaJjHQ7rDHE6R8=;
        b=tGSiKDSNHFieJ31mDsuK4XdrCFLUF4RBnsX6svL73/8pZlmmFBtEpnZ9UBa6calbTS
         eUSpEo1OQ8Sc5LI+8jsPzxHuvbvG+rZeppregioDqlAXK7fX3PO802zwA665os5T8hhJ
         zdcs/InX9w8UahlP+XJ7RE5CYR3F98qVekElCeTFvngzwfLKJcYqziyFOmJ1v1h5NWnH
         lrbpYT+Z6dQ/1AacnqCXmI7RrcSkqc8QfneCXb4XJCTz0p2xkCWaTSJn0DxpgKZMzD9O
         /j6+CcYgfy7gzO3IzDKidtYohiEOZ9NECyY4XFCDQugxNsjIKH4fNlbPnWT1lnovePdR
         C/LQ==
X-Gm-Message-State: AOAM530tfHp1LKAt2q5nKA8pJrV7Z2g6aI97AvFpA1MFNaA8VzJWDAHV
        ZTjV/ncFKACs852iw0mm/+QvtRzdYpZJ5x410uo=
X-Google-Smtp-Source: ABdhPJwque8Uf6G9h305X1MrSAtiMEEesSqMfkEwVSYosOibUf4sinoMvSyLURLyrfTNH//+wKVo+dNJv+e/0S/9dR8=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr2900580lfh.140.1598854564567;
 Sun, 30 Aug 2020 23:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200828054629.583577-1-daeho43@gmail.com> <61996dcd-6db1-13fc-8239-7e684f3ec49e@kernel.org>
 <CACOAw_wc29AROzFhcGyC73i_vYZC1NmHP60uQfP7X-j6y6=kSA@mail.gmail.com>
 <bd1a8ffa-83ff-b774-9bed-ed68025d0c7a@huawei.com> <CACOAw_y=O35_SFxdfsVER4+a+n-eE6f48NXF6CsAnj=Ms-dgkA@mail.gmail.com>
 <c4f58675-9df5-e3af-45fc-6fa924e3ee68@huawei.com> <CACOAw_wZFAyyt8qPCFd-LQKpMGa1moyOqSBpUnaeM0z2Y5Z+cA@mail.gmail.com>
 <78ffaf17-56a0-32bd-0bcf-212333b52f06@huawei.com>
In-Reply-To: <78ffaf17-56a0-32bd-0bcf-212333b52f06@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 31 Aug 2020 15:15:52 +0900
Message-ID: <CACOAw_xpVOaU1-zJXmNSc8kkxhqE5eMZFT0PwWxwNo4XwjRH0g@mail.gmail.com>
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

I think this patch is enough for now.
If you have anything else we should take care, please let me know~

2020=EB=85=84 8=EC=9B=94 31=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 3:08, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/8/31 11:55, Daeho Jeong wrote:
> >> - open(O_RDWR)
> >> - ioctl(FS_IOC_SETFLAGS, F2FS_COMPR_FL)
> >> - write()
> >> - ioctl(RELEASE_COMPRESS_BLOCKS) -- inode is immutable now
> >> - ioctl(FS_IOC_SETFLAGS, ~F2FS_COMPR_FL) -- Should we allow to update =
immutable inode?
> >> as we know, normally, immutable inode should deny open(O_WRONLY or O_R=
DWR) and later update.
> >>
> >
> > For this case, with this patch we'll return -EINVAL for
> > ioctl(FS_IOC_SETFLAGS, ~F2FS_COMPR_FL).
> > I thought RESERVE_COMPRESS_BLOCKS ioctl is always required to get the
> > file to normal mode after RELEASE_COMPRESS_BLOCKS is called.
>
> That's an example, after compressed block release, shouldn't we disallow =
other ioctl
> interface which updates immutable inode?
>
> > .
> >
