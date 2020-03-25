Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C4C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B835E206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCYO52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:57:28 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYO52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:57:28 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MQdpG-1ivahk0Lna-00Nl2B for <linux-kernel@vger.kernel.org>; Wed, 25 Mar
 2020 15:57:26 +0100
Received: by mail-qk1-f172.google.com with SMTP id h14so2825157qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:57:25 -0700 (PDT)
X-Gm-Message-State: ANhLgQ27jPz7yE3ko6kCBqgpejOvw9KJ45DVGRVkzDZtBg+8gO/ZknKm
        56d9xucPE0z11gHWQsGdbyr/PsvVnKRO+wOY3iA=
X-Google-Smtp-Source: ADFU+vuBFx+DrJ3HySHZKoMxE/V6Mizt9Ywp8c5Ep/YvQX3uhQp8zLzO0qxWoi2CE7aNDWQ0gsbBYuxtars/NoJ2USw=
X-Received: by 2002:a37:b984:: with SMTP id j126mr3116067qkf.3.1585148244970;
 Wed, 25 Mar 2020 07:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200124092359.12429-1-peter.ujfalusi@ti.com> <20200124200811.ytgs66cg5qpugi5c@localhost>
 <12f40648-fec6-9179-1f62-0a648996ed20@ti.com> <CAOesGMiFw2V6fdbGCOfgsVq+WK-4ijdzivDdX3hbS2E=bO4zkg@mail.gmail.com>
 <a81fa6b0-811c-82af-4cf6-e2f4ac3c0ded@ti.com>
In-Reply-To: <a81fa6b0-811c-82af-4cf6-e2f4ac3c0ded@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 25 Mar 2020 15:57:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Y2LAGPT8qtk51MxbsXjf8nHBbA7E1CvWcSgNi8UNNEA@mail.gmail.com>
Message-ID: <CAK8P3a0Y2LAGPT8qtk51MxbsXjf8nHBbA7E1CvWcSgNi8UNNEA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable Texas Instruments UDMA driver
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: <soc.lore.kernel.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:85xpPI9PnXJ0hQfCpW/SZKMGXzQXSFONXjbm4kBloJzsAAF0S24
 /LDEFJg7we5TAb4vRhfpROzqUs6x8qb5ofIxEPIZ+JU34SlQhtslzdUlBxAs9bvLCorJ7Qx
 +Wa/lmZjsh74Hehr1xX8y+PDwxlCW03Bexc7jYVb4xr2ic/vpl8MjP6/iNnBPiju12DOmhB
 gWpvTQqMT5+hqfiG7Eghw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xj1FhfeVdgE=:NbBz5PdmhxERni6DzyJ4yM
 pZ/8oT2r5TlWFNDXJUxf/FmHGoqbVgMJXTG3ujJBATVAOT0EvUfQLg6G2TFeP7Bx1TLifw4CQ
 TxH4/K/TFRyVISDbTcUW0KsKUom//HbMRrYOATX5Es0cxwJEeqFP9D+7rtXF61Nz3sAakuhei
 l0BjxOBJsk3OiQdcWmkXDB6TsSk2I6vN/Rs8UDfGVI54Ezaho1aapszBm7+fuXm16va34SRd9
 p08oP9O3RSGHHaWHvcCRdBVD50ukR/GHA3MIZNqwx7va0yHHumXveN8JWFS4Dr0sqGWQRFyLv
 xl28iNCXuM1FavO9XhAQE+4AIShu6V9iDXnHV2g3VIylvqK7YFz78TJh2YGvv8/qMtpecagHq
 ju7u6/6+sStK9C+N2H0BXHdvLpEQNmoZ2Y89DXN/e9KPMjic6yioCSLTlToueLaPeBzmn9lig
 hsjHxj74fCz+mT7hvhKtMB1xE6vVAUlmkt3arQhU/E8eoPxE/I1+ZgKca2+/LN1uMOfLaFr9r
 EWGMQ0W3NcqdWdcG3sQq/iQdSVQx0IgS2Ko9JWLF5Eb3uvQL6I1FgdXlLFRqNDMC52Lo27THY
 1YNqRhOlMKA4I+VC3XN+Z1vLYEIxdUiSAvoODTt8gRui8c/fqaoNY60B++s9RX7OOkmVeR1yG
 RXKbdkBym/ItH+6DOgGk3CNTYjcG3JfbiK6k7R4mY8XZIBkwUy9CfLYAfe/1rfIDGVx/TKStx
 3zd43hnntkFeNiIr2nIwuMU5pMqofgZkL4dkPS9uDSeaxR87sSwO181wd+NMuGLF0QtmxgtWb
 zcbJJ7sJa6m2FT0ith8aYGhJovguDU7nuL0fYg+QdmucC8xhfU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 9:20 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 27/01/2020 17.30, Olof Johansson wrote:
> >>> I also see that this is statically enabling this driver -- we try to keep as
> >>> many drivers as possible as modules to avoid the static kernel from growing too
> >>> large. Would that be a suitable approach here, or is the driver needed to reach
> >>> rootfs for further module loading?
> >>
> >> We would need built in DMA for nfs rootfs, SD/MMC has it's own buit-in
> >> ADMA. We do not have network drivers upstream as they depend on the DMA.
> >
> > Ok, so that can either be turned into a ramdisk argument, or into a
> > "we really want to enable non-ramdisk rootfs boots on this hardware
> > because it's a common use case".
>
> SD/MMC does not need slave DMA, it is self containing with it's own
> built-in DMA.
> I'm not sure if it is enabled in defconfig. It is not enabled at all in
> defconfig atm.
>
> Normally I would use nfs rootfs, but we don't have network drivers
> upstream for K3 platform.
>
> I think having the UDMA stack as module should be fine when I have the
> dependencies in to be able to build them as modules.

Picking up this thread as I noticed the patch is still marked as 'New'
in patchwork.

I see no problem making this driver built-in at all if you want to
respin it.

> > but this particular driver is probably
> > OK (it's also not large).
>
> Well, it depends how you look at it ;)
>
> UDMA stack is not enabled in defconfig (w/o this patch):
> $ size vmlinux
> text      data     bss     dec       hex      filename
> 17853717  9221872  469288  27544877  1a44d2d  vmlinux
>
> UDMA stack is enabled in defconfig (w this patch):
> $ size vmlinux
> text      data     bss     dec       hex      filename
> 17890970  9237544  469288  27597802  1a51bea  vmlinux
>
> It would be nice for other driver to enable the DMA if it is acceptable
> to have it built in for start and when I can build it as module we can
> switch it to module?

In general, I'd prefer to avoid listing references to other drivers
in Kconfig when those are only runtime dependencies rather than
compile-time.

If the network driver just uses the generic dma slave API, then
I would not add a 'depends on' or 'select' for the particular DMA
engine that it uses, unless it relies on nonstandard exported
functions from that driver. Just enable both as modules and have
the runtime module loading along with deferred probe figure out
runtime dependency.

       Arnd
