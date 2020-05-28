Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56701C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D296207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390334AbgE1NXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:23:06 -0400
Received: from foss.arm.com ([217.140.110.172]:52622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390314AbgE1NW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:22:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CA4DD6E;
        Thu, 28 May 2020 06:22:56 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 177183F52E;
        Thu, 28 May 2020 06:22:54 -0700 (PDT)
Subject: Re: [PATCH 07/15] drm/panfrost: use device_property_present to check
 for OPP
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
 <20200510165538.19720-8-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2f7a41d6-325d-3731-0a6a-fa2e41d4e33a@arm.com>
Date:   Thu, 28 May 2020 14:22:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-8-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2020 17:55, Clément Péron wrote:
> Instead of expecting an error from dev_pm_opp_of_add_table()
> do a simple device_property_present() check.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

I'm not sure I understand why this is better. We seem to have more code 
to do roughly the same thing just with the hard-coded 
"operating-points-v2" name (if there's ever a 'v3' we'll then have to 
update this).

Is the desire just to get an error on probe if the table is malformed? 
Have you hit this situation? If so this sounds like something which 
would be better fixed in the generic OPP code rather than Panfrost itself.

Steve

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index d9007f44b772..fce21c682414 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -96,15 +96,19 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	struct thermal_cooling_device *cooling;
>   	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
>   
> -	ret = dev_pm_opp_of_add_table(dev);
> -	if (ret == -ENODEV) /* Optional, continue without devfreq */
> +	if (!device_property_present(dev, "operating-points-v2"))
> +		/* Optional, continue without devfreq */
>   		return 0;
> -	else if (ret)
> -		return ret;
> -	pfdevfreq->opp_of_table_added = true;
>   
>   	spin_lock_init(&pfdevfreq->lock);
>   
> +	ret = dev_pm_opp_of_add_table(dev);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "Couldn't add OPP table\n");
> +		goto err_fini;
> +	}
> +	pfdevfreq->opp_of_table_added = true;
> +
>   	panfrost_devfreq_reset(pfdevfreq);
>   
>   	cur_freq = clk_get_rate(pfdev->clock);
> 

