Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38041C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E167420748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgIDJQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:16:45 -0400
Received: from 8bytes.org ([81.169.241.247]:40914 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729901AbgIDJQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:16:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 343F99CE; Fri,  4 Sep 2020 11:16:44 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:16:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     iommu@lists.linux-foundation.org, person@a.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: Rename iommu_tlb_* functions to iommu_iotlb_*
Message-ID: <20200904091642.GI6714@8bytes.org>
References: <20200817210051.13546-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817210051.13546-1-murphyt7@tcd.ie>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:00:49PM +0100, Tom Murphy wrote:
> To keep naming consistent we should stick with *iotlb*. This patch
> renames a few remaining functions.
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>  drivers/iommu/dma-iommu.c       |  2 +-
>  drivers/iommu/iommu.c           |  4 ++--
>  drivers/vfio/vfio_iommu_type1.c |  2 +-
>  include/linux/io-pgtable.h      |  2 +-
>  include/linux/iommu.h           | 10 +++++-----
>  5 files changed, 10 insertions(+), 10 deletions(-)

Applied, thanks.

