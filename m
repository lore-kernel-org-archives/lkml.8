Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C165EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E84206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgFHH43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:56:29 -0400
Received: from foss.arm.com ([217.140.110.172]:49338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgFHH42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:56:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E23111F1;
        Mon,  8 Jun 2020 00:56:27 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D19F13F6CF;
        Mon,  8 Jun 2020 00:56:26 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Use kvfree() to free bo->sgts in
 panfrost_mmu_map_fault_addr()
To:     Denis Efremov <efremov@linux.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20200605185207.76661-1-efremov@linux.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <143663fd-59e9-37b9-371d-e15cf35e7374@arm.com>
Date:   Mon, 8 Jun 2020 08:56:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605185207.76661-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2020 19:52, Denis Efremov wrote:
> Use kvfree() to free bo->sgts, because the memory is allocated with
> kvmalloc_array().
> 
> Fixes: 187d2929206e ("drm/panfrost: Add support for GPU heap allocations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Efremov <efremov@linux.com>

Well spotted, but there's another one in panfrost_gem_free_object(). 
Please can you fix that at the same time?

Thanks,

Steve

> ---
>   drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index ed28aeba6d59..3c8ae7411c80 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -486,7 +486,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>   		pages = kvmalloc_array(bo->base.base.size >> PAGE_SHIFT,
>   				       sizeof(struct page *), GFP_KERNEL | __GFP_ZERO);
>   		if (!pages) {
> -			kfree(bo->sgts);
> +			kvfree(bo->sgts);
>   			bo->sgts = NULL;
>   			mutex_unlock(&bo->base.pages_lock);
>   			ret = -ENOMEM;
> 

