Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B71C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE1E207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgGJJF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:05:59 -0400
Received: from foss.arm.com ([217.140.110.172]:33202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgGJJF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:05:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0094831B;
        Fri, 10 Jul 2020 02:05:57 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E81C3F68F;
        Fri, 10 Jul 2020 02:05:55 -0700 (PDT)
Subject: Re: [PATCH v3 07/14] drm/panfrost: rename error labels in device_init
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
 <20200709140322.131320-8-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <19cea82f-ca6a-ae77-ca18-814ec5b731a8@arm.com>
Date:   Fri, 10 Jul 2020 10:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200709140322.131320-8-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2020 15:03, Clément Péron wrote:
> Rename goto labels in device_init it will be easier to maintain.
> 
> Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Nice clean up, thanks. As you noted this needs rebasing as the 
"regulator init" message has gone.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_device.c | 30 +++++++++++-----------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 8136babd3ba9..cc16d102b275 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -215,57 +215,57 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>   	err = panfrost_regulator_init(pfdev);
>   	if (err) {
>   		dev_err(pfdev->dev, "regulator init failed %d\n", err);
> -		goto err_out0;
> +		goto out_clk;
>   	}
>   
>   	err = panfrost_reset_init(pfdev);
>   	if (err) {
>   		dev_err(pfdev->dev, "reset init failed %d\n", err);
> -		goto err_out1;
> +		goto out_regulator;
>   	}
>   
>   	err = panfrost_pm_domain_init(pfdev);
>   	if (err)
> -		goto err_out2;
> +		goto out_reset;
>   
>   	res = platform_get_resource(pfdev->pdev, IORESOURCE_MEM, 0);
>   	pfdev->iomem = devm_ioremap_resource(pfdev->dev, res);
>   	if (IS_ERR(pfdev->iomem)) {
>   		dev_err(pfdev->dev, "failed to ioremap iomem\n");
>   		err = PTR_ERR(pfdev->iomem);
> -		goto err_out3;
> +		goto out_pm_domain;
>   	}
>   
>   	err = panfrost_gpu_init(pfdev);
>   	if (err)
> -		goto err_out3;
> +		goto out_pm_domain;
>   
>   	err = panfrost_mmu_init(pfdev);
>   	if (err)
> -		goto err_out4;
> +		goto out_gpu;
>   
>   	err = panfrost_job_init(pfdev);
>   	if (err)
> -		goto err_out5;
> +		goto out_mmu;
>   
>   	err = panfrost_perfcnt_init(pfdev);
>   	if (err)
> -		goto err_out6;
> +		goto out_job;
>   
>   	return 0;
> -err_out6:
> +out_job:
>   	panfrost_job_fini(pfdev);
> -err_out5:
> +out_mmu:
>   	panfrost_mmu_fini(pfdev);
> -err_out4:
> +out_gpu:
>   	panfrost_gpu_fini(pfdev);
> -err_out3:
> +out_pm_domain:
>   	panfrost_pm_domain_fini(pfdev);
> -err_out2:
> +out_reset:
>   	panfrost_reset_fini(pfdev);
> -err_out1:
> +out_regulator:
>   	panfrost_regulator_fini(pfdev);
> -err_out0:
> +out_clk:
>   	panfrost_clk_fini(pfdev);
>   	return err;
>   }
> 

