Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9C8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A2D20658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sD8jA94P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgHKLbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgHKLbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:31:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3E3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:31:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so13081970ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NsxTq2hJFDhrj5npD19VEMk0elp7jl9d+dS7G7R9+H0=;
        b=sD8jA94PMGPpDFYMLLEWLQMu/TVAMrHiAfW0URFlU298Lgkw9BQ6kNu7SlY8XXKa8O
         P1ouiMD40YX4x/7FWlpPJ8O+bgKyItLW/uLPe1a9sCqQ3967SVPYvWG0eAE8WfB7p23N
         JK79hkWDS7ycnKZFuLOmg8a+ltRLgwcvscGGpR8WdTt0CP9BhjzS0/3NkoIs2V5Eggul
         Lp0quDbjrivbDIUF9RO8p49QmcutyqcUrSMHmEkgvBZJ3VX4SXVPfdkn+Gt+6DYRkMPE
         S5R1ONAlWvR7E26iUyqZqewJt1IuXhQltef9mADESy7ub7kUAoMApkTfD/JiZeqNR/0+
         6W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NsxTq2hJFDhrj5npD19VEMk0elp7jl9d+dS7G7R9+H0=;
        b=dREJJIFI2ki6FPb/abvO5C9FQVMa5Tmx/1WuejMKZFGb9r6UKtEb70OkzghijE5uxX
         vSjYhuEqsSGgctip0gZ/EwJ/e448+QyRUPaWNlXyNsJXoRvMQufd/RQTi/CXa6jMJrZm
         fYahqOS3MBUCwnRtfeQm2wRLaeYYxz8J6hY8Yu1yA8WloLTYBMvSss26bBM9nAVx6Ap4
         V171AgX/Nljr33zkQvqiuAP1aR/GeSiWheQcxEgUPXG5BJdagwaJSVSOSp/Uo1hLECzL
         lBHt8JZbdDC5RTzHRYjSIFoiY0zlub5wvYHEX9DIjy0zE9tJmj8hpKn2PiDcYysyfCXz
         8gAw==
X-Gm-Message-State: AOAM5332xR0c8ax/1whFfpaXpy2I/IYM8BVbnhjOxEPOvRURwa7VIHAE
        Qtqp1nQuVzocjQbSz7c0hO9dRWkCY1RiZEVGqHY=
X-Google-Smtp-Source: ABdhPJwwrqVlzleSsVvjFZzTMP7FfThPY4qYUrFEYqKFaqXkAuPi4bBx6KzR9xiqIhwQZSBoEjvnPTU5IoK9GFYOsg4=
X-Received: by 2002:a2e:b8cf:: with SMTP id s15mr2944467ljp.166.1597145509756;
 Tue, 11 Aug 2020 04:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200811033753.783276-1-daeho43@gmail.com> <20200811071552.GA8365@xiangao.remote.csb>
 <3059d7b0-cf50-4315-e5a9-8d9c00965a7c@huawei.com> <CACOAw_yic7GF3E1zEvZ=Gea3XW4fMYdg-cNuu4wfg+uTKMcJqA@mail.gmail.com>
 <CACOAw_wi3C0iyTVYc3075d4K27NT7BGMGzsKFDDozf=98vWMcA@mail.gmail.com>
 <20200811101827.GA7870@xiangao.remote.csb> <CACOAw_zRPeGzHyc_siLqBRjURWTE61G5rGCwk7bnbcOnADGRpg@mail.gmail.com>
 <20200811112912.GB7870@xiangao.remote.csb>
In-Reply-To: <20200811112912.GB7870@xiangao.remote.csb>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 11 Aug 2020 20:31:38 +0900
Message-ID: <CACOAw_zAbTf+hEW0XVyL-aUw7oxCFTm_jRXLM8eiaOEdDWc0Qw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change virtual mapping way for
 compression pages
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Plus, differently from your testbed, in my pixel device, there seems
to be much more contention in vmap() operation.
If it's not there, I agree that there might not be a big difference
between vmap() and vm_map_ram().

2020=EB=85=84 8=EC=9B=94 11=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 8:29, G=
ao Xiang <hsiangkao@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Aug 11, 2020 at 08:21:23PM +0900, Daeho Jeong wrote:
> > Sure, I'll update the test condition as you said in the commit message.
> > FYI, the test is done with 16kb chunk and Pixel 3 (arm64) device.
>
> Yeah, anyway, it'd better to lock the freq and offline the little
> cores in your test as well (it'd make more sense). e.g. if 16k cluster
> is applied, even all data is zeroed, the count of vmap/vm_map_ram
> isn't hugeous (and as you said, "sometimes, it has a very long delay",
> it's much like another scheduling concern as well).
>
> Anyway, I'm not against your commit but the commit message is a bit
> of unclear. At least, if you think that is really the case, I'm ok
> with that.
>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> >
> > 2020=C3=AB=E2=80=A6=E2=80=9E 8=C3=AC=E2=80=BA=E2=80=9D 11=C3=AC=EF=BF=
=BD=C2=BC (=C3=AD=E2=84=A2=E2=80=9D) =C3=AC=CB=9C=C2=A4=C3=AD=E2=80=BA=E2=
=80=9E 7:18, Gao Xiang <hsiangkao@redhat.com>=C3=AB=E2=80=B9=CB=9C=C3=AC=EF=
=BF=BD=C2=B4 =C3=AC=C5=BE=E2=80=98=C3=AC=E2=80=9E=C2=B1:
> > >
> > > On Tue, Aug 11, 2020 at 06:33:26PM +0900, Daeho Jeong wrote:
> > > > Plus, when we use vmap(), vmap() normally executes in a short time
> > > > like vm_map_ram().
> > > > But, sometimes, it has a very long delay.
> > > >
> > > > 2020=C3=83=C2=AB=C3=A2=E2=82=AC=C2=A6=C3=A2=E2=82=AC=C5=BE 8=C3=83=
=C2=AC=C3=A2=E2=82=AC=C2=BA=C3=A2=E2=82=AC=EF=BF=BD 11=C3=83=C2=AC=C3=AF=C2=
=BF=C2=BD=C3=82=C2=BC (=C3=83=C2=AD=C3=A2=E2=80=9E=C2=A2=C3=A2=E2=82=AC=EF=
=BF=BD) =C3=83=C2=AC=C3=8B=C5=93=C3=82=C2=A4=C3=83=C2=AD=C3=A2=E2=82=AC=C2=
=BA=C3=A2=E2=82=AC=C5=BE 6:28, Daeho Jeong <daeho43@gmail.com>=C3=83=C2=AB=
=C3=A2=E2=82=AC=C2=B9=C3=8B=C5=93=C3=83=C2=AC=C3=AF=C2=BF=C2=BD=C3=82=C2=B4=
 =C3=83=C2=AC=C3=85=C2=BE=C3=A2=E2=82=AC=CB=9C=C3=83=C2=AC=C3=A2=E2=82=AC=
=C5=BE=C3=82=C2=B1:
> > > > >
> > > > > Actually, as you can see, I use the whole zero data blocks in the=
 test file.
> > > > > It can maximize the effect of changing virtual mapping.
> > > > > When I use normal files which can be compressed about 70% from th=
e
> > > > > original file,
> > > > > The vm_map_ram() version is about 2x faster than vmap() version.
> > >
> > > What f2fs does is much similar to btrfs compression. Even if these
> > > blocks are all zeroed. In principle, the maximum compression ratio
> > > is determined (cluster sized blocks into one compressed block, e.g
> > > 16k cluster into one compressed block).
> > >
> > > So it'd be better to describe your configured cluster size (16k or
> > > 128k) and your hardware information in the commit message as well.
> > >
> > > Actually, I also tried with this patch as well on my x86 laptop just
> > > now with FIO (I didn't use zeroed block though), and I didn't notice
> > > much difference with turbo boost off and maxfreq.
> > >
> > > I'm not arguing this commit, just a note about this commit message.
> > > > > > >> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
> > > > > > >> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
> > > > > > >> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
> > >
> > > IMHO, the above number is much like decompressing in the arm64 little=
 cores.
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > >
> > > > >
> > > > > 2020=C3=83=C2=AB=C3=A2=E2=82=AC=C2=A6=C3=A2=E2=82=AC=C5=BE 8=C3=
=83=C2=AC=C3=A2=E2=82=AC=C2=BA=C3=A2=E2=82=AC=EF=BF=BD 11=C3=83=C2=AC=C3=AF=
=C2=BF=C2=BD=C3=82=C2=BC (=C3=83=C2=AD=C3=A2=E2=80=9E=C2=A2=C3=A2=E2=82=AC=
=EF=BF=BD) =C3=83=C2=AC=C3=8B=C5=93=C3=82=C2=A4=C3=83=C2=AD=C3=A2=E2=82=AC=
=C2=BA=C3=A2=E2=82=AC=C5=BE 4:55, Chao Yu <yuchao0@huawei.com>=C3=83=C2=AB=
=C3=A2=E2=82=AC=C2=B9=C3=8B=C5=93=C3=83=C2=AC=C3=AF=C2=BF=C2=BD=C3=82=C2=B4=
 =C3=83=C2=AC=C3=85=C2=BE=C3=A2=E2=82=AC=CB=9C=C3=83=C2=AC=C3=A2=E2=82=AC=
=C5=BE=C3=82=C2=B1:
> > > > > >
> > > > > > On 2020/8/11 15:15, Gao Xiang wrote:
> > > > > > > On Tue, Aug 11, 2020 at 12:37:53PM +0900, Daeho Jeong wrote:
> > > > > > >> From: Daeho Jeong <daehojeong@google.com>
> > > > > > >>
> > > > > > >> By profiling f2fs compression works, I've found vmap() calli=
ngs are
> > > > > > >> bottlenecks of f2fs decompression path. Changing these with
> > > > > > >> vm_map_ram(), we can enhance f2fs decompression speed pretty=
 much.
> > > > > > >>
> > > > > > >> [Verification]
> > > > > > >> dd if=3D/dev/zero of=3Ddummy bs=3D1m count=3D1000
> > > > > > >> echo 3 > /proc/sys/vm/drop_caches
> > > > > > >> dd if=3Ddummy of=3D/dev/zero bs=3D512k
> > > > > > >>
> > > > > > >> - w/o compression -
> > > > > > >> 1048576000 bytes (0.9 G) copied, 1.999384 s, 500 M/s
> > > > > > >> 1048576000 bytes (0.9 G) copied, 2.035988 s, 491 M/s
> > > > > > >> 1048576000 bytes (0.9 G) copied, 2.039457 s, 490 M/s
> > > > > > >>
> > > > > > >> - before patch -
> > > > > > >> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
> > > > > > >> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
> > > > > > >> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
> > > > > > >>
> > > > > > >> - after patch -
> > > > > > >> 1048576000 bytes (0.9 G) copied, 2.253441 s, 444 M/s
> > > > > > >> 1048576000 bytes (0.9 G) copied, 2.739764 s, 365 M/s
> > > > > > >> 1048576000 bytes (0.9 G) copied, 2.185649 s, 458 M/s
> > > > > > >
> > > > > > > Indeed, vmap() approach has some impact on the whole
> > > > > > > workflow. But I don't think the gap is such significant,
> > > > > > > maybe it relates to unlocked cpufreq (and big little
> > > > > > > core difference if it's on some arm64 board).
> > > > > >
> > > > > > Agreed,
> > > > > >
> > > > > > I guess there should be other reason causing the large performa=
nce
> > > > > > gap, scheduling, frequency, or something else.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > Linux-f2fs-devel mailing list
> > > > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > > > > .
> > > > > > >
> > > >
> > >
> >
>
