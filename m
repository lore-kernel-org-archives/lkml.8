Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393A5C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E27E2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BiTqCQ6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgGXLHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXLHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:07:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F221C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:07:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so7896792wrj.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EdQT63Ax+A3aODmg5U77uJh2icVxckFwj6Fw6w57Kic=;
        b=BiTqCQ6xZwjFwNXUjnfNOQmwwbGF1zO/bDH/fbt/YsdrblLH+TYtPD8oR2abGh2AGY
         c4KVUJWL0dLVAKBfwxEjla2NwHMKtsIeHSglXl2ti3i5MiAD5W3Agr2WayGqZWON7EZe
         WsS2ZgvcgFWo4s9AzQYU2z2iFbG1DPfpW1T3G5dxoN7rPmyCB1uIh6/z9u3rvo0ZAt6I
         LuUyoizw5wj/HRRE0juJfJgcOQYucim9Qdv0t3mHx/seCoWqKQSexSJkkri/uq469nj+
         KYQ7vNsS3wWE14fFfWpRQDxtZNSuhGwgTUHVj3Ttdo5pBgyEK53y5p7JXEIz1mEBl97U
         WqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EdQT63Ax+A3aODmg5U77uJh2icVxckFwj6Fw6w57Kic=;
        b=XxD/lvsRz4EzYU6Gx5O2CeTzbZNHbF/gG4jVd22WlXV7unjHsI4oJkdhvU/aa8kNa/
         yHN4IGjXw99MEUP2LTEd/ub18h3WcMnAnHvxoga80Fx0lLGIPCl/nAm5jFHNqIIIKVCY
         CS0DD7lKMEWQX8V0KYfsaPhmv/H8VPwXlJvS+ZhQ5vEqZ3G7n6WK4Frnaby4+iFbhULp
         ehsgQ0lodbRIKhlmGoCrV8+kfEipvMUCoU7/aqk/4CYomoslNIOt26qEXGN1btv46LHn
         ch7pP3cZKRgiC9qXOt6wzmIjkqh3UcZ2WMAITO8999XxL5Go8LyWSDljeTlcagKC2S56
         1QGw==
X-Gm-Message-State: AOAM530LRzCIIeZBb6SX5tNW06ROUXcB/sz9LUjg3qD7WKJzKezXCn0/
        Exjn92XX0ZIvlrkoyMpLuHuX0nH1FPcl7aUR25/EiA==
X-Google-Smtp-Source: ABdhPJxNaOA56Km6atDzUVWw9zPvlssdJZaf1ujzptAwAuQ3K/AVgnDaKbLddCq5PjILSV0SwQLvRTdywfHIhRtq6MI=
X-Received: by 2002:adf:f44b:: with SMTP id f11mr8503038wrp.114.1595588848909;
 Fri, 24 Jul 2020 04:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de> <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de> <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
 <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de> <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
 <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de> <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
 <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de> <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
 <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
In-Reply-To: <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 24 Jul 2020 16:36:52 +0530
Message-ID: <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com>
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

On Fri, 24 Jul 2020 at 15:06, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Amit,
>
> On Thu, 2020-07-23 at 10:44 +0530, Amit Pundir wrote:
> > Hi Nicolas,
> >
> > Sorry I got stuck on other things yesterday.
>
> No worries :)
>
> > On Tue, 21 Jul 2020 at 21:57, Nicolas Saenz Julienne
>
> [...]
>
> > >
> > > Let's get a bigger hammer, I'm just looking for clues here. Can you
> > > apply this and provide the dmesg output.
> > >
> > > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > > index 6bc74a2d5127..2160676bf488 100644
> > > --- a/kernel/dma/pool.c
> > > +++ b/kernel/dma/pool.c
> > > @@ -268,6 +268,8 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
> > >                         schedule_work(&atomic_pool_work);
> > >         }
> > >
> > > +       dev_info(dev, "%s: size %lx, phys addr %llx, flags 0x%x\n", __func__, size, phys, flags);
> > > +
> > >         return ptr;
> > >  }
> >
> > I never made it to dma_alloc_from_pool() call from
> > dma_direct_alloc_pages(), dma_should_alloc_from_pool() returns False
> > from gfpflags_allow_blocking() block.
>
> I'm a little sceptical about this. The only way you can get memory from these
> pools is through dma_alloc_from_pool(), and given how changes in the pool
> initialization affected the phone, it's pretty clear some amount of pool
> allocation is happening.

Maybe from here iommu_dma_alloc_remap()?

I see two paths to dma_alloc_from_pool(), one from
dma_direct_alloc_pages() which I mentioned above and
2nd one is thru iommu_dma_alloc(), but the flow doesn't
reach up to dma_alloc_from_pool(), and always returns
from iommu_dma_alloc_remap().


Regards,
Amit Pundir

>
> Regards,
> Nicolas
>
