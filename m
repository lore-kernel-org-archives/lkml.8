Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5121AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E9420842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrYbrwOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgAJVUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:20:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42375 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgAJVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:20:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so1306133plk.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qf123HPwVYH24BsrOwH9DTDjLwXeUU5UpZOEyqKD1/A=;
        b=SrYbrwOBvi8YgWQmPD6TBUR0HaApGFKkfko8steRJpOfH97xMvMB80rEzKj1lR9huN
         TVXiNGXuIxjSVDHmQBjyLv6TEzlTd9SeVSuxbHeiMcrepA/tQdT2Wx3o5g/zu47G6Nh3
         zpR1H/OE07oj8PjrX9REQD3uBCnr4axHS5LCu25EHyNOR6z4AJhdeD6tdtr+Hj6l3Spe
         0jJcakJML9HkXZAZUhAaFIdcjch5Q9kzS7TPiqwdTTGLaIcYiOO1ypI4UgvnP2lXReQJ
         C1HQ90ZegMJb3o9X54jbcf96SDHKb/ilCQIs5LVB/ujPI+2axYegihfU2YmkgtjorR6/
         tqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qf123HPwVYH24BsrOwH9DTDjLwXeUU5UpZOEyqKD1/A=;
        b=SrGiBEA7hfLaVAx73Lho8+gGJiRXoFPqxmteBSspfyTJHYMRJQeCxhck4+0ZYCg1zT
         B1FK9xTEt/K6u1qiYFlE2Tk47TPjiuFldGSLpQ0+umuqdG0v/mPLfwCNrMEF7Sbj63vQ
         G1LRJS/RLMnsZgrybyTPVT7sT98BbrzYEfbN75aYweoRXxaa7fBHp0vvzoceO4Y8noaw
         4JVp2uj2N3hBAB1WVBgKLGxXkBc25m6Idc0Ww/wb7b8rfyaRjqc+QXjEd2lh/roPSrYS
         9aTVpYqvGjW1e30bF9+xUlniGXrwSYXGKu+L7eAy5EWdnrJp/7ST9uvh75DK57Gtdb9z
         RTtQ==
X-Gm-Message-State: APjAAAWL/Z/o31WWqop0FULKCZDHYRHprQdNechJ1l79MZ00GJB1NhbC
        qbGOc7Ds7zbf7Gj/NMwIBpk+qw==
X-Google-Smtp-Source: APXvYqx5ehAQdNJrU1S3f50NENDT3/Y9q/7LAu1x49IqkJdtDXGCdZ5QwiDu4ib99ThKPS/H+994SQ==
X-Received: by 2002:a17:902:9a41:: with SMTP id x1mr615582plv.169.1578691201459;
        Fri, 10 Jan 2020 13:20:01 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i23sm4014003pfo.11.2020.01.10.13.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:20:01 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:19:58 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH v2 3/8] remoteproc: qcom: Update IMEM PIL info on load
Message-ID: <20200110211958.GB11555@xps15>
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
 <20191227053215.423811-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227053215.423811-4-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 09:32:10PM -0800, Bjorn Andersson wrote:
> Update the PIL info region structure in IMEM with information about
> where the firmware for various remoteprocs are loaded.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Squashed patches for the individual drivers into one
> - Probe defer on qcom_pil_info_available()
> 
>  drivers/remoteproc/Kconfig          |  3 +++
>  drivers/remoteproc/qcom_q6v5_adsp.c | 19 ++++++++++++++++---
>  drivers/remoteproc/qcom_q6v5_mss.c  |  6 ++++++
>  drivers/remoteproc/qcom_q6v5_pas.c  | 18 +++++++++++++++---
>  drivers/remoteproc/qcom_wcnss.c     | 17 ++++++++++++++---
>  5 files changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 0798602e355a..84922bb922e0 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -135,6 +135,7 @@ config QCOM_Q6V5_PAS
>  	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	select MFD_SYSCON
> +	select QCOM_PIL_INFO
>  	select QCOM_MDT_LOADER
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
> @@ -152,6 +153,7 @@ config QCOM_Q6V5_WCSS
>  	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	select MFD_SYSCON
> +	select QCOM_PIL_INFO
>  	select QCOM_MDT_LOADER
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
> @@ -183,6 +185,7 @@ config QCOM_WCNSS_PIL
>  	depends on QCOM_SMEM
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	select QCOM_MDT_LOADER
> +	select QCOM_PIL_INFO
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
>  	help
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index e953886b2eb7..1a942c92d974 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -26,6 +26,7 @@
>  #include <linux/soc/qcom/smem_state.h>
>  
>  #include "qcom_common.h"
> +#include "qcom_pil_info.h"
>  #include "qcom_q6v5.h"
>  #include "remoteproc_internal.h"
>  
> @@ -82,6 +83,7 @@ struct qcom_adsp {
>  	unsigned int halt_lpass;
>  
>  	int crash_reason_smem;
> +	const char *info_name;
>  
>  	struct completion start_done;
>  	struct completion stop_done;
> @@ -164,10 +166,17 @@ static int qcom_adsp_shutdown(struct qcom_adsp *adsp)
>  static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>  {
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	int ret;
> +
> +	ret = qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, 0,
> +				    adsp->mem_region, adsp->mem_phys, adsp->mem_size,

Line over 80 characters.

> +				    &adsp->mem_reloc);
> +	if (ret)
> +		return ret;
>  
> -	return qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, 0,
> -			     adsp->mem_region, adsp->mem_phys, adsp->mem_size,
> -			     &adsp->mem_reloc);
> +	qcom_pil_info_store(adsp->info_name, adsp->mem_reloc, adsp->mem_size);
> +
> +	return 0;
>  }
>  
>  static int adsp_start(struct rproc *rproc)
> @@ -413,6 +422,9 @@ static int adsp_probe(struct platform_device *pdev)
>  	struct rproc *rproc;
>  	int ret;
>  
> +	if (!qcom_pil_info_available())
> +		return -EPROBE_DEFER;
> +
>  	desc = of_device_get_match_data(&pdev->dev);
>  	if (!desc)
>  		return -EINVAL;
> @@ -427,6 +439,7 @@ static int adsp_probe(struct platform_device *pdev)
>  	adsp = (struct qcom_adsp *)rproc->priv;
>  	adsp->dev = &pdev->dev;
>  	adsp->rproc = rproc;
> +	adsp->info_name = desc->sysmon_name;
>  	platform_set_drvdata(pdev, adsp);
>  
>  	ret = adsp_alloc_memory_region(adsp);
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 471128a2e723..6360e69b54e4 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -28,6 +28,7 @@
>  
>  #include "remoteproc_internal.h"
>  #include "qcom_common.h"
> +#include "qcom_pil_info.h"
>  #include "qcom_q6v5.h"
>  
>  #include <linux/qcom_scm.h>
> @@ -1052,6 +1053,8 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  	else if (ret < 0)
>  		dev_err(qproc->dev, "MPSS authentication failed: %d\n", ret);
>  
> +	qcom_pil_info_store("modem", mpss_reloc, qproc->mpss_size);
> +
>  release_firmware:
>  	release_firmware(fw);
>  out:
> @@ -1400,6 +1403,9 @@ static int q6v5_probe(struct platform_device *pdev)
>  	if (desc->need_mem_protection && !qcom_scm_is_available())
>  		return -EPROBE_DEFER;
>  
> +	if (!qcom_pil_info_available())
> +		return -EPROBE_DEFER;
> +
>  	mba_image = desc->hexagon_mba_image;
>  	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
>  					    0, &mba_image);
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index b890e6e305f3..4dcdf1301e50 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -25,6 +25,7 @@
>  #include <linux/soc/qcom/smem_state.h>
>  
>  #include "qcom_common.h"
> +#include "qcom_pil_info.h"
>  #include "qcom_q6v5.h"
>  #include "remoteproc_internal.h"
>  
> @@ -64,6 +65,7 @@ struct qcom_adsp {
>  	int pas_id;
>  	int crash_reason_smem;
>  	bool has_aggre2_clk;
> +	const char *info_name;
>  
>  	struct completion start_done;
>  	struct completion stop_done;
> @@ -117,11 +119,17 @@ static void adsp_pds_disable(struct qcom_adsp *adsp, struct device **pds,
>  static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>  {
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	int ret;
> +
> +	ret = qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
> +			    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
> +			    &adsp->mem_reloc);
> +	if (ret)
> +		return ret;
>  
> -	return qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
> -			     adsp->mem_region, adsp->mem_phys, adsp->mem_size,
> -			     &adsp->mem_reloc);
> +	qcom_pil_info_store(adsp->info_name, adsp->mem_reloc, adsp->mem_size);
>  
> +	return 0;
>  }
>  
>  static int adsp_start(struct rproc *rproc)
> @@ -376,6 +384,9 @@ static int adsp_probe(struct platform_device *pdev)
>  	if (!qcom_scm_is_available())
>  		return -EPROBE_DEFER;
>  
> +	if (!qcom_pil_info_available())
> +		return -EPROBE_DEFER;
> +
>  	fw_name = desc->firmware_name;
>  	ret = of_property_read_string(pdev->dev.of_node, "firmware-name",
>  				      &fw_name);
> @@ -396,6 +407,7 @@ static int adsp_probe(struct platform_device *pdev)
>  	adsp->rproc = rproc;
>  	adsp->pas_id = desc->pas_id;
>  	adsp->has_aggre2_clk = desc->has_aggre2_clk;
> +	adsp->info_name = desc->sysmon_name;
>  	platform_set_drvdata(pdev, adsp);
>  
>  	ret = adsp_alloc_memory_region(adsp);
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> index dc135754bb9c..2c1cefeacf97 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -27,6 +27,7 @@
>  
>  #include "qcom_common.h"
>  #include "remoteproc_internal.h"
> +#include "qcom_pil_info.h"
>  #include "qcom_wcnss.h"
>  
>  #define WCNSS_CRASH_REASON_SMEM		422
> @@ -145,10 +146,17 @@ void qcom_wcnss_assign_iris(struct qcom_wcnss *wcnss,
>  static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
>  {
>  	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
> +	int ret;
> +
> +	ret = qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
> +			    wcnss->mem_region, wcnss->mem_phys,
> +			    wcnss->mem_size, &wcnss->mem_reloc);
> +	if (ret)
> +		return ret;
>  
> -	return qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
> -			     wcnss->mem_region, wcnss->mem_phys,
> -			     wcnss->mem_size, &wcnss->mem_reloc);
> +	qcom_pil_info_store("wcnss", wcnss->mem_reloc, wcnss->mem_size);
> +
> +	return 0;
>  }
>  
>  static void wcnss_indicate_nv_download(struct qcom_wcnss *wcnss)
> @@ -469,6 +477,9 @@ static int wcnss_probe(struct platform_device *pdev)
>  	if (!qcom_scm_is_available())
>  		return -EPROBE_DEFER;
>  
> +	if (!qcom_pil_info_available())
> +		return -EPROBE_DEFER;
> +
>  	if (!qcom_scm_pas_supported(WCNSS_PAS_ID)) {
>  		dev_err(&pdev->dev, "PAS is not available for WCNSS\n");
>  		return -ENXIO;
> -- 
> 2.24.0
> 
