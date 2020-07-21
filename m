Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD06C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017A220771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgGUKKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:10:11 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:51349 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgGUKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:10:11 -0400
Received: from [78.134.114.177] (port=47970 helo=[192.168.77.67])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jxpDs-000C6e-Eh; Tue, 21 Jul 2020 12:10:08 +0200
Subject: Re: [PATCH][next] clk: vc5: fix use of memory after it has been
 kfree'd
To:     Colin King <colin.king@canonical.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200625132736.88832-1-colin.king@canonical.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <eb35ccc8-d3dc-a17c-a7b2-06475d310a4e@lucaceresoli.net>
Date:   Tue, 21 Jul 2020 12:10:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200625132736.88832-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 25/06/20 15:27, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a several places where printing an error message of
> init.name occurs after init.name has been kfree'd. Also the failure
> message is duplicated each time in the code. Fix this by adding
> a registration error failure path for these cases, moving the
> duplicated error messages to one common point and kfree'ing init.name
> only after it has been used.
> 
> Changes also shrink the object code size by 171 bytes (x86-64, gcc 9.3):
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   21057	   3960	     64	  25081	   61f9	drivers/clk/clk-versaclock5.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   20886	   3960	     64	  24910	   614e	drivers/clk/clk-versaclock5.o
> 
> Addresses-Coverity: ("Use after free")
> Fixes: f491276a5168 ("clk: vc5: Allow Versaclock driver to support multiple instances")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Woah, good catch!

> ---
>  drivers/clk/clk-versaclock5.c | 51 +++++++++++++----------------------
>  1 file changed, 19 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index 9a5fb3834b9a..1d8ee4b8b1f5 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -882,11 +882,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	init.parent_names = parent_names;
>  	vc5->clk_mux.init = &init;
>  	ret = devm_clk_hw_register(&client->dev, &vc5->clk_mux);
> +	if (ret)
> +		goto err_clk_register;
>  	kfree(init.name);	/* clock framework made a copy of the name */
> -	if (ret) {
> -		dev_err(&client->dev, "unable to register %s\n", init.name);
> -		goto err_clk;
> -	}
>  
>  	if (vc5->chip_info->flags & VC5_HAS_PFD_FREQ_DBL) {
>  		/* Register frequency doubler */
> @@ -900,12 +898,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		init.num_parents = 1;
>  		vc5->clk_mul.init = &init;
>  		ret = devm_clk_hw_register(&client->dev, &vc5->clk_mul);
> +		if (ret)
> +			goto err_clk_register;
>  		kfree(init.name); /* clock framework made a copy of the name */
> -		if (ret) {
> -			dev_err(&client->dev, "unable to register %s\n",
> -				init.name);
> -			goto err_clk;
> -		}
>  	}
>  
>  	/* Register PFD */
> @@ -921,11 +916,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	init.num_parents = 1;
>  	vc5->clk_pfd.init = &init;
>  	ret = devm_clk_hw_register(&client->dev, &vc5->clk_pfd);
> +	if (ret)
> +		goto err_clk_register;
>  	kfree(init.name);	/* clock framework made a copy of the name */
> -	if (ret) {
> -		dev_err(&client->dev, "unable to register %s\n", init.name);
> -		goto err_clk;
> -	}
>  
>  	/* Register PLL */
>  	memset(&init, 0, sizeof(init));
> @@ -939,11 +932,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	vc5->clk_pll.vc5 = vc5;
>  	vc5->clk_pll.hw.init = &init;
>  	ret = devm_clk_hw_register(&client->dev, &vc5->clk_pll.hw);
> +	if (ret)
> +		goto err_clk_register;
>  	kfree(init.name); /* clock framework made a copy of the name */
> -	if (ret) {
> -		dev_err(&client->dev, "unable to register %s\n", init.name);
> -		goto err_clk;
> -	}
>  
>  	/* Register FODs */
>  	for (n = 0; n < vc5->chip_info->clk_fod_cnt; n++) {
> @@ -960,12 +951,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		vc5->clk_fod[n].vc5 = vc5;
>  		vc5->clk_fod[n].hw.init = &init;
>  		ret = devm_clk_hw_register(&client->dev, &vc5->clk_fod[n].hw);
> +		if (ret)
> +			goto err_clk_register;
>  		kfree(init.name); /* clock framework made a copy of the name */
> -		if (ret) {
> -			dev_err(&client->dev, "unable to register %s\n",
> -				init.name);
> -			goto err_clk;
> -		}
>  	}
>  
>  	/* Register MUX-connected OUT0_I2C_SELB output */
> @@ -981,11 +969,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	vc5->clk_out[0].vc5 = vc5;
>  	vc5->clk_out[0].hw.init = &init;
>  	ret = devm_clk_hw_register(&client->dev, &vc5->clk_out[0].hw);
> -	kfree(init.name);	/* clock framework made a copy of the name */
> -	if (ret) {
> -		dev_err(&client->dev, "unable to register %s\n", init.name);
> -		goto err_clk;
> -	}
> +	if (ret)
> +		goto err_clk_register;
> +	kfree(init.name); /* clock framework made a copy of the name */
>  
>  	/* Register FOD-connected OUTx outputs */
>  	for (n = 1; n < vc5->chip_info->clk_out_cnt; n++) {
> @@ -1008,17 +994,15 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		vc5->clk_out[n].vc5 = vc5;
>  		vc5->clk_out[n].hw.init = &init;
>  		ret = devm_clk_hw_register(&client->dev, &vc5->clk_out[n].hw);
> +		if (ret)
> +			goto err_clk_register;
>  		kfree(init.name); /* clock framework made a copy of the name */
> -		if (ret) {
> -			dev_err(&client->dev, "unable to register %s\n",
> -				init.name);
> -			goto err_clk;
> -		}
>  
>  		/* Fetch Clock Output configuration from DT (if specified) */
>  		ret = vc5_get_output_config(client, &vc5->clk_out[n]);
>  		if (ret)
>  			goto err_clk;
> +
>  	}

Stray newline. With it possibly fixed:

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
