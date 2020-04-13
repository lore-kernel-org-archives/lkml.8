Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF6EC2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0974C2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgDMNHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:07:40 -0400
Received: from foss.arm.com ([217.140.110.172]:41340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgDMNHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:07:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 499131FB;
        Mon, 13 Apr 2020 06:07:39 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 090573F68F;
        Mon, 13 Apr 2020 06:07:37 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/panfrost: missing remove opp table in case of
 failure
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200411200632.4045-1-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <694c3bd0-1588-ed28-d282-8e83fc6a06f5@arm.com>
Date:   Mon, 13 Apr 2020 14:07:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200411200632.4045-1-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2020 21:06, Clément Péron wrote:
> In case of failure we need to remove OPP table.
> 
> Use Linux classic error handling with goto usage.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 413987038fbf..62541f4edd81 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -90,8 +90,11 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	cur_freq = clk_get_rate(pfdev->clock);
>   
>   	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
> -	if (IS_ERR(opp))
> -		return PTR_ERR(opp);
> +	if (IS_ERR(opp)) {
> +		DRM_DEV_ERROR(dev, "Failed to set recommended OPP\n");
> +		ret = PTR_ERR(opp);
> +		goto err_opp;
> +	}
>   
>   	panfrost_devfreq_profile.initial_freq = cur_freq;
>   	dev_pm_opp_put(opp);
> @@ -100,8 +103,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
>   	if (IS_ERR(devfreq)) {
>   		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
> -		dev_pm_opp_of_remove_table(dev);
> -		return PTR_ERR(devfreq);
> +		ret = PTR_ERR(devfreq);
> +		goto err_opp;
>   	}
>   	pfdev->devfreq.devfreq = devfreq;
>   
> @@ -112,6 +115,11 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   		pfdev->devfreq.cooling = cooling;
>   
>   	return 0;
> +
> +err_opp:
> +	dev_pm_opp_of_remove_table(dev);
> +
> +	return ret;
>   }
>   
>   void panfrost_devfreq_fini(struct panfrost_device *pfdev)
> 

