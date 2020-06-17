Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157B3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF70C2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZbCyWzUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgFQVJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQVJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:09:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7CFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 14:08:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y78so943161wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ikmoUr6wNmodBgxmQ4g8ECiTcai8GP8d0AhUemgSHO8=;
        b=ZbCyWzUcNY7xey+81jniW95DUP+ILcTS9Msa5jg4HLxPv25RR5rrzIIIFvRtGTpLjz
         vAvAtRjL5EXjYfIoE4GEMWp8OI3PL1gYGuZi62FeKD5XBz+kJCNdG8/wfwUIQZy0srB8
         6HYlAwRYMIaTemMv5FqfPOU6lpf2KfTjmH5SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ikmoUr6wNmodBgxmQ4g8ECiTcai8GP8d0AhUemgSHO8=;
        b=B/HFPyymipxD+VKhIf41Sk33lPHk+rP1vRVy9KlbKrzUSe3l4wyQVpTbdGc8mUEoKH
         WQtVn8TOgEc0XoqzEK+SSl2/FK01uhTeFrVeB700h+DOT5T6XXcBEbvtFDTtW8iJ3SHF
         9MnrPJEzmerQhFWwSgj5LEn5rM8bZXCIbRsyMXcgOQYmFqHy81AmPf0eRa0CGS/7vY+X
         xgx7beNotZkkE6k3LeLj67H4cRWsXEgWKaYrPihu7GlFVRP4hgvMry5boXUTfX4K+f7L
         UsjR7/OlBmnJJeDfQ5MsvaFYSlW4Y1QECd3UnNOmtlbY8B2AW4qyfHruLHySMHvsvGp6
         Acbw==
X-Gm-Message-State: AOAM5308s+lzOmd2EOBT50wAvwtQvj6Y9RQEA/rCvgJGEUQWf9eQ5eFn
        7wrql0Mo/qA1U4C/tCV9KRuMOg==
X-Google-Smtp-Source: ABdhPJy6hlLynDSJQAGPzvTJ0LukysVmmQM/TeklBwIrSogkOIxOEnVL4GhueV2LP4pjVnW+fum2NA==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr567186wma.101.1592428137695;
        Wed, 17 Jun 2020 14:08:57 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id t188sm1014794wmt.27.2020.06.17.14.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:08:57 -0700 (PDT)
Date:   Wed, 17 Jun 2020 21:08:55 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        dafna.hirschfeld@collabora.com, linux-kernel@vger.kernel.org,
        tfiga@google.com, hans.verkuil@cisco.com, kernel@collabora.com,
        Wojciech Zabolotny <wzab01@gmail.com>
Subject: Re: [PATCH] media: staging: rkisp1: isp: check return value from
 phy_*
Message-ID: <20200617210855.GA81308@chromium.org>
References: <20200617182229.164675-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617182229.164675-1-helen.koike@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helen,

On Wed, Jun 17, 2020 at 03:22:29PM -0300, Helen Koike wrote:
> When starting streaming, do not ignore return value from phy_set_mode(),
> phy_configure() and phy_power_on().
> If it fails, return error to the user.
> 
> Fixes: d65dd85281fb ("media: staging: rkisp1: add Rockchip ISP1 base driver")
> 
> Reported-by: Wojciech Zabolotny <wzab01@gmail.com>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 
> ---
> 
>  drivers/staging/media/rkisp1/rkisp1-isp.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 

Thank you for the patch. Please see my comments inline.

> diff --git a/drivers/staging/media/rkisp1/rkisp1-isp.c b/drivers/staging/media/rkisp1/rkisp1-isp.c
> index dc2b59a0160a8..531047fc34a01 100644
> --- a/drivers/staging/media/rkisp1/rkisp1-isp.c
> +++ b/drivers/staging/media/rkisp1/rkisp1-isp.c
> @@ -892,6 +892,7 @@ static int rkisp1_mipi_csi2_start(struct rkisp1_isp *isp,
>  	union phy_configure_opts opts;
>  	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
>  	s64 pixel_clock;
> +	int ret;
>  
>  	if (!sensor->pixel_rate_ctrl) {
>  		dev_warn(sensor->sd->dev, "No pixel rate control in subdev\n");
> @@ -906,9 +907,24 @@ static int rkisp1_mipi_csi2_start(struct rkisp1_isp *isp,
>  
>  	phy_mipi_dphy_get_default_config(pixel_clock, isp->sink_fmt->bus_width,
>  					 sensor->lanes, cfg);
> -	phy_set_mode(sensor->dphy, PHY_MODE_MIPI_DPHY);
> -	phy_configure(sensor->dphy, &opts);
> -	phy_power_on(sensor->dphy);
> +
> +	ret = phy_set_mode(sensor->dphy, PHY_MODE_MIPI_DPHY);
> +	if (ret) {

nit: I don't seem to be able to find any documentation for this API and
it's not clear if it's guaranteed that the API doesn't return positive
values. It would probably be safer to check for ret < 0.

> +		dev_err(sensor->sd->dev, "Fail setting MIPI DPHY mode\n");
> +		return -EINVAL;

Should we just return ret?

> +	}
> +
> +	ret = phy_configure(sensor->dphy, &opts);
> +	if (ret && ret != -EOPNOTSUPP) {

Why are we okay with -EOPNOTSUPP?

> +		dev_err(sensor->sd->dev, "Fail configuring MIPI DPHY\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = phy_power_on(sensor->dphy);
> +	if (ret) {
> +		dev_err(sensor->sd->dev, "Fail powering on MIPI DPHY\n");
> +		return -EINVAL;

Ditto.

Best regards,
Tomasz
