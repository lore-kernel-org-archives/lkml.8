Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562F4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2773924679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS4Cs8/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA0Trl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:47:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36129 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0Trl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:47:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id f24so7171705lfh.3;
        Mon, 27 Jan 2020 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8N56+uwNzL4BtEV3m9/SZahhJM7vJj2lXnrPv331uNA=;
        b=GS4Cs8/z2H+nsAyIfkIssh2nPOu2dPROaVu1LjaSkVN2FxE7AIdvTaBysC+gP+WeNU
         HFRwweqZeek8jHre2PRJRpwWpbpB4YIKr1FzOyJx00TnlMGabzvp+Z9n1BO+J3r7KYrC
         6zkYmGPdizAJxly9h7WwK+a7iP46YWU6LqmRHT2Cpi+/KZbLyrT/FctCi0x8KfjV3J4R
         tDRj9xS93hifbwrIwrJYZE+YGYlQ6DhkBkRLQwKw/e2pKQEhw8PzqXMkwtBNjfps1QNL
         oppuNRJXVaDWjteTPI+ZNbKpVqL73icMsK3xJbO5JOmY0xyY7q3hND70yR2NSTqOhOXs
         G4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8N56+uwNzL4BtEV3m9/SZahhJM7vJj2lXnrPv331uNA=;
        b=cqwu60apsbe6rUqhUqTwJFryJ1+RZh8ICToT8SwKtE9AqApm1nh+Vsw8QRtgVWyTj3
         P405IPVPEA/w2L3wCUNJubqZ0ns4HvpvWsEwXSHFmTYggPLD/cxywlpMsKbIdUKe45xt
         sCRvq2NBt+pSQ+SIPstUJQS5HeG1EaEyJ7qOmXtZ6O9SnK7A0yHB6gs45dgpIHSDr0GE
         CSP1H7qMKIVNxfmCzPeF1Ol4gVYJzPOgiCP/IKmi9+cjrNrsad6R7luGNQrfUdiJhcN0
         9KrHzR6CjViy2ULBqswwhqiwhrEyNaJYwSEi/hfEUNMSWAFpFbMjjVuKn2JSX8lP5YM8
         YTYA==
X-Gm-Message-State: APjAAAUu2JPxgcSZlKDYfsWH8M0IhPudAjv2oDP+kYNG2JPYZpOBFg7x
        +8s5TY8wS8fdP0ttvSUBlxrjjGAF
X-Google-Smtp-Source: APXvYqw7ijbIubuYLfC7tAZAuVvjYs89FTtBLA619TrkVJ+yACKs6MXi5U9K1mv44MDLYMLGftXRdw==
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr159657lfl.64.1580154458315;
        Mon, 27 Jan 2020 11:47:38 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w19sm8581143lfl.55.2020.01.27.11.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 11:47:37 -0800 (PST)
Subject: Re: [PATCH] usb: phy: tegra: make the code simple by
 devm_platform_ioremap_resource()
To:     Dejin Zheng <zhengdejin5@gmail.com>, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200127135841.17935-1-zhengdejin5@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ebb395ec-89ef-12e9-b3a9-2fc35f764ee2@gmail.com>
Date:   Mon, 27 Jan 2020 22:47:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200127135841.17935-1-zhengdejin5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.01.2020 16:58, Dejin Zheng пишет:
> make the code simple by use devm_platform_ioremap_resource() function
> to replace platform_get_resource() and devm_ioremap().
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/usb/phy/phy-tegra-usb.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
> index ea7ef1dc0b42..8220bb4ce1ed 100644
> --- a/drivers/usb/phy/phy-tegra-usb.c
> +++ b/drivers/usb/phy/phy-tegra-usb.c
> @@ -944,20 +944,12 @@ static int read_utmi_param(struct platform_device *pdev, const char *param,
>  static int utmi_phy_probe(struct tegra_usb_phy *tegra_phy,
>  			  struct platform_device *pdev)
>  {
> -	struct resource *res;
>  	int err;
>  	struct tegra_utmip_config *config;
>  
>  	tegra_phy->is_ulpi_phy = false;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get UTMI pad regs\n");
> -		return  -ENXIO;
> -	}
> -
> -	tegra_phy->pad_regs = devm_ioremap(&pdev->dev, res->start,
> -		resource_size(res));
> +	tegra_phy->pad_regs = devm_platform_ioremap_resource(pdev, 1);
>  	if (!tegra_phy->pad_regs) {
>  		dev_err(&pdev->dev, "Failed to remap UTMI pad regs\n");
>  		return -ENOMEM;
> @@ -1054,7 +1046,6 @@ MODULE_DEVICE_TABLE(of, tegra_usb_phy_id_table);
>  static int tegra_usb_phy_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
> -	struct resource *res;
>  	struct tegra_usb_phy *tegra_phy = NULL;
>  	struct device_node *np = pdev->dev.of_node;
>  	enum usb_phy_interface phy_type;
> @@ -1071,14 +1062,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
>  	}
>  	tegra_phy->soc_config = match->data;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get I/O memory\n");
> -		return  -ENXIO;
> -	}
> -
> -	tegra_phy->regs = devm_ioremap(&pdev->dev, res->start,
> -		resource_size(res));
> +	tegra_phy->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (!tegra_phy->regs) {
>  		dev_err(&pdev->dev, "Failed to remap I/O memory\n");
>  		return -ENOMEM;
> 

Hello Dejin,

Unfortunately this is not a correct change because registers are shared
by both PHY and USB controllers on Tegra SoCs. The
devm_platform_ioremap_resource() can't be used here because it makes the
mapping exclusive for a single driver, while it should be shared.
