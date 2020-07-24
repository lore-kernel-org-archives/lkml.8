Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D401EC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9270206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGXJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:36:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGXJg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:36:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28B63ACC5;
        Fri, 24 Jul 2020 09:37:06 +0000 (UTC)
Message-ID: <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
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
Date:   Fri, 24 Jul 2020 11:36:55 +0200
In-Reply-To: <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
         <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
         <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
         <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
         <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
         <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
         <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
         <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
         <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de>
         <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On Thu, 2020-07-23 at 10:44 +0530, Amit Pundir wrote:
> Hi Nicolas,
> 
> Sorry I got stuck on other things yesterday.

No worries :)

> On Tue, 21 Jul 2020 at 21:57, Nicolas Saenz Julienne

[...]

> > 
> > Let's get a bigger hammer, I'm just looking for clues here. Can you
> > apply this and provide the dmesg output.
> > 
> > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > index 6bc74a2d5127..2160676bf488 100644
> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -268,6 +268,8 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
> >                         schedule_work(&atomic_pool_work);
> >         }
> > 
> > +       dev_info(dev, "%s: size %lx, phys addr %llx, flags 0x%x\n", __func__, size, phys, flags);
> > +
> >         return ptr;
> >  }
> 
> I never made it to dma_alloc_from_pool() call from
> dma_direct_alloc_pages(), dma_should_alloc_from_pool() returns False
> from gfpflags_allow_blocking() block.

I'm a little sceptical about this. The only way you can get memory from these
pools is through dma_alloc_from_pool(), and given how changes in the pool
initialization affected the phone, it's pretty clear some amount of pool
allocation is happening.

Regards,
Nicolas

