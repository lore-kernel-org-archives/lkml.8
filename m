Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBBCC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A8420787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNiShD7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDKB3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:29:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44219 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgDKB3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:29:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so1206013plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 18:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oViI8SklfCpZEbbYlFvgdpzM6/kZH9ALRRalOuYsvgM=;
        b=UNiShD7wlrWrXzBNeCBUu2DcSXJtHq7Z0Y8/MbsvAvNfpVWxNN7VvKLAuR31RGhV31
         LEOiAQi3VF/qJssY+mxdRur0UBNn39b9pLsPV87xF1fdZAvudU3b0CZ2rnInopThwfyR
         0XyuuwJblsOtu+P+1AbiEW7/c1NwHvY+NZM2Yfy140kEFWTiqkSKfSbdXm9/RHxRv2dT
         aSrwEV2ox1H3Oz/URa8lu4yUXLj3AURT7dyuFqOEpYrfMklx44SQAiIFR6yGKCAs06K0
         aC2AR5lgaz9SoZn9OzR3ZhLbqpuDjsRS1k5vUFBhYBtLPbOJ3BqPH9S5MlQeBTE1ux+9
         OfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oViI8SklfCpZEbbYlFvgdpzM6/kZH9ALRRalOuYsvgM=;
        b=oTXMxVw7jF28aMPBBsiL+Xv9y086lEMNnLWSQMR+y53fl+OXIsQwYRH1XC3tfY7DJ1
         dUbsYaGrlZmV4XB4Ih/WZqt8wgRHjOck/deGqwwxFw/ktPBQWTnJ+928LvVS+E/wLE/A
         mVffcWgBSjuM4qy4rqJfZKHeYhgeG2YKxGeB6ekw376weUuanPDR68nnSCJgX0MWmX9i
         2WnirHBVeQqVhUGwaq/7RoIwKVNQqIBUy04fvWB9/s+3OgIIK10sneEWbbX3QB1lVxfw
         lz2WqUTM2JGjQ0wasd52bVSsIqIssqnt+76Qfh+5IiazMPVkgMYthg7RF0/WLP6fTt8T
         H1iw==
X-Gm-Message-State: AGi0PuYpaR4QjKDrFOOC6FIY4AOoZNL66uSYO12rMKQwH1u9DWY4eOcb
        rYWFaluz1yq84bkCD7QL7XLL3A==
X-Google-Smtp-Source: APiQypIXEXPs9ksy3YjzBn7ixpo5mSMrugBfNzjkDJTpNfz4i3ihrt5TAUeFr8YSL7/BbVFVdh0/LA==
X-Received: by 2002:a17:90a:6c22:: with SMTP id x31mr8469537pjj.124.1586568591685;
        Fri, 10 Apr 2020 18:29:51 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s62sm2575561pgb.94.2020.04.10.18.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:29:51 -0700 (PDT)
Date:   Fri, 10 Apr 2020 18:30:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] remoteproc: use rproc_coredump_set_elf_info in
 drivers
Message-ID: <20200411013001.GG576963@builder.lan>
References: <20200410102433.2672-1-cleger@kalray.eu>
 <20200410102433.2672-3-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410102433.2672-3-cleger@kalray.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10 Apr 03:24 PDT 2020, Clement Leger wrote:

> Modify drivers which are using remoteproc coredump functionnality to use
> rproc_coredump_set_elf_info in order to create correct elf coredump
> format.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Clement Leger <cleger@kalray.eu>
> ---
>  drivers/remoteproc/qcom_q6v5_adsp.c | 1 +
>  drivers/remoteproc/qcom_q6v5_mss.c  | 3 +++
>  drivers/remoteproc/qcom_q6v5_pas.c  | 1 +
>  drivers/remoteproc/qcom_wcnss.c     | 1 +
>  drivers/remoteproc/stm32_rproc.c    | 1 +
>  5 files changed, 7 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 2b01f2282062..8c3bd0954a13 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -423,6 +423,7 @@ static int adsp_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
>  		return -ENOMEM;
>  	}
> +	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  
>  	adsp = (struct qcom_adsp *)rproc->priv;
>  	adsp->dev = &pdev->dev;
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 03ffc6db4c68..5a7ff1092362 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -1355,6 +1355,8 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
>  		return ret;
>  	}
>  
> +	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
> +
>  	ehdr = (struct elf32_hdr *)fw->data;
>  	phdrs = (struct elf32_phdr *)(ehdr + 1);
>  	qproc->dump_complete_mask = 0;
> @@ -1632,6 +1634,7 @@ static int q6v5_probe(struct platform_device *pdev)
>  	}
>  
>  	rproc->auto_boot = false;
> +	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  
>  	qproc = (struct q6v5 *)rproc->priv;
>  	qproc->dev = &pdev->dev;
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index a41860d2243a..991f57e8e55b 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -390,6 +390,7 @@ static int adsp_probe(struct platform_device *pdev)
>  	}
>  
>  	rproc->auto_boot = desc->auto_boot;
> +	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  
>  	adsp = (struct qcom_adsp *)rproc->priv;
>  	adsp->dev = &pdev->dev;
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> index 0c7afd038f0d..5d65e1a9329a 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -480,6 +480,7 @@ static int wcnss_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
>  		return -ENOMEM;
>  	}
> +	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  
>  	wcnss = (struct qcom_wcnss *)rproc->priv;
>  	wcnss->dev = &pdev->dev;
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 6a66dbf2df40..0f9d02ca4f5a 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -625,6 +625,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	if (!rproc)
>  		return -ENOMEM;
>  
> +	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  	rproc->has_iommu = false;
>  	ddata = rproc->priv;
>  	ddata->workqueue = create_workqueue(dev_name(dev));
> -- 
> 2.17.1
> 
