Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C523C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D800320737
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGMnDWsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbgDAURi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:17:38 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33070 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgDAURi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:17:38 -0400
Received: by mail-pj1-f65.google.com with SMTP id jz1so2522748pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7QXM5fjeLv6e7wruqQv62gWJ5sED1p3tH47WlR+hLIE=;
        b=YGMnDWsG0ZR1g+JyYg5zKDRMK1O35HfU96XTzVrCiZyyDkfnHAwwvKq6yHyonJL84n
         jl2aLQDk9OzxeGyHN+98LRY7pSor3o6Zelig3o0Avko9l7MwjQLnx1SRFI5xyvvoxxay
         e60vy+XVTbJbBPbyU7oJ44zEsH0WTS/yAuu/n27mXk1jonz8+MXZWemQrWMN2t7mkPn0
         QvlOR7RQP9I7lF9D+gPb2NppYbb/yTIZdxRxU1A+8q3lAKQgLuBD54cYU509eKNSvRsy
         9C7nExb+NOJeFhWy0szZbp3XaiiOggn2HfnUY9ATK4So1oeBlTITuKTK7/I+j1GlF+XB
         nkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7QXM5fjeLv6e7wruqQv62gWJ5sED1p3tH47WlR+hLIE=;
        b=FuVRQrxnIa4pCPHCXq3U1U8VBvam16iJx0FulkQ850RPjg+VCoi0UXcx3Iaii1hQEf
         VWo+F8E/UxcH8pp+28JF4Ymw2P/80bY/DtOkKH3M4aAJiZntU0Pqh2Dbvex/ojeASHHC
         3E8SIhNffWzu3b29ZLjqXj1ok6/+b2xDZqGTirngSywjwIW90HyxUdM/+H2Pcpbsvn7d
         79O/ykTISJzS+SMPMR2McBFObavdrW5PSooumnVHSY16e9ZdylZ/+CPvFpv1oypjxmQt
         BUSYr6PM4hBuQjzH32dgVq34M4Cup+Zb6U4nqSNbbAdmkXmCsvCQwdf89Bf062KwGFUK
         P0Ig==
X-Gm-Message-State: AGi0PuY7pPyVpdfYYCt+IXuJJCH5JknuxLyHvuyZCIHeGW5fxqTV4wAo
        o74uLYkopWJlqFewJa7Ahi+IMwZSqM8=
X-Google-Smtp-Source: APiQypLtGYyXbFfmZZjtyDuDbV7lYQakXZwSxTvMqeaSjxfrV12j482v+QbT3C15jtCjVEWzzqOUdg==
X-Received: by 2002:a17:90a:c001:: with SMTP id p1mr7107170pjt.86.1585772255587;
        Wed, 01 Apr 2020 13:17:35 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y4sm2214312pfo.39.2020.04.01.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 13:17:11 -0700 (PDT)
Date:   Wed, 1 Apr 2020 13:17:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH 1/2] remoteproc: qcom: Add bus scaling capability during
 bootup
Message-ID: <20200401201707.GG267644@minitux>
References: <1585357147-4616-1-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585357147-4616-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Mar 17:59 PDT 2020, Rishabh Bhatnagar wrote:

> During bootup since remote processors cannot request for
> additional bus bandwidth from the interconect framework,
> platform driver should provide the proxy resources. This
> is useful for scenarios where the Q6 tries to access the DDR
> memory in the initial stages of bootup. For e.g. during
> bootup or after recovery modem Q6 tries to zero out the bss
> section in the DDR. Since this is a big chunk of memory if
> don't bump up the bandwidth we might encounter timeout issues.
> This patch makes a proxy vote for maximizing the bus bandwidth
> during bootup and removes it once processor is up.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 43 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index edf9d0e..8f5db8d 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -20,6 +20,7 @@
>  #include <linux/qcom_scm.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
> +#include <linux/interconnect.h>

These are sorted alphabetically, please maintain this.

>  #include <linux/soc/qcom/mdt_loader.h>
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
> @@ -28,6 +29,9 @@
>  #include "qcom_q6v5.h"
>  #include "remoteproc_internal.h"
>  
> +#define PIL_TZ_AVG_BW  0
> +#define PIL_TZ_PEAK_BW UINT_MAX

Please just inline these in do_bus_scaling().

> +
>  struct adsp_data {
>  	int crash_reason_smem;
>  	const char *firmware_name;
> @@ -62,6 +66,7 @@ struct qcom_adsp {
>  	int proxy_pd_count;
>  
>  	int pas_id;
> +	struct icc_path *bus_client;

Please rename this proxy_path

>  	int crash_reason_smem;
>  	bool has_aggre2_clk;
>  
> @@ -124,6 +129,25 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>  
>  }
>  
> +static int do_bus_scaling(struct qcom_adsp *adsp, bool enable)

adsp_bus_vote()

> +{
> +	int rc;

This driver uses "int ret".

> +	u32 avg_bw = enable ? PIL_TZ_AVG_BW : 0;

No need to carry a variable for 0 or 0, jut pass 0 in the function call
directly.

> +	u32 peak_bw = enable ? PIL_TZ_PEAK_BW : 0;
> +
> +	if (adsp->bus_client) {

No need for this check, icc_set_bw(NULL, ..) is a nop.

> +		rc = icc_set_bw(adsp->bus_client, avg_bw, peak_bw);
> +		if (rc) {
> +			dev_err(adsp->dev, "bandwidth request failed(rc:%d)\n",

"failed to request bandwidth: %d\n"

> +				rc);
> +			return rc;
> +		}
> +	} else
> +		dev_info(adsp->dev, "Bus scaling not setup for %s\n",

No need to print this.

> +			adsp->rproc->name);
> +	return 0;
> +}
> +
>  static int adsp_start(struct rproc *rproc)
>  {
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> @@ -131,9 +155,13 @@ static int adsp_start(struct rproc *rproc)
>  
>  	qcom_q6v5_prepare(&adsp->q6v5);
>  
> +	ret = do_bus_scaling(adsp, true);
> +	if (ret)
> +		goto disable_irqs;
> +
>  	ret = adsp_pds_enable(adsp, adsp->active_pds, adsp->active_pd_count);
>  	if (ret < 0)
> -		goto disable_irqs;
> +		goto unscale_bus;
>  
>  	ret = adsp_pds_enable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>  	if (ret < 0)
> @@ -183,6 +211,8 @@ static int adsp_start(struct rproc *rproc)
>  	adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>  disable_active_pds:
>  	adsp_pds_disable(adsp, adsp->active_pds, adsp->active_pd_count);
> +unscale_bus:
> +	do_bus_scaling(adsp, false);
>  disable_irqs:
>  	qcom_q6v5_unprepare(&adsp->q6v5);
>  
> @@ -198,6 +228,7 @@ static void qcom_pas_handover(struct qcom_q6v5 *q6v5)
>  	clk_disable_unprepare(adsp->aggre2_clk);
>  	clk_disable_unprepare(adsp->xo);
>  	adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> +	do_bus_scaling(adsp, false);
>  }
>  
>  static int adsp_stop(struct rproc *rproc)
> @@ -280,6 +311,14 @@ static int adsp_init_regulator(struct qcom_adsp *adsp)
>  	return PTR_ERR_OR_ZERO(adsp->px_supply);
>  }
>  
> +static void adsp_init_bus_scaling(struct qcom_adsp *adsp)
> +{
> +	adsp->bus_client = of_icc_get(adsp->dev, NULL);
> +	if (!adsp->bus_client)

!adsp->bus_client means there's no interconnects property in the DT
node, you still need to test for errors with IS_ERR().

And in particular you're not guaranteed that the provider has probed, so
you need to propagate EPROBE_DEFER.

> +		dev_warn(adsp->dev, "%s: unable to get bus client \n",
> +			__func__);

This is a dev_err() for the case of IS_ERR().

And please drop the __func__, it doesn't add any value.

> +}
> +
>  static int adsp_pds_attach(struct device *dev, struct device **devs,
>  			   char **pd_names)
>  {
> @@ -410,6 +449,8 @@ static int adsp_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> +	adsp_init_bus_scaling(adsp);
> +

As stated above, you need to propagate actual errors here (i.e. not the
case where of_icc_get() returned NULL, but when it returned IS_ERR())

Regards,
bjorn
>  	ret = adsp_pds_attach(&pdev->dev, adsp->active_pds,
>  			      desc->active_pd_names);
>  	if (ret < 0)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
