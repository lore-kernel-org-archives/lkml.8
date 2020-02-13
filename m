Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EF0C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A3020848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgBMLNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:13:33 -0500
Received: from foss.arm.com ([217.140.110.172]:45162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMLNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:13:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC9DF1FB;
        Thu, 13 Feb 2020 03:13:31 -0800 (PST)
Received: from [10.1.195.32] (e112269-lin.cambridge.arm.com [10.1.195.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4F513F6CF;
        Thu, 13 Feb 2020 03:13:30 -0800 (PST)
Subject: Re: [PATCH v2] drm/panfrost: Don't try to map on error faults
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20200212202236.13095-1-robh@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <9c0a0ac7-69fe-c799-c273-81e7a8cba2c7@arm.com>
Date:   Thu, 13 Feb 2020 11:13:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212202236.13095-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2020 20:22, Rob Herring wrote:
> From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> If the exception type isn't a translation fault, don't try to map and
> instead go straight to a terminal fault.
> 
> Otherwise, we can get flooded by kernel warnings and further faults.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I rewrote this some simplifying the code and somewhat following Steven's 
> suggested. Still not using defines though. No defines here was good 
> enough before IMO.

Heresy! It's a good thing you're not writing kbase code - there you
(seemingly) need to pick a #define which is as long as possible, but
then still wrap the code to avoid the 80 character limit... For
example[1]. Although shifting the code right might get you extra bonus
points, deep nesting seems to be encouraged! ;)

[1]
https://gitlab.freedesktop.org/panfrost/mali_kbase/blob/master/driver/product/kernel/drivers/gpu/arm/midgard/backend/gpu/mali_kbase_js_backend.c#L156

> 
> Only compile tested.

I've done some quick testing on a Firefly RK3288. But I don't have any
(handy) tests to trigger non-TRANSLATION_FAULT MMU faults.

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

> 
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 44 +++++++++++--------------
>  1 file changed, 19 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 763cfca886a7..4f2836bd9215 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -596,33 +596,27 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
>  		source_id = (fault_status >> 16);
>  
>  		/* Page fault only */
> -		if ((status & mask) == BIT(i)) {
> -			WARN_ON(exception_type < 0xC1 || exception_type > 0xC4);
> -
> +		ret = -1;
> +		if ((status & mask) == BIT(i) && (exception_type & 0xF8) == 0xC0)
>  			ret = panfrost_mmu_map_fault_addr(pfdev, i, addr);
> -			if (!ret) {
> -				mmu_write(pfdev, MMU_INT_CLEAR, BIT(i));
> -				status &= ~mask;
> -				continue;
> -			}
> -		}
>  
> -		/* terminal fault, print info about the fault */
> -		dev_err(pfdev->dev,
> -			"Unhandled Page fault in AS%d at VA 0x%016llX\n"
> -			"Reason: %s\n"
> -			"raw fault status: 0x%X\n"
> -			"decoded fault status: %s\n"
> -			"exception type 0x%X: %s\n"
> -			"access type 0x%X: %s\n"
> -			"source id 0x%X\n",
> -			i, addr,
> -			"TODO",
> -			fault_status,
> -			(fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
> -			exception_type, panfrost_exception_name(pfdev, exception_type),
> -			access_type, access_type_name(pfdev, fault_status),
> -			source_id);
> +		if (ret)
> +			/* terminal fault, print info about the fault */
> +			dev_err(pfdev->dev,
> +				"Unhandled Page fault in AS%d at VA 0x%016llX\n"
> +				"Reason: %s\n"
> +				"raw fault status: 0x%X\n"
> +				"decoded fault status: %s\n"
> +				"exception type 0x%X: %s\n"
> +				"access type 0x%X: %s\n"
> +				"source id 0x%X\n",
> +				i, addr,
> +				"TODO",
> +				fault_status,
> +				(fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
> +				exception_type, panfrost_exception_name(pfdev, exception_type),
> +				access_type, access_type_name(pfdev, fault_status),
> +				source_id);
>  
>  		mmu_write(pfdev, MMU_INT_CLEAR, mask);
>  
> 

