Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2D5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6FB21D7A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHV3MpZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgFVHVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgFVHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:21:37 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEF6C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:21:35 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g5so12264080otg.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vwl6qS4yPQKOHaGGWLpDtmj9DBSRzOFDIA5kXBhpOwg=;
        b=bHV3MpZjVsKCj7ZFCGAaCW7pzZm+lcPv0lRbgwGZnvnbakQkziiM/YhEILoxlpb/Qc
         jrp8UCvVe3nISscgrH+SN7K77872MVVSehQWSq7KN4gfUezrxODTop8l4HzJj+46kaVx
         yWTyx8tFyvYSxIQA3S/MCOkNye3CB2pe3rGldlTb0Oizhjzhxofs6Gs3PodrfHaRPJxp
         nsxFQ4YOBhJEh5MDp6zZ35otAZ2Bze7LLxbZkACmtxBDfV3JTFM4LzCsrgaHsdpDsq7g
         V+LafUZ7rA2FBOEEuKtY0hHIWIzo06pNYvKxu3P1AVhR8DX0tdB0kcEhDglrCkaNEubq
         WNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vwl6qS4yPQKOHaGGWLpDtmj9DBSRzOFDIA5kXBhpOwg=;
        b=cipyJWb8Ln2Om/T669CszqcVp1oZw1VkCaB1V4pljNy3gYB8sL7SXNE1S0DmgTnx1y
         c1Yv//LK+HQ3Z5Y5aoRTnM1Aoql5EXVpMw0pdA6W9cX4il+46+Zp+omqknVRna9b0pbn
         Dy+HRLlxxKhELFblTJovX1lfSdcU0ia32c6fcMZj+1JVtD6QFYp+iKFKklH/yOz1VGBZ
         5MOtUz4l26NdA2JwZrlnPNFk7UjycyK/dzTv/YkLcPh7u8KuRJUiyFkNsWI48dC8dMyn
         kQdvHW6NJQqztybGVgH4lmtaOiHq2UTsLVmnueGU9kCNbpZzMviUYf0YOgm0R7RPIVAu
         QK1g==
X-Gm-Message-State: AOAM533ONBjXnykroiSSJhjW+xiwz2r84hvnJUyKkMZlqU+wbt2JZBVh
        O5gZYk7KdtjTUfUHA05/BXacKQ==
X-Google-Smtp-Source: ABdhPJx/P9N4iexcz+KrvYw7rX1vvCOD6LLcpZJYHZAEvNfPuZQsSrDqjwUpikfbs2KUfP2zi2GSjg==
X-Received: by 2002:a9d:104:: with SMTP id 4mr11665154otu.124.1592810495260;
        Mon, 22 Jun 2020 00:21:35 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x131sm713446ooa.31.2020.06.22.00.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 00:21:34 -0700 (PDT)
Date:   Mon, 22 Jun 2020 00:18:49 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, s-anna@ti.com
Subject: Re: [PATCH v4 4/9] remoteproc: Introducing function rproc_actuate()
Message-ID: <20200622071849.GF149351@builder.lan>
References: <20200601175139.22097-1-mathieu.poirier@linaro.org>
 <20200601175139.22097-5-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601175139.22097-5-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Jun 10:51 PDT 2020, Mathieu Poirier wrote:

> Introduce function rproc_actuate() that provides the same
> functionatlity as rproc_fw_boot(), but without the steps that
> involve interaction with the firmware image.  That way we can
> deal with scenarios where the remoteproc core is attaching
> to a remote processor that has already been started by another
> entity.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 68 +++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 0b323f6b554b..c70fa0372d07 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1370,7 +1370,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	return ret;
>  }
>  
> -static int __maybe_unused rproc_attach(struct rproc *rproc)
> +static int rproc_attach(struct rproc *rproc)
>  {
>  	struct device *dev = &rproc->dev;
>  	int ret;
> @@ -1499,6 +1499,72 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	return ret;
>  }
>  
> +/*
> + * Attach to remote processor - similar to rproc_fw_boot() but without
> + * the steps that deal with the firmware image.
> + */
> +static int __maybe_unused rproc_actuate(struct rproc *rproc)
> +{
> +	struct device *dev = &rproc->dev;
> +	int ret;
> +
> +	/* Tell the PM runtime core we need to keep this device powered */
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * if enabling an IOMMU isn't relevant for this rproc, this is
> +	 * just a nop
> +	 */
> +	ret = rproc_enable_iommu(rproc);
> +	if (ret) {
> +		dev_err(dev, "can't enable iommu: %d\n", ret);
> +		goto put_pm_runtime;
> +	}
> +
> +	/* reset max_notifyid */
> +	rproc->max_notifyid = -1;
> +
> +	/* reset handled vdev */
> +	rproc->nb_vdev = 0;
> +
> +	/*
> +	 * Handle firmware resources required to attach to a remote processor.
> +	 * Because we are attaching rather than booting the remote processor,
> +	 * we expect the platform driver to properly set rproc->table_ptr.
> +	 */
> +	ret = rproc_handle_resources(rproc, rproc_loading_handlers);
> +	if (ret) {
> +		dev_err(dev, "Failed to process resources: %d\n", ret);
> +		goto disable_iommu;
> +	}
> +
> +	/* Allocate carveout resources associated to rproc */
> +	ret = rproc_alloc_registered_carveouts(rproc);
> +	if (ret) {
> +		dev_err(dev, "Failed to allocate associated carveouts: %d\n",
> +			ret);
> +		goto clean_up_resources;
> +	}
> +
> +	ret = rproc_attach(rproc);
> +	if (ret)
> +		goto clean_up_resources;
> +
> +	return 0;
> +
> +clean_up_resources:
> +	rproc_resource_cleanup(rproc);
> +disable_iommu:
> +	rproc_disable_iommu(rproc);
> +put_pm_runtime:
> +	pm_runtime_put(dev);
> +	return ret;
> +}
> +
>  /*
>   * take a firmware and boot it up.
>   *
> -- 
> 2.20.1
> 
