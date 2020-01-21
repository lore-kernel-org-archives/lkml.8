Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A832C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4168B24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gp5wngKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAUX0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:26:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46171 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgAUX0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:26:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so2278165pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fya0ETVWBsK5/pHiMBVCMTG0c4UO4fQFq/uw5FrlvKc=;
        b=Gp5wngKjd2Dgmx6PzdIbrPwECnkAIVJNxGqMuUZzr0rEYmuit8y4Ot3ttQpAgp6Qu9
         Y+8x+QpVRIjrcp+dLI7QD1Q2c+d26pgEFtZDDWI9hmaiADhtbThpYjB+9sOW1dZRNHfr
         GCpZ+g0VIXXuBQVaqRK4xqCvhSkOZDkyGzqwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fya0ETVWBsK5/pHiMBVCMTG0c4UO4fQFq/uw5FrlvKc=;
        b=HLNOB0P2RkEwDp31XlS1X8TE5pq+muYcVVRpUKPhKe39wawwa7QL/5+3Ij69n4Poo1
         wg6DsSOENgNg9gGdNjVcpH6yeQanuHnU7i4SP2FiY3iUv1Ta48/GBBEstCWz1tw0zomE
         i9v+XC5THD9UgnmhXvU/KAJ58v4M8AhZwkSx0EgWYKy1COmgQVK2Pn92tH8GJnCVSaBG
         XV8/D4dQjtk0mhAoNVj6vNex6u5p+86LEtx/I60JOssNneSuctSB0ak0O8hpf7IVQWkw
         Lc5rL6jN7sRZiuXrU7qfbwnrHqt6CcxESHERe/dRmw+B+CQVmUraa/iqqn96rcTt6jXh
         A6jQ==
X-Gm-Message-State: APjAAAVRo9/dHPjXSWPHb5hpmwRDG6oTa0+mIT+FuFcixO5O3TV2Sjfj
        3foy51BPZJbqHLF6F4RTipo54g==
X-Google-Smtp-Source: APXvYqz3gfa3kyqLCQlJ5AYjH73VwhxuTnQbPEn6gYN0WLEi7728RPbNIzLfMAiZi11SXMIUjQjs0w==
X-Received: by 2002:a62:e40e:: with SMTP id r14mr6686924pfh.115.1579649160249;
        Tue, 21 Jan 2020 15:26:00 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 7sm45548660pfx.52.2020.01.21.15.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 15:25:59 -0800 (PST)
Date:   Tue, 21 Jan 2020 15:25:58 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        vbadigan@codeaurora.org, sayalil@codeaurora.org,
        cang@codeaurora.org, rampraka@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH V1] mmc: sdhci-msm: Add system suspend/resume callbacks
Message-ID: <20200121232558.GV89495@google.com>
References: <1579617022-13031-1-git-send-email-sbhanu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1579617022-13031-1-git-send-email-sbhanu@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaik,

On Tue, Jan 21, 2020 at 08:00:22PM +0530, Shaik Sajida Bhanu wrote:
> Add system suspend/resume callbacks to sdhci-msm platform driver.
> 
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 47 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 71f29ba..4984857 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2028,9 +2028,52 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int sdhci_msm_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret = 0;

initialization is not needed.

> +
> +	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +		ret = cqhci_suspend(host->mmc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	disable_irq(msm_host->pwr_irq);
> +	ret = sdhci_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	return sdhci_msm_runtime_suspend(dev);
> +}
> +
> +static int sdhci_msm_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret = 0;

initialization is not needed.

> +	ret = sdhci_msm_runtime_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = sdhci_resume_host(host);
> +	if (ret < 0)
> +		return ret;
> +	enable_irq(msm_host->pwr_irq);
> +
> +	if (host->mmc->caps2 & MMC_CAP2_CQE)
> +		ret = cqhci_resume(host->mmc);
> +
> +	return ret;
> +}
> +
>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_msm_suspend,
> +				sdhci_msm_resume)
>  	SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend,
>  			   sdhci_msm_runtime_resume,
>  			   NULL)
