Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886AEC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6C7206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuOt3ynS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgBNDim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:38:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgBNDim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:38:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id b35so4090808pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 19:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YpT/0QhQ5nsh3HHNrOGD2UvWMmgP5kfJ75tWHECF+hQ=;
        b=EuOt3ynST2GRsjr6KunmZnvaDlJbWORw0X7CA8ujXt1RZUTBeuwgCFiTirmdwwLFuH
         a6Fa77AdeXkv3JtLuasw8tHAGWcZcJrvRRPYGENxkNVfSRdESNNyktxaEP1vdqQgE75U
         gVL7G8WK73xJ7DvdBB0Yz1csYi+yemGZ05n4pXzzu0QTyJZfjx0DvoLXQysxzeGWyH9g
         I41yEAPx4D6ngJCQ/vG5fvMjxrXxxfC5ALGP+tgesINBGwZVccvOIlVdpV30M578BI6z
         Z7pYnyyzRZAuwtAwzn/RhdGUaKaAQzxQQfYtrAfLntm+glVSF2zpoL6ZbWHYX516GJe+
         gm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YpT/0QhQ5nsh3HHNrOGD2UvWMmgP5kfJ75tWHECF+hQ=;
        b=D7iO53jilSTN+9VdYJ6guT2OROOIHxeelIDJ3cxiSdPmd+ACvoayE7m21L463dPvM8
         HsBOoYFw7pvSD2XuOMMrdpBHQW6D0mL2TIdT5XxQYCobCBH9o1Jorx7S0lg2qbPoBTqM
         D/Ho6o3HiTZQMdld0XFFVOUqseqCjF8JbzVGhwlANfraA7qdE7gSjP6mmeo6pCjsgL9K
         RyogQjQhqu9P/+6l/BL8J6/M4SHtvjEtBvPRPCrmMdHW/fUST0WFErRajOjZH0gkwDhG
         /HjfDAIWREjotmVBhxQeydGoLXc8ZKehtm/SQtnl66s8lSM4S8tlZYZhoEzHylPqYNTF
         um8w==
X-Gm-Message-State: APjAAAUDcFUaZOGrf2syyRbiz35nHMTX3TVQ1jgfA84c3DqcgWJ1gMiR
        aFaR9kos8X5QyVw6/KSODBVT+w==
X-Google-Smtp-Source: APXvYqxBSvujR3F+pGx8H/PY2LNZESotzmA9i8KgD9q4nKG1oPxHD0C4C20mkmbpCn2h+e7zdT/9cQ==
X-Received: by 2002:a62:878a:: with SMTP id i132mr1319208pfe.8.1581651521115;
        Thu, 13 Feb 2020 19:38:41 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r11sm4799806pgi.9.2020.02.13.19.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 19:38:40 -0800 (PST)
Date:   Thu, 13 Feb 2020 19:38:37 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 2/3] remoteproc: stm32: add support for co-processor
 booted before kernel
Message-ID: <20200214033837.GR1443@yoga>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
 <20200211174205.22247-3-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211174205.22247-3-arnaud.pouliquen@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11 Feb 09:42 PST 2020, Arnaud Pouliquen wrote:

> From: Fabien Dessenne <fabien.dessenne@st.com>
> 
> Add support of a remote firmware, preloaded by the boot loader.

This again describes what Loic was describing, a remote processor with
persistent or already loaded firmware, not an already booted remote
processor.

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

What does the states INIT and CSTOP represent and how would you deal
with these and STANDBY/CRASH? Or will this only ever be OFF or CRUN?

> +
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

I think it would look better to move this and below prints to the
caller (you print in the other cases there).

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

This indicates that the core's support for skip_fw_load isn't
sufficient, let's ensure that the necessary core support is in place to
make the drivers pretty.

> +		return rproc_elf_load_segments(rproc, fw);
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

If we properly support skipping the booting/setup phase of a remoteproc
driver in the core, then I don't see a reason why you can't do this
directly in your probe function.

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

If the bootloader started the M4, why do we call start()?

> +	if (!rproc->skip_fw_load) {
> +		err = stm32_rproc_set_hold_boot(rproc, false);
> +		if (err)
> +			return err;
> +	}
>  
>  	return stm32_rproc_set_hold_boot(rproc, true);
>  }
> @@ -473,6 +576,21 @@ static int stm32_rproc_stop(struct rproc *rproc)
>  		}
>  	}
>  
> +	/* update copro state to OFF */

Please spell out "coprocessor"

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

Now that's a hack...

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

Unrelated change?

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

return 0;

> +	}
> +
> +	err = regmap_read(ddata->copro_state.map, ddata->copro_state.reg,
> +			  &state);

Per the name of this function I think it should parse the dt, not figure
out if the processor is booted already. Please parse things here and
then read out the state and handle the absence of the "optional"
properties depending on the state.

> +	if (err) {
> +		dev_err(&rproc->dev, "failed to read copro state\n");
> +		return err;
> +	}
> +
> +	if (state == COPRO_STATE_CRUN) {
> +		rproc->skip_fw_load = true;
> +
> +		if (stm32_rproc_get_syscon(np, "st,syscfg-rsc-tbl", &rsctbl)) {
> +			/* no rsc table syscon (optional) */
> +			dev_warn(dev, "rsc tbl syscon not supported\n");
> +			goto bail;

But you're still going to skip_fw_load?

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

Shouldn't this be just !ddata->rsc_va?

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

So you read from the state map that the processor is not booted, why do
you need to stop it?

> +		ret = stm32_rproc_stop(rproc);
> +		if (ret)
> +			goto free_rproc;
> +	}
> +
>  	ret = stm32_rproc_request_mbox(rproc);
>  	if (ret)
>  		goto free_rproc;

Thanks for including this patch in the series. After reading this patch
I no longer think that patch 1 implements the proper support for what
you need.

The one piece I'm uncertain of is how are you dealing with the firmware
during a restart or do you simply not support restarts without user
space selecting new firmware?

Regards,
Bjorn
