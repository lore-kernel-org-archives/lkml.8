Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0671C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9020814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbgE1NXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:23:25 -0400
Received: from foss.arm.com ([217.140.110.172]:52656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390295AbgE1NXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:23:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB5B6D6E;
        Thu, 28 May 2020 06:23:00 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80D8E3F52E;
        Thu, 28 May 2020 06:22:59 -0700 (PDT)
Subject: Re: [PATCH 09/15] drm/panfrost: dynamically alloc regulators
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200510165538.19720-1-peron.clem@gmail.com>
 <20200510165538.19720-10-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1988db9d-6340-1e36-d567-21b2164fbeb2@arm.com>
Date:   Thu, 28 May 2020 14:22:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-10-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2020 17:55, Clément Péron wrote:
> We will later introduce regulators managed by OPP.
> 
> Only alloc regulators when it's needed. This also help use
> to release the regulators only when they are allocated.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

LGTM:

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_device.c | 14 +++++++++-----
>   drivers/gpu/drm/panfrost/panfrost_device.h |  3 +--
>   2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index f480127205d6..67eedf64e82d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -90,9 +90,11 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
>   {
>   	int ret, i;
>   
> -	if (WARN(pfdev->comp->num_supplies > ARRAY_SIZE(pfdev->regulators),
> -			"Too many supplies in compatible structure.\n"))
> -		return -EINVAL;
> +	pfdev->regulators = devm_kcalloc(pfdev->dev, pfdev->comp->num_supplies,
> +					 sizeof(*pfdev->regulators),
> +					 GFP_KERNEL);
> +	if (!pfdev->regulators)
> +		return -ENOMEM;
>   
>   	for (i = 0; i < pfdev->comp->num_supplies; i++)
>   		pfdev->regulators[i].supply = pfdev->comp->supply_names[i];
> @@ -117,8 +119,10 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
>   
>   static void panfrost_regulator_fini(struct panfrost_device *pfdev)
>   {
> -	regulator_bulk_disable(pfdev->comp->num_supplies,
> -			pfdev->regulators);
> +	if (!pfdev->regulators)
> +		return;
> +
> +	regulator_bulk_disable(pfdev->comp->num_supplies, pfdev->regulators);
>   }
>   
>   static void panfrost_pm_domain_fini(struct panfrost_device *pfdev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 2efa59c9d1c5..953f7536a773 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -22,7 +22,6 @@ struct panfrost_job;
>   struct panfrost_perfcnt;
>   
>   #define NUM_JOB_SLOTS 3
> -#define MAX_REGULATORS 2
>   #define MAX_PM_DOMAINS 3
>   
>   struct panfrost_features {
> @@ -81,7 +80,7 @@ struct panfrost_device {
>   	void __iomem *iomem;
>   	struct clk *clock;
>   	struct clk *bus_clock;
> -	struct regulator_bulk_data regulators[MAX_REGULATORS];
> +	struct regulator_bulk_data *regulators;
>   	struct reset_control *rstc;
>   	/* pm_domains for devices with more than one. */
>   	struct device *pm_domain_devs[MAX_PM_DOMAINS];
> 

