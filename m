Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6780C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8037320738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QW2VmaGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQNUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:20:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XvzyhaFk/wu7skK/5j6uwYlT+ZJkYaLS7Iej2CpX2yI=; b=QW2VmaGzcPNbAM0cpTRfclXlIy
        dOyw2GWUIcqv9bO9vI+4WYLEeyBx0PY04xYG+ZM6PmYLvMPWOIhPPcqp2kqFUT5JssJxyZ5id7qgn
        EYdU43apJV2k/VVcfrVd4Drha7iaa0Q1/Ig9V51k0XqeXgBx9lH8mgYkOgR8DQfPikCgKLT2UDluT
        uCAm47h316v3IXPEQ33SkyWLSbKeR68GYo3fJG7Ng3cmwqSIAKGS5TAUMza4aMWHF9G2wvSTySgso
        Pdnt/J5kJIpFdJE681LWl67wzH4aSzCsTOX1pgB0X9R6sh+tLQqUfkkAN1l8uKyGQHcg3Nk/5OM9W
        Q+CZKxYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEC91-00080e-P0; Tue, 17 Mar 2020 13:20:31 +0000
Date:   Tue, 17 Mar 2020 06:20:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, smasetty@codeaurora.org,
        John Stultz <john.stultz@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v5 2/2] drm/msm/a6xx: Use the DMA API for GMU memory
 objects
Message-ID: <20200317132031.GA8125@infradead.org>
References: <1583767066-1555-1-git-send-email-jcrouse@codeaurora.org>
 <1583767066-1555-3-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583767066-1555-3-git-send-email-jcrouse@codeaurora.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -942,7 +932,6 @@ static struct a6xx_gmu_bo *a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu,
>  		size_t size)
>  {
>  	struct a6xx_gmu_bo *bo;
> -	int ret, count, i;
>  
>  	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
>  	if (!bo)
> @@ -950,86 +939,14 @@ static struct a6xx_gmu_bo *a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu,
>  
>  	bo->size = PAGE_ALIGN(size);
>  
> -	count = bo->size >> PAGE_SHIFT;
> +	bo->virt = dma_alloc_wc(gmu->dev, bo->size, &bo->iova, GFP_KERNEL);

No really new in this patch, but why do you need the a6xx_gmu_bo,
and even more so, why does it need to be allocated dynamically?

Also please check for errors when setting the dma mask
