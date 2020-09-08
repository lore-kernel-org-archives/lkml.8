Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638B1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2FE21D43
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCX6C2mF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgIHIWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbgIHIWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:22:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D051C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:22:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so18155416wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hRCUpBJbsTPAmTlNPl9II0p+aJCvPnoFM+9BG9MADrY=;
        b=RCX6C2mFrmwa11KW2xUmEyK0/yQavByhhFvoRiMdE/JP6krDXKM6niXvQ6/hcHX/zt
         INqiSfPRTRYOwev2eSTi/K1ZKeXO4y4nE7NaTYriNzceiBNnWuiECp6OGTE94HdKQcAH
         RxcpHLNXK8fhOsVS8GmADSXV9oos4nEAjYFvBDu4Ni3QXVXXQg/r1IEhFTam2gA77lpt
         s8xcYaco/PycR4vzvi6SyTC0+6YQvhvMUZ20ERdH3nC4freEPamfBUG2q7Xy0vL+oUWY
         M8yMuhF6TsrbtXL5ZynI80t0y2TlkPYPVW7xSxAMXk4vjsC7TYF94zDWqk9tdBBFkbVR
         SWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hRCUpBJbsTPAmTlNPl9II0p+aJCvPnoFM+9BG9MADrY=;
        b=Mp81ImZ+RHN2M9Pfp84unPFfOD4Stksa9PI1X8GhL/pN6bUrUxbp7k+5WoMCkY6cfr
         RHOAXlA+NvO4S04ShhgEA8IWb4IbGkzeCilypgca1mQCp6X+D7aW52d/oEggr19j8ib2
         2RQrTHQSxNke/a5I22ld39WfM0FcFHI+cuTjB6/ROqeCgjVKHz5IkoBhJ8WLsltefkMk
         J3oHXv1G27DHHSuFLXk51IdICmSuWgn1wrRbH9JHHi6OuNs5sddDvNcbiJzrEBA3BCMi
         eoo6PuQVqQbvCjqOFRbO7LerRl7dE8l443hNoDe20NuFf91J6/E3od4pcLxPrQjEDex+
         7DZw==
X-Gm-Message-State: AOAM530SIt7Bj+/eoLzxD+KSwatQ3Ugp3Mo6ExRyyaVZrUya4GhkOT60
        bMVTSBOTXwHpMz4lwweA4uE/Bg==
X-Google-Smtp-Source: ABdhPJx4WuDajYdzs1cXwQPvbTepCBmMIa1dvKOuiFmlzLlhs/o2WqZVGcHrpcRsvnYNkh1CuRVo0g==
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr26188814wrr.104.1599553356703;
        Tue, 08 Sep 2020 01:22:36 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f6sm32223618wro.5.2020.09.08.01.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:22:36 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:22:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Suman Anna <s-anna@ti.com>,
        kernel-team@android.com
Subject: Re: [PATCH] mfd: syscon: Don't free allocated name for regmap_config
Message-ID: <20200908082234.GD4400@dell>
References: <20200903160237.932818-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200903160237.932818-1-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020, Marc Zyngier wrote:

> The name allocated for the regmap_config structure is freed
> pretty early, right after the registration of the MMIO region.
> 
> Unfortunately, that doesn't follow the life cycle that debugfs
> expects, as it can access the name field long after the free
> has occured.
> 
> Move the free on the error path, and keep it forever otherwise.
> 
> Fixes: e15d7f2b81d2 ("mfd: syscon: Use a unique name with regmap_config")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Does this work for you Suman, Arnd?

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 75859e492984..7a660411c562 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -108,7 +108,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	syscon_config.max_register = resource_size(&res) - reg_io_width;
>  
>  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
> -	kfree(syscon_config.name);
>  	if (IS_ERR(regmap)) {
>  		pr_err("regmap init failed\n");
>  		ret = PTR_ERR(regmap);
> @@ -145,6 +144,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	regmap_exit(regmap);
>  err_regmap:
>  	iounmap(base);
> +	kfree(syscon_config.name);
>  err_map:
>  	kfree(syscon);
>  	return ERR_PTR(ret);

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
