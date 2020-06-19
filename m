Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C2EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5DB214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgFSIwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:52:31 -0400
Received: from foss.arm.com ([217.140.110.172]:48188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgFSIw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:52:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDAEB2B;
        Fri, 19 Jun 2020 01:52:28 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C21CB3F71F;
        Fri, 19 Jun 2020 01:52:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] panfrost: Make sure GPU is powered on when reading
 GPU_LATEST_FLUSH_ID
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
References: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2bd3f3c6-aa6f-4082-c2e4-949509c2ebae@arm.com>
Date:   Fri, 19 Jun 2020 09:52:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2020 09:58, Tomeu Vizoso wrote:
> Bifrost devices do support the flush reduction feature, so on first job
> submit we were trying to read the register while still powered off.
> 
> If the GPU is powered off, the feature doesn't bring any benefit, so
> don't try to read.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_gpu.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index f2c1ddc41a9b..e0f190e43813 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -10,6 +10,7 @@
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>   
>   #include "panfrost_device.h"
>   #include "panfrost_features.h"
> @@ -368,7 +369,16 @@ void panfrost_gpu_fini(struct panfrost_device *pfdev)
>   
>   u32 panfrost_gpu_get_latest_flush_id(struct panfrost_device *pfdev)
>   {
> -	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_FLUSH_REDUCTION))
> -		return gpu_read(pfdev, GPU_LATEST_FLUSH_ID);
> +	u32 flush_id;
> +
> +	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_FLUSH_REDUCTION)) {
> +		/* Flush reduction only makes sense when the GPU is kept powered on between jobs */
> +		if (pm_runtime_get_if_in_use(pfdev->dev)) {
> +			flush_id = gpu_read(pfdev, GPU_LATEST_FLUSH_ID);
> +			pm_runtime_put(pfdev->dev);
> +			return flush_id;
> +		}
> +	}
> +
>   	return 0;
>   }
> 

