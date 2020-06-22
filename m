Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EE3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F5620732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bftkEq2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgFVSId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgFVSIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:08:32 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644CAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:08:31 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id c194so16472650oig.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jm6bjK+DZcG0T8JiyiA68BtynZx883K3XjW2OLQiO2A=;
        b=bftkEq2a51p+DW68Q2XCLk5dmflAD5WMjTxB6mlUfr5UbyRvEI+GIOHsciMkO2Vp9l
         cb9W4q2OsKVrxVpjj0yoEjGi8S9dPNQ8x9RvbvEZVswLS/lpuRiz9ERT/vZDta/heeQR
         /5u9toSK/cSkeiwGAdW+NDWN/X9HasreMvD75VZNZCiUL/XVffLbdvf44KiopBTZjBh1
         EHSAoJjsoTfyyypZkvahGppgkuQJc4DNB1kgmW8S9BhFNquV+95N4KTkVO2p4nCsOyJJ
         kVTI41Denqsbm5hzgxC2TMehhvNedd/a8NQVYIkI29R/sBHyI1ldstkoJ3reSRwdB/jU
         74qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jm6bjK+DZcG0T8JiyiA68BtynZx883K3XjW2OLQiO2A=;
        b=YR0iPqzrsKqzIpdOFkvFhDXtJxyjV5nc0HJNq2RI8TNwV8Fp4RmNjeeUtwIEWFYmMz
         fSefKjBJcWrYCqPLWWXCos8bXuWOiGJppVavF4DsvFlpWxgB/KZno+bwXPFDKXZ1K+kd
         42Zc4bvKZItxoZ3A7mX21oY38JEWAO1a4YapDH3kC7vMP93pSnVc0zaBHM98KBqfFmW2
         duFQYBkjfN9BOUdO0C3ZMnxpjZvtgJ4ug4ug7Z075+DBCAODHs34VJ0jdj2PQLnKw+V7
         b6pHd4Wjq40b1Wp8Q6zJGTGPhyS5zfNN+iQRCgaZVWKrPtVLk3ggRaQq6ARkoEBvCVI7
         ftyQ==
X-Gm-Message-State: AOAM531Gmv6oQr4JtzxmSefsR+HG3P6pAveh+GBD//U46flOj0R1qhpf
        YcuGidgr2P8xeEbF/+C/EPm4cV9NSkQ=
X-Google-Smtp-Source: ABdhPJyK93YJhfPtxJTdAiMfzN0O99PZVEz67jcgBt6vGBzhF0DwyY6f+HuyEeSZcDAH+We/1ZoeWA==
X-Received: by 2002:aca:c34b:: with SMTP id t72mr13773010oif.34.1592849310661;
        Mon, 22 Jun 2020 11:08:30 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t1sm3556113oot.36.2020.06.22.11.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:08:29 -0700 (PDT)
Date:   Mon, 22 Jun 2020 11:05:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 06/11] remoteproc: stm32: Properly set co-processor
 state when attaching
Message-ID: <20200622180545.GL149351@builder.lan>
References: <20200601175552.22286-1-mathieu.poirier@linaro.org>
 <20200601175552.22286-7-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601175552.22286-7-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Jun 10:55 PDT 2020, Mathieu Poirier wrote:

> Introduce the required mechanic to set the state of the M4 in order
> to properly deal with scenarios where the co-processor has been
> stated by another entity.
> 
> Mainly based on the work published by Arnaud Pouliquen [1].
> 
> [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/stm32_rproc.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 80fd8fd831da..2154c8b90a2a 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -38,6 +38,13 @@
>  #define STM32_MBX_VQ1_ID	1
>  #define STM32_MBX_SHUTDOWN	"shutdown"
>  
> +#define M4_STATE_OFF		0
> +#define M4_STATE_INI		1
> +#define M4_STATE_CRUN		2
> +#define M4_STATE_CSTOP		3
> +#define M4_STATE_STANDBY	4
> +#define M4_STATE_CRASH		5
> +
>  struct stm32_syscon {
>  	struct regmap *map;
>  	u32 reg;
> @@ -635,12 +642,30 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int stm32_rproc_get_m4_status(struct stm32_rproc *ddata,
> +				     unsigned int *state)
> +{
> +	/* See stm32_rproc_parse_dt() */
> +	if (!ddata->m4_state.map) {
> +		/*
> +		 * We couldn't get the coprocessor's state, assume
> +		 * it is not running.
> +		 */
> +		state = M4_STATE_OFF;
> +		return 0;
> +	}
> +
> +	return regmap_read(ddata->m4_state.map, ddata->m4_state.reg, state);
> +}
> +
> +
>  static int stm32_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct stm32_rproc *ddata;
>  	struct device_node *np = dev->of_node;
>  	struct rproc *rproc;
> +	unsigned int state;
>  	int ret;
>  
>  	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> @@ -663,6 +688,13 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> +	ret = stm32_rproc_get_m4_status(ddata, &state);
> +	if (ret)
> +		goto free_rproc;
> +
> +	if (state == M4_STATE_CRUN)

I presume this won't ever be e.g. M4_STATE_CRASH or M4_STATE_STANDBY?

Regards,
Bjorn

> +		rproc->state = RPROC_DETACHED;
> +
>  	rproc->has_iommu = false;
>  	ddata->workqueue = create_workqueue(dev_name(dev));
>  	if (!ddata->workqueue) {
> -- 
> 2.20.1
> 
