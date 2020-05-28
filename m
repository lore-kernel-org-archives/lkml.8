Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BC9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE06220814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbgE1NXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:23:22 -0400
Received: from foss.arm.com ([217.140.110.172]:52680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390327AbgE1NXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:23:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C511DD6E;
        Thu, 28 May 2020 06:23:03 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 482683F52E;
        Thu, 28 May 2020 06:23:02 -0700 (PDT)
Subject: Re: [PATCH 10/15] drm/panfrost: add regulators to devfreq
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
 <20200510165538.19720-11-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2f0d2cd6-481c-26ce-fcef-ee5b4fdb249b@arm.com>
Date:   Thu, 28 May 2020 14:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-11-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2020 17:55, Clément Péron wrote:
> Some OPP tables specify voltage for each frequency. Devfreq can
> handle these regulators but they should be get only 1 time to avoid
> issue and know who is in charge.
> 
> If OPP table is probe don't init regulator.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

This looks like it should work - thanks for doing this!

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 19 +++++++++++++++++++
>   drivers/gpu/drm/panfrost/panfrost_devfreq.h |  2 ++
>   drivers/gpu/drm/panfrost/panfrost_device.c  | 11 +++++++----
>   3 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index fce21c682414..9ffea0d4a087 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -93,6 +93,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	unsigned long cur_freq;
>   	struct device *dev = &pfdev->pdev->dev;
>   	struct devfreq *devfreq;
> +	struct opp_table *opp_table;
>   	struct thermal_cooling_device *cooling;
>   	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
>   
> @@ -102,6 +103,19 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   
>   	spin_lock_init(&pfdevfreq->lock);
>   
> +	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
> +					      pfdev->comp->num_supplies);
> +	if (IS_ERR(opp_table)) {
> +		ret = PTR_ERR(opp_table);
> +		/* Continue if the optional regulator is missing */
> +		if (ret != -ENODEV) {
> +			DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
> +			goto err_fini;
> +		}
> +	} else {
> +		pfdevfreq->regulators_opp_table = opp_table;
> +	}
> +
>   	ret = dev_pm_opp_of_add_table(dev);
>   	if (ret) {
>   		DRM_DEV_ERROR(dev, "Couldn't add OPP table\n");
> @@ -157,6 +171,11 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
>   		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
>   		pfdevfreq->opp_of_table_added = false;
>   	}
> +
> +	if (pfdevfreq->regulators_opp_table) {
> +		dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
> +		pfdevfreq->regulators_opp_table = NULL;
> +	}
>   }
>   
>   void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> index add203cb00c2..347cde4786cf 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> @@ -8,12 +8,14 @@
>   #include <linux/ktime.h>
>   
>   struct devfreq;
> +struct opp_table;
>   struct thermal_cooling_device;
>   
>   struct panfrost_device;
>   
>   struct panfrost_devfreq {
>   	struct devfreq *devfreq;
> +	struct opp_table *regulators_opp_table;
>   	struct thermal_cooling_device *cooling;
>   	bool opp_of_table_added;
>   
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 67eedf64e82d..8b17fb2e3369 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -222,10 +222,13 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>   		goto err_out0;
>   	}
>   
> -	err = panfrost_regulator_init(pfdev);
> -	if (err) {
> -		dev_err(pfdev->dev, "regulator init failed %d\n", err);
> -		goto err_out1;
> +	/* OPP will handle regulators */
> +	if (!pfdev->pfdevfreq.opp_of_table_added) {
> +		err = panfrost_regulator_init(pfdev);
> +		if (err) {
> +			dev_err(pfdev->dev, "regulator init failed %d\n", err);
> +			goto err_out1;
> +		}
>   	}
>   
>   	err = panfrost_reset_init(pfdev);
> 

