Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F7DC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9379222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G02f6fUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBMUe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:34:29 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33051 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgBMUe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:34:29 -0500
Received: by mail-pj1-f68.google.com with SMTP id m7so170497pjs.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 12:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2GYuus2VqSbpxuT8tlkx6xMJTdx8OzbP9fckzQRG/4=;
        b=G02f6fUoBJHNQJ7Bgp5uVlUiqZxLgVPLAPS9xlBfQNOkoP2W7B8zYTQ9DX8Lb73jV/
         NB2oIp6f7LN+ivAsf5oXgdRp4WiXdCOcOdnk1IuPmuWj2EvHZfrT2Wqni3S6EbUJQmQc
         0alt34gcSOJ4sStiJMkU1elwnFycFuJxu7zPjd821o5LYGEv4nAFScsx0GgYlVWkMhH6
         fFoiSyOXafSZQ/zcZNKeKqQpOvohvXLiJGhve8o+GvHZHGJgpPYlsxmpHDd2q3oXsmth
         OqPRmQ+fjjr3nBgPfIK9txsNLAWjwgg1EUMpcljrfMfxDOqFN5xEBoIO550fDH8/ybkA
         n++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2GYuus2VqSbpxuT8tlkx6xMJTdx8OzbP9fckzQRG/4=;
        b=dSJv/kiLNkkhIaWK2jdSkElPzlooGzI4foYl1UQWLBXAlNS0nrCEffrWZDtemexu3x
         fk5W/L1G//jSFbs+fp7eaNe+X/0L7jYx/bqgmWLaW87L5pVrsmQdL/P5vEhODra0CxC/
         X5iWbQKptsANsDIsa0/iIWd1FdoubxgjHv2tlp8OOXbcKEw7auuYMnI6vIURxz4IdzJL
         A9Tf58OkDFlivdLEaqZqHCLe7fd6k2jWbUd+vtTrdbuJbYinPw6/wAc3/4H+kZkfKtTO
         nsSoyjUhAcD6CHST81kO64h485zdkkXO2ab95/1SjcOT6xUWJbfdqfbSlcKmx0LCXYdG
         LELg==
X-Gm-Message-State: APjAAAVdXT9iZqqXoeeJoL7iTl+7y7/Rn+TXy4yaZwncxcsb5LQ81ZQa
        W15he1yoqeuuRXXU4Ax6PHSuOrCH+E8=
X-Google-Smtp-Source: APXvYqxkyBqjbaki0/oaF8commOfUHekscfu5WY16tVwjuFNLrXh8yDz4KCZi5wqiI0k6BloS9dAxg==
X-Received: by 2002:a17:90b:110d:: with SMTP id gi13mr7239008pjb.123.1581626067853;
        Thu, 13 Feb 2020 12:34:27 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id iq22sm3826002pjb.9.2020.02.13.12.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:34:27 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:34:25 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 2/3] remoteproc: stm32: add support for co-processor
 booted before kernel
Message-ID: <20200213203425.GB14415@xps15>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
 <20200211174205.22247-3-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211174205.22247-3-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:42:04PM +0100, Arnaud Pouliquen wrote:
> From: Fabien Dessenne <fabien.dessenne@st.com>
> 
> Add support of a remote firmware, preloaded by the boot loader.
> Two backup registers are used to retrieve the state of the remote
> firmware and to get the optional resource table address.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  drivers/remoteproc/stm32_rproc.c | 205 ++++++++++++++++++++++++++++---
>  1 file changed, 191 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index a18f88044111..3d1e0774318c 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -38,6 +38,15 @@
>  #define STM32_MBX_VQ1_ID	1
>  #define STM32_MBX_SHUTDOWN	"shutdown"
>  
> +#define RSC_TBL_SIZE		(1024)
> +
> +#define COPRO_STATE_OFF		0
> +#define COPRO_STATE_INIT	1
> +#define COPRO_STATE_CRUN	2
> +#define COPRO_STATE_CSTOP	3
> +#define COPRO_STATE_STANDBY	4
> +#define COPRO_STATE_CRASH	5
> +

At this time only COPRO_STATE_OFF and COPRO_STATE_CRUN are used.  I also looked
on github[1] but couldn't find where the rest of the defines come in.

[1]. https://github.com/STMicroelectronics/linux/blob/v4.19-stm32mp/drivers/remoteproc/stm32_rproc.c

>  struct stm32_syscon {
>  	struct regmap *map;
>  	u32 reg;
> @@ -70,12 +79,14 @@ struct stm32_rproc {
>  	struct reset_control *rst;
>  	struct stm32_syscon hold_boot;
>  	struct stm32_syscon pdds;
> +	struct stm32_syscon copro_state;
>  	int wdg_irq;
>  	u32 nb_rmems;
>  	struct stm32_rproc_mem *rmems;
>  	struct stm32_mbox mb[MBOX_NB_MBX];
>  	struct workqueue_struct *workqueue;
>  	bool secured_soc;
> +	void __iomem *rsc_va;
>  };
>  
>  static int stm32_rproc_pa_to_da(struct rproc *rproc, phys_addr_t pa, u64 *da)
> @@ -98,6 +109,28 @@ static int stm32_rproc_pa_to_da(struct rproc *rproc, phys_addr_t pa, u64 *da)
>  	return -EINVAL;
>  }
>  
> +static int stm32_rproc_da_to_pa(struct rproc *rproc, u64 da, phys_addr_t *pa)
> +{
> +	unsigned int i;
> +	struct stm32_rproc *ddata = rproc->priv;
> +	struct stm32_rproc_mem *p_mem;
> +
> +	for (i = 0; i < ddata->nb_rmems; i++) {
> +		p_mem = &ddata->rmems[i];
> +
> +		if (da < p_mem->dev_addr ||
> +		    da >= p_mem->dev_addr + p_mem->size)
> +			continue;
> +		*pa = da - p_mem->dev_addr + p_mem->bus_addr;
> +		dev_dbg(rproc->dev.parent, "da %llx to pa %#x\n", da, *pa);
> +		return 0;
> +	}
> +
> +	dev_err(rproc->dev.parent, "can't translate da %llx\n", da);
> +
> +	return -EINVAL;
> +}
> +
>  static int stm32_rproc_mem_alloc(struct rproc *rproc,
>  				 struct rproc_mem_entry *mem)
>  {
> @@ -127,6 +160,15 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
>  	return 0;
>  }
>  
> +static int stm32_rproc_elf_load_segments(struct rproc *rproc,
> +					 const struct firmware *fw)
> +{
> +	if (!rproc->skip_fw_load)
> +		return rproc_elf_load_segments(rproc, fw);

Is it possible that the image loaded by the boot loader be also present in
lib/firmware?  If so the segment from the image could be added to the
->dump_segments so that if a crash occurs before the MCU is rebooted, some
information is available.  But that is just a thought...  Nothing specific to
change if you don't feel the need to.

> +
> +	return 0;
> +}
> +
>  static int stm32_rproc_of_memory_translations(struct rproc *rproc)
>  {
>  	struct device *parent, *dev = rproc->dev.parent;
> @@ -197,9 +239,34 @@ static int stm32_rproc_mbox_idx(struct rproc *rproc, const unsigned char *name)
>  static int stm32_rproc_elf_load_rsc_table(struct rproc *rproc,
>  					  const struct firmware *fw)
>  {
> -	if (rproc_elf_load_rsc_table(rproc, fw))
> -		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
> +	struct resource_table *table = NULL;
> +	struct stm32_rproc *ddata = rproc->priv;
> +
> +	if (!rproc->skip_fw_load) {
> +		if (rproc_elf_load_rsc_table(rproc, fw))
> +			goto no_rsc_table;
> +
> +		return 0;
> +	}
> +
> +	if (ddata->rsc_va) {
> +		table = (struct resource_table *)ddata->rsc_va;
> +		/* Assuming that the resource table fits in 1kB is fair */
> +		rproc->cached_table = kmemdup(table, RSC_TBL_SIZE, GFP_KERNEL);
> +		if (!rproc->cached_table)
> +			return -ENOMEM;
> +
> +		rproc->table_ptr = rproc->cached_table;
> +		rproc->table_sz = RSC_TBL_SIZE;
> +		return 0;
> +	}
>  
> +	rproc->cached_table = NULL;
> +	rproc->table_ptr = NULL;
> +	rproc->table_sz = 0;
> +
> +no_rsc_table:
> +	dev_warn(&rproc->dev, "no resource table found for this firmware\n");
>  	return 0;
>  }
>  
> @@ -259,6 +326,36 @@ static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  	return stm32_rproc_elf_load_rsc_table(rproc, fw);
>  }
>  
> +static struct resource_table *
> +stm32_rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
> +				      const struct firmware *fw)
> +{
> +	struct stm32_rproc *ddata = rproc->priv;
> +
> +	if (!rproc->skip_fw_load)
> +		return rproc_elf_find_loaded_rsc_table(rproc, fw);
> +
> +	return (struct resource_table *)ddata->rsc_va;
> +}
> +
> +static int stm32_rproc_elf_sanity_check(struct rproc *rproc,
> +					const struct firmware *fw)
> +{
> +	if (!rproc->skip_fw_load)
> +		return rproc_elf_sanity_check(rproc, fw);
> +
> +	return 0;
> +}
> +
> +static u32 stm32_rproc_elf_get_boot_addr(struct rproc *rproc,
> +					 const struct firmware *fw)
> +{
> +	if (!rproc->skip_fw_load)
> +		return rproc_elf_get_boot_addr(rproc, fw);
> +
> +	return 0;
> +}
> +
>  static irqreturn_t stm32_rproc_wdg(int irq, void *data)
>  {
>  	struct rproc *rproc = data;
> @@ -420,7 +517,7 @@ static int stm32_rproc_start(struct rproc *rproc)
>  	stm32_rproc_add_coredump_trace(rproc);
>  
>  	/* clear remote proc Deep Sleep */
> -	if (ddata->pdds.map) {
> +	if (ddata->pdds.map && !rproc->skip_fw_load) {
>  		err = regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
>  					 ddata->pdds.mask, 0);

Because this is platform code it is really hard to understand what is going on
and why this change is needed.  As such it is hard to do a meticulous review of
the code and find problems.  Ideally reviewers should only have to look at the
code and read the comments to understand the logic.

There is probably nothing wrong with the above, I just don't have enough
information to understand it. 

>  		if (err) {
> @@ -429,9 +526,15 @@ static int stm32_rproc_start(struct rproc *rproc)
>  		}
>  	}
>  
> -	err = stm32_rproc_set_hold_boot(rproc, false);
> -	if (err)
> -		return err;
> +	/*
> +	 * If M4 previously started by bootloader, just guarantee holdboot
> +	 * is set to catch any crash.
> +	 */
> +	if (!rproc->skip_fw_load) {
> +		err = stm32_rproc_set_hold_boot(rproc, false);
> +		if (err)
> +			return err;
> +	}

Same here. 

>  
>  	return stm32_rproc_set_hold_boot(rproc, true);
>  }
> @@ -473,6 +576,21 @@ static int stm32_rproc_stop(struct rproc *rproc)
>  		}
>  	}
>  
> +	/* update copro state to OFF */
> +	if (ddata->copro_state.map) {
> +		err = regmap_update_bits(ddata->copro_state.map,
> +					 ddata->copro_state.reg,
> +					 ddata->copro_state.mask,
> +					 COPRO_STATE_OFF);
> +		if (err) {
> +			dev_err(&rproc->dev, "failed to set copro state\n");
> +			return err;
> +		}
> +	}
> +
> +	/* Reset skip_fw_load state as we stop the co-processor */
> +	rproc->skip_fw_load = false;
> +
>  	return 0;
>  }
>  
> @@ -502,11 +620,11 @@ static struct rproc_ops st_rproc_ops = {
>  	.start		= stm32_rproc_start,
>  	.stop		= stm32_rproc_stop,
>  	.kick		= stm32_rproc_kick,
> -	.load		= rproc_elf_load_segments,
> +	.load		= stm32_rproc_elf_load_segments,
>  	.parse_fw	= stm32_rproc_parse_fw,
> -	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> -	.sanity_check	= rproc_elf_sanity_check,
> -	.get_boot_addr	= rproc_elf_get_boot_addr,
> +	.find_loaded_rsc_table = stm32_rproc_elf_find_loaded_rsc_table,
> +	.sanity_check	= stm32_rproc_elf_sanity_check,
> +	.get_boot_addr	= stm32_rproc_elf_get_boot_addr,
>  };
>  
>  static const struct of_device_id stm32_rproc_match[] = {
> @@ -543,8 +661,10 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
>  	struct device_node *np = dev->of_node;
>  	struct rproc *rproc = platform_get_drvdata(pdev);
>  	struct stm32_rproc *ddata = rproc->priv;
> -	struct stm32_syscon tz;
> -	unsigned int tzen;
> +	struct stm32_syscon tz, rsctbl;
> +	phys_addr_t rsc_pa;
> +	u32 rsc_da;
> +	unsigned int tzen, state;
>  	int err, irq;
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -602,11 +722,62 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
>  
>  	err = stm32_rproc_get_syscon(np, "st,syscfg-pdds", &ddata->pdds);
>  	if (err)
> -		dev_warn(dev, "failed to get pdds\n");
> +		dev_warn(dev, "pdds not supported\n");
>  
>  	rproc->auto_boot = of_property_read_bool(np, "st,auto-boot");
>  
> -	return stm32_rproc_of_memory_translations(rproc);
> +	err = stm32_rproc_of_memory_translations(rproc);
> +	if (err)
> +		return err;
> +
> +	/* check if the coprocessor has been started from the bootloader */
> +	err = stm32_rproc_get_syscon(np, "st,syscfg-copro-state",
> +				     &ddata->copro_state);
> +	if (err) {
> +		/* no copro_state syscon (optional) */
> +		dev_warn(dev, "copro_state not supported\n");
> +		goto bail;
> +	}
> +
> +	err = regmap_read(ddata->copro_state.map, ddata->copro_state.reg,
> +			  &state);
> +	if (err) {
> +		dev_err(&rproc->dev, "failed to read copro state\n");
> +		return err;
> +	}
> +

        if (state != COPRO_STATE_CRUN)
                goto bail;

> +	if (state == COPRO_STATE_CRUN) {
> +		rproc->skip_fw_load = true;
> +
> +		if (stm32_rproc_get_syscon(np, "st,syscfg-rsc-tbl", &rsctbl)) {
> +			/* no rsc table syscon (optional) */
> +			dev_warn(dev, "rsc tbl syscon not supported\n");
> +			goto bail;
> +		}
> +
> +		err = regmap_read(rsctbl.map, rsctbl.reg, &rsc_da);
> +		if (err) {
> +			dev_err(&rproc->dev, "failed to read rsc tbl addr\n");
> +			return err;
> +		}
> +		if (!rsc_da)
> +			/* no rsc table */
> +			goto bail;
> +
> +		err = stm32_rproc_da_to_pa(rproc, rsc_da, &rsc_pa);
> +		if (err)
> +			return err;
> +
> +		ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
> +		if (IS_ERR_OR_NULL(ddata->rsc_va)) {
> +			dev_err(dev, "Unable to map memory region: %pa+%zx\n",
> +				&rsc_pa, RSC_TBL_SIZE);
> +			ddata->rsc_va = NULL;
> +			return -ENOMEM;
> +		}
> +	}
> +bail:
> +	return 0;
>  }
>  
>  static int stm32_rproc_probe(struct platform_device *pdev)
> @@ -640,6 +811,12 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_wkq;
>  
> +	if (!rproc->skip_fw_load) {
> +		ret = stm32_rproc_stop(rproc);
> +		if (ret)
> +			goto free_rproc;
> +	}
> +

I'm very puzzled here, especially since it deals with the case where FW is
loaded by the framework.  Do you think you could add a (lengthy) comment to
explain what is going on?

Thanks,
Mathieu

>  	ret = stm32_rproc_request_mbox(rproc);
>  	if (ret)
>  		goto free_rproc;
> -- 
> 2.17.1
> 
