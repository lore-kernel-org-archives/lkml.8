Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AF8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F47C21D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgGNLBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:01:46 -0400
Received: from verein.lst.de ([213.95.11.211]:53842 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgGNLBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:01:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D05A568CFC; Tue, 14 Jul 2020 13:01:41 +0200 (CEST)
Date:   Tue, 14 Jul 2020 13:01:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Claire Chang <tientzu@chromium.org>, robh+dt@kernel.org,
        frowand.list@gmail.com, hch@lst.de, m.szyprowski@samsung.com,
        treding@nvidia.com, gregkh@linuxfoundation.org,
        saravanak@google.com, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        tfiga@chromium.org, drinkcat@chromium.org
Subject: Re: [PATCH 1/4] dma-mapping: Add bounced DMA ops
Message-ID: <20200714110141.GD16178@lst.de>
References: <20200713091211.2183368-1-tientzu@chromium.org> <20200713091211.2183368-2-tientzu@chromium.org> <4a2451f9-57d8-2e83-e1d6-f144f37173c0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2451f9-57d8-2e83-e1d6-f144f37173c0@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 12:55:43PM +0100, Robin Murphy wrote:
> On 2020-07-13 10:12, Claire Chang wrote:
>> The bounced DMA ops provide an implementation of DMA ops that bounce
>> streaming DMA in and out of a specially allocated region. Only the
>> operations relevant to streaming DMA are supported.
>
> I think there are too many implicit assumptions here - apparently that 
> coherent allocations will always be intercepted by 
> dma_*_from_dev_coherent(), and that calling into dma-direct won't actually 
> bounce things a second time beyond where you thought they were going, 
> manage coherency for a different address, and make it all go subtly wrong. 
> Consider "swiotlb=force", for instance...
>
> Again, plumbing this straight into dma-direct so that SWIOTLB can simply 
> target a different buffer and always bounce regardless of masks would seem 
> a far better option.

I haven't really had time to read through the details, but I agree that
any bouncing scheme should reuse the swiotlb code and not invent a
parallel infrastructure.
