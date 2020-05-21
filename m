Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DA020738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flKVBAWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgEUTI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgEUTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:08:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DCCC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:08:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b190so3800142pfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z9lfKcpsk04+MOjenH3XmZ96ZShPJypXmsAOWsF+hL8=;
        b=flKVBAWuiWwOAA9S9JGU6N3N3DZ1k/BIhgDYq+IJS1Lh9cBYnnY/7UPOZRlCYVLpRg
         rpH3swfpnnGOb/2ynI7ZJWJv1sAa0Rl7icksSX+XYvnyJIKfz1WpK2N15qchQgje3pON
         gB/8dfYLAeu1puK6NUs3AuQOkUCCHaJUHkEW/ZwfSWm5XCR3B2eGleNyGLKrt7ujLMEv
         Nq04dkI45QpGkqcXsUOaPGeo3vMiyqMl4BQV1GGZTDl7xEEGTThMvrVZOdz7PlKYuqv9
         GVTGZBdxVohQXb6pnXI+zAcA1d1vjxRkgwLOkGtChAFBSdQIA5i0RdLYRPx1QDSit9Pq
         rJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z9lfKcpsk04+MOjenH3XmZ96ZShPJypXmsAOWsF+hL8=;
        b=ag+u3CmnBfSoPQ0Yvw/rFEVWOXim4gvQJmQnNDlzI1EKtDxl4Bv4Buw7abqC+jam3c
         6opgOkIfRuhiqqlbUezWiaCDStTyk1v9U0MePj/Ki04bWe28B9Jt6bWtsW4crPS3X4da
         0ccFuRjbX5/SRd7/e0C4/S+e1Tp0KQokOw2TKdPJZPBoN1rtLzjKVDo+nr1dk3wP/CDE
         94MApUrk4RIINVx+nsJ2OZvteU7as+5OIGsgpdxyVDz+h3RrwEnJeUAT/zXFmwbE+qQM
         nhfmpMHVNfPAsLhJWmbjE5ypaMdiYIXK7m2MHkannCnS9Ku20XN50ytSj2wUsf1zVCgX
         zohA==
X-Gm-Message-State: AOAM532YbaRcPY8+x9ft8cf/WkJipXXIQ0dT0Qkv4S/ZLM5spPnm9OvG
        JtN3plZCmzmFx6O7k2M8/cyAaw==
X-Google-Smtp-Source: ABdhPJzvWYyJDO4JoirTkov2oI3WzQyVmBYO53edLU3D5fEctgmNUNunuP5QihACIwCQCB1eHJ1gpQ==
X-Received: by 2002:a62:6186:: with SMTP id v128mr162480pfb.185.1590088137862;
        Thu, 21 May 2020 12:08:57 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x2sm4961819pfc.106.2020.05.21.12.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 12:08:57 -0700 (PDT)
Date:   Thu, 21 May 2020 12:07:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Asutosh Das <asutoshd@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V2 2/3] mmc: sdhci-msm: Use internal voltage control
Message-ID: <20200521190739.GC1331782@builder.lan>
References: <1589541535-8523-1-git-send-email-vbadigan@codeaurora.org>
 <1590074615-10787-1-git-send-email-vbadigan@codeaurora.org>
 <1590074615-10787-3-git-send-email-vbadigan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590074615-10787-3-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 May 08:23 PDT 2020, Veerabhadrarao Badiganti wrote:

> On qcom SD host controllers voltage switching be done after the HW
> is ready for it. The HW informs its readiness through power irq.
> The voltage switching should happen only then.
> 
> Use the internal voltage switching and then control the voltage
> switching using power irq.
> 
> Set the regulator load as well so that regulator can be configured
> in LPM mode when in is not being used.
> 
> Co-developed-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Co-developed-by: Vijay Viswanath <vviswana@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> Co-developed-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Looks better, thanks.

> ---
>  drivers/mmc/host/sdhci-msm.c | 207 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 198 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
[..]
>  static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> @@ -1298,6 +1302,71 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>  		sdhci_msm_hs400(host, &mmc->ios);
>  }
>  
> +static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
> +{
> +	int ret;
> +
> +	if (IS_ERR(mmc->supply.vmmc))
> +		return 0;
> +
> +	ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, mmc->ios.vdd);
> +	if (ret)
> +		dev_err(mmc_dev(mmc), "%s: vmmc set ocr with vdd=%d failed: %d\n",
> +			mmc_hostname(mmc), mmc->ios.vdd, ret);

Missed this one on v1, in the event that mmc_regulator_set_ocr() return
a non-zero value it has already printed an error message. So please
replace the tail with just:

	return mmc_regulator_set_ocr(...);

> +
> +	return ret;
> +}
> +
> +static int sdhci_msm_set_vqmmc(struct sdhci_msm_host *msm_host,
> +			      struct mmc_host *mmc, bool level)
> +{
> +	int load, ret;
> +	struct mmc_ios ios;
> +
> +	if (IS_ERR(mmc->supply.vqmmc)			 ||
> +	    (mmc->ios.power_mode == MMC_POWER_UNDEFINED) ||
> +	    (msm_host->vqmmc_enabled == level))
> +		return 0;
> +
> +	if (msm_host->vqmmc_load) {
> +		load = level ? msm_host->vqmmc_load : 0;
> +		ret = regulator_set_load(mmc->supply.vqmmc, load);

Sorry for the late reply on v1, but please see my explanation regarding
load and always-on regulators there.

> +		if (ret) {
> +			dev_err(mmc_dev(mmc), "%s: vqmmc set load failed: %d\n",
> +				mmc_hostname(mmc), ret);
> +			goto out;
> +		}
> +	}
> +
> +	if (level) {
> +		/* Set the IO voltage regulator to default voltage level */
> +		if (msm_host->caps_0 & CORE_3_0V_SUPPORT)
> +			ios.signal_voltage = MMC_SIGNAL_VOLTAGE_330;
> +		else if (msm_host->caps_0 & CORE_1_8V_SUPPORT)
> +			ios.signal_voltage = MMC_SIGNAL_VOLTAGE_180;
> +
> +		if (msm_host->caps_0 & CORE_VOLT_SUPPORT) {
> +			ret = mmc_regulator_set_vqmmc(mmc, &ios);
> +			if (ret < 0) {
> +				dev_err(mmc_dev(mmc), "%s: vqmmc set volgate failed: %d\n",
> +					mmc_hostname(mmc), ret);
> +				goto out;
> +			}
> +		}
> +		ret = regulator_enable(mmc->supply.vqmmc);
> +	} else {
> +		ret = regulator_disable(mmc->supply.vqmmc);
> +	}
> +
> +	if (ret)
> +		dev_err(mmc_dev(mmc), "%s: vqmm %sable failed: %d\n",
> +			mmc_hostname(mmc), level ? "en":"dis", ret);
> +	else
> +		msm_host->vqmmc_enabled = level;
> +out:
> +	return ret;
> +}
[..]
> +static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
> +				      struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u16 ctrl, status;
> +
> +	/*
> +	 * Signal Voltage Switching is only applicable for Host Controllers
> +	 * v3.00 and above.
> +	 */
> +	if (host->version < SDHCI_SPEC_300)
> +		return 0;
> +
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +	switch (ios->signal_voltage) {
> +	case MMC_SIGNAL_VOLTAGE_330:
> +		if (!(host->flags & SDHCI_SIGNALING_330))
> +			return -EINVAL;
> +
> +		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
> +		ctrl &= ~SDHCI_CTRL_VDD_180;
> +		break;
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		if (!(host->flags & SDHCI_SIGNALING_180))
> +			return -EINVAL;
> +
> +		/*
> +		 * Enable 1.8V Signal Enable in the Host Control2
> +		 * register
> +		 */
> +		ctrl |= SDHCI_CTRL_VDD_180;
> +		break;
> +	case MMC_SIGNAL_VOLTAGE_120:
> +		if (!(host->flags & SDHCI_SIGNALING_120))
> +			return -EINVAL;
> +		return 0;
> +	default:
> +		/* No signal voltage switch required */
> +		return 0;
> +	}
> +
> +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +	/* Wait for 5ms */
> +	usleep_range(5000, 5500);
> +
> +	/* regulator output should be stable within 5 ms */
> +	status = !!(ctrl & SDHCI_CTRL_VDD_180);
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	if (!!(ctrl &  SDHCI_CTRL_VDD_180) == status)

You should be able to drop the !! both here and when assigning status.

Overall this looks neater, thanks for reworking it.

Regards,
Bjorn
