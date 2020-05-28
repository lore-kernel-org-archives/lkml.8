Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A00C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C8D207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390351AbgE1NXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:23:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390339AbgE1NXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:23:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59D0ED6E;
        Thu, 28 May 2020 06:23:08 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C92433F52E;
        Thu, 28 May 2020 06:23:06 -0700 (PDT)
Subject: Re: [PATCH 11/15] drm/panfrost: set devfreq clock name
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
 <20200510165538.19720-12-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <8bc659b4-dbf9-5ae6-a677-937cab6bd798@arm.com>
Date:   Thu, 28 May 2020 14:23:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-12-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2020 17:55, Clément Péron wrote:
> Some SoCs have  several clocks defined and the OPP core
> needs to know the exact name of the clk to use.
> 
> Set the clock name to "core".
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

This is unfortunately a regression for the RK3288. The device tree 
binding doesn't require "clock-names", and for the RK3288 it currently 
isn't specified. So this breaks the platform.

Adding the "clock-names" to the device tree 'fixes' it, but we really 
need to keep backwards compatibility.

Steve

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 13 +++++++++++++
>   drivers/gpu/drm/panfrost/panfrost_devfreq.h |  1 +
>   2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 9ffea0d4a087..6bf3541b4d53 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -103,6 +103,14 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   
>   	spin_lock_init(&pfdevfreq->lock);
>   
> +	opp_table = dev_pm_opp_set_clkname(dev, "core");
> +	if (IS_ERR(opp_table)) {
> +		ret = PTR_ERR(opp_table);
> +		goto err_fini;
> +	}
> +
> +	pfdevfreq->clkname_opp_table = opp_table;
> +
>   	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
>   					      pfdev->comp->num_supplies);
>   	if (IS_ERR(opp_table)) {
> @@ -176,6 +184,11 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
>   		dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
>   		pfdevfreq->regulators_opp_table = NULL;
>   	}
> +
> +	if (pfdevfreq->clkname_opp_table) {
> +		dev_pm_opp_put_clkname(pfdevfreq->clkname_opp_table);
> +		pfdevfreq->clkname_opp_table = NULL;
> +	}
>   }
>   
>   void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> index 347cde4786cf..1f2475e1d034 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> @@ -16,6 +16,7 @@ struct panfrost_device;
>   struct panfrost_devfreq {
>   	struct devfreq *devfreq;
>   	struct opp_table *regulators_opp_table;
> +	struct opp_table *clkname_opp_table;
>   	struct thermal_cooling_device *cooling;
>   	bool opp_of_table_added;
>   
> 

