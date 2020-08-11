Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE90C20716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCwAvJxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgHKLVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgHKLVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:21:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F38C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:21:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so13074410ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Ct58qMIg0pwE2hoQADteqtstqL+kB4e2gL5OWh/wsI=;
        b=HCwAvJxed5Br6kXQie/OgvDJ2NQ/z31CpHC6x5m8dKFidNdgyIKv6dZnn6b9zN09or
         A2TQ1BI+EzXiJesGfcKPEDyjobKuOSd7nR04Ar1ric1IW5rcvSXXlpxIcIdlv1sgeKIV
         XHjwhjziuEyxoTHwCMIXjSIH2PTVXKVc1EVz52PodX0WMS53G4DtsltjGpbxxw8SNim7
         F9z8MyWNiV/EWU/EnnNzB0u4UmXai5Pjv+fDsIcMiWVA9KiJ12b5r32shpoivo+vMqD1
         el9FZcy9q60ICpNPe+TQs/fB87ug5izH9ocybaYmKdwHlR+hPkoj9ywz1lj/VnC8Epaz
         xluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Ct58qMIg0pwE2hoQADteqtstqL+kB4e2gL5OWh/wsI=;
        b=GU+7vi58Wsfgj+dJnUkVN1mWlkVlNCKsAby4nMRoIQUvxphi8aesjIlHRNfEYIC542
         42TDTzLSFu2UeEeJ+1cPxGn3f7prYz0NWmyFO4JMtalkspO+KVMbVJho5QQIptU1fflG
         MNNJf/q4ENOw40j8DqUrMctBkl1y2nwBya1A13ntixELGZDWw0ZI/9rFDQ6k2eCtS/Gs
         9GCa0rDhtdL3MGKbdjtLudkwec2XF6qpgPP3aJ/MYL+BpKZ/GO8/oUC3rc9tGsM9VPlh
         nG84220mflXwERYjkpCldZAseX0rkLYIzFDqVUHsv8d3N6wZTNUn2A9yNV1Y0p3wmDnT
         W/RQ==
X-Gm-Message-State: AOAM530DbdwQWgOcVPlrAOhJ+OdPvnR3KrKiLM6c4jJfgNXbvq/xxsCl
        NcbSaPBk0qj3sg0RJeX4fSruqC+eEFXIkohjZOU=
X-Google-Smtp-Source: ABdhPJzk5Ns2umh9W9MkI6/l77QbQnjwM4eNUYg9DPae0+PlOO/EEm4ixqit0bXszbw2ZGhcAUsrRlQacJSdg/xOI5I=
X-Received: by 2002:a2e:3615:: with SMTP id d21mr2884573lja.333.1597144894562;
 Tue, 11 Aug 2020 04:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200811033753.783276-1-daeho43@gmail.com> <20200811071552.GA8365@xiangao.remote.csb>
 <3059d7b0-cf50-4315-e5a9-8d9c00965a7c@huawei.com> <CACOAw_yic7GF3E1zEvZ=Gea3XW4fMYdg-cNuu4wfg+uTKMcJqA@mail.gmail.com>
 <CACOAw_wi3C0iyTVYc3075d4K27NT7BGMGzsKFDDozf=98vWMcA@mail.gmail.com> <20200811101827.GA7870@xiangao.remote.csb>
In-Reply-To: <20200811101827.GA7870@xiangao.remote.csb>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 11 Aug 2020 20:21:23 +0900
Message-ID: <CACOAw_zRPeGzHyc_siLqBRjURWTE61G5rGCwk7bnbcOnADGRpg@mail.gmail.com>
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

Sure, I'll update the test condition as you said in the commit message.
FYI, the test is done with 16kb chunk and Pixel 3 (arm64) device.

Thanks,

2020=EB=85=84 8=EC=9B=94 11=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 7:18, G=
ao Xiang <hsiangkao@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Aug 11, 2020 at 06:33:26PM +0900, Daeho Jeong wrote:
> > Plus, when we use vmap(), vmap() normally executes in a short time
> > like vm_map_ram().
> > But, sometimes, it has a very long delay.
> >
> > 2020=C3=AB=E2=80=A6=E2=80=9E 8=C3=AC=E2=80=BA=E2=80=9D 11=C3=AC=EF=BF=
=BD=C2=BC (=C3=AD=E2=84=A2=E2=80=9D) =C3=AC=CB=9C=C2=A4=C3=AD=E2=80=BA=E2=
=80=9E 6:28, Daeho Jeong <daeho43@gmail.com>=C3=AB=E2=80=B9=CB=9C=C3=AC=EF=
=BF=BD=C2=B4 =C3=AC=C5=BE=E2=80=98=C3=AC=E2=80=9E=C2=B1:
> > >
> > > Actually, as you can see, I use the whole zero data blocks in the tes=
t file.
> > > It can maximize the effect of changing virtual mapping.
> > > When I use normal files which can be compressed about 70% from the
> > > original file,
> > > The vm_map_ram() version is about 2x faster than vmap() version.
>
> What f2fs does is much similar to btrfs compression. Even if these
> blocks are all zeroed. In principle, the maximum compression ratio
> is determined (cluster sized blocks into one compressed block, e.g
> 16k cluster into one compressed block).
>
> So it'd be better to describe your configured cluster size (16k or
> 128k) and your hardware information in the commit message as well.
>
> Actually, I also tried with this patch as well on my x86 laptop just
> now with FIO (I didn't use zeroed block though), and I didn't notice
> much difference with turbo boost off and maxfreq.
>
> I'm not arguing this commit, just a note about this commit message.
> > > > >> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
> > > > >> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
> > > > >> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
>
> IMHO, the above number is much like decompressing in the arm64 little cor=
es.
>
> Thanks,
> Gao Xiang
>
>
> > >
> > > 2020=C3=AB=E2=80=A6=E2=80=9E 8=C3=AC=E2=80=BA=E2=80=9D 11=C3=AC=EF=BF=
=BD=C2=BC (=C3=AD=E2=84=A2=E2=80=9D) =C3=AC=CB=9C=C2=A4=C3=AD=E2=80=BA=E2=
=80=9E 4:55, Chao Yu <yuchao0@huawei.com>=C3=AB=E2=80=B9=CB=9C=C3=AC=EF=BF=
=BD=C2=B4 =C3=AC=C5=BE=E2=80=98=C3=AC=E2=80=9E=C2=B1:
> > > >
> > > > On 2020/8/11 15:15, Gao Xiang wrote:
> > > > > On Tue, Aug 11, 2020 at 12:37:53PM +0900, Daeho Jeong wrote:
> > > > >> From: Daeho Jeong <daehojeong@google.com>
> > > > >>
> > > > >> By profiling f2fs compression works, I've found vmap() callings =
are
> > > > >> bottlenecks of f2fs decompression path. Changing these with
> > > > >> vm_map_ram(), we can enhance f2fs decompression speed pretty muc=
h.
> > > > >>
> > > > >> [Verification]
> > > > >> dd if=3D/dev/zero of=3Ddummy bs=3D1m count=3D1000
> > > > >> echo 3 > /proc/sys/vm/drop_caches
> > > > >> dd if=3Ddummy of=3D/dev/zero bs=3D512k
> > > > >>
> > > > >> - w/o compression -
> > > > >> 1048576000 bytes (0.9 G) copied, 1.999384 s, 500 M/s
> > > > >> 1048576000 bytes (0.9 G) copied, 2.035988 s, 491 M/s
> > > > >> 1048576000 bytes (0.9 G) copied, 2.039457 s, 490 M/s
> > > > >>
> > > > >> - before patch -
> > > > >> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
> > > > >> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
> > > > >> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
> > > > >>
> > > > >> - after patch -
> > > > >> 1048576000 bytes (0.9 G) copied, 2.253441 s, 444 M/s
> > > > >> 1048576000 bytes (0.9 G) copied, 2.739764 s, 365 M/s
> > > > >> 1048576000 bytes (0.9 G) copied, 2.185649 s, 458 M/s
> > > > >
> > > > > Indeed, vmap() approach has some impact on the whole
> > > > > workflow. But I don't think the gap is such significant,
> > > > > maybe it relates to unlocked cpufreq (and big little
> > > > > core difference if it's on some arm64 board).
> > > >
> > > > Agreed,
> > > >
> > > > I guess there should be other reason causing the large performance
> > > > gap, scheduling, frequency, or something else.
> > > >
> > > > >
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > Linux-f2fs-devel mailing list
> > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > > .
> > > > >
> >
>
