Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DB9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 03:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC1820714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 03:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6d5SPlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbgGVDsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 23:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbgGVDsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 23:48:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058FDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 20:48:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so460601pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 20:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G5KYjb9bNgf9eCCuCYizkaT2kpB0m1ixCzJ1dcGJY6U=;
        b=V6d5SPltSWqumvHstU3VvtLH3Ci84LGquioPfjldy1c4jhoQ6FglxljnmTta/cKn+T
         qIcb73/3/Zq5LzqI+8Pdijq8nmyesJbsxBubdTV4uA/K+CEfCl0t2wbrmjCM1Bi79Hvd
         uRDKG72AbHFIAZY3whaU+wxChhzDp4CiViLqQugbf7Zfy2Ob0xKH52lgjvJkm+5SrsB1
         /pw16L22jEI8bHLKdleJtlTaNbG6wdY69zqC9mtS0n9vQu4yMUTfkBHoz8OZMDCBZFS6
         egrg/DTuecWnSNHSjcVkGw82Rm50z4ISCRC8t8LfAjZJv6IQ2RFd+23SO7+xYIeeuT+k
         UxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G5KYjb9bNgf9eCCuCYizkaT2kpB0m1ixCzJ1dcGJY6U=;
        b=K1x0Ux+2pwPUXS8R6gVPlUO1XW2Z90R4e7s7Az4n8wfWoNzOl0UokXNHDNFYojWXxC
         1LqhBUgD2DicTX7ooymYlVNQ14LN2pERMUf2p08I2qVgdupSGdeE/DIolL42A1fElgfc
         IQFVsrpJjiHFjJ+5Uj6nd9cSDoCYvA/UilW9zFMusU0zbZAsIRG1tqKfUT/8r7oYDCpL
         yiI0GU898kvSywwgHDgSFeDFUBjH5Tey4f/XNgL6HfvgJeB2Z7ZACJFNeTMhsY0DVU1J
         VPaU0CdlTH2z/VRASBiArDMs2tdZ4u+j65oqulY2YFG3DaLMjrt90KqAg9yHm3WZHzi0
         8OKQ==
X-Gm-Message-State: AOAM530PmG++YfKsHk+hEvG/pd3bafG/lDo9zHRg/xwjKJAYcL5rpAOP
        62FTjLZELK8NHfly+invFZgvkQ==
X-Google-Smtp-Source: ABdhPJxHUzJMxV2Q5+PGR2CNZ4P47YBRSndklbesbF/hAWkYin017A7oyZFQAs4vvRl+MU0+ZZw73A==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr8219218pjp.228.1595389718402;
        Tue, 21 Jul 2020 20:48:38 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e8sm21383713pff.185.2020.07.21.20.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 20:48:37 -0700 (PDT)
Date:   Tue, 21 Jul 2020 20:46:44 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mka@chromium.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7180: Include xo clock to sdhc
 clocks list
Message-ID: <20200722034644.GP388985@builder.lan>
References: <1595328268-29398-1-git-send-email-sbhanu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595328268-29398-1-git-send-email-sbhanu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 Jul 03:44 PDT 2020, Shaik Sajida Bhanu wrote:

> From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> 
> Include xo clock to sdhc clocks list which will be used
> in calculating MCLK_FREQ field of DLL_CONFIG2 register.
> 

Can you please describe why this is useful, perhaps required? What
difference does this make and what problem does it resolve?

If required please include a Fixes: tag here to show that you're fixing
the previous commit.

Thanks,
Bjorn

> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index d78a066..7ccb780 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -682,8 +682,9 @@
>  			interrupt-names = "hc_irq", "pwr_irq";
>  
>  			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> -					<&gcc GCC_SDCC1_AHB_CLK>;
> -			clock-names = "core", "iface";
> +					<&gcc GCC_SDCC1_AHB_CLK>,
> +					<&xo_board>;
> +			clock-names = "core", "iface", "xo";
>  			interconnects = <&aggre1_noc MASTER_EMMC &mc_virt SLAVE_EBI1>,
>  				<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_EMMC_CFG>;
>  			interconnect-names = "sdhc-ddr","cpu-sdhc";
> @@ -2481,8 +2482,9 @@
>  			interrupt-names = "hc_irq", "pwr_irq";
>  
>  			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> -					<&gcc GCC_SDCC2_AHB_CLK>;
> -			clock-names = "core", "iface";
> +					<&gcc GCC_SDCC2_AHB_CLK>,
> +					<&xo_board>;
> +			clock-names = "core", "iface", "xo";
>  
>  			interconnects = <&aggre1_noc MASTER_SDCC_2 &mc_virt SLAVE_EBI1>,
>  				<&gem_noc MASTER_APPSS_PROC &config_noc	SLAVE_SDCC_2>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
