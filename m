Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEF8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E679321D92
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgIIMcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:32:10 -0400
Received: from foss.arm.com ([217.140.110.172]:42368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbgIIMYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:24:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD3B5113E;
        Wed,  9 Sep 2020 05:23:41 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8081D3F68F;
        Wed,  9 Sep 2020 05:23:40 -0700 (PDT)
Subject: Re: [PATCH 3/5] drm/panfrost: add support for reset quirk
To:     Neil Armstrong <narmstrong@baylibre.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20200908151853.4837-1-narmstrong@baylibre.com>
 <20200908151853.4837-4-narmstrong@baylibre.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <ff982600-d705-1dc8-44c8-b69015791997@arm.com>
Date:   Wed, 9 Sep 2020 13:23:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908151853.4837-4-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2020 16:18, Neil Armstrong wrote:
> The T820, G31 & G52 GPUs integratewd by Amlogic in the respective GXM, G12A/SM1 & G12B
> SoCs needs a quirk in the PWR registers at the GPU reset time.
> 
> This adds a callback in the device compatible struct of permit this.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_device.h | 3 +++
>   drivers/gpu/drm/panfrost/panfrost_gpu.c    | 4 ++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 2cf1a6a13af8..4c9cd5452ba5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -73,6 +73,9 @@ struct panfrost_compatible {
>   
>   	/* IOMMU quirks flags */
>   	unsigned long pgtbl_quirks;
> +
> +	/* Vendor implementation quirks at reset time callback */
> +	void (*vendor_reset_quirk)(struct panfrost_device *pfdev);
>   };
>   
>   struct panfrost_device {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index e0f190e43813..c129aaf77790 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -62,6 +62,10 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
>   	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
>   	gpu_write(pfdev, GPU_CMD, GPU_CMD_SOFT_RESET);
>   
> +	/* The Amlogic GPU integration needs quirks at this stage */
> +	if (pfdev->comp->vendor_reset_quirk)
> +		pfdev->comp->vendor_reset_quirk(pfdev);
> +
>   	ret = readl_relaxed_poll_timeout(pfdev->iomem + GPU_INT_RAWSTAT,
>   		val, val & GPU_IRQ_RESET_COMPLETED, 100, 10000);

Placing the quirk before the reset has completed is dodgy. Can this be 
ordered after the GPU_IRQ_RESET_COMPLETED signal has been seen? The 
problem is the reset could (in theory) cause a power transition (e.g. if 
the GPU is reset while a core is powered) and changing the PWR_OVERRIDEx 
registers during a transition is undefined. But I don't know the details 
of how the hardware is broken so it is possible the override is needed 
for the reset to complete so this would need testing.

I also wonder if this could live in panfrost_gpu_init_quirks() instead? 
Although that is mostly about quirks common to all Mali GPU 
implementations rather than a specific implementation. Although now I've 
looked I've noticed we have a bug as we don't appear to reapply those 
quirks after a reset - I'll send a patch!

Steve
