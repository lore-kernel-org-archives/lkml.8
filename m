Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C8DC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5B120714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgG1JeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgG1JeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:34:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DF9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:34:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 89BA72958A0
Subject: Re: [PATCH] regulator: cros-ec-regulator: Fix double free of
 desc->name.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>
References: <20200728091909.2009771-1-pihsun@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f2e18f40-aa04-618a-ebdb-a4557e03db57@collabora.com>
Date:   Tue, 28 Jul 2020 11:34:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728091909.2009771-1-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pi-Hsun,

Thank you for your patch and to send upstream.

On 28/7/20 11:19, Pi-Hsun Shih wrote:
> The desc->name field is allocated with devm_kstrdup, but is also kfreed
> on the error path, causing it to be double freed. Remove the kfree on
> the error path.
> 
> Fixes: 8d9f8d57e023 ("regulator: Add driver for cros-ec-regulator")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/regulator/cros-ec-regulator.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
> index 35f97246bc48..cee259eb0213 100644
> --- a/drivers/regulator/cros-ec-regulator.c
> +++ b/drivers/regulator/cros-ec-regulator.c
> @@ -222,18 +222,13 @@ static int cros_ec_regulator_probe(struct platform_device *pdev)
>  
>  	drvdata->dev = devm_regulator_register(dev, &drvdata->desc, &cfg);
>  	if (IS_ERR(drvdata->dev)) {
> -		ret = PTR_ERR(drvdata->dev);
>  		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
> -		goto free_name;
> +		return PTR_ERR(drvdata->dev);
>  	}
>  
>  	platform_set_drvdata(pdev, drvdata);
>  
>  	return 0;
> -
> -free_name:
> -	kfree(desc->name);
> -	return ret;
>  }
>  
>  static const struct of_device_id regulator_cros_ec_of_match[] = {
> 
> base-commit: 8d9f8d57e023893bfa708d83e3a787e77766a378
> 
