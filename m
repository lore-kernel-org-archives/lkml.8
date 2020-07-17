Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C294FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FDD320704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzQEnJsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgGQURa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQUR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:17:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688FBC0619D4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:17:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 207so5924813pfu.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iywrvyPBUDOgHRTdq53ACuS34hQViRNteLGcc1mvGYA=;
        b=ZzQEnJsNJiKD1+yaEqf4xcmZtSkJVW4gUh/WVumhUke25claBLvOg39F57AjX/yF+t
         IvyVWmqsEW1BG1/7ICm+lb5tIZHbhj6w4nT+BPSJ6CibQrPdK+8W8oAm9ZV7+CSh3o1L
         9SBC3nq8OLCaa+A3fSH2QIaFY3KBeCMeHL73w5dOYvvE1PpkBGOCFRx8y6ZlQ31K2kAi
         ZxpJ9UEIW9v0vrZQNDYA2jBFcqpLUTC5ham8evExg5OaVhsyNcwqAZTR3fjV6lHUUC3g
         enqTg+ha9FChfUqjoDjg6uCiikxsYcZBbiKoKMsgyjIjrKE6ubdCgM7ABH06BNxm421j
         xWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iywrvyPBUDOgHRTdq53ACuS34hQViRNteLGcc1mvGYA=;
        b=cuq6tyhml8dmTn7wkLFid7uhSm0Ab/aSVsUgH+RnvZLEacrBJDkDLEZfLXHqVDuxoX
         WVzMkQ7OHqi0f+UKb45HcrC/oobl7rGrhLMrUWy27jIX57IdMuLQ7FgugMtx044ABwJB
         +Lc1s/BJ5TZjmmLYqra/OLQ/GOeQLDRMXdusfQ2vKKv5RPStHFHALte8rHBOvZZ0RRRJ
         N/7XNX/gR8N18WPP8LfLyFwrl6ZvOi2dO2Gx+3Fmkp9Utu3+OKfPGlGIXkAahYGsFXWs
         y2WOCU90jnPAp5UNcylksv5dVXmRNOHorMzzgl2qKtsiQz86mlm4GMNW5lMeucU2XnNF
         gZJw==
X-Gm-Message-State: AOAM532a/uR5vNx1/CXrjJo9OFAn3q5VHUG5r1/FturDojHH1O6QF7+/
        Cnb6X5N/rDbMuff1eZZDZRnikw==
X-Google-Smtp-Source: ABdhPJz7Sa8W0Soyk0M+slHFD6+b0FyIRfrfoarpP+teJuhSDo13gE34xXY80gmRSxgao04OxKIvOg==
X-Received: by 2002:a63:c150:: with SMTP id p16mr10228264pgi.141.1595017047679;
        Fri, 17 Jul 2020 13:17:27 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w12sm3084248pjb.18.2020.07.17.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 13:17:26 -0700 (PDT)
Date:   Fri, 17 Jul 2020 13:15:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 26/30] iio: adc: qcom-pm8xxx-xoadc: Demote standard
 comment block and supply missing description
Message-ID: <20200717201525.GK388985@builder.lan>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
 <20200717165538.3275050-27-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717165538.3275050-27-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17 Jul 09:55 PDT 2020, Lee Jones wrote:

> Kerneldoc is only suitable for documenting functions and struct/enums.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_INTERNAL' description in 'PM8XXX_CHANNEL_INTERNAL'
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_125V' description in 'PM8XXX_CHANNEL_INTERNAL'
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_INTERNAL_2' description in 'PM8XXX_CHANNEL_INTERNAL'
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_MUXOFF' description in 'PM8XXX_CHANNEL_INTERNAL'
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c:412: warning: Function parameter or member 'variant' not described in 'pm8xxx_xoadc'
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index c599ffa45a04c..cd5fa30e77df4 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -120,7 +120,7 @@
>  #define ADC_ARB_USRP_DATA0			0x19D
>  #define ADC_ARB_USRP_DATA1			0x19C
>  
> -/**
> +/*
>   * Physical channels which MUST exist on all PM variants in order to provide
>   * proper reference points for calibration.
>   *
> @@ -388,6 +388,7 @@ struct pm8xxx_chan_info {
>   * struct pm8xxx_xoadc - state container for the XOADC
>   * @dev: pointer to device
>   * @map: regmap to access registers
> + * @variant: XOADC variant characteristics
>   * @vref: reference voltage regulator
>   * characteristics of the channels, and sensible default settings
>   * @nchans: number of channels, configured by the device tree
> -- 
> 2.25.1
> 
