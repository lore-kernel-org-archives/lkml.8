Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76765C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3D622CBB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgGULhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:37:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:39252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgGULhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:37:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D424AD25;
        Tue, 21 Jul 2020 11:37:19 +0000 (UTC)
Message-ID: <d073fc344a4ec458aa3456b6838e2000f042f8e2.camel@suse.de>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>,
        Amit Pundir <amit.pundir@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 21 Jul 2020 13:37:11 +0200
In-Reply-To: <20200721112842.GB27356@lst.de>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
         <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
         <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
         <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
         <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
         <20200721112842.GB27356@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-21 at 13:28 +0200, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 01:15:23PM +0200, Nicolas Saenz Julienne
> wrote:
> > I'm at loss at what could be failing here. Your device should be
> > able
> > to address the whole 8GB memory space, which AFAIK is the max
> > available
> > on that smartphone family. But maybe the device-tree is lying, who
> > knows...
> 
> Maybe we should give your patch to allocate from CMA but check the
> address a try?  (just because we can..)

Yes, good idea!

Amir, could you also test this patch[1] (having reverted the one that
casues trouble) and report on whether it boots or not?

Regards,
Nicolas

[1] https://lore.kernel.org/linux-iomhttps://lore.kernel.org/linux-iom
mu/fe14037b02fd887a73cd91c115dccc4485f8446e.camel@suse.de/T/#t


