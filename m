Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7D0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C998420774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omj1hGSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgHKJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgHKJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:33:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09959C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 02:33:39 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c15so6299178lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vr+YAPUn6N4dSx2qVc2bEJB62Hk13xcs0NQkMDb0a3E=;
        b=Omj1hGSjKXZRe1OLMx57+tZ3KgMo68eDvuhMeeQj/DYbyY/7bi2vWawvkV4mlze3mN
         qnEHESnfoW5DC939GmMhwMZsoas8HUIUdt6AgPVB9vGCloiAQ++qW02yvHB6IQttb4zh
         T1E92N6m6cfdtDB6dVgLB1ILze8LIHAxDY+fn33rQXxQDxlyIrlcMlCg46v+BcyAig0r
         xHyFvYV+bAYFN7qxJKVnQ7aaOyzO+1i7VgS0KIxrf0jyFMI9wvFz91qcyTigQB3FgENs
         sJCl9sJmfxR+PmP2lpxG9KqqSDYWZhUqiH5aV9j3fTZdCM61iGBszPRB7+Jqma+kIzum
         25Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vr+YAPUn6N4dSx2qVc2bEJB62Hk13xcs0NQkMDb0a3E=;
        b=dk6PSYA4wGsujbVmBQwZ8aenRoRh9POPKWgVRuXHjsLmt8qrwdz2mK4vuRwQdjG/Oo
         xXDj907WQUq9SSHVHDEUdZk7U9JOV3Nf5u/Pp4z7apx+6g+Jsyf88DSb5xZo8N/AFA8h
         xQhZpdMfje/+z2tLotBWnspRaEs/vNS1Z6BFJ1hxcneIEMVaLhx2JLTdIf5Iqwtmqjtm
         amTgIrvgCaZdY1YjiYy6UwHEXJW15WLcmDBE0EZpOBMFqkpatxhs7E7kNL7ajAcOqw98
         YHV09XdsuzynkV3Sb4FNHCsUP+/UQcg33qYoEU84SKAwTEd7rT6LEOYwDKBt0MdDxHMN
         Z7dg==
X-Gm-Message-State: AOAM530Am5dDn9T7Aioguo7MUyu+Vsol3jMYzFXjMTDBnNADALeqEZao
        vYg0x3bavDHFsschJncMbZV2+RFxS9cYTCF8SWU=
X-Google-Smtp-Source: ABdhPJzDIV6ej2CnAWTam+6M7DMCu/58gN3ERRhWB631uDglP2D16ZpLlMoWSMKJRFK7bmUEmYTGXH9gxP4r2GV6ePI=
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr2783256lfc.100.1597138417413;
 Tue, 11 Aug 2020 02:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200811033753.783276-1-daeho43@gmail.com> <20200811071552.GA8365@xiangao.remote.csb>
 <3059d7b0-cf50-4315-e5a9-8d9c00965a7c@huawei.com> <CACOAw_yic7GF3E1zEvZ=Gea3XW4fMYdg-cNuu4wfg+uTKMcJqA@mail.gmail.com>
In-Reply-To: <CACOAw_yic7GF3E1zEvZ=Gea3XW4fMYdg-cNuu4wfg+uTKMcJqA@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 11 Aug 2020 18:33:26 +0900
Message-ID: <CACOAw_wi3C0iyTVYc3075d4K27NT7BGMGzsKFDDozf=98vWMcA@mail.gmail.com>
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

Plus, when we use vmap(), vmap() normally executes in a short time
like vm_map_ram().
But, sometimes, it has a very long delay.

2020=EB=85=84 8=EC=9B=94 11=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:28, D=
aeho Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Actually, as you can see, I use the whole zero data blocks in the test fi=
le.
> It can maximize the effect of changing virtual mapping.
> When I use normal files which can be compressed about 70% from the
> original file,
> The vm_map_ram() version is about 2x faster than vmap() version.
>
> 2020=EB=85=84 8=EC=9B=94 11=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 4:55,=
 Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On 2020/8/11 15:15, Gao Xiang wrote:
> > > On Tue, Aug 11, 2020 at 12:37:53PM +0900, Daeho Jeong wrote:
> > >> From: Daeho Jeong <daehojeong@google.com>
> > >>
> > >> By profiling f2fs compression works, I've found vmap() callings are
> > >> bottlenecks of f2fs decompression path. Changing these with
> > >> vm_map_ram(), we can enhance f2fs decompression speed pretty much.
> > >>
> > >> [Verification]
> > >> dd if=3D/dev/zero of=3Ddummy bs=3D1m count=3D1000
> > >> echo 3 > /proc/sys/vm/drop_caches
> > >> dd if=3Ddummy of=3D/dev/zero bs=3D512k
> > >>
> > >> - w/o compression -
> > >> 1048576000 bytes (0.9 G) copied, 1.999384 s, 500 M/s
> > >> 1048576000 bytes (0.9 G) copied, 2.035988 s, 491 M/s
> > >> 1048576000 bytes (0.9 G) copied, 2.039457 s, 490 M/s
> > >>
> > >> - before patch -
> > >> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
> > >> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
> > >> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
> > >>
> > >> - after patch -
> > >> 1048576000 bytes (0.9 G) copied, 2.253441 s, 444 M/s
> > >> 1048576000 bytes (0.9 G) copied, 2.739764 s, 365 M/s
> > >> 1048576000 bytes (0.9 G) copied, 2.185649 s, 458 M/s
> > >
> > > Indeed, vmap() approach has some impact on the whole
> > > workflow. But I don't think the gap is such significant,
> > > maybe it relates to unlocked cpufreq (and big little
> > > core difference if it's on some arm64 board).
> >
> > Agreed,
> >
> > I guess there should be other reason causing the large performance
> > gap, scheduling, frequency, or something else.
> >
> > >
> > >
> > >
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > .
> > >
