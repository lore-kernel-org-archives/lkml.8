Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB68FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3A9214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUzJDQoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgFPRWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFPRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:22:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F598C061573;
        Tue, 16 Jun 2020 10:22:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c71so3613434wmd.5;
        Tue, 16 Jun 2020 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=POTjqByYRbOQ/frF7/yQePjpbGaXYUQJP5UNWUEfE/A=;
        b=vUzJDQoez6aAImGZ/7qFnlj161x30/bcv/CWnbyyJHffgcAbvcCmPyG2ougMK0bkBk
         Lem+Y/krz2KJxsrI2uer1kVXQT/Nu41TV49Kwj7RyUXkeVS8IB5fIGQK4C+kDaeqgSee
         WoI1iglnXVia5EbPNYmU6WKknanzO6ruWjvKToFh2mAoS6/UwZCtRrYiYhcUYNL4U4bz
         sR6rXevrj8RMJ5GBCPa10DBLG2q/PGW9ZX14ohKz6u+ak/YyO09IQedycYeq6rJOEFdm
         BAuuTG57ySKJfCKhc64pXMrwzByxZgKAvGlgmx4yWQ4z0YayIZMwFzJnBvgj0gfErn7+
         tKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=POTjqByYRbOQ/frF7/yQePjpbGaXYUQJP5UNWUEfE/A=;
        b=CokBg3ws+72K5JaOVb5Q87RqQNyxB7eNkBO+vz7LZB8G0bj2f8/7zGg5iv9hCYZr6F
         apP1n5sCEj54dF+ad2baalt7bPAmyhGvoY/FXFqEtxm9+ZB+1/KXZKC9YUV7bTrwyMX3
         RjclwXCj6e+rxJwNBBZppEqY8PuPQrB3ZUDW4yXCFOhPQ5HuYm6cxIMOPEtfXDDiG2xZ
         onlFGj3YFvWTTcqwD2v20rCsQqRXpH+3A8MXMzBJgGL9qkOlvgxC7K++IvtkWKkAW33l
         jtMj7AmiLIh1/yYK2kZyA5IS3CTfb8+z4FdV3HMz4yjFfcJk5rCCjyxT9kCysCkLFCvB
         ZHfg==
X-Gm-Message-State: AOAM532ZtjPZMxnACj3BVUdxNelsqZLwEl9Z7WmQWJ4igGddqjE4DWgJ
        CD+MNH2sBxliOhlsXa9kNQE=
X-Google-Smtp-Source: ABdhPJwXYB3vpq5S0weVHDq18Q9f5udtu01CzES1KJEMynkfpLzjqhQwmogX6HHJDPtPvWECnmOrUw==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr4597556wmi.82.1592328160618;
        Tue, 16 Jun 2020 10:22:40 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id i8sm29066319wru.30.2020.06.16.10.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:22:39 -0700 (PDT)
Subject: Re: [PATCH 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        simon@fire.lp0.eu, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200616083408.3426435-1-noltari@gmail.com>
 <20200616083408.3426435-3-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <338262f0-bfe6-759c-c7f9-af7b62f5144d@gmail.com>
Date:   Tue, 16 Jun 2020 10:22:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616083408.3426435-3-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2020 1:34 AM, Álvaro Fernández Rojas wrote:
> Add BCM63xx USBH PHY driver for BMIPS.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

This looks good to me at first glance, just a few comments below.

> ---
>  drivers/phy/broadcom/Kconfig            |  10 +
>  drivers/phy/broadcom/Makefile           |   1 +
>  drivers/phy/broadcom/phy-bcm63xx-usbh.c | 463 ++++++++++++++++++++++++
>  3 files changed, 474 insertions(+)
>  create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c
> 
> diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
> index b29f11c19155..896506c7b1f8 100644
> --- a/drivers/phy/broadcom/Kconfig
> +++ b/drivers/phy/broadcom/Kconfig
> @@ -2,6 +2,16 @@
>  #
>  # Phy drivers for Broadcom platforms
>  #
> +config PHY_BCM63XX_USBH
> +	tristate "BCM63xx USBH PHY driver"
> +	depends on BMIPS_GENERIC || COMPILE_TEST
> +	depends on OF

I do not think you need to add the depends on OF here if you use
device_get_match_data() instead of of_device_get_match_data() and
devm_of_phy_provider_register() has an inline stub provided when
CONFIG_OF=n.

[snip]

> +static int __init bcm63xx_usbh_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct bcm63xx_usbh_phy	*usbh;
> +	const struct bcm63xx_usbh_phy_variant *variant;
> +	struct resource *res;
> +	struct phy *phy;
> +	struct phy_provider *phy_provider;
> +
> +	usbh = devm_kzalloc(dev, sizeof(*usbh), GFP_KERNEL);
> +	if (!usbh)
> +		return -ENOMEM;
> +
> +	variant = of_device_get_match_data(dev);

We can use device_get_match_data() to be OF independent.

> +	if (!variant)
> +		return -EINVAL;
> +	memcpy(&usbh->variant, variant, sizeof(*variant));

I would just avoid marking the variant tables with __initconst, and just
reference them directly here.

> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	usbh->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(usbh->base))
> +		return PTR_ERR(usbh->base);
> +
> +	usbh->reset = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(usbh->reset)) {
> +		if (PTR_ERR(usbh->reset) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get reset\n");
> +		return PTR_ERR(usbh->reset);
> +	}
> +
> +	if (variant->has_usb_clk) {
> +		usbh->usbh_clk = devm_clk_get(dev, "usbh");

You can use devm_clk_get_optional() which would save you from having to
record whether the clock is needed or not.

> +		if (IS_ERR(usbh->usbh_clk)) {
> +			if (PTR_ERR(usbh->usbh_clk) != -EPROBE_DEFER)
> +				dev_err(dev, "failed to get usbh clock\n");
> +			return PTR_ERR(usbh->usbh_clk);
> +		}
> +	} else {
> +		usbh->usbh_clk = NULL;
> +	}
> +
> +	if (variant->has_usb_ref_clk) {
> +		usbh->usb_ref_clk = devm_clk_get(dev, "usb_ref");

Likewise.
-- 
Florian
