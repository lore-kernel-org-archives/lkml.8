Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D963C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B24520756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8mNccyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgHKJ2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgHKJ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:28:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79797C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 02:28:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v12so12719426ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HvBhapulJHNTLDfrlwHP8ErNXcvplrpb7lxbHcaHUtw=;
        b=U8mNccyW3yzDJXPYeFEAVoPs5JVKhs0prNEtFyrW7pDtmkGgVKqmPiNsGO9kJYJGOp
         BY8VUGhNyG8xs3p58nO9z/PIMCi05UQ+dDpe7aMDZ9Mb1WPi9vIM6XX8wvSOLgL70m4O
         fOghEQpcp62m4TvEpysHbigawDwhksl4whHC2lXUkui90gOgPJVEbYla5UK89Ojljfbm
         udNGIAVxhTjm9MTwzkkR4HooxW3klZ4LX7MhDPn539CIbvIAUPyhJ4ZxFbsSRESMDevu
         ZvWtc5M2JHtpTu4xU1rq5XtTcQj9my+57hd5H9XnyB0+zt5abuIFWLnrwtxJ0EX1e1Gu
         FIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HvBhapulJHNTLDfrlwHP8ErNXcvplrpb7lxbHcaHUtw=;
        b=FEDuPRKNMKYWEYSllvtY/pIT7k6arXk64gtXTrvbZuqQKCo9UJeD9s5GzOlj9VCsjP
         Dm2RHkzAM0bSMVlLRVrutxSCXKM5a6ywDwS+rL8LIlS/XS8iMvQ32tuODME9Zkov6qHJ
         Wy6DW+JseLnbrn1H6inpBgr9N4g7jJw2OQ7kRZTX+oc1utXLH/WP02j4+1Ze3Xrp7O0o
         Ye7TJxzgSJ8eulGHRREWx5gEA+cREjSUuOIc70DGunUtqP+l6u4UGg8M4RkTkLFBXb1w
         tW1N5FfuAhcxXzM14Ot86rv+1u4MnM9fiuU5D1/nZktKQE+t42mp1J1Xo7rsf0PlQdJ9
         nHcw==
X-Gm-Message-State: AOAM5329uy0ooFS+GlNiGm9W02N7GItuYPvj+D/BkQvOmiTYW6rNqooT
        lorx6NCIaXBz5yNqoFcAnpKS/Olz/l0cNM1uZD5vXKsO
X-Google-Smtp-Source: ABdhPJw5uYCu/KhAWYcYZ7ckKrVEbVS+zajglDqgVuJTHtg67Wv3tbh76aYFS1w2RTMMSVUb+HGZ9Dn0rljQeaeNxF4=
X-Received: by 2002:a2e:85d3:: with SMTP id h19mr2788882ljj.363.1597138124832;
 Tue, 11 Aug 2020 02:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200811033753.783276-1-daeho43@gmail.com> <20200811071552.GA8365@xiangao.remote.csb>
 <3059d7b0-cf50-4315-e5a9-8d9c00965a7c@huawei.com>
In-Reply-To: <3059d7b0-cf50-4315-e5a9-8d9c00965a7c@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 11 Aug 2020 18:28:33 +0900
Message-ID: <CACOAw_yic7GF3E1zEvZ=Gea3XW4fMYdg-cNuu4wfg+uTKMcJqA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change virtual mapping way for
 compression pages
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <hsiangkao@redhat.com>,
        Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, as you can see, I use the whole zero data blocks in the test file=
.
It can maximize the effect of changing virtual mapping.
When I use normal files which can be compressed about 70% from the
original file,
The vm_map_ram() version is about 2x faster than vmap() version.

2020=EB=85=84 8=EC=9B=94 11=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 4:55, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/8/11 15:15, Gao Xiang wrote:
> > On Tue, Aug 11, 2020 at 12:37:53PM +0900, Daeho Jeong wrote:
> >> From: Daeho Jeong <daehojeong@google.com>
> >>
> >> By profiling f2fs compression works, I've found vmap() callings are
> >> bottlenecks of f2fs decompression path. Changing these with
> >> vm_map_ram(), we can enhance f2fs decompression speed pretty much.
> >>
> >> [Verification]
> >> dd if=3D/dev/zero of=3Ddummy bs=3D1m count=3D1000
> >> echo 3 > /proc/sys/vm/drop_caches
> >> dd if=3Ddummy of=3D/dev/zero bs=3D512k
> >>
> >> - w/o compression -
> >> 1048576000 bytes (0.9 G) copied, 1.999384 s, 500 M/s
> >> 1048576000 bytes (0.9 G) copied, 2.035988 s, 491 M/s
> >> 1048576000 bytes (0.9 G) copied, 2.039457 s, 490 M/s
> >>
> >> - before patch -
> >> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
> >> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
> >> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
> >>
> >> - after patch -
> >> 1048576000 bytes (0.9 G) copied, 2.253441 s, 444 M/s
> >> 1048576000 bytes (0.9 G) copied, 2.739764 s, 365 M/s
> >> 1048576000 bytes (0.9 G) copied, 2.185649 s, 458 M/s
> >
> > Indeed, vmap() approach has some impact on the whole
> > workflow. But I don't think the gap is such significant,
> > maybe it relates to unlocked cpufreq (and big little
> > core difference if it's on some arm64 board).
>
> Agreed,
>
> I guess there should be other reason causing the large performance
> gap, scheduling, frequency, or something else.
>
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> >
