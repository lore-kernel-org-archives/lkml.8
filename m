Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A993BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 04:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF4B2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 04:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBxaHLfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHZEg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 00:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgHZEg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 00:36:27 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD88C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 21:36:27 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j18so430375oig.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kyOrvxFXtNgL4zAGtOMZFfz+8v3uTAeplQcWa0UdSXE=;
        b=eBxaHLfk5gupA6m97Igqg9fXphuauyec7V3i1sevHB0042s9k2MZgr6n6SsIeH8R3+
         eGBqCegNIkXii7iMYSFtWQZtZGhhxCFPx7w6Pw/xMboHJI0MqJl4Lem6Q0ntoPHUms4r
         Eyt82Jdl9JCqg2tmk19Zd6BM7tKxiHCeuYS2APTrBZGrGSXotvQiolJl7AnfQlhnKPdW
         vYyYooFhsCP/RVhT507xlosyC+6iel2pPFAcd4bxRemhRctQYREbUp0ldjWWNFLhmh2H
         wBIH9VAdMAwLpXUfyUbyAVCTNWDihVt9L9yQDqF+YvW0Oqh4vu8BzK88No3wqLpu7e3c
         0GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kyOrvxFXtNgL4zAGtOMZFfz+8v3uTAeplQcWa0UdSXE=;
        b=PvMwJejCV7tmTmYPKv3/HQ6qMFXCPmgMDRwF8esXoDnEjsS8FsV8mcOVPJL5epsZ9m
         6aHBgRuZRfMBQVELhaOmxzsL6H8G8u88xW3htjcfhmgcuPHSHqKfND/1pwKNcfisIeJq
         1v8Z0tLIsNzlqnr+1euAZX3Odu5TAvVdM6tgsNsaj6hFC3h3YwFKGcNdKLpMQJdUc38R
         GW38Pna6kU4RAX12wa6NJfY2qDNo6slXsyPelQ2dxADy1bu+A5SESuQRVd73l4YdMhyV
         XzVU2WNDc2buYFyl9WD7urN4o4dbs6nXMyz8/IVQ21mzWx+zJvLvlomkH1FzGfnpwh9D
         lDSQ==
X-Gm-Message-State: AOAM531OYkYmT5XPx8EJgddsnKLPGXCPf1pdqzYGlJcHuq+0pvRa3DGF
        z4Tpm3toJtH0PQtKTE93RZvSdg==
X-Google-Smtp-Source: ABdhPJwBkWrJyFQrh2DP9xWSIS/5wMqZGkYF8N/fkzeeP/jxn/K5njYM9Snl7RByH+kmUAMdeyKZaA==
X-Received: by 2002:a54:4791:: with SMTP id o17mr2763820oic.4.1598416585587;
        Tue, 25 Aug 2020 21:36:25 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id v200sm17257oie.20.2020.08.25.21.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 21:36:24 -0700 (PDT)
Date:   Tue, 25 Aug 2020 23:36:16 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v1 5/9] phy: qcom-qmp: Get dp_com I/O resource by index
Message-ID: <20200826043616.GF3715@yoga>
References: <20200826024711.220080-1-swboyd@chromium.org>
 <20200826024711.220080-6-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826024711.220080-6-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Aug 21:47 CDT 2020, Stephen Boyd wrote:

> The dp_com resource is always at index 1 according to the dts files in
> the kernel. Get this resource by index so that we don't need to make
> future additions to the DT binding use 'reg-names'.
> 

Afaict the DT binding for the USB/DP phy defines that there should be a
reg name of "dp_com" and the current dts files all specifies this. Am I
missing something?

PS. Why isn't this a devm_platform_ioremap_resource{,_byname}()?

Regards,
Bjorn

> Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
> Cc: Chandan Uddaraju <chandanu@codeaurora.org>
> Cc: Vara Reddy <varar@codeaurora.org>
> Cc: Tanmay Shah <tanmay@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Manu Gautam <mgautam@codeaurora.org>
> Cc: Sandeep Maheswaram <sanm@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Jonathan Marek <jonathan@marek.ca>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 40c051813c34..76d7a9e80f04 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -3266,8 +3266,7 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
>  
>  	/* per PHY dp_com; if PHY has dp_com control block */
>  	if (cfg->has_phy_dp_com_ctrl) {
> -		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -						   "dp_com");
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  		base = devm_ioremap_resource(dev, res);
>  		if (IS_ERR(base))
>  			return PTR_ERR(base);
> -- 
> Sent by a computer, using git, on the internet
> 
