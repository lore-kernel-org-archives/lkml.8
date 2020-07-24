Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C8BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D85D206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGXQ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:27:13 -0400
Received: from verein.lst.de ([213.95.11.211]:36298 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXQ1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:27:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACA5968AFE; Fri, 24 Jul 2020 18:27:09 +0200 (CEST)
Date:   Fri, 24 Jul 2020 18:27:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
Message-ID: <20200724162709.GA15051@lst.de>
References: <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de> <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com> <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de> <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com> <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de> <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com> <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de> <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com> <20200724134114.GA3152@lst.de> <CAMi1Hd2tmf0J78dXK_y_onJkPW=JSf6Ki5P+j1iYfwu3wb0V4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd2tmf0J78dXK_y_onJkPW=JSf6Ki5P+j1iYfwu3wb0V4w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 09:49:17PM +0530, Amit Pundir wrote:
> On Fri, 24 Jul 2020 at 19:11, Christoph Hellwig <hch@lst.de> wrote:
> >
> > Yes, the iommu is an interesting case, and the current code is
> > wrong for that.  Can you try the patch below?  It contains a modified
> > version of Nicolas' patch to try CMA again for the expansion and a new
> > (for now hackish) way to not apply the addressability check for dma-iommu
> > allocations.
> 
> Thank you. The below patch worked on today's linux/master (f37e99aca03f).

Ok, I'll try to massage it into a few cleaner patches over the weekend
and will send them to you again for retesting.

Thanks a lot for your patience!
