Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEDBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE352054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKxE6Ezb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390430AbgEMTJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMTJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:09:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A94C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:09:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b8so153670pgi.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mPeSDkrzJQqPILvuZ/g9BUh2SNJeTKycrCrn0jKvjdo=;
        b=sKxE6EzbsM/5GH2G8e1JZrsFqmIjEw7ypaSkS74AMV7acR+v3CGethJTLeVs13G/3u
         nDbxtDSrvq7nrnsdM6XOF0SjhCUytV6HQ7Gx0VQPYkpdnRUU74E4im3+TQWPGfh0RfQb
         oLxpqHSIKaG2oPfjP6ohs1AMYLZsWbwd5tjnQGxyUL3hFOVw8jMn2cNqEpqAJfzKZ7RY
         dxdM56PLiktpJp2OuMrAsgmPUuOwLr3QDv0nrTPFJFqFR7Hj1/1Ouzt2RXtiThAX6xPM
         ECzQp/nnLcf48LBoYcQgEUBiL6ah4FOCbtElly68Vy+ntBZBiU2KQ3S0x0w0RQQP79q6
         lheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPeSDkrzJQqPILvuZ/g9BUh2SNJeTKycrCrn0jKvjdo=;
        b=c3Kn0BBGn16NHOx91xHEraisoG5TInM3p/o0ZyixeeS/t0VmhqHVdpNDV1Ia/H1/Ku
         w2s7U8VlQV2Osz5OP1lHqm+lbhakCw0LRxyidWZ481SrYa2ZZViKDGaT/418XsnKP66W
         RUp9isoUE6IcVVX+sDv8detH3SECLewyUtk75YWu0J/s3M6WGW73xmaw/hJIrxQgkVRm
         svD+w1AhdNDnHL6pnc/mduBZ2OjSyO6wHrdaG0FgpWkGevymfQURASlb4QJPiFHkB6RE
         C4cZ1ZLP86Qa6OWORTUj7cxAB40jpvQqi+rEmiE7f/5IAPYdjWimV404ymq3RS1hTBRx
         jezQ==
X-Gm-Message-State: AOAM5312OibyuHwvKi61hGZf+FzYQ4xLcneQ1IYlDi72udms7qMfXLYX
        6YgTPUgTWXBn3uROZOjvQmGjdQ==
X-Google-Smtp-Source: ABdhPJxvuxhAazLApTjz3FqiX9smw1rIvssGyz1uG1QoLowJJkwfEt4wQlhuMvntn7nvwUy9jgxE4g==
X-Received: by 2002:a62:3642:: with SMTP id d63mr731063pfa.222.1589396964679;
        Wed, 13 May 2020 12:09:24 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v3sm252249pfv.186.2020.05.13.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 12:09:24 -0700 (PDT)
Date:   Wed, 13 May 2020 12:07:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 2/6] spi: spi-geni-qcom: Use OPP API to set clk/perf
 state
Message-ID: <20200513190752.GS2165@builder.lan>
References: <1589368382-19607-1-git-send-email-rnayak@codeaurora.org>
 <1589368382-19607-3-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589368382-19607-3-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 May 04:12 PDT 2020, Rajendra Nayak wrote:

> geni spi needs to express a perforamnce state requirement on CX
> depending on the frequency of the clock rates. Use OPP table from
> DT to register with OPP framework and use dev_pm_opp_set_rate() to
> set the clk/perf state.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Cc: linux-spi@vger.kernel.org
> ---
> This patch will need to land via the msm tree because of a dependency
> with another change.
> Change in v5: OPP cleanup done as the last thing in spi_geni_remove()
> 
>  drivers/spi/spi-geni-qcom.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index c397242..0d7ead1 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -7,6 +7,7 @@
>  #include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/qcom-geni-se.h>
>  #include <linux/spi/spi.h>
> @@ -95,7 +96,6 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>  {
>  	unsigned long sclk_freq;
>  	unsigned int actual_hz;
> -	struct geni_se *se = &mas->se;
>  	int ret;
>  
>  	ret = geni_se_clk_freq_match(&mas->se,
> @@ -112,9 +112,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>  
>  	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
>  				actual_hz, sclk_freq, *clk_idx, *clk_div);
> -	ret = clk_set_rate(se->clk, sclk_freq);
> +	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
>  	if (ret)
> -		dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
> +		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
>  	return ret;
>  }
>  
> @@ -561,6 +561,17 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	mas->se.wrapper = dev_get_drvdata(dev->parent);
>  	mas->se.base = base;
>  	mas->se.clk = clk;
> +	mas->se.opp_table = dev_pm_opp_set_clkname(&pdev->dev, "se");
> +	if (IS_ERR(mas->se.opp_table))
> +		return PTR_ERR(mas->se.opp_table);
> +	/* OPP table is optional */
> +	ret = dev_pm_opp_of_add_table(&pdev->dev);
> +	if (!ret) {
> +		mas->se.has_opp_table = true;
> +	} else if (ret != -ENODEV) {
> +		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
> +		return ret;
> +	}
>  
>  	spi->bus_num = -1;
>  	spi->dev.of_node = dev->of_node;
> @@ -596,6 +607,9 @@ static int spi_geni_probe(struct platform_device *pdev)
>  spi_geni_probe_runtime_disable:
>  	pm_runtime_disable(dev);
>  	spi_master_put(spi);
> +	if (mas->se.has_opp_table)

Why do you need has_opp_table?

Afaict if dev_pm_opp_of_add_table() returns -ENODEV there's no attached
opp-table and dev_pm_opp_of_remove_table() is a nop.

Regards,
Bjorn

> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(mas->se.opp_table);
>  	return ret;
>  }
>  
> @@ -609,6 +623,9 @@ static int spi_geni_remove(struct platform_device *pdev)
>  
>  	free_irq(mas->irq, spi);
>  	pm_runtime_disable(&pdev->dev);
> +	if (mas->se.has_opp_table)
> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(mas->se.opp_table);
>  	return 0;
>  }
>  
> @@ -617,6 +634,9 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
>  	struct spi_master *spi = dev_get_drvdata(dev);
>  	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>  
> +	/* Drop the performance state vote */
> +	dev_pm_opp_set_rate(dev, 0);
> +
>  	return geni_se_resources_off(&mas->se);
>  }
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
