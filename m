Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BBDC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5FF20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgGJM6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:58:36 -0400
Received: from 8bytes.org ([81.169.241.247]:52268 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgGJM6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:58:35 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7231920C; Fri, 10 Jul 2020 14:58:33 +0200 (CEST)
Date:   Fri, 10 Jul 2020 14:58:32 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag
Message-ID: <20200710125831.GI27672@8bytes.org>
References: <20200703162548.19953-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703162548.19953-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 05:25:48PM +0100, Will Deacon wrote:
> The IOMMU_SYS_CACHE_ONLY flag was never exposed via the DMA API and
> has no in-tree users. Remove it.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
> 
> As discussed in [1], sounds like this should be a domain attribute anyway
> when it's needed by the GPU.
> 
> [1] https://lore.kernel.org/r/CAF6AEGsCROVTsi2R7_aUkmH9Luoc_guMR0w0KUJc2cEgpfj79w@mail.gmail.com
> 
>  drivers/iommu/io-pgtable-arm.c | 3 ---
>  include/linux/iommu.h          | 6 ------
>  2 files changed, 9 deletions(-)

Applied, thanks.

