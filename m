Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D7FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFE820702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgGUL2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:28:46 -0400
Received: from verein.lst.de ([213.95.11.211]:51721 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbgGUL2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:28:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2BCBC68AFE; Tue, 21 Jul 2020 13:28:43 +0200 (CEST)
Date:   Tue, 21 Jul 2020 13:28:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
Message-ID: <20200721112842.GB27356@lst.de>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de> <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com> <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de> <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com> <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 01:15:23PM +0200, Nicolas Saenz Julienne wrote:
> I'm at loss at what could be failing here. Your device should be able
> to address the whole 8GB memory space, which AFAIK is the max available
> on that smartphone family. But maybe the device-tree is lying, who
> knows...

Maybe we should give your patch to allocate from CMA but check the
address a try?  (just because we can..)
