Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A48C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D376221E3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2jghuXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgIKIaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgIKIaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:30:15 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A652C061573;
        Fri, 11 Sep 2020 01:30:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y2so5032888lfy.10;
        Fri, 11 Sep 2020 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v3X+VL4+MsixaR62rPp7HwB6Wzg0tRmPuvJoIJorT2g=;
        b=c2jghuXtnbNv5767gqGXY+pPhE9HA7vje+0qO1UeB9hLYukfKNNfu5vKtRGTUk70jm
         77zzBzRNCDISWsgvWp2d3rHq1VqFPJRyOaGnJpFfHkjNI8LoSWbMRhj4CbExcwWHALPD
         12FPeWX1q6VU3qmyJlHtEaa7S6QYtMANjlfTsPzNvfjTOGcvj4iS/38Tc7U6tMzlP5cr
         Z+N3C1z1OdMr06KhWSVC+M88jA7GW/99zMVcyfV1iyaaXARfuy4cMpfE77KM/Tgj0ABy
         zbvoMvYoX/oDiI/JVUnoqWD7mUfDTO/uNP0Fk2eXMp6bXtVPH3OqCdGbCLq794f4GIh7
         XZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v3X+VL4+MsixaR62rPp7HwB6Wzg0tRmPuvJoIJorT2g=;
        b=cxLULYK0LlrL9bfHyLvtDF1mFGUl+e7C3YL+Y557IZvqnQ3yDxteZE+spPSg/6BNS/
         UALJq5eqVvr4cT582pDabgV3et0+vwwpcdGec5VjIFKl+Ry7cWhwNlRxC4595cH9Rotz
         1NhyOx3hCN3CzlNjL7W25Zd+7Sod3dzriQWrggq9ue9VXuAYu6t/4XbM5mKI/Nc2RSzf
         t3lyVnhK+aE9+3Bq0LAjyUqjur3o0GWfMM+Ro5WbXticWZvhjBlQvS7dIPV4ja51pcyk
         /1ungX6I592viHh4FDa486T0jgluBDAqSeIiOLlyxJDFeStDA0GazFtk5E0pM23Nh0lM
         BINA==
X-Gm-Message-State: AOAM530rl28Y+PnIhOwfZEcx7zRrbDnJQAsDnu0oqEaUCsOTjJhopQvG
        Jvk8t6ljrrq0emaGzCoOf6k=
X-Google-Smtp-Source: ABdhPJx9nUeV/83qz7H1mGdfts1xPRTGfCTDFwjiGZJTuXH+zznv/fgZvjUnwsdAo5TlZkuTcP6u0Q==
X-Received: by 2002:a05:6512:36cd:: with SMTP id e13mr409270lfs.165.1599813010980;
        Fri, 11 Sep 2020 01:30:10 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4498:c7cc:1d90:b990:ebe6:7df7? ([2a00:1fa0:4498:c7cc:1d90:b990:ebe6:7df7])
        by smtp.gmail.com with ESMTPSA id z15sm400438lji.78.2020.09.11.01.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 01:30:10 -0700 (PDT)
Subject: Re: [PATCH] usb: phy: tegra: Use IS_ERR() to check and simplify code
To:     Tang Bin <tangbin@cmss.chinamobile.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <20200910115607.11392-1-tangbin@cmss.chinamobile.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <d0bd4d4c-0447-6c5f-6dc3-17e5ceae2623@gmail.com>
Date:   Fri, 11 Sep 2020 11:29:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910115607.11392-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10.09.2020 14:56, Tang Bin wrote:

> Use IS_ERR() and PTR_ERR() instead of PTR_ERR_OR_ZERO() to
> simplify code, avoid redundant judgements.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>   drivers/usb/phy/phy-tegra-usb.c | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
> index 6153cc35a..3b901429d 100644
> --- a/drivers/usb/phy/phy-tegra-usb.c
> +++ b/drivers/usb/phy/phy-tegra-usb.c
> @@ -1121,10 +1121,9 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
>   		return PTR_ERR(tegra_phy->vbus);
>   
>   	tegra_phy->pll_u = devm_clk_get(&pdev->dev, "pll_u");
> -	err = PTR_ERR_OR_ZERO(tegra_phy->pll_u);
> -	if (err) {
> +	if (IS_ERR(tegra_phy->pll_u)) {
>   		dev_err(&pdev->dev, "Failed to get pll_u clock: %d\n", err);

    'err' should be changed here too...

> -		return err;
> +		return PTR_ERR(tegra_phy->pll_u);
>   	}
>   
>   	phy_type = of_usb_get_phy_mode(np);
> @@ -1135,20 +1134,18 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
>   			return err;
>   
>   		tegra_phy->pad_clk = devm_clk_get(&pdev->dev, "utmi-pads");
> -		err = PTR_ERR_OR_ZERO(tegra_phy->pad_clk);
> -		if (err) {
> +		if (IS_ERR(tegra_phy->pad_clk)) {
>   			dev_err(&pdev->dev,
>   				"Failed to get UTMIP pad clock: %d\n", err);

    Same here.

> -			return err;
> +			return PTR_ERR(tegra_phy->pad_clk);
>   		}
>   
>   		reset = devm_reset_control_get_optional_shared(&pdev->dev,
>   							       "utmi-pads");
> -		err = PTR_ERR_OR_ZERO(reset);
> -		if (err) {
> +		if (IS_ERR(reset)) {
>   			dev_err(&pdev->dev,
>   				"Failed to get UTMI-pads reset: %d\n", err);

    And here.

> -			return err;
> +			return PTR_ERR(reset);
>   		}
>   		tegra_phy->pad_rst = reset;
>   		break;
> @@ -1157,22 +1154,20 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
>   		tegra_phy->is_ulpi_phy = true;
>   
>   		tegra_phy->clk = devm_clk_get(&pdev->dev, "ulpi-link");
> -		err = PTR_ERR_OR_ZERO(tegra_phy->clk);
> -		if (err) {
> +		if (IS_ERR(tegra_phy->clk)) {
>   			dev_err(&pdev->dev,
>   				"Failed to get ULPI clock: %d\n", err);

    And here.

> -			return err;
> +			return PTR_ERR(tegra_phy->clk);
>   		}
>   
>   		gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
>   						    "nvidia,phy-reset-gpio",
>   						    0, GPIOD_OUT_HIGH,
>   						    "ulpi_phy_reset_b");
> -		err = PTR_ERR_OR_ZERO(gpiod);
> -		if (err) {
> +		if (IS_ERR(gpiod)) {
>   			dev_err(&pdev->dev,
>   				"Request failed for reset GPIO: %d\n", err);

    And here.

> -			return err;
> +			return PTR_ERR(gpiod);
>   		}
>   		tegra_phy->reset_gpio = gpiod;
>   

    Overall, this patch is broken and not even worth redoing -- the current 
code seems good...

MBR, Sergei
