Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6057FC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F83C20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595427832;
	bh=HViDa/6hjozS4flzUpGeM9eHxpksA+x+OprAXGIweW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OPLPDhcW6bZIWQ3V0UOqBu7D73Oz4mD/EQy3Nw+LslrRgcXj9FG3dU5nDWGBATe1m
	 poO5htMHuGKC84p1OyyRWuD6ZDrvcvuEvq9OSJqTAUEICiIIuSt9NFi5YV2RM6J19Y
	 Gn21izku0aqoZDSh9HR2O67+zM8SetHQdrtLVqp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbgGVOXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbgGVOXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:23:50 -0400
Received: from embeddedor (unknown [200.76.83.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87CE20709;
        Wed, 22 Jul 2020 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595427829;
        bh=HViDa/6hjozS4flzUpGeM9eHxpksA+x+OprAXGIweW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkzEtYs5Mp8bQzGGVvu0YSqZygjayznM/xXLvUSOXrazaJd7KhBSnTL0ptHirp2uH
         NETuXEm574RTzUtSH4GxkbeMatKIGtKkv9bIKOKL7wkgegA58TlzKMWqgML9/9bAPz
         316UI0hiEadXdanaCFrEi2iB48CBoQnxSSFaymmU=
Date:   Wed, 22 Jul 2020 09:29:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] gpio: omap: improve coding style for pin config flags
Message-ID: <20200722142927.GA22267@embeddedor>
References: <20200722120755.230741-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722120755.230741-1-drew@beagleboard.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 02:07:56PM +0200, Drew Fustini wrote:
> Change the handling of pin config flags from if/else to switch
> statement to make the code more readable and cleaner.
> 
> Suggested-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, Drew.
--
Gustavo

> ---
>  drivers/gpio/gpio-omap.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index e0eada82178c..7fbe0c9e1fc1 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -899,13 +899,18 @@ static int omap_gpio_set_config(struct gpio_chip *chip, unsigned offset,
>  	u32 debounce;
>  	int ret = -ENOTSUPP;
>  
> -	if ((pinconf_to_config_param(config) == PIN_CONFIG_BIAS_DISABLE) ||
> -	    (pinconf_to_config_param(config) == PIN_CONFIG_BIAS_PULL_UP) ||
> -	    (pinconf_to_config_param(config) == PIN_CONFIG_BIAS_PULL_DOWN)) {
> +	switch (pinconf_to_config_param(config)) {
> +	case PIN_CONFIG_BIAS_DISABLE:
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
>  		ret = gpiochip_generic_config(chip, offset, config);
> -	} else if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
> +		break;
> +	case PIN_CONFIG_INPUT_DEBOUNCE:
>  		debounce = pinconf_to_config_argument(config);
>  		ret = omap_gpio_debounce(chip, offset, debounce);
> +		break;
> +	default:
> +		break;
>  	}
>  
>  	return ret;
> -- 
> 2.25.1
> 
