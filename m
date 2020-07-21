Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A171020717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVSGtGXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgGUIzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgGUIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:55:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C262C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:55:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so2047244wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CTmtnmdZY9YRQRw2JoAj2R7ehpvx1UOd5wk1nRyAk4=;
        b=iVSGtGXmRhf4JUrMrWhpMV7KvM5JVFkx1ir5uEYCIl+mRjDfai5NBGmIY/3/4BaItf
         Df+M31NVTb61rKYwAglK2FlqsnF9uu/UwTwJPcJ54QyiGsKOI/86OpmYU8b7F8nZH7pK
         DMbOFA+IG6PEPQpB2glBphC6o8gScfrV0fUW80SQMQLpnIsKw0Y3mjY2vHtGHDUp8LHv
         DNoDMpOxTEX4jhpvro/YTATL9uDv5QKzo+U3VDzaQ03G56MBHn9HXQ0JuFI3Rp1FCURN
         vVlFBV8qtc/eUMOaAiHTlicehnLniLpCP3Hw2JtdBRkQY2+h/tLlzXuFV92AY/GnIhfs
         WGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CTmtnmdZY9YRQRw2JoAj2R7ehpvx1UOd5wk1nRyAk4=;
        b=XOaqqr5gSIuiGp7Q321RU+jDjZigDc2of801g5Sk9fHZL2p5ssKjrfby62ZtAxeIXp
         2dULA0G1UtJyJ/IaM2anzoiteehRf+g7mutJ8zCFbw8Ro8q7NAL3M+C8DUOsyoLo840c
         pfUcVMtjIvyulgk8XFnLwJ7DCkxE3aUOsRvw9/JuJ7J/1LFdmR+NvDNYl21n+mlm+MsS
         igv1J+Xt3WtmGAfKFzKXOVVd1xXGlK6l0s3wSOBPdM18ZfJvTlkz+AWWpRxv4jXkmm9d
         5cRtbyP5lRC8nQZCVyBENI1nwd11UECr4iGzhs9zL4mWsWQLZHFp8omw6wHm2PrqJeCt
         AUnA==
X-Gm-Message-State: AOAM533sBQGJ4cLBZ0DkBL47t3EG+HLD8QTqqavpT1qlYFpX+BJD72bc
        /mKC47ScLpu4NiE/8bwr5A2j/oNVnmlc4y55FsHy2dJC
X-Google-Smtp-Source: ABdhPJyZqBx+5DxqL/B9eY3DTkJe+mB4GoZ8A1ocvar0p111bDPlN6UUFB9G2wacmGPdJi21kuc6Feck5gRaFsWuNmk=
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr3023317wmg.70.1595321701764;
 Tue, 21 Jul 2020 01:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de> <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
In-Reply-To: <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 21 Jul 2020 14:24:25 +0530
Message-ID: <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 at 14:09, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Amit,
>
> On Tue, 2020-07-21 at 12:51 +0530, Amit Pundir wrote:
> > On Wed, 8 Jul 2020 at 22:43, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > There is no guarantee to CMA's placement, so allocating a zone
> > > specific
> > > atomic pool from CMA might return memory from a completely
> > > different
> > > memory zone. So stop using it.
> > >
> > > Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to
> > > map to gfp mask")
> >
> > Hi Nicolas,
> >
> > I see a boot regression with this commit d9765e41d8e9 "dma-pool:
> > Do not allocate pool memory from CMA" on my Xiaomi Poco F1
> > (Qcom sdm845) phone running v5.8-rc6. I can't boot past the
> > bootloader splash screen with this patch.
> >
> > Phone boots fine if I revert this patch. I carry only one out of tree
> > dts patch https://lkml.org/lkml/2020/6/25/52. And since this is a
> > stock
> > phone, I don't have access to serial/dmesg logs until I boot to AOSP
> > (adb) shell.
> >
> > Any thoughts as to what might be going wrong here? I'd be happy to
> > help debug things. For what it's worth, I don't see this regression
> > on
> > other two sdm845 devices (db845c and Pixel 3) I tested on.
>
> Can you provide a boot log (even if without my patch) and the device-
> tree files? It'd help a lot figuring things out.

Thank you for the prompt reply Nicolas.

Here is the boot log with the reverted patch
https://pastebin.ubuntu.com/p/BrhPf83nKF/

Here is my phone's dts
https://github.com/pundiramit/linux/commit/2a394c199deeaf4c91e0e008e8fba2a72f494d8c

And here is my kernel tree just in case
https://github.com/pundiramit/linux/commits/beryllium-mainline

Regards,
Amit Pundir


>
> Regards,
> Nicolas
>
> > Regards,
> > Amit Pundir
> >
> > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > >
> > > An more costly alternative would be adding an option to
> > > dma_alloc_from_contiguous() so it fails when the allocation doesn't
> > > fall
> > > in a specific zone.
> > >
> > >  kernel/dma/pool.c | 11 ++---------
> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > > index 8cfa01243ed2..4bc1c46ae6ef 100644
> > > --- a/kernel/dma/pool.c
> > > +++ b/kernel/dma/pool.c
> > > @@ -6,7 +6,6 @@
> > >  #include <linux/debugfs.h>
> > >  #include <linux/dma-direct.h>
> > >  #include <linux/dma-noncoherent.h>
> > > -#include <linux/dma-contiguous.h>
> > >  #include <linux/init.h>
> > >  #include <linux/genalloc.h>
> > >  #include <linux/set_memory.h>
> > > @@ -69,12 +68,7 @@ static int atomic_pool_expand(struct gen_pool
> > > *pool, size_t pool_size,
> > >
> > >         do {
> > >                 pool_size = 1 << (PAGE_SHIFT + order);
> > > -
> > > -               if (dev_get_cma_area(NULL))
> > > -                       page = dma_alloc_from_contiguous(NULL, 1 <<
> > > order,
> > > -                                                        order,
> > > false);
> > > -               else
> > > -                       page = alloc_pages(gfp, order);
> > > +               page = alloc_pages(gfp, order);
> > >         } while (!page && order-- > 0);
> > >         if (!page)
> > >                 goto out;
> > > @@ -118,8 +112,7 @@ static int atomic_pool_expand(struct gen_pool
> > > *pool, size_t pool_size,
> > >         dma_common_free_remap(addr, pool_size);
> > >  #endif
> > >  free_page: __maybe_unused
> > > -       if (!dma_release_from_contiguous(NULL, page, 1 << order))
> > > -               __free_pages(page, order);
> > > +       __free_pages(page, order);
> > >  out:
> > >         return ret;
> > >  }
> > > --
> > > 2.27.0
> > >
>
