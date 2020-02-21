Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF80C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF68207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+F3ZE3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgBUVQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:16:53 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35838 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:16:52 -0500
Received: by mail-pj1-f68.google.com with SMTP id q39so1327081pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 13:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jbWjcCeJ+tMsJ37H+v4wCDC++6PlNXZq8kBvXslPfN4=;
        b=X+F3ZE3hbunhDZmTf0XuTehr8+T2eymaP89vqHqLM9LwMJ/bvw9HT1TfnRuCp8rXJF
         T78t4x9pMEE4gqOH44YiYKiZ6pYZON1PYBEt/4yXUGkZ86GIrwi6qel3QVW0mCVztdE5
         Vf/8uLx4WCt/3H1fGVHDcLl8cWHqqdO7gw7jPjagYgv6yzCAFOPM5R25J+QXDU8m6MIz
         0SzXOZHOiMO1LNpa02ZHOXNFfwr5OKUXe6LXgNOh7X/Qeg4KtcmNO48kByg39euyTejJ
         X9/EU8bRi0AgFhTEA/o0NDnfHl7y76VqVK+Htnu7jSg0ouUsS2xuKw0YiUFq6msD5opp
         13NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jbWjcCeJ+tMsJ37H+v4wCDC++6PlNXZq8kBvXslPfN4=;
        b=k41p2okphre9EjykfffOWYIrHmAH4rJXGfnzQ3HlZq0ivmYO7/CTZUg8pXbg+n2VnJ
         VvVDk4ju1QcncqrwfVbKAz37UIab/KTERaBvFd587fs0mQv4i9Eohd9f8SO7jEMJKCm3
         Mqfw6aLYsbhiggl6mTuNCbjL2ZzFlp7cOpLKwekB9Wn/W7Kx4uq3RwSUyac+7AQUFHrj
         TmLZGnvCqK+uL1oifYgV9VPxbnBI9Xuirq3f4RnJYFBHNyYHnbDcCNQGnlVvXuRNM262
         6H64ZbJVd6fPLDOiJrOA0xQMoREcu9xa4iBMRJrA8mgTXbdOWcou95j3CQk3GLuRS1JG
         SkjQ==
X-Gm-Message-State: APjAAAXaKyQm3rTIW6AkYG+34/WfON26oCYG7ubHJvGDjduBpVfgaJAV
        BOfvxRcMLJK3mbCx2GA1Qi7tkMXiZUo=
X-Google-Smtp-Source: APXvYqyvpohp5Lwua3UpWk1U7OsOu9P1jPfqEvBnFOsRxZ8SULDy58bOHnFgSH6gf/9akXUCoJgEcQ==
X-Received: by 2002:a17:90a:fb87:: with SMTP id cp7mr5304844pjb.56.1582319809893;
        Fri, 21 Feb 2020 13:16:49 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c26sm3879574pfj.8.2020.02.21.13.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:16:48 -0800 (PST)
Date:   Fri, 21 Feb 2020 14:16:46 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] remoteproc: imx_rproc: surport early booted remote
 processor
Message-ID: <20200221211646.GB10368@xps15>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-5-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582097265-20170-5-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:27:40PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When remote processor is booted by bootloader, Linux need to
> ignore firmware loading, and ignore remote processor start/stop
> related hardware operations. what should do is to need to handle
> memory-regions and resource table.
> 
> Add a src_started entry to check whether Cortex-M4 is started for i.MX7D
> and i.MX6SX.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 240 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 220 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 3e72b6f38d4b..b9fabe269fd2 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -74,6 +74,7 @@ struct imx_rproc_dcfg {
>  	u32				src_mask;
>  	u32				src_start;
>  	u32				src_stop;
> +	u32				src_started;
>  	const struct imx_rproc_att	*att;
>  	size_t				att_size;
>  };
> @@ -85,6 +86,7 @@ struct imx_rproc {
>  	const struct imx_rproc_dcfg	*dcfg;
>  	struct imx_rproc_mem		mem[IMX7D_RPROC_MEM_MAX];
>  	struct clk			*clk;
> +	bool				early_boot;
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx7d[] = {
> @@ -142,6 +144,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx7d = {
>  	.src_mask	= IMX7D_M4_RST_MASK,
>  	.src_start	= IMX7D_M4_START,
>  	.src_stop	= IMX7D_M4_STOP,
> +	.src_started	= IMX7D_ENABLE_M4,
>  	.att		= imx_rproc_att_imx7d,
>  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx7d),
>  };
> @@ -151,6 +154,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx6sx = {
>  	.src_mask	= IMX6SX_M4_RST_MASK,
>  	.src_start	= IMX6SX_M4_START,
>  	.src_stop	= IMX6SX_M4_STOP,
> +	.src_started	= IMX6SX_ENABLE_M4,
>  	.att		= imx_rproc_att_imx6sx,
>  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx6sx),
>  };
> @@ -162,6 +166,9 @@ static int imx_rproc_start(struct rproc *rproc)
>  	struct device *dev = priv->dev;
>  	int ret;
>  
> +	if (priv->early_boot)
> +		return 0;
> +
>  	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
>  				 dcfg->src_mask, dcfg->src_start);
>  	if (ret)
> @@ -177,6 +184,9 @@ static int imx_rproc_stop(struct rproc *rproc)
>  	struct device *dev = priv->dev;
>  	int ret;
>  
> +	if (priv->early_boot)
> +		return 0;
> +
>  	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
>  				 dcfg->src_mask, dcfg->src_stop);
>  	if (ret)
> @@ -240,10 +250,167 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
>  	return va;
>  }
>  
> +static int imx_rproc_elf_load_segments(struct rproc *rproc,
> +				       const struct firmware *fw)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +
> +	if (!priv->early_boot)
> +		return rproc_elf_load_segments(rproc, fw);
> +
> +	return 0;
> +}
> +
> +static int imx_rproc_mem_alloc(struct rproc *rproc,
> +			       struct rproc_mem_entry *mem)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	void *va;
> +
> +	dev_dbg(dev, "map memory: %p+%x\n", &mem->dma, mem->len);
> +	va = ioremap_wc(mem->dma, mem->len);
> +	if (IS_ERR_OR_NULL(va)) {
> +		dev_err(dev, "Unable to map memory region: %p+%x\n",
> +			&mem->dma, mem->len);
> +		return -ENOMEM;
> +	}
> +
> +	/* Update memory entry va */
> +	mem->va = va;
> +
> +	return 0;
> +}
> +
> +static int imx_rproc_mem_release(struct rproc *rproc,
> +				 struct rproc_mem_entry *mem)
> +{
> +	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
> +	iounmap(mem->va);
> +
> +	return 0;
> +}
> +
> +static int imx_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +	struct resource_table *resource_table;
> +	struct device_node *np = priv->dev->of_node;
> +	struct of_phandle_iterator it;
> +	struct rproc_mem_entry *mem;
> +	struct reserved_mem *rmem;
> +	int index = 0;
> +	int elems;
> +	int ret;
> +	u64 da;
> +
> +	if (!priv->early_boot)
> +		return rproc_elf_load_rsc_table(rproc, fw);

Once again I will concentrate on the scenario rather than making comments on the
code.

If I understand correctly if the AP is responsible for loading the firmware and
starting the MCU, the ELF image contains a resource table that describes all the
memory areas and vdev needed.

Otherwise the MCU firmware that is preloaded by the boot loader or the SCU
does _not_ have a resource table and as such specifics need to be coming from
the DT.  

Is my assesment correct?

> +
> +	/* Register associated reserved memory regions */
> +	of_phandle_iterator_init(&it, np, "memory-region", NULL, 0);
> +	while (of_phandle_iterator_next(&it) == 0) {
> +		rmem = of_reserved_mem_lookup(it.node);
> +		if (!rmem) {
> +			dev_err(priv->dev, "unable to acquire memory-region\n");
> +			return -EINVAL;
> +		}
> +
> +		/* No need to translate pa to da */
> +		da = rmem->base;
> +
> +		if (strcmp(it.node->name, "vdev0buffer")) {
> +			/* Register memory region */
> +			mem = rproc_mem_entry_init(priv->dev, NULL,
> +						   (dma_addr_t)rmem->base,
> +						   rmem->size, da,
> +						   imx_rproc_mem_alloc,
> +						   imx_rproc_mem_release,
> +						   it.node->name);
> +
> +			if (mem)
> +				rproc_coredump_add_segment(rproc, da,
> +							   rmem->size);
> +		} else {
> +			/* Register reserved memory for vdev buffer alloc */
> +			mem = rproc_of_resm_mem_entry_init(priv->dev, index,
> +							   rmem->size,
> +							   rmem->base,
> +							   it.node->name);
> +		}
> +
> +		if (!mem)
> +			return -ENOMEM;
> +
> +		rproc_add_carveout(rproc, mem);
> +		index++;
> +	}
> +
> +	/*Parse device tree to get resource table */
> +	elems = of_property_count_u32_elems(np, "rsrc-table");
> +	if (elems < 0) {
> +		dev_err(&rproc->dev, "no rsrc-table\n");
> +		return elems;
> +	}
> +
> +	resource_table = kzalloc(elems * sizeof(u32), GFP_KERNEL);
> +	if (!resource_table)
> +		return PTR_ERR(resource_table);
> +
> +	ret = of_property_read_u32_array(np, "rsrc-table",
> +					 (u32 *)resource_table, elems);
> +	if (ret)
> +		return ret;
> +
> +	rproc->cached_table = resource_table;
> +	rproc->table_ptr = resource_table;
> +	rproc->table_sz = elems * sizeof(u32);
> +
> +	return 0;
> +}
> +
> +static struct resource_table *
> +imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
> +				    const struct firmware *fw)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +
> +	if (!priv->early_boot)
> +		return rproc_elf_find_loaded_rsc_table(rproc, fw);
> +
> +	return NULL;
> +}
> +
> +static int imx_rproc_elf_sanity_check(struct rproc *rproc,
> +				      const struct firmware *fw)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +
> +	if (!priv->early_boot)
> +		return rproc_elf_sanity_check(rproc, fw);
> +
> +	return 0;
> +}
> +
> +static u32 imx_rproc_elf_get_boot_addr(struct rproc *rproc,
> +				       const struct firmware *fw)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +
> +	if (!priv->early_boot)
> +		return rproc_elf_get_boot_addr(rproc, fw);
> +
> +	return 0;
> +}
> +
>  static const struct rproc_ops imx_rproc_ops = {
>  	.start		= imx_rproc_start,
>  	.stop		= imx_rproc_stop,
>  	.da_to_va       = imx_rproc_da_to_va,
> +	.load		= imx_rproc_elf_load_segments,
> +	.parse_fw	= imx_rproc_parse_fw,
> +	.find_loaded_rsc_table = imx_rproc_elf_find_loaded_rsc_table,
> +	.sanity_check	= imx_rproc_elf_sanity_check,
> +	.get_boot_addr	= imx_rproc_elf_get_boot_addr,
>  };
>  
>  static int imx_rproc_addr_init(struct imx_rproc *priv,
> @@ -309,6 +476,31 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  	return 0;
>  }
>  
> +static int imx_rproc_configure_mode(struct imx_rproc *priv)
> +{
> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> +	struct device *dev = priv->dev;
> +	int ret;
> +	u32 val;
> +
> +	if (of_get_property(dev->of_node, "early-booted", NULL)) {
> +		priv->early_boot = true;
> +	} else {
> +		ret = regmap_read(priv->regmap, dcfg->src_reg, &val);
> +		if (ret) {
> +			dev_err(dev, "Failed to read src\n");
> +			return ret;
> +		}
> +
> +		priv->early_boot = !!(val & dcfg->src_started);
> +	}
> +
> +	if (priv->early_boot)
> +		priv->rproc->skip_fw_load = true;
> +
> +	return 0;
> +}
> +
>  static int imx_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -347,27 +539,33 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(dev, rproc);
>  
> -	ret = imx_rproc_addr_init(priv, pdev);
> -	if (ret) {
> -		dev_err(dev, "failed on imx_rproc_addr_init\n");
> +	ret = imx_rproc_configure_mode(priv);
> +	if (ret)
>  		goto err_put_rproc;
> -	}
>  
> -	priv->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(priv->clk)) {
> -		dev_err(dev, "Failed to get clock\n");
> -		ret = PTR_ERR(priv->clk);
> -		goto err_put_rproc;
> -	}
> +	if (!priv->early_boot) {
> +		ret = imx_rproc_addr_init(priv, pdev);
> +		if (ret) {
> +			dev_err(dev, "failed on imx_rproc_addr_init\n");
> +			goto err_put_rproc;
> +		}
>  
> -	/*
> -	 * clk for M4 block including memory. Should be
> -	 * enabled before .start for FW transfer.
> -	 */
> -	ret = clk_prepare_enable(priv->clk);
> -	if (ret) {
> -		dev_err(&rproc->dev, "Failed to enable clock\n");
> -		goto err_put_rproc;
> +		priv->clk = devm_clk_get(dev, NULL);
> +		if (IS_ERR(priv->clk)) {
> +			dev_err(dev, "Failed to get clock\n");
> +			ret = PTR_ERR(priv->clk);
> +			goto err_put_rproc;
> +		}
> +
> +		/*
> +		 * clk for M4 block including memory. Should be
> +		 * enabled before .start for FW transfer.
> +		 */
> +		ret = clk_prepare_enable(priv->clk);
> +		if (ret) {
> +			dev_err(&rproc->dev, "Failed to enable clock\n");
> +			goto err_put_rproc;
> +		}
>  	}
>  
>  	ret = rproc_add(rproc);
> @@ -379,7 +577,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_put_clk:
> -	clk_disable_unprepare(priv->clk);
> +	if (!priv->early_boot)
> +		clk_disable_unprepare(priv->clk);
>  err_put_rproc:
>  	rproc_free(rproc);
>  
> @@ -391,7 +590,8 @@ static int imx_rproc_remove(struct platform_device *pdev)
>  	struct rproc *rproc = platform_get_drvdata(pdev);
>  	struct imx_rproc *priv = rproc->priv;
>  
> -	clk_disable_unprepare(priv->clk);
> +	if (!priv->early_boot)
> +		clk_disable_unprepare(priv->clk);
>  	rproc_del(rproc);
>  	rproc_free(rproc);
>  
> -- 
> 2.16.4
> 
