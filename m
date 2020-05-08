Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059AC47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F8A206D5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEHVnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:43:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHVnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:43:35 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M8yoa-1jSCyB2flW-0066pb; Fri, 08 May 2020 23:43:33 +0200
Received: by mail-lj1-f169.google.com with SMTP id g4so3242276ljl.2;
        Fri, 08 May 2020 14:43:33 -0700 (PDT)
X-Gm-Message-State: AOAM531qluAr+diUzl7ZPQnIW0NZmgFhSdPoTHaUeN337gYGXV/XFY6e
        ow2GKythDkyUwL2kwn/Tk40KXKDNAxsGIceOfbg=
X-Google-Smtp-Source: ABdhPJyRp2oxjOeqeg5ENiT9+DXJ38iq1iUgrmbVJE77HNSlXmj4qNJze/k7fGHouA2c4pFLbRFncyp77YcpDJaXnCg=
X-Received: by 2002:a2e:6a08:: with SMTP id f8mr3135164ljc.8.1588974213097;
 Fri, 08 May 2020 14:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200508093553.2742898-1-arnd@arndb.de> <5849978b-7330-1dae-0896-7ecbc6083d34@gmx.de>
In-Reply-To: <5849978b-7330-1dae-0896-7ecbc6083d34@gmx.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 May 2020 23:43:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a16Qb2-H5UGMftonvEAuJ2LrKMO4nVudg+JD6HtuYR==Q@mail.gmail.com>
Message-ID: <CAK8P3a16Qb2-H5UGMftonvEAuJ2LrKMO4nVudg+JD6HtuYR==Q@mail.gmail.com>
Subject: Re: [PATCH] parisc: use -fno-strict-aliasing for decompressor
To:     Helge Deller <deller@gmx.de>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        kbuild test robot <lkp@intel.com>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dG+jwwxM7Abw9pygChUF37Z4SE0mWCH6FDpCg3iv24rDRbhLaVY
 avObk6EnJSdf8Z1SjJ6TmuegQ7QAaVmfVAbiMa+62730yAFmFh8ExVjXKHqNqaRlvbrnOQZ
 3V849i/dO9Qo9MCcvyYiYM9pHoMvhXA9Jt/Qm9WU1A/+qK+LUYY0il67KAqxH5cWl2JGPGG
 KjfrlJauulkoAW4SCx0+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PavUf7bxs9c=:6URT3eutfXhN/4L0DWBuz1
 SUjjSHzdMJ267ceacvNLcUz0tGDKHpuUrTd158svL6NC10rhFqZQRCiiceucoDTk3ixxYJr7R
 ZyaQDUppg4K50f4WObNwDYEnXfeeNqi9vdIuuGjAXytXMafduiCBbJrb+Lx6o6KTMJZe5sa8d
 evurAEGxaO1UIElRfJpZL7nUCBFiy9LHuBN0ioIr44JZJrbTpB02todT+oycOuWs799IymYZV
 kQd7oHjDuKlXsyS6vvWGz5U4CoGhdK2JxbXrAq2cVVROf/Kppy9iR1WcQDI/VH3CdQ/5AxjyZ
 dkR3QZPRm7hYLCPEB8OJzMIjyBIzO7VWk7BGU1IDlWhIzvciKjNa5TuRPMLf5fLlMjvVrY0II
 pOlKNulJw0L9U2I+XAG8TltSzhb9y7fgHf10c1loAOpwOMe+St3t8FYSeIdWqjr3WQnNEGb77
 aMOUxPJaWWHAmWT3c3RiUH0xnYi+C+bWEUuEOZYj11UCJS37dYnUh5rkPIpBW6ViHQwLMOVfm
 JEN7mQBZTB3kS3MGTJ3bwB3G6l9sf+J5pJZzJZLXPlFtiCJyu2BvDJF/L6TgvWfgbaaHnoLtT
 tqzb0NB+0IWPAvD168klaQ0XLLlwmeucOpr07VFuWYM+hpj32to+jaB6aKSfjbDnSV/YrkBWK
 FZzUfjUeUPH3YpfGFQTKVYpEQGgUZLHU2DKwi513Hlqdn+ZNZaS+EvOasK7VLgncU4lvMUV2a
 Dx36YNqV1F2JdBFadXngNlR7GUiGrh6uBda/gix87fwzaSBzzQHNafhortPAetUPO011etYja
 0CKRsFDsKAyItJKGou0zMG2pcUYQKVrc559zF25w2gll2RhgyY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 11:40 PM Helge Deller <deller@gmx.de> wrote:
> On 08.05.20 11:35, Arnd Bergmann wrote:
> > An experimental patch series of mine reworks how warnings are processed
> > in Kbuild. A side effect is a new warning about a harmless aliasing
> > rule violation in an inline function:
> >
> > In file included from
> > include/linux/rhashtable-types.h:15:0,
> >                  from include/linux/ipc.h:7,
> >                  from include/uapi/linux/sem.h:5,
> >                  from include/linux/sem.h:5,
> >                  from include/linux/sched.h:15,
> >                  from include/linux/uaccess.h:6,
> >                  from arch/parisc/boot/compressed/misc.c:7:
> > include/linux/workqueue.h: In function 'work_static':
> > include/linux/workqueue.h:212:2: warning: dereferencing
> > type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
> >   return *work_data_bits(work) & WORK_STRUCT_STATIC;
> >
> > Make the decompressor use -fno-strict-aliasing like the rest of
> > the kernel for consistency, and to ensure this warning never makes
> > it into a release.
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Helge Deller <deller@gmx.de>
>
> Arnd, will you take it through your trees when you push your experimental
> patches, or do you want me to take it through the parisc tree?

Please take it through your tree. It will take me a while to finish my
series, and having one less change will make it easier to review.

       Arnd
