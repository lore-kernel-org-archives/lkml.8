Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0426DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12C3207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgGJJFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:05:48 -0400
Received: from foss.arm.com ([217.140.110.172]:33172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgGJJFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:05:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4BA31B;
        Fri, 10 Jul 2020 02:05:43 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C40243F68F;
        Fri, 10 Jul 2020 02:05:41 -0700 (PDT)
Subject: Re: [PATCH v3 08/14] drm/panfrost: move devfreq_init()/fini() in
 device
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200709140322.131320-1-peron.clem@gmail.com>
 <20200709140322.131320-9-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2c8776ae-6342-8932-47c7-bf32b60967ab@arm.com>
Date:   Fri, 10 Jul 2020 10:05:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200709140322.131320-9-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2020 15:03, Clément Péron wrote:
> Later we will introduce devfreq probing regulator if they
> are present. As regulator should be probe only one time we
> need to get this logic in the device_init().
> 
> panfrost_device is already taking care of devfreq_resume()
> and devfreq_suspend(), so it's not totally illogic to move
> the devfreq_init() and devfreq_fini() here.
> 
> Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_device.c | 12 +++++++++++-
>   drivers/gpu/drm/panfrost/panfrost_drv.c    | 15 ++-------------
>   2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index cc16d102b275..464da1646398 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -212,10 +212,17 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>   		return err;
>   	}
>   
> +	err = panfrost_devfreq_init(pfdev);
> +	if (err) {
> +		if (err != -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "devfreq init failed %d\n", err);
> +		goto out_clk;
> +	}
> +
>   	err = panfrost_regulator_init(pfdev);
>   	if (err) {
>   		dev_err(pfdev->dev, "regulator init failed %d\n", err);
> -		goto out_clk;
> +		goto out_devfreq;
>   	}
>   
>   	err = panfrost_reset_init(pfdev);
> @@ -265,6 +272,8 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>   	panfrost_reset_fini(pfdev);
>   out_regulator:
>   	panfrost_regulator_fini(pfdev);
> +out_devfreq:
> +	panfrost_devfreq_fini(pfdev);
>   out_clk:
>   	panfrost_clk_fini(pfdev);
>   	return err;
> @@ -278,6 +287,7 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
>   	panfrost_gpu_fini(pfdev);
>   	panfrost_pm_domain_fini(pfdev);
>   	panfrost_reset_fini(pfdev);
> +	panfrost_devfreq_fini(pfdev);
>   	panfrost_regulator_fini(pfdev);
>   	panfrost_clk_fini(pfdev);
>   }
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 882fecc33fdb..4dda68689015 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -14,7 +14,6 @@
>   #include <drm/drm_utils.h>
>   
>   #include "panfrost_device.h"
> -#include "panfrost_devfreq.h"
>   #include "panfrost_gem.h"
>   #include "panfrost_mmu.h"
>   #include "panfrost_job.h"
> @@ -606,13 +605,6 @@ static int panfrost_probe(struct platform_device *pdev)
>   		goto err_out0;
>   	}
>   
> -	err = panfrost_devfreq_init(pfdev);
> -	if (err) {
> -		if (err != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Fatal error during devfreq init\n");
> -		goto err_out1;
> -	}
> -
>   	pm_runtime_set_active(pfdev->dev);
>   	pm_runtime_mark_last_busy(pfdev->dev);
>   	pm_runtime_enable(pfdev->dev);
> @@ -625,16 +617,14 @@ static int panfrost_probe(struct platform_device *pdev)
>   	 */
>   	err = drm_dev_register(ddev, 0);
>   	if (err < 0)
> -		goto err_out2;
> +		goto err_out1;
>   
>   	panfrost_gem_shrinker_init(ddev);
>   
>   	return 0;
>   
> -err_out2:
> -	pm_runtime_disable(pfdev->dev);
> -	panfrost_devfreq_fini(pfdev);
>   err_out1:
> +	pm_runtime_disable(pfdev->dev);
>   	panfrost_device_fini(pfdev);
>   err_out0:
>   	drm_dev_put(ddev);
> @@ -650,7 +640,6 @@ static int panfrost_remove(struct platform_device *pdev)
>   	panfrost_gem_shrinker_cleanup(ddev);
>   
>   	pm_runtime_get_sync(pfdev->dev);
> -	panfrost_devfreq_fini(pfdev);
>   	panfrost_device_fini(pfdev);
>   	pm_runtime_put_sync_suspend(pfdev->dev);
>   	pm_runtime_disable(pfdev->dev);
> 

