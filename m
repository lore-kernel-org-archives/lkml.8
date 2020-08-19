Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC13AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 04:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4758207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 04:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597811372;
	bh=yZCa1YE/YNd1E5AUvE8c/6qe+ChwGp2Dizx/VHpBxUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X/dyz8+Y+SWbzj5Ks34CO1WxCb7gy7NmK1zJ497COUflhzTnp4TL2zAfrgKyKEJw8
	 Mjp85085UXmETBBaQLnPvFFbs7St4o6IjjpssR7E8fSLcG2ThjuymKERmLMYAdk5qa
	 Ka+rItJzN2YELZ9AGCrjdDhK8YBtYFHrfU/WE9hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHSE3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 00:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgHSE33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 00:29:29 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92DB020772;
        Wed, 19 Aug 2020 04:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597811369;
        bh=yZCa1YE/YNd1E5AUvE8c/6qe+ChwGp2Dizx/VHpBxUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mY+oDC8FnwqCbFUslcsKZZWYmn5dArjnpojyMev05c9N0UbhAAE28IJNi7TuEU1Qs
         OnauKYb7oH+ox4MpnlD1HFDimRdWOe7SfN9Mfp0udCvy15FSRXPMGNk+wVgv/GN8hM
         W5CF7hTLEvGrZifbeFUC5ebOwjo8Z2j87Yt29mX4=
Date:   Wed, 19 Aug 2020 09:59:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        dan.j.williams@intel.com, nicolas.ferre@microchip.com,
        plagnioj@jcrosoft.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH V2 0/3] do exception handling appropriately in
 at_dma_xlate()
Message-ID: <20200819042925.GC2639@vkoul-mobl>
References: <20200817115728.1706719-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817115728.1706719-1-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-20, 19:57, Yu Kuai wrote:
> changes from V1:
> -separate different changes to different patches, as suggested by Vinod.

Please write proper cover letter explaining the patch series and also
the changes from v1..

I have applied the patches.

Thanks

> Yu Kuai (3):
>   dmaengine: at_hdmac: check return value of of_find_device_by_node() in
>     at_dma_xlate()
>   dmaengine: at_hdmac: add missing put_device() call in at_dma_xlate()
>   dmaengine: at_hdmac: add missing kfree() call in at_dma_xlate()
> 
>  drivers/dma/at_hdmac.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.4

-- 
~Vinod
