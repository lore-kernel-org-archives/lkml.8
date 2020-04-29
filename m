Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318A4C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6B2206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XpsPFxZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgD2Atu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD2Att (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:49:49 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2A1C035493
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:49:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h11so171304plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q3EtAKvEWUW0/w8OE9AzaYUShPhgEQZLo83EeVoVlc8=;
        b=XpsPFxZaKEr5HNrwdLuHLBro4Q5ws03ekVwIfeuLisq1Awlppg8GH1tIGMYhyA3Sz7
         4ATUAgx1MVLSFttmueMe1mlHnEbFsthxOxWIC17+NLy43GuPldaWJCd03/bFRfP+HvVP
         x30IY/T14k/EHzusAjSy+CzGRfkwgknV2LEc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q3EtAKvEWUW0/w8OE9AzaYUShPhgEQZLo83EeVoVlc8=;
        b=DJWlQyxPEE6niY9jNcAE+tI9GrTjbb8ZD2CH/BXYGD7+b2L3ZSI69E/875MYDjrejb
         YusImlwIbrtCvT5BMpFfWFq2jJNW/WJ5jPKIVwWC5k9CWjZtCoBA7EncBO15NxWxlQMN
         d0b70VjLmfoJ8EiA+i73OaPIbNnwV56Tke0qWA+2EzF4+ygD62k3/v4KQMTb3IVr2ep/
         VuW/dQlK/X0cICcRzbjWynGVK3HaZ8jfTGL9C7C4hb2nH9f1mpeq18wlaOMVqwB2xt8C
         A3wQ/Uu2G8j3eTPd1gnhTvJzyXijNfirtyVgHV/ua+hp5WwnBs5uFbwdI6XDjQdUSBiM
         0jLA==
X-Gm-Message-State: AGi0PubvAQiyMDsLnnttwuY0pQK4oIUtqmcAcnL0Amb8khEeiRqX4Q2m
        XV8LbYHpIftLG48c+2wdKHybgQ==
X-Google-Smtp-Source: APiQypKbNcABrcklk/jOHdelRiUtXSs4G6lWcVte78/wBQee0IK+DS+s0hk+TPBBJkWfCkERI4hA4A==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr29864763pll.113.1588121387832;
        Tue, 28 Apr 2020 17:49:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b3sm14073059pgh.75.2020.04.28.17.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 17:49:47 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:49:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 15/17] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
Message-ID: <20200429004945.GP4525@google.com>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-16-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1588080785-6812-16-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 28, 2020 at 07:03:03PM +0530, Rajendra Nayak wrote:
> QSPI needs to vote on a performance state of a power domain depending on
> the clock rate. Add support for it by specifying the perf state/clock rate
> as an OPP table in device tree.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Cc: linux-spi@vger.kernel.org
> ---
>  drivers/spi/spi-qcom-qspi.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 3c4f83b..724a658 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -8,6 +8,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_opp.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
>  
> @@ -139,6 +140,8 @@ struct qcom_qspi {
>  	struct device *dev;
>  	struct clk_bulk_data *clks;
>  	struct qspi_xfer xfer;
> +	struct opp_table *opp_table;
> +	bool has_opp_table;
>  	/* Lock to protect xfer and IRQ accessed registers */
>  	spinlock_t lock;
>  };
> @@ -235,7 +238,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
>  		speed_hz = xfer->speed_hz;
>  
>  	/* In regular operation (SBL_EN=1) core must be 4x transfer clock */
> -	ret = clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz * 4);
> +	ret = dev_pm_opp_set_rate(ctrl->dev, speed_hz * 4);
>  	if (ret) {
>  		dev_err(ctrl->dev, "Failed to set core clk %d\n", ret);
>  		return ret;
> @@ -481,6 +484,20 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  	master->handle_err = qcom_qspi_handle_err;
>  	master->auto_runtime_pm = true;
>  
> +	ctrl->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
> +	if (IS_ERR(ctrl->opp_table)) {
> +		ret = PTR_ERR(ctrl->opp_table);
> +		goto exit_probe_master_put;
> +	}
> +	/* OPP table is optional */
> +	ret = dev_pm_opp_of_add_table(&pdev->dev);
> +	if (!ret) {
> +		ctrl->has_opp_table = true;
> +	} else if (ret != -ENODEV) {
> +		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
> +		return ret;

		goto exit_probe_master_put;
