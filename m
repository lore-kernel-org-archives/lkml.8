Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBAAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56F22065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgERL5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:57:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48601 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgERL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:57:32 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M1q4e-1jcqFm3dlY-002J7X; Mon, 18 May 2020 13:57:31 +0200
Received: by mail-qv1-f44.google.com with SMTP id r3so4535612qve.1;
        Mon, 18 May 2020 04:57:30 -0700 (PDT)
X-Gm-Message-State: AOAM531FwLcGxSgowINhwEXZGqrWN32MzxhrMcq20nhgg8uxpL1KgD1J
        tJmhrt3znUP7YWVKGntf1Y4yaCOdgkRq8Kc5cK0=
X-Google-Smtp-Source: ABdhPJyUnKr4SHUFnJe9QsFvJhBBCNQyLNfjUzwAzO8o0fxqdsPeqZBhu6yQh15LV+E3iObLKOIbnTvte/PqUNqOYLg=
X-Received: by 2002:a05:6214:1392:: with SMTP id g18mr14567610qvz.210.1589803049670;
 Mon, 18 May 2020 04:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200515105537.4876-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <202005152142.AWvx4xc5%lkp@intel.com> <CAHp75Ven9q-6dDYtP_uXigeS_r2uvpUZVR5Mh0RdEd36MbTG+Q@mail.gmail.com>
 <CAK8P3a3RKJo-C5=19oAppx212s7T8NdnKJVmkj+h=34a8aKMNA@mail.gmail.com>
 <5180e734-ff56-db5a-ab49-8a55cfa2f2c0@linux.intel.com> <CAHp75Ve_XjvvGBEQyhy=qVVJMFS+18j3aKxNxSQpGK5qJmzfBg@mail.gmail.com>
In-Reply-To: <CAHp75Ve_XjvvGBEQyhy=qVVJMFS+18j3aKxNxSQpGK5qJmzfBg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 May 2020 13:57:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a25GbMwbtvkxgmuGss6nEfAW4_vVbOXPxOYuDOaU_zcjA@mail.gmail.com>
Message-ID: <CAK8P3a25GbMwbtvkxgmuGss6nEfAW4_vVbOXPxOYuDOaU_zcjA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        kbuild test robot <lkp@intel.com>,
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
X-Provags-ID: V03:K1:aZXMNFxuDqcW7d7dZw64Yqx3tjdzNwT7mq238HcffP43zUt83W1
 d/0DZtOgO3kcF/I9ZugCeXHx9Mr+BnLdHmnagJOE4hHuVTBMxw7e0TSSvRrjGKYCm2/sXce
 BWyeM/sbmKx+rfCKtUZ8GMyPW9MmohWrrTVOD1DrWfg7lukuBLHzN2KJ68jsMVKs894lauB
 7tl13swvaq4lZnT4y6ChA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:37csoL6+g6A=:yBbzYVNceE2ZVVkrL0BrYB
 DnIBwi3YLiDby6nRphphY39aXjhnijUSCVtVwrikSx+oy+IN4KbGmhhpNVnpSv73J811pybfS
 tPKgD7XMNzUdVKDe6VmRk5Atl/OcpRnzwvJFxSzA640V2uAf9wrUYUG7H36a1AUL9+Z/d6Er0
 OU2G+wxpLzRXhk2ow0HTg6A2QgNFisrf4+12O3pQb/WsN8y0CQMoJpIciel4TRLbyVQuZwRGW
 PU4v5qZqlSQQOQmf3zfV7vh8id76S22HccCLNWCD2GmHZgV3ew7XYbM80dvdKzgr3lXJ/mx6B
 JZ4wbO1DnjE2BzBWqee+/LMSmtOvhWG1izRAJvr55b5/peh1dCDnLBwE6bt4Ra3S7e/ccI5yE
 P2q1Tn8vnHI3zQbKCYhNAhdzMvJKUEN8mvh7bqTdr7rLf529xjr9YUmqU858SFRTavR4LhRrv
 6K4RndzgkDhIXs+as3TWsEKNq34C+4Qrbxlyoz0LW1yNJIvrDr0HVjwE3M5cL89hi3zMBRedP
 6gh5M3hOYc+jMPg8w4sEJBXSzwSe1guj1yJW0+TwxdppWakyLf0YPaEZbLAPf4Njv1r21cfpE
 ltaxHeFvKLnKb+bM1K108GXsOHF7E8kLHuRlMtZsC0mkRRYejnxGFvNRrX2SNaG5oU09VqXUR
 ifylmLXr9ag9PJBUSmi0fXQLiz17L3QcjoA9bcf9GeUuoZlRMQIYJe/md+VAV2xukfUiRTXqj
 tdBkRNfpwyzWwoeoiU6fOVWK49CQ47GtLBhBSwHqso7BPvsbZDb8vg2lVQdm5qmED9A+QR/Yn
 zfcfylmN7M7OJKDTQNwk1zHUQDbGM3C8SpnGKOSYfyRl+ygoYE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 1:43 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, May 18, 2020 at 2:39 PM Ramuthevar, Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> > On 15/5/2020 10:30 pm, Arnd Bergmann wrote:
> > > On Fri, May 15, 2020 at 4:25 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > >> On Fri, May 15, 2020 at 4:48 PM kbuild test robot <lkp@intel.com> wrote:
>
> > > iowrite_be32() is the correct way to store word into a big-endian mmio register,
> > > if that is the intention here.
> > Thank you for suggestions to use iowrite32be(), it suits exactly.
>
> Can you before doing this comment what is the real intention here?
>
> And note, if you are going to use iowrite*() / ioread*() in one place,
> you will probably need to replace all of the read*() / write*() to
> respective io* API.

The way that ioread/iowrite are defined, they are required to be a superset
of what readl/writel do and can take __iomem pointers from either
ioremap() or ioport_map()/pci_iomap() style mappings, while readl/writel
are only required to work with ioremap().

There is no technical requirement to stick to one set or the other for
ioremap(), but the overhead of ioread/iowrite is also small enough
that it generally does not hurt.

       Arnd
