Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A470C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF0D20747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFKJbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:31:25 -0400
Received: from foss.arm.com ([217.140.110.172]:49146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFKJbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:31:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1ABF1FB;
        Thu, 11 Jun 2020 02:31:19 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A02333F73D;
        Thu, 11 Jun 2020 02:31:18 -0700 (PDT)
Subject: Re: [PATCH v2] drm/panfrost: Use kvfree() to free bo->sgts
To:     Denis Efremov <efremov@linux.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, stable@vger.kernel.org
References: <20200605185207.76661-1-efremov@linux.com>
 <20200608151728.234026-1-efremov@linux.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <9cb39a92-5cdf-38da-98f8-b513dcdf69db@arm.com>
Date:   Thu, 11 Jun 2020 10:31:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608151728.234026-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2020 16:17, Denis Efremov wrote:
> Use kvfree() to free bo->sgts, because the memory is allocated with
> kvmalloc_array() in panfrost_mmu_map_fault_addr().
> 
> Fixes: 187d2929206e ("drm/panfrost: Add support for GPU heap allocations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

> ---
> Change in v2:
>   - kvfree() fixed in panfrost_gem_free_object(), thanks to Steven Price
> 
>   drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
>   drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 17b654e1eb94..556181ea4a07 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -46,7 +46,7 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
>   				sg_free_table(&bo->sgts[i]);
>   			}
>   		}
> -		kfree(bo->sgts);
> +		kvfree(bo->sgts);
>   	}
>   
>   	drm_gem_shmem_free_object(obj);
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

