Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F6C35241
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7A924687
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqdOAPHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgAWX4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:56:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41254 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbgAWX4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:56:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so353215ljc.8;
        Thu, 23 Jan 2020 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GBpSA+S70IveCTtKIGEFtQpKccngEqKX7VJI5QTlR44=;
        b=gqdOAPHfQJs7X0ZXIxK83uE8YRY1mng4HqdwWXVTp8ByvyNa6ZheKj2RHCguW3xOwZ
         PUmnNIdiPmp1TjkbXzo4bwZ21v8NE7OR0rDTqT9O9iEZXXL3EeCNmepJpMkkLj+lNpYn
         CQ7ZTNuFfLU3mLP1kjo5813jL7L7BEakXcMcWSmqmSrMMDSWau3h0+JuO/z7/fxIARFz
         Gxho2oK8ZnU+aweBDeR8YBIB01ggNKfDr+9S2Xwfc0/R4iOCDAeWFTxyampSwIweBf3g
         ylJKbNGhspngo3OUllSFtZxk0fQ6RgE64tZVOJOXmIcNo6z2VE3UZM5OXmDXIEE23tpJ
         6L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GBpSA+S70IveCTtKIGEFtQpKccngEqKX7VJI5QTlR44=;
        b=ThwgBCnCAaZxwT9cifvUcUMiNz5K5z+XDDaSFK23ZKUmljC0f7s4446PA/nNTyb+2g
         DiuAVLRrHc/gBbYOfI7d4OTF3EXUiMr3mtPr5xsw3WZsPE1nxVte57o41AdOyB3SMzmf
         5h0ZZ6VMCDtd3NjgDoxXEzO64HO2H8VtLsMKhcYOd6rZEswuJc4b5obSgHo9VqhVb4vY
         Xa9qxKmvl+mutP8AaYPH/+AnvCZLWiDmh2pNfX2gw0mtlN7sQmAp2klavPxPDEPqWIPs
         a3DvcTZcUh4f9xoZrgNWpV9i6auF8HJNZF1PuZfaOziNX15OBM+mG7Mu1csH2+ykFmfW
         Dvvw==
X-Gm-Message-State: APjAAAWNkP8SPsvYxVcP2pPY+LPrDPakpYBO3EGWI1RF2hZxMD7qdTUS
        LP22RPfSoG1mn9VcltVoCBDPQkBB
X-Google-Smtp-Source: APXvYqxoTeKZ48pGOHQTsLFqutvtN4hgoSviLPAKKeyV9HeVxPD93R0HyzG+SjwU+HzCapUUY5PaPQ==
X-Received: by 2002:a2e:3619:: with SMTP id d25mr481791lja.231.1579823809203;
        Thu, 23 Jan 2020 15:56:49 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y2sm188582ljm.28.2020.01.23.15.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 15:56:48 -0800 (PST)
Subject: Re: [PATCH v8 11/22] ASoC: tegra: Add fallback implementation for
 audio mclk
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-12-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <aef36b46-789a-c44e-4cd1-9d4183435ba9@gmail.com>
Date:   Fri, 24 Jan 2020 02:56:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1578986667-16041-12-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.01.2020 10:24, Sowjanya Komatineni пишет:
> mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
> are moved to Tegra PMC driver with pmc as clock provider and using pmc
> clock ids.
> 
> New device tree uses clk_out_1 from pmc clock provider as audio mclk.
> 
> So, this patch adds implementation for mclk fallback to extern1 when
> retrieving mclk returns -ENOENT to be backward compatible of new device
> tree with older kernels.
> 
> Fixes: 110147c8c513 ("ASoC: tegra: always use clk_get() in utility code")
> 
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  sound/soc/tegra/tegra_asoc_utils.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
> index 536a578e9512..74d3ffe7e603 100644
> --- a/sound/soc/tegra/tegra_asoc_utils.c
> +++ b/sound/soc/tegra/tegra_asoc_utils.c
> @@ -191,9 +191,21 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>  
>  	data->clk_cdev1 = clk_get(dev, "mclk");
>  	if (IS_ERR(data->clk_cdev1)) {
> -		dev_err(data->dev, "Can't retrieve clk cdev1\n");
> -		ret = PTR_ERR(data->clk_cdev1);
> -		goto err_put_pll_a_out0;
> +		if (PTR_ERR(data->clk_cdev1) != -ENOENT) {
> +			dev_err(data->dev, "Can't retrieve clk cdev1\n");
> +			ret = PTR_ERR(data->clk_cdev1);
> +			goto err_put_pll_a_out0;
> +		}
> +
> +		/* Fall back to extern1 */
> +		data->clk_cdev1 = clk_get(dev, "extern1");
> +		if (IS_ERR(data->clk_cdev1)) {
> +			dev_err(data->dev, "Can't retrieve clk extern1\n");
> +			ret = PTR_ERR(data->clk_cdev1);
> +			goto err_put_pll_a_out0;
> +		}
> +
> +		dev_info(data->dev, "Falling back to extern1\n");
>  	}
>  
>  	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
> 

I tried to double-check if audio works using the updated DT works with
this fallback and unfortunately it is not (maybe I actually missed to
test this case before).. the driver doesn't probe at all because of the
assigned-clocks presence, which makes clk core to fail finding the MCLK
and thus assigned-clocks configuration fails, preventing the driver's
loading.

I'm not sure what could be done about it. Perhaps just to give up on the
compatibility of older kernels with the new DTs, missing audio isn't
really that critical (perhaps).
