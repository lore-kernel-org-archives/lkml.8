Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E4AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BF1207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390324AbgE1NXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:23:03 -0400
Received: from foss.arm.com ([217.140.110.172]:52600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390301AbgE1NWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:22:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78148D6E;
        Thu, 28 May 2020 06:22:51 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 101303F52E;
        Thu, 28 May 2020 06:22:49 -0700 (PDT)
Subject: Re: [PATCH 06/15] drm/panfrost: properly handle error in probe
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
 <20200510165538.19720-7-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <6a5915af-680f-0e9f-1502-ccb4f8d3d199@arm.com>
Date:   Thu, 28 May 2020 14:22:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-7-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2020 17:55, Clément Péron wrote:
> Introduce a boolean to know if opp table has been added.
> 
> With this, we can call panfrost_devfreq_fini() in case of error
> and release what has been initialised.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

LGTM:

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 25 ++++++++++++++++-----
>   drivers/gpu/drm/panfrost/panfrost_devfreq.h |  1 +
>   2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 78753cfb59fb..d9007f44b772 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -101,6 +101,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   		return 0;
>   	else if (ret)
>   		return ret;
> +	pfdevfreq->opp_of_table_added = true;
>   
>   	spin_lock_init(&pfdevfreq->lock);
>   
> @@ -109,8 +110,10 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	cur_freq = clk_get_rate(pfdev->clock);
>   
>   	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
> -	if (IS_ERR(opp))
> -		return PTR_ERR(opp);
> +	if (IS_ERR(opp)) {
> +		ret = PTR_ERR(opp);
> +		goto err_fini;
> +	}
>   
>   	panfrost_devfreq_profile.initial_freq = cur_freq;
>   	dev_pm_opp_put(opp);
> @@ -119,8 +122,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
>   	if (IS_ERR(devfreq)) {
>   		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
> -		dev_pm_opp_of_remove_table(dev);
> -		return PTR_ERR(devfreq);
> +		ret = PTR_ERR(devfreq);
> +		goto err_fini;
>   	}
>   	pfdevfreq->devfreq = devfreq;
>   
> @@ -131,15 +134,25 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   		pfdevfreq->cooling = cooling;
>   
>   	return 0;
> +
> +err_fini:
> +	panfrost_devfreq_fini(pfdev);
> +	return ret;
>   }
>   
>   void panfrost_devfreq_fini(struct panfrost_device *pfdev)
>   {
>   	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
>   
> -	if (pfdevfreq->cooling)
> +	if (pfdevfreq->cooling) {
>   		devfreq_cooling_unregister(pfdevfreq->cooling);
> -	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
> +		pfdevfreq->cooling = NULL;
> +	}
> +
> +	if (pfdevfreq->opp_of_table_added) {
> +		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
> +		pfdevfreq->opp_of_table_added = false;
> +	}
>   }
>   
>   void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> index e6629900a618..add203cb00c2 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> @@ -15,6 +15,7 @@ struct panfrost_device;
>   struct panfrost_devfreq {
>   	struct devfreq *devfreq;
>   	struct thermal_cooling_device *cooling;
> +	bool opp_of_table_added;
>   
>   	ktime_t busy_time;
>   	ktime_t idle_time;
> 

