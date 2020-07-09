Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAAFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FF920720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="it/B9r03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGITwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgGITvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:51:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EBDC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 12:51:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so1417035pgg.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RKoiYmnqg/oFAokvGDIpwpiVhiuKO9b5n8VEE7Z8HE8=;
        b=it/B9r0362HsDPiIYjY/j7FwYnayXCWDVi1l4DQPuC0o6hvNZZmq/PrrwyNwVi7mCa
         T97g2TghHXywHle1twFq+JpnT+2uA4Y7Fn5uhc51cdS9dp0iIpn2qzOjLypRXfdmqzk9
         UQEjCZ6xvm8qPnJkR2LkoLjvx561sN8fmDkHR23CCN5mwAvK0F5NNKyQhYgKJaugdf4N
         MCckZ0pQKpqcSiaNIhlUqFctXTHPhc9DxMiDKT4sXyZW6uHC2J2gteGTvnRylEZT7vEV
         EXE0SR2/tjUuDkIBBSAvf26n3trUN4oesMCH3HdQcvssgygJl5csCEKXJ7snC+PGy06U
         ajUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RKoiYmnqg/oFAokvGDIpwpiVhiuKO9b5n8VEE7Z8HE8=;
        b=EPhXzBvawuRR/scKEItL6X7lKcVjbuZuq+jl5vJYZtFGIb0KxnFEo3a6v99eg3rO0E
         4kKzgwYjFz9HqP+82RPy4mMtRd3S/g7xwmRZlSi1snjXUhEqVimYm9hg9PGEIsDJbUAm
         y5DG1SM3/fRVMUh2qaQ38Nj3MguYZ8IgOo+g8G3Y/QBOy0vWNNnpSkZ5ZqL/uHjA8oNK
         vsjgjlUD18JCkwMAW7+B+ssCzHZFrrNGaMvxcVYTxTTgf7uJEvdHXH8yzqcwj3t3UM3S
         JLbHbNDxNViwQAu46x34EYwAcp4TkxU4/535fGofydk25XoNFHH7EjZvCvxShjIwvAUC
         q+Gg==
X-Gm-Message-State: AOAM5331Myg5u6lVui45+pTnsXz7guQVIDFWDTh28chGFED7DYMsF8u6
        rq8adGOCf8pVVy+h7dHo/UhF5A==
X-Google-Smtp-Source: ABdhPJye/dlKRIG7MMw5hNVxhwmSWEsx9/WxUR6K7A2xxTk7FBJTIGgFEZGNinozbGwd+GarBA9OqQ==
X-Received: by 2002:a63:405:: with SMTP id 5mr53556062pge.449.1594324273843;
        Thu, 09 Jul 2020 12:51:13 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id ci23sm3369898pjb.29.2020.07.09.12.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 12:51:13 -0700 (PDT)
Date:   Thu, 9 Jul 2020 13:51:11 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] remoteproc: k3-r5: Add loading support for
 on-chip SRAM regions
Message-ID: <20200709195111.GC948668@xps15>
References: <20200630024922.32491-1-s-anna@ti.com>
 <20200630024922.32491-5-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630024922.32491-5-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:49:22PM -0500, Suman Anna wrote:
> The K3 SoCs has various internal on-chip SRAM memories like the SRAM
> within the MCU domain or the shared MSMC RAM within NavSS that can be
> used for multiple purposes. One such purpose is to have the R5F cores
> use a portion of such on-chip SRAM for fast-access data or to directly
> execute code.
> 
> Add support to the K3 R5 remoteproc driver to parse and support
> loading into such memories. The SRAM regions need to be mapped as
> normal non-cacheable memory to avoid kernel crashes when the remoteproc
> loader code uses the Arm64 memset library function (the "DC ZVA"
> instruction throws a alignment fault on device type memory).
> 
> These SRAM regions are completely optional as not all firmware images
> require these memories, and any such memory has to be reserved as such
> in the DTS files.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v2:
>  - Adapted to use various devm_ functions resulting in a smaller patch
>  - Failure path code is dropped as a result in k3_r5_core_of_exit() and
>    k3_r5_core_of_get_sram_memories()
>  - Dropped unneeded whitespaces in a debug trace
>  - Revised the patch title to move away from remoteproc/k3-r5
>  - Dropped Mathieu's Acked-by because of the changes
> v1: https://patchwork.kernel.org/patch/11456373/
> 
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 79 ++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index aca0eaf42a38..ac8ae29f38aa 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -86,7 +86,9 @@ struct k3_r5_cluster {
>   * @dev: cached device pointer
>   * @rproc: rproc handle representing this core
>   * @mem: internal memory regions data
> + * @sram: on-chip SRAM memory regions data
>   * @num_mems: number of internal memory regions
> + * @num_sram: number of on-chip SRAM memory regions
>   * @reset: reset control handle
>   * @tsp: TI-SCI processor control handle
>   * @ti_sci: TI-SCI handle
> @@ -100,7 +102,9 @@ struct k3_r5_core {
>  	struct device *dev;
>  	struct rproc *rproc;
>  	struct k3_r5_mem *mem;
> +	struct k3_r5_mem *sram;
>  	int num_mems;
> +	int num_sram;
>  	struct reset_control *reset;
>  	struct ti_sci_proc *tsp;
>  	const struct ti_sci_handle *ti_sci;
> @@ -588,6 +592,18 @@ static void *k3_r5_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
>  		}
>  	}
>  
> +	/* handle any SRAM regions using SoC-view addresses */
> +	for (i = 0; i < core->num_sram; i++) {
> +		dev_addr = core->sram[i].dev_addr;
> +		size = core->sram[i].size;
> +
> +		if (da >= dev_addr && ((da + len) <= (dev_addr + size))) {
> +			offset = da - dev_addr;
> +			va = core->sram[i].cpu_addr + offset;
> +			return (__force void *)va;
> +		}
> +	}
> +
>  	/* handle static DDR reserved memory regions */
>  	for (i = 0; i < kproc->num_rmems; i++) {
>  		dev_addr = kproc->rmem[i].dev_addr;
> @@ -1030,6 +1046,63 @@ static int k3_r5_core_of_get_internal_memories(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int k3_r5_core_of_get_sram_memories(struct platform_device *pdev,
> +					   struct k3_r5_core *core)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *sram_np;
> +	struct resource res;
> +	int num_sram;
> +	int i, ret;
> +
> +	num_sram = of_property_count_elems_of_size(np, "sram", sizeof(phandle));
> +	if (num_sram <= 0) {
> +		dev_dbg(dev, "device does not use reserved on-chip memories, num_sram = %d\n",
> +			num_sram);
> +		return 0;
> +	}
> +
> +	core->sram = devm_kcalloc(dev, num_sram, sizeof(*core->sram), GFP_KERNEL);
> +	if (!core->sram)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_sram; i++) {
> +		sram_np = of_parse_phandle(np, "sram", i);
> +		if (!sram_np)
> +			return -EINVAL;
> +
> +		if (!of_device_is_available(sram_np)) {
> +			of_node_put(sram_np);
> +			return -EINVAL;
> +		}
> +
> +		ret = of_address_to_resource(sram_np, 0, &res);
> +		of_node_put(sram_np);
> +		if (ret)
> +			return -EINVAL;
> +
> +		core->sram[i].bus_addr = res.start;
> +		core->sram[i].dev_addr = res.start;
> +		core->sram[i].size = resource_size(&res);
> +		core->sram[i].cpu_addr = devm_ioremap_wc(dev, res.start,
> +							 resource_size(&res));
> +		if (!core->sram[i].cpu_addr) {
> +			dev_err(dev, "failed to parse and map sram%d memory at %pad\n",
> +				i, &res.start);
> +			return -ENOMEM;
> +		}
> +
> +		dev_dbg(dev, "memory sram%d: bus addr %pa size 0x%zx va %pK da 0x%x\n",
> +			i, &core->sram[i].bus_addr,
> +			core->sram[i].size, core->sram[i].cpu_addr,
> +			core->sram[i].dev_addr);
> +	}
> +	core->num_sram = num_sram;
> +
> +	return 0;
> +}
> +
>  static
>  struct ti_sci_proc *k3_r5_core_of_get_tsp(struct device *dev,
>  					  const struct ti_sci_handle *sci)
> @@ -1143,6 +1216,12 @@ static int k3_r5_core_of_init(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> +	ret = k3_r5_core_of_get_sram_memories(pdev, core);
> +	if (ret) {
> +		dev_err(dev, "failed to get sram memories, ret = %d\n", ret);
> +		goto err;
> +	}
> +

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	ret = ti_sci_proc_request(core->tsp);
>  	if (ret < 0) {
>  		dev_err(dev, "ti_sci_proc_request failed, ret = %d\n", ret);
> -- 
> 2.26.0
> 
