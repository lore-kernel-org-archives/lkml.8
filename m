Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B6EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACD22076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgEOOap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:30:45 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgEOOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:30:44 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mzydy-1jBtXI2Xgs-00x30o; Fri, 15 May 2020 16:30:42 +0200
Received: by mail-qk1-f170.google.com with SMTP id g185so2686971qke.7;
        Fri, 15 May 2020 07:30:42 -0700 (PDT)
X-Gm-Message-State: AOAM531OacSyEhjr9MnZhauVdXCmOp2RQ//M8wvrjfb3P6Y8XgeWoeJ5
        OYPXhkPxkfmVJdTbSDGfwALqh9F/u69gJ5uLeio=
X-Google-Smtp-Source: ABdhPJzWWXgTORWkb4jbrO8K6QMT6N5lPpxFdl5UWPmbpX97RbGZ8EERls9fxqPwUdbnag+Twa+m+oPKAZzZIORJbmw=
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr3652955qkg.394.1589553041352;
 Fri, 15 May 2020 07:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200515105537.4876-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <202005152142.AWvx4xc5%lkp@intel.com> <CAHp75Ven9q-6dDYtP_uXigeS_r2uvpUZVR5Mh0RdEd36MbTG+Q@mail.gmail.com>
In-Reply-To: <CAHp75Ven9q-6dDYtP_uXigeS_r2uvpUZVR5Mh0RdEd36MbTG+Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 May 2020 16:30:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3RKJo-C5=19oAppx212s7T8NdnKJVmkj+h=34a8aKMNA@mail.gmail.com>
Message-ID: <CAK8P3a3RKJo-C5=19oAppx212s7T8NdnKJVmkj+h=34a8aKMNA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        masonccyang@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fyohI0+hw5ytppZoJZd/XmCfZsfVnsd6n3zCOrkbrMezdv5+tyv
 X1oZ3f8TWbSVCNojpAAANE3s9hgV+BHNP6LkVn4/ajz1awkSkBB7fedgKs+pvRHGmEspvOQ
 jIGR32OYo7AlhTB7FgCuUi80L3JUzvCcl+jMKYwZQ6cmhfpfv3ShlvuZJfHT5Byb82ei67p
 M+8eac3TrEcNMivY2Nepg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dytqvl0/TSg=:Yo6IWW/ehKu/h4tnfwlLhl
 RTdaJMBmzma5uU2CHUAkNAZehZJ7HWaQvpUdyYFWBqRmBGLhPklkjexn5yi22aFSwLUsNmNoX
 45+joPlil9ynwS7gQN1zx3Z/fxUKGCVbwte8Dp5Hmw0W3DrGUP9XRKHzQ7ryJ031Iu44CLvLH
 AC4EdILA++cw0ohjiIgMiDHCjUkWXLlhAwolpN/cqEYA9YHFhZG9NiI1k7LeeaHPIb5PE1wsy
 5nZxc4/BRJq1myYyh5pcUmdnOuPQa0vhBGBWnAC66+txIjIWUeAO1J/weZpxfOe0k++qj4FLF
 Y4Vc/YHongNN99E15v2FuD1R1FIQe+T6Hw2JyUIbdb/k4iqULYquhWmcgzwNa+wLf/8rAJOrt
 hPAd+uAySAIJ/O2i9iG8dkMHoKARFjP20RxkPHvXC5Myz7mjJn5zQ/pFH8KTQbAJm5b6TdOVJ
 uUrASJLNxT+UEl8SV4OPMPY5ohHWgFkKH/eiUTeelpUOFJbnAudfYe5mazl3xV+zwCDBdxCYg
 z24uWO/HjqNvxlak7DEbTkqMGb1SddlgBLkFNBn/XnVcZ+KrnulS2TzWEZTAtUbwmfbiBpI/v
 pKBIZdSvaPK42Lwa8BWGl92uJAUfCeqios+EidpExdk5sYRkP5zk7I+Ymy+QjbH46LWTjDSq2
 Mfo+T3ldOq0fkMvFwKqxLN3m4LydJclbM9VL5VK4BvgePjZ2VsmEZb7q9jABFJVkxAZbbcoeH
 Qc8HhilEedCS5g0FJzupglyuhoZ6+ejXfzQlQ5dj1VJzeDCX8TCvC3iOCek2VcS+QH6nMzXzF
 kmbzD3NbT9kuiC5eZLloP6axx0+u84iQ7UxRwAi75vBOkEjIFk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 4:25 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, May 15, 2020 at 4:48 PM kbuild test robot <lkp@intel.com> wrote:
>
> > sparse warnings: (new ones prefixed by >>)
> >
> > >> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int val @@    got restricted __be32 [assignedunsigned int val @@
> > >> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse:    expected unsigned int val
> > >> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse:    got restricted __be32 [assigned] [usertype] reg
> >    drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int val @@    got restricted __be32 [assignedunsigned int val @@
> >    drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse:    expected unsigned int val
> >    drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse:    got restricted __be32 [assigned] [usertype] reg
> >
> >    440                  reg = cpu_to_be32(*pdata++);
> >  > 441                  writel(reg, ebu_host->hsnand + HSNAND_CMSG_0);
> >    442
> >    443                  reg = cpu_to_be32(*pdata);
> >    444                  writel(reg, ebu_host->hsnand + HSNAND_CMSG_1);
>
> On BE:
> cpu_to_be32 -> no-op
> writel() -> converts reg to LE
>
> On LE:
> cpu_to_be32 -> converts to BE
> writel() -> no-op (in terms of conversion)
>
> Seems to me that the proper API (if above is intended) should be swab32().
> But something tells me that above is broken (or my understanding is wrong).

iowrite_be32() is the correct way to store word into a big-endian mmio register,
if that is the intention here.

      Arnd
