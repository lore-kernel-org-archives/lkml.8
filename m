Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C30C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA89024673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOeF5IAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgBTSvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:51:01 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37320 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgBTSu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:50:59 -0500
Received: by mail-yw1-f68.google.com with SMTP id l5so2345026ywd.4;
        Thu, 20 Feb 2020 10:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zxEjfC9qysOEYz/uA2xiD/exrMiBDn8DQeJ/H1ImPeI=;
        b=vOeF5IAwfqyD4UjHnQxFvqrEL90PuTYYQ4PHXBFKDV7ZbakFWFaWzua6UYyEUAXQ92
         zDX7l+tkulRP5kuqkdO9KmO4wGE/ocgsSuWgmq4gdhlZLJBs1KjquticFTuPvWuaqdil
         U78Rg92ZQGU415XVxD4/4w4JcLp+pI/nkJgwdzeJNLKaQ2gnoM3wsswdE5q0ld3zt3SO
         DextXdp6Z92+ImqLu4BBuBD4oQkRhUdxfl/HEBKeurOgMAEuGgIuvMwLOLzIcbLPXbRw
         DwGW4KXiylmhLYde9lx5n9taNmCIQoNd4XIZtr8B3M7uI19xiHPBK43nKqBwEWNyMZ7v
         s1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zxEjfC9qysOEYz/uA2xiD/exrMiBDn8DQeJ/H1ImPeI=;
        b=SIdkZVrj1vuqd7MkLnHV8f7bn7mU3KZW4LwT1Coea2M9Abbcw4V5R9JlCRTU1NaKBF
         42Jd697evTEI+GtqxtWtARMlRajKiol0bgZmS/vQkAAMaQgXpc29wbvvd3tj6Bej/v4a
         3gnRNalNxHnNlcKaYB/yg+ROTeG/mf90Ono0ztZKD40q5qRA00vFmEsis5yqn0d3nx5t
         lAmSd1JmXderSRXBaVxywmIZZFhwFE/C7H/oGb9mIOPoz+5QOaBRxk+SUrwCuUUl8+gh
         4000l/zEXJWRSF/BU+KVWAePeYWXCDnfgTxvL7pqUC5Mg3n3w/WgBA4dl2Lu2wg3VGC+
         7T+A==
X-Gm-Message-State: APjAAAUl6h41kWLMUTfDPI7otow6vnrY8QC/Jp73OwDKy1KE665WNUET
        Sou3QyQZyntKMMiwGDWg8rE=
X-Google-Smtp-Source: APXvYqzzI0G8JXyQA8z5ibMWtYWDCxNVmMsdqyWKeFRO2zeOL2vG/Ctjbb1OgBqCIKTgqVRSjtbfxg==
X-Received: by 2002:a0d:e745:: with SMTP id q66mr25974738ywe.503.1582224658124;
        Thu, 20 Feb 2020 10:50:58 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id d22sm212927ywb.77.2020.02.20.10.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 10:50:57 -0800 (PST)
Subject: Re: [PATCH v2 1/2] gpio: of: Extract of_gpiochip_add_hog()
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200220130149.26283-1-geert+renesas@glider.be>
 <20200220130149.26283-2-geert+renesas@glider.be>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7b902253-cb5c-d192-0a94-788f4d59c7b5@gmail.com>
Date:   Thu, 20 Feb 2020 12:50:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220130149.26283-2-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 7:01 AM, Geert Uytterhoeven wrote:
> Extract the code to add all GPIO hogs of a gpio-hog node into its own
> function, so it can be reused.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - No changes.
> ---
>  drivers/gpio/gpiolib-of.c | 49 ++++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index c6d30f73df078e0b..2b47f93886075294 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -604,6 +604,35 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
>  	return desc;
>  }
>  
> +/**
> + * of_gpiochip_add_hog - Add all hogs in a hog device node
> + * @chip:	gpio chip to act on
> + * @hog:	device node describing the hogs
> + *
> + * Returns error if it fails otherwise 0 on success.
> + */
> +static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
> +{
> +	enum gpiod_flags dflags;
> +	struct gpio_desc *desc;
> +	unsigned long lflags;
> +	const char *name;
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0;; i++) {
> +		desc = of_parse_own_gpio(hog, chip, i, &name, &lflags, &dflags);
> +		if (IS_ERR(desc))
> +			break;
> +
> +		ret = gpiod_hog(desc, name, lflags, dflags);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * of_gpiochip_scan_gpios - Scan gpio-controller for gpio definitions
>   * @chip:	gpio chip to act on
> @@ -614,29 +643,17 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
>   */
>  static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
>  {
> -	struct gpio_desc *desc = NULL;
>  	struct device_node *np;
> -	const char *name;
> -	unsigned long lflags;
> -	enum gpiod_flags dflags;
> -	unsigned int i;
>  	int ret;
>  
>  	for_each_available_child_of_node(chip->of_node, np) {
>  		if (!of_property_read_bool(np, "gpio-hog"))
>  			continue;
>  
> -		for (i = 0;; i++) {
> -			desc = of_parse_own_gpio(np, chip, i, &name, &lflags,
> -						 &dflags);
> -			if (IS_ERR(desc))
> -				break;
> -
> -			ret = gpiod_hog(desc, name, lflags, dflags);
> -			if (ret < 0) {
> -				of_node_put(np);
> -				return ret;
> -			}
> +		ret = of_gpiochip_add_hog(chip, np);
> +		if (ret < 0) {
> +			of_node_put(np);
> +			return ret;
>  		}
>  	}
>  
> 

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
