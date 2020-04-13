Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AEFC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B4820767
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgDMNSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:18:07 -0400
Received: from foss.arm.com ([217.140.110.172]:41416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgDMNSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:18:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2F131FB;
        Mon, 13 Apr 2020 06:18:05 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC2583F68F;
        Mon, 13 Apr 2020 06:18:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200411200632.4045-1-peron.clem@gmail.com>
 <20200411200632.4045-2-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com>
Date:   Mon, 13 Apr 2020 14:18:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200411200632.4045-2-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2020 21:06, Clément Péron wrote:
> OPP table can defined both frequency and voltage.
> 
> Register the mali regulator if it exist.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++++++++---
>   drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
>   2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 62541f4edd81..2dc8e2355358 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	struct device *dev = &pfdev->pdev->dev;
>   	struct devfreq *devfreq;
>   	struct thermal_cooling_device *cooling;
> +	const char *mali = "mali";
> +	struct opp_table *opp_table = NULL;
> +
> +	/* Regulator is optional */
> +	opp_table = dev_pm_opp_set_regulators(dev, &mali, 1);

This looks like it applies before 3e1399bccf51 ("drm/panfrost: Add 
support for multiple regulators") which is currently in drm-misc-next 
(and linux-next). You want something more like:

     opp_table = dev_pm_opp_set_regulators(dev,
                                           pfdev->comp->supply_names,
                                           pfdev->comp->num_supplies);

Otherwise a platform with multiple regulators won't work correctly.

Also running on my firefly (RK3288) board I get the following warning:

    debugfs: Directory 'ffa30000.gpu-mali' with parent 'vdd_gpu' already 
present!

This is due to the regulator debugfs entries getting created twice (once 
in panfrost_regulator_init() and once here).

I have been taking a look at doing the same thing (I picked up Martin 
Blumenstingl's patch series[1]), but haven't had much time to focus on 
this recently.

Thanks,

Steve

[1] 
https://lore.kernel.org/dri-devel/20200112001623.2121227-1-martin.blumenstingl@googlemail.com/


> +	if (IS_ERR(opp_table)) {
> +		ret = PTR_ERR(opp_table);
> +		if (ret != -ENODEV) {
> +			DRM_DEV_ERROR(dev, "Failed to set regulator: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +	pfdev->devfreq.opp_table = opp_table;
>   
>   	ret = dev_pm_opp_of_add_table(dev);
> -	if (ret == -ENODEV) /* Optional, continue without devfreq */
> -		return 0;
> -	else if (ret)
> -		return ret;
> +	if (ret) {
> +		if (ret == -ENODEV) /* Optional, continue without devfreq */
> +			ret = 0;
> +		goto err_opp_reg;
> +	}
>   
>   	panfrost_devfreq_reset(pfdev);
>   
> @@ -119,6 +133,12 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   err_opp:
>   	dev_pm_opp_of_remove_table(dev);
>   
> +err_opp_reg:
> +	if (pfdev->devfreq.opp_table) {
> +		dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
> +		pfdev->devfreq.opp_table = NULL;
> +	}
> +
>   	return ret;
>   }
>   
> @@ -126,7 +146,13 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
>   {
>   	if (pfdev->devfreq.cooling)
>   		devfreq_cooling_unregister(pfdev->devfreq.cooling);
> +
>   	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
> +
> +	if (pfdev->devfreq.opp_table) {
> +		dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
> +		pfdev->devfreq.opp_table = NULL;
> +	}
>   }
>   
>   void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 06713811b92c..f6b0c779dfe5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -86,6 +86,7 @@ struct panfrost_device {
>   	struct {
>   		struct devfreq *devfreq;
>   		struct thermal_cooling_device *cooling;
> +		struct opp_table *opp_table;
>   		ktime_t busy_time;
>   		ktime_t idle_time;
>   		ktime_t time_last_update;
> 

