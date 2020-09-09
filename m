Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E166AC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BCB21D91
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIIM2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:28:33 -0400
Received: from foss.arm.com ([217.140.110.172]:42384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730174AbgIIMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:24:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B875513D5;
        Wed,  9 Sep 2020 05:23:43 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99DC13F68F;
        Wed,  9 Sep 2020 05:23:42 -0700 (PDT)
Subject: Re: [PATCH 4/5] drm/panfrost: add amlogic reset quirk callback
To:     Neil Armstrong <narmstrong@baylibre.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20200908151853.4837-1-narmstrong@baylibre.com>
 <20200908151853.4837-5-narmstrong@baylibre.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <5efe218c-19d5-c25b-74cc-e5ae5da418a2@arm.com>
Date:   Wed, 9 Sep 2020 13:23:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908151853.4837-5-narmstrong@baylibre.com>
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
> Since the documentation of the GPU cores are not public, we do not know what does these
> values, but they permit having a fully functional GPU running with Panfrost.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_gpu.c  | 13 +++++++++++++
>   drivers/gpu/drm/panfrost/panfrost_gpu.h  |  2 ++
>   drivers/gpu/drm/panfrost/panfrost_regs.h |  3 +++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index c129aaf77790..018737bd4ac6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -80,6 +80,19 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
>   	return 0;
>   }
>   
> +void panfrost_gpu_amlogic_quirks(struct panfrost_device *pfdev)
> +{
> +	/*
> +	 * The Amlogic integrated Mali-T820, Mali-G31 & Mali-G52 needs
> +	 * these undocumented bits to be set in order to operate
> +	 * correctly.
> +	 * These GPU_PWR registers contains:
> +	 * "device-specific power control value"
> +	 */
> +	gpu_write(pfdev, GPU_PWR_KEY, 0x2968A819);

As Alyssa has mentioned this magic value is not Amlogic specific, but is 
just the unlock key value, so please add the define in panfrost-gpu.h

> +	gpu_write(pfdev, GPU_PWR_OVERRIDE1, 0xfff | (0x20 << 16));

But PWR_OVERRIDE1 is indeed device specific so I can't offer an insight 
here.

> +}
> +
>   static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
>   {
>   	u32 quirks = 0;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.h b/drivers/gpu/drm/panfrost/panfrost_gpu.h
> index 4112412087b2..a881d7dc812f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.h
> @@ -16,4 +16,6 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev);
>   void panfrost_gpu_power_on(struct panfrost_device *pfdev);
>   void panfrost_gpu_power_off(struct panfrost_device *pfdev);
>   
> +void panfrost_gpu_amlogic_reset_quirk(struct panfrost_device *pfdev);

You need to be consistent about the name - this has _reset_, the above 
function doesn't.

Steve

> +
>   #endif
> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
> index ea38ac60581c..fa0d02f3c830 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
> @@ -51,6 +51,9 @@
>   #define GPU_STATUS			0x34
>   #define   GPU_STATUS_PRFCNT_ACTIVE	BIT(2)
>   #define GPU_LATEST_FLUSH_ID		0x38
> +#define GPU_PWR_KEY			0x050	/* (WO) Power manager key register */
> +#define GPU_PWR_OVERRIDE0		0x054	/* (RW) Power manager override settings */
> +#define GPU_PWR_OVERRIDE1		0x058	/* (RW) Power manager override settings */
>   #define GPU_FAULT_STATUS		0x3C
>   #define GPU_FAULT_ADDRESS_LO		0x40
>   #define GPU_FAULT_ADDRESS_HI		0x44
> 

