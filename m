Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4728C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D9520684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/nH1rdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGVEZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 00:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGVEZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 00:25:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A2BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 21:25:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so496441pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 21:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JyfZs1fHQ/blLkrFQMU2v7JeeEiViiuzIwxf6ciMQ9I=;
        b=I/nH1rdUUeezvq6ZwJWq4DyrdZI8DByuPbtlNnssIK6q6k2rpYikkIFiECE9U1yhsz
         Kz4JOM6k9hfmQU7PLBpQt3WI6sLoju7etL0XGZBu2T3n2Cm5ac+HYBUx1uVhdqBn3fwF
         KLQh5mUnVJTOmlW/fRckNHhtDDykqakfcdDeEqV/JO11FcRtReRITaD5FS/7xFkPDq3m
         2h3voWOWhvl8yNNLIx76jwzXojeE9XHx7T31nOgnFx/BuJW8V3slWds/6FA5RU2ZXDdY
         lzZ1MnjliX2KcmllKFgzJSLqsQyXGwzycA88UwKlRLClBlPXmKa+EVTFw0OhHY3/LQQV
         a1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JyfZs1fHQ/blLkrFQMU2v7JeeEiViiuzIwxf6ciMQ9I=;
        b=SVmp7s0gpqt4ecBIUF+P10BbaXSGc0p889rXrXj5pjR/4jwHbdemSKo3a8996V+IeE
         u7aDR//r/XXlHhAIXosNU9D1jb3CpJABU+a3tg2D8yOANa/cYVKN4aNKm7Tyhqknytot
         SAANuhgyPKRzFKU1jkgk577GKL+d1NSjrRpYZJ0miajvA9SUAVFzR3hlahRbuSVrgg66
         5YrXm+9oNE34S59bB1/FknL9txPRs8iPLyUb7Nu1pz0qoF5KeYKosRhqtS7GcZcuNqcg
         1q7cehbpoHZ8AQpHNyVeOZxZ5bKtvT75YYbVtAkN+UzISWbRN9wTkkRgDCt7hjRD1PNf
         rh1g==
X-Gm-Message-State: AOAM532O1HU0KTwnYggeh5B4COJnkUAEJPAWw1I/HwnGar1rowfLLE20
        6kOruYz4XoQkh6T3VMf+Qh7u1A==
X-Google-Smtp-Source: ABdhPJywKGCqP7OKsj8nI23NT9BWESLDFyZ8piR4UWAnPiyIyq3Om8NCWNNqfh0AA1agHvT299UGpw==
X-Received: by 2002:a17:90a:1a83:: with SMTP id p3mr7554984pjp.113.1595391933557;
        Tue, 21 Jul 2020 21:25:33 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s14sm5048791pjl.14.2020.07.21.21.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 21:25:32 -0700 (PDT)
Date:   Tue, 21 Jul 2020 21:23:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, ohad@wizery.com
Subject: Re: [PATCH v2 2/2] remoteproc: qcom_q6v5_mss: Add MBA log extraction
 support
Message-ID: <20200722042339.GO2922385@builder.lan>
References: <20200721112935.25716-1-sibis@codeaurora.org>
 <20200721112935.25716-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721112935.25716-3-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 Jul 04:29 PDT 2020, Sibi Sankar wrote:

> On SC7180 the MBA firmware stores the bootup text logs in a 4K segment
> at the beginning of the MBA region. Add support to extract the logs
> which will be useful to debug mba boot/authentication issues.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>


Afaict this is completely independent from the other patch in the
series, so I applied this.

Regards,
Bjorn

> ---
> 
> V2:
>  * Don't dump logs in mba_reclaim path [Bjorn]
>  * Move has_mba_logs check to q6v5_dump_mba_logs [Bjorn]
>  * SDM845 mss was incorrectly marked to support mba logs
> 
>  drivers/remoteproc/qcom_q6v5_mss.c | 38 +++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 49cd16e050533..945ca2652e7d6 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/devcoredump.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -37,6 +38,8 @@
>  
>  #define MPSS_CRASH_REASON_SMEM		421
>  
> +#define MBA_LOG_SIZE			SZ_4K
> +
>  /* RMB Status Register Values */
>  #define RMB_PBL_SUCCESS			0x1
>  
> @@ -141,6 +144,7 @@ struct rproc_hexagon_res {
>  	int version;
>  	bool need_mem_protection;
>  	bool has_alt_reset;
> +	bool has_mba_logs;
>  	bool has_spare_reg;
>  };
>  
> @@ -202,6 +206,7 @@ struct q6v5 {
>  	struct qcom_sysmon *sysmon;
>  	bool need_mem_protection;
>  	bool has_alt_reset;
> +	bool has_mba_logs;
>  	bool has_spare_reg;
>  	int mpss_perm;
>  	int mba_perm;
> @@ -521,6 +526,26 @@ static int q6v5_rmb_mba_wait(struct q6v5 *qproc, u32 status, int ms)
>  	return val;
>  }
>  
> +static void q6v5_dump_mba_logs(struct q6v5 *qproc)
> +{
> +	struct rproc *rproc = qproc->rproc;
> +	void *data;
> +
> +	if (!qproc->has_mba_logs)
> +		return;
> +
> +	if (q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true, false, qproc->mba_phys,
> +				    qproc->mba_size))
> +		return;
> +
> +	data = vmalloc(MBA_LOG_SIZE);
> +	if (!data)
> +		return;
> +
> +	memcpy(data, qproc->mba_region, MBA_LOG_SIZE);
> +	dev_coredumpv(&rproc->dev, data, MBA_LOG_SIZE, GFP_KERNEL);
> +}
> +
>  static int q6v5proc_reset(struct q6v5 *qproc)
>  {
>  	u32 val;
> @@ -839,6 +864,7 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>  {
>  	int ret;
>  	int xfermemop_ret;
> +	bool mba_load_err = false;
>  
>  	qcom_q6v5_prepare(&qproc->q6v5);
>  
> @@ -932,7 +958,7 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>  	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
>  	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
>  	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
> -
> +	mba_load_err = true;
>  reclaim_mba:
>  	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
>  						false, qproc->mba_phys,
> @@ -940,6 +966,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>  	if (xfermemop_ret) {
>  		dev_err(qproc->dev,
>  			"Failed to reclaim mba buffer, system may become unstable\n");
> +	} else if (mba_load_err) {
> +		q6v5_dump_mba_logs(qproc);
>  	}
>  
>  disable_active_clks:
> @@ -1298,6 +1326,7 @@ static int q6v5_start(struct rproc *rproc)
>  
>  reclaim_mpss:
>  	q6v5_mba_reclaim(qproc);
> +	q6v5_dump_mba_logs(qproc);
>  
>  	return ret;
>  }
> @@ -1717,6 +1746,7 @@ static int q6v5_probe(struct platform_device *pdev)
>  
>  	qproc->version = desc->version;
>  	qproc->need_mem_protection = desc->need_mem_protection;
> +	qproc->has_mba_logs = desc->has_mba_logs;
>  
>  	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM,
>  			     qcom_msa_handover);
> @@ -1808,6 +1838,7 @@ static const struct rproc_hexagon_res sc7180_mss = {
>  	},
>  	.need_mem_protection = true,
>  	.has_alt_reset = false,
> +	.has_mba_logs = true,
>  	.has_spare_reg = true,
>  	.version = MSS_SC7180,
>  };
> @@ -1843,6 +1874,7 @@ static const struct rproc_hexagon_res sdm845_mss = {
>  	},
>  	.need_mem_protection = true,
>  	.has_alt_reset = true,
> +	.has_mba_logs = false,
>  	.has_spare_reg = false,
>  	.version = MSS_SDM845,
>  };
> @@ -1870,6 +1902,7 @@ static const struct rproc_hexagon_res msm8998_mss = {
>  	},
>  	.need_mem_protection = true,
>  	.has_alt_reset = false,
> +	.has_mba_logs = false,
>  	.has_spare_reg = false,
>  	.version = MSS_MSM8998,
>  };
> @@ -1900,6 +1933,7 @@ static const struct rproc_hexagon_res msm8996_mss = {
>  	},
>  	.need_mem_protection = true,
>  	.has_alt_reset = false,
> +	.has_mba_logs = false,
>  	.has_spare_reg = false,
>  	.version = MSS_MSM8996,
>  };
> @@ -1933,6 +1967,7 @@ static const struct rproc_hexagon_res msm8916_mss = {
>  	},
>  	.need_mem_protection = false,
>  	.has_alt_reset = false,
> +	.has_mba_logs = false,
>  	.has_spare_reg = false,
>  	.version = MSS_MSM8916,
>  };
> @@ -1974,6 +2009,7 @@ static const struct rproc_hexagon_res msm8974_mss = {
>  	},
>  	.need_mem_protection = false,
>  	.has_alt_reset = false,
> +	.has_mba_logs = false,
>  	.has_spare_reg = false,
>  	.version = MSS_MSM8974,
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
