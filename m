Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8619C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8756206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGUMpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgGUMpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:45:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32595AB7A;
        Tue, 21 Jul 2020 12:45:16 +0000 (UTC)
Message-ID: <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 21 Jul 2020 14:45:07 +0200
In-Reply-To: <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
         <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
         <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
         <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
         <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
         <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-21 at 17:45 +0530, Amit Pundir wrote:
> On Tue, 21 Jul 2020 at 16:45, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > On Tue, 2020-07-21 at 14:24 +0530, Amit Pundir wrote:
> > > On Tue, 21 Jul 2020 at 14:09, Nicolas Saenz Julienne
> > > <nsaenzjulienne@suse.de> wrote:
> > > > Hi Amit,
> > > > > Hi Nicolas,
> > > > > 
> > > > > I see a boot regression with this commit d9765e41d8e9 "dma-
> > > > > pool:
> > > > > Do not allocate pool memory from CMA" on my Xiaomi Poco F1
> > > > > (Qcom sdm845) phone running v5.8-rc6. I can't boot past the
> > > > > bootloader splash screen with this patch.
> > > > > 
> > > > > Phone boots fine if I revert this patch. I carry only one out
> > > > > of
> > > > > tree
> > > > > dts patch https://lkml.org/lkml/2020/6/25/52. And since this
> > > > > is a
> > > > > stock
> > > > > phone, I don't have access to serial/dmesg logs until I boot
> > > > > to
> > > > > AOSP
> > > > > (adb) shell.
> > > > > 
> > > > > Any thoughts as to what might be going wrong here? I'd be
> > > > > happy
> > > > > to
> > > > > help debug things. For what it's worth, I don't see this
> > > > > regression
> > > > > on
> > > > > other two sdm845 devices (db845c and Pixel 3) I tested on.
> > > > 
> > > > Can you provide a boot log (even if without my patch) and the
> > > > device-
> > > > tree files? It'd help a lot figuring things out.
> > > 
> > > Thank you for the prompt reply Nicolas.
> > > 
> > > Here is the boot log with the reverted patch
> > > https://pastebin.ubuntu.com/p/BrhPf83nKF/
> > > 
> > > Here is my phone's dts
> > > https://github.com/pundiramit/linux/commit/2a394c199deeaf4c91e0e008e8fba2a72f494d8c
> > 
> > I'm at loss at what could be failing here. Your device should be
> > able
> > to address the whole 8GB memory space, which AFAIK is the max
> > available
> > on that smartphone family. But maybe the device-tree is lying, who
> > knows...
> 
> If it helps, my phone has 6GB memory space.
> 
> > Can you try booting *without* my patch and this in the kernel
> > command
> > line: "cma=16M@0x100000000-0x200000000".
> 
> It doesn't boot with this added kernel command line.


For the record, this placed the CMA in the [4GB, 8GB] address space
instead of you setup's default: [3GB, 4GB]. All atomic pools fall in
that memory area without my patch, which makes me think some of the
devices on your board might not like higher addresses.

What happens if you boot with my troublesome patch with this in your
device tree? (insert it at the bottom of sdm845-beryllium.dts)

&soc {
	dma-ranges = <0 0 0 0 0x1 0>;
};

Regards,
Nicolas

> Regards,
> Amit Pundir
> 
> > Regards,
> > Nicolas
> > 
> > And here is my kernel tree just in case
> > > https://github.com/pundiramit/linux/commits/beryllium-mainline
> > > 
> > > Regards,
> > > Amit Pundir
> > > 
> > > 
> > > > Regards,
> > > > Nicolas
> > > > 
> > > > > Regards,
> > > > > Amit Pundir
> > > > > 
> > > > > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > > > Signed-off-by: Nicolas Saenz Julienne <
> > > > > > nsaenzjulienne@suse.de>
> > > > > > ---
> > > > > > 
> > > > > > An more costly alternative would be adding an option to
> > > > > > dma_alloc_from_contiguous() so it fails when the allocation
> > > > > > doesn't
> > > > > > fall
> > > > > > in a specific zone.
> > > > > > 
> > > > > >  kernel/dma/pool.c | 11 ++---------

