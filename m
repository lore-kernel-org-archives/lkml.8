Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27091C55185
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 03:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060C12073A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 03:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E11SChRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDWDNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 23:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgDWDNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 23:13:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7267C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 20:13:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c21so952492plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4fisqMMsjkXIIaoiEwZqz/+KMKxIEdSIi4Ag2uuUrns=;
        b=E11SChRwqleTAcPL0IoAAxo4iRW6XMOWC4C4UyPdxP6yfE1X3pgodeSDiYhHBEdKIk
         /dfWrRMsblKCxVJArb1Tla8FkT0ri/AMw8W6K8LeXTuYmOUXkFMyl+KwJHpBKdJe3hLE
         bHCzfwOF6e4m2EGh+Mpj9j+hC0TCWP7XmAvmQKLQQJasTJWCmm37mgaymwf2NhGJs/aW
         BF0HBMuGbL0RXKCSwLUNC9AD09ceGaxVbnPy7xDBNp4+5KbPU9Yk27zyCf4zk9QbjLi9
         wFHK3yqPXEev5C5pAP2xaTvLD+lACbML75KOaVVj79X9BpOOvPao+eSe3BOnWuL7Rbyz
         qwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4fisqMMsjkXIIaoiEwZqz/+KMKxIEdSIi4Ag2uuUrns=;
        b=by8wW5BA6nFp2wy8a8cWAw4hUXkwJVwvDht41vusu3butqhXC4HE5dRPCd2mGAmlKW
         JZtdkjV/y+rAsPCq3G59Eqzy1OgDkLukTf1wq+IV73RswMDBAxkB2K7vjiXTSi69agWn
         9ZxhmDZkeJ7s96VnBWVLqLIi4XZpHPipml2XHIDRCQyuT0pwfLMqxNPtTCAbPoJQ3nuJ
         t3pm3XAeA6TdAZYBe4Z+u4ZxMSzARBFwh5N8N9lIm99pAQrmFAWT/uXk2HEg9gv56+gl
         0TSwIqzOykPMzoh+losWg3Uf1o1jjp8WhLaN2fV4BSn1cnBHUt0BkOsrlkDV8hoFY2Ca
         xfxw==
X-Gm-Message-State: AGi0PuYvdjuxs+Akyl8khMckgSNBXtOHcTP+uzl7FEDe9dTTVbfMB4Pt
        u/Lx4klVit8KyHvf0K7kYlX22w==
X-Google-Smtp-Source: APiQypLH6jXOlspqqLhFHI3VKsHcXSlBrETFXKdD0T4wHUQdx55V6QAW3InFyjhpVSnNPDAvQjkvnA==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr1738972ple.183.1587611590028;
        Wed, 22 Apr 2020 20:13:10 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z25sm968561pfa.213.2020.04.22.20.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 20:13:09 -0700 (PDT)
Date:   Wed, 22 Apr 2020 20:13:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qualcomm: usb-hs-28nm: Prepare clocks in init
Message-ID: <20200423031307.GI987656@yoga>
References: <20200408012854.3070187-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408012854.3070187-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Apr 18:28 PDT 2020, Bjorn Andersson wrote:

> The AHB clock must be on for qcom_snps_hsphy_init() to be able to write
> the initialization sequence to the hardware, so move the clock
> enablement to phy init and exit.
> 
> Fixes: 67b27dbeac4d ("phy: qualcomm: Add Synopsys 28nm Hi-Speed USB PHY driver")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Kishon, can we have this picked up?

Thanks,
Bjorn

> ---
>  drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c | 32 ++++++++++++++-------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c b/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
> index d998e65c89c8..a52a9bf13b75 100644
> --- a/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
> +++ b/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
> @@ -160,18 +160,11 @@ static int qcom_snps_hsphy_power_on(struct phy *phy)
>  	ret = regulator_bulk_enable(VREG_NUM, priv->vregs);
>  	if (ret)
>  		return ret;
> -	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
> -	if (ret)
> -		goto err_disable_regulator;
> +
>  	qcom_snps_hsphy_disable_hv_interrupts(priv);
>  	qcom_snps_hsphy_exit_retention(priv);
>  
>  	return 0;
> -
> -err_disable_regulator:
> -	regulator_bulk_disable(VREG_NUM, priv->vregs);
> -
> -	return ret;
>  }
>  
>  static int qcom_snps_hsphy_power_off(struct phy *phy)
> @@ -180,7 +173,6 @@ static int qcom_snps_hsphy_power_off(struct phy *phy)
>  
>  	qcom_snps_hsphy_enter_retention(priv);
>  	qcom_snps_hsphy_enable_hv_interrupts(priv);
> -	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
>  	regulator_bulk_disable(VREG_NUM, priv->vregs);
>  
>  	return 0;
> @@ -266,21 +258,39 @@ static int qcom_snps_hsphy_init(struct phy *phy)
>  	struct hsphy_priv *priv = phy_get_drvdata(phy);
>  	int ret;
>  
> -	ret = qcom_snps_hsphy_reset(priv);
> +	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
>  	if (ret)
>  		return ret;
>  
> +	ret = qcom_snps_hsphy_reset(priv);
> +	if (ret)
> +		goto disable_clocks;
> +
>  	qcom_snps_hsphy_init_sequence(priv);
>  
>  	ret = qcom_snps_hsphy_por_reset(priv);
>  	if (ret)
> -		return ret;
> +		goto disable_clocks;
> +
> +	return 0;
> +
> +disable_clocks:
> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> +	return ret;
> +}
> +
> +static int qcom_snps_hsphy_exit(struct phy *phy)
> +{
> +	struct hsphy_priv *priv = phy_get_drvdata(phy);
> +
> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
>  
>  	return 0;
>  }
>  
>  static const struct phy_ops qcom_snps_hsphy_ops = {
>  	.init = qcom_snps_hsphy_init,
> +	.exit = qcom_snps_hsphy_exit,
>  	.power_on = qcom_snps_hsphy_power_on,
>  	.power_off = qcom_snps_hsphy_power_off,
>  	.set_mode = qcom_snps_hsphy_set_mode,
> -- 
> 2.24.0
> 
