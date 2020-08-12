Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB752C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 06:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA4720768
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 06:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgHLG3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 02:29:22 -0400
Received: from mleia.com ([178.79.152.223]:36570 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgHLG3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 02:29:21 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 3E9D83FDFA4;
        Wed, 12 Aug 2020 06:29:20 +0000 (UTC)
Subject: Re: [PATCH v2 5/7] regulator: plug of_node leak in
 regulator_register()'s error path
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
 <f5035b1b4d40745e66bacd571bbbb5e4644d21a1.1597195321.git.mirq-linux@rere.qmqm.pl>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <cddd3d73-8666-d64b-34f5-d82a3b31cf36@mleia.com>
Date:   Wed, 12 Aug 2020 09:29:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f5035b1b4d40745e66bacd571bbbb5e4644d21a1.1597195321.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20200812_062920_277791_509CDCAC 
X-CRM114-Status: GOOD (  19.19  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michał,

On 8/12/20 4:31 AM, Michał Mirosław wrote:
> By calling device_initialize() earlier and noting that kfree(NULL) is
> ok, we can save a bit of code in error handling and plug of_node leak.
> Fixed commit already did part of the work.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9177514ce349 ("regulator: fix memory leak on error path of regulator_register()")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/regulator/core.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 71749f48caee..448a267641df 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5137,6 +5137,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
>  		ret = -ENOMEM;
>  		goto rinse;
>  	}
> +	device_initialize(&rdev->dev);
>  
>  	/*
>  	 * Duplicate the config so the driver could override it after
> @@ -5144,9 +5145,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
>  	 */
>  	config = kmemdup(cfg, sizeof(*cfg), GFP_KERNEL);
>  	if (config == NULL) {
> -		kfree(rdev);
>  		ret = -ENOMEM;
> -		goto rinse;
> +		goto clean;

Here config == NULL

>  	}
>  
>  	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
> @@ -5158,10 +5158,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
>  	 * from a gpio extender or something else.
>  	 */
>  	if (PTR_ERR(init_data) == -EPROBE_DEFER) {
> -		kfree(config);
> -		kfree(rdev);
>  		ret = -EPROBE_DEFER;
> -		goto rinse;
> +		goto clean;
>  	}
>  
>  	/*
> @@ -5214,7 +5212,6 @@ regulator_register(const struct regulator_desc *regulator_desc,
>  	}
>  
>  	/* register with sysfs */
> -	device_initialize(&rdev->dev);
>  	rdev->dev.class = &regulator_class;
>  	rdev->dev.parent = dev;
>  	dev_set_name(&rdev->dev, "regulator.%lu",
> @@ -5292,13 +5289,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
>  	mutex_lock(&regulator_list_mutex);
>  	regulator_ena_gpio_free(rdev);
>  	mutex_unlock(&regulator_list_mutex);
> -	put_device(&rdev->dev);
> -	rdev = NULL;
>  clean:
>  	if (dangling_of_gpiod)
>  		gpiod_put(config->ena_gpiod);

And above 'config' NULL pointer could be dereferenced now, right?

> -	kfree(rdev);
>  	kfree(config);
> +	put_device(&rdev->dev);
>  rinse:
>  	if (dangling_cfg_gpiod)
>  		gpiod_put(cfg->ena_gpiod);
> 

--
Best wishes,
Vladimir
