Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49962C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D5624670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="R1ydfZbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394112AbgBNQuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:50:01 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5730 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392431AbgBNQt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:49:56 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EGgTmP009207;
        Fri, 14 Feb 2020 17:49:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Yj2a7IFHSnPDZ3WYLP65fPO1wS3+vJNQmMzo6fKB96w=;
 b=R1ydfZblboptgDoUuJwZYy73sl+TVqTgOZ9Gp8NcEjdGcHAkPY0hf2XZMtNkhFOY9zB+
 Ky2KwMRJ9vGf6LOh7C/njUHF144wF/y5YhVWOQsSWLzlRxobfpb3X17o4c0i/tkwxzjT
 y9G092v5JArbREH2RDdIjvx6dyXs1k+LHNgKS1O1gkonNaing+rBwMwEqp7nRooS46Ur
 LhJkXDntY99SyUjmhudEDOwIZqeEBqijp1DT5FXlo0AS+Z1Cm0XPFzbfcGKU5eiPtnKO
 TDskgjjIkKHcy387EbJeyMxYrfMNnAZmq7gE91NcrO1Zh9m3GWiRBsBBHHHSG4otwBEY Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1uve4sae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 17:49:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0FC5A10002A;
        Fri, 14 Feb 2020 17:49:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E526D2C0972;
        Fri, 14 Feb 2020 17:49:39 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.45) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 17:49:39 +0100
Subject: Re: [PATCH v5 2/3] remoteproc: stm32: add support for co-processor
 booted before kernel
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
 <20200211174205.22247-3-arnaud.pouliquen@st.com> <20200214033837.GR1443@yoga>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <dfe0b740-c701-00f6-405d-c1808a146093@st.com>
Date:   Fri, 14 Feb 2020 17:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214033837.GR1443@yoga>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_05:2020-02-12,2020-02-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 2/14/20 4:38 AM, Bjorn Andersson wrote:
> On Tue 11 Feb 09:42 PST 2020, Arnaud Pouliquen wrote:
> 
>> From: Fabien Dessenne <fabien.dessenne@st.com>
>>
>> Add support of a remote firmware, preloaded by the boot loader.
> 
> This again describes what Loic was describing, a remote processor with
> persistent or already loaded firmware, not an already booted remote
> processor.
> 
>> Two backup registers are used to retrieve the state of the remote
>> firmware and to get the optional resource table address.
>>
>> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  drivers/remoteproc/stm32_rproc.c | 205 ++++++++++++++++++++++++++++---
>>  1 file changed, 191 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
>> index a18f88044111..3d1e0774318c 100644
>> --- a/drivers/remoteproc/stm32_rproc.c
>> +++ b/drivers/remoteproc/stm32_rproc.c
>> @@ -38,6 +38,15 @@
>>  #define STM32_MBX_VQ1_ID	1
>>  #define STM32_MBX_SHUTDOWN	"shutdown"
>>  
>> +#define RSC_TBL_SIZE		(1024)
>> +
>> +#define COPRO_STATE_OFF		0
>> +#define COPRO_STATE_INIT	1
>> +#define COPRO_STATE_CRUN	2
>> +#define COPRO_STATE_CSTOP	3
>> +#define COPRO_STATE_STANDBY	4
>> +#define COPRO_STATE_CRASH	5
> 
> What does the states INIT and CSTOP represent and how would you deal
> with these and STANDBY/CRASH? Or will this only ever be OFF or CRUN?

I will add references in commit message, information is missing.
This come from stm32 code that has been upstreamed in U-boot.
These definitions match with the u-boot definitions available here:
https://gitlab.denx.de/u-boot/u-boot/blob/master/arch/arm/mach-stm32mp/include/mach/stm32.h
The U-boot source code related to the preloaded is available here:
https://gitlab.denx.de/u-boot/u-boot/blob/master/drivers/remoteproc/stm32_copro.c  

> 
>> +
>>  struct stm32_syscon {
>>  	struct regmap *map;
>>  	u32 reg;
>> @@ -70,12 +79,14 @@ struct stm32_rproc {
>>  	struct reset_control *rst;
>>  	struct stm32_syscon hold_boot;
>>  	struct stm32_syscon pdds;
>> +	struct stm32_syscon copro_state;
>>  	int wdg_irq;
>>  	u32 nb_rmems;
>>  	struct stm32_rproc_mem *rmems;
>>  	struct stm32_mbox mb[MBOX_NB_MBX];
>>  	struct workqueue_struct *workqueue;
>>  	bool secured_soc;
>> +	void __iomem *rsc_va;
>>  };
>>  
>>  static int stm32_rproc_pa_to_da(struct rproc *rproc, phys_addr_t pa, u64 *da)
>> @@ -98,6 +109,28 @@ static int stm32_rproc_pa_to_da(struct rproc *rproc, phys_addr_t pa, u64 *da)
>>  	return -EINVAL;
>>  }
>>  
>> +static int stm32_rproc_da_to_pa(struct rproc *rproc, u64 da, phys_addr_t *pa)
>> +{
>> +	unsigned int i;
>> +	struct stm32_rproc *ddata = rproc->priv;
>> +	struct stm32_rproc_mem *p_mem;
>> +
>> +	for (i = 0; i < ddata->nb_rmems; i++) {
>> +		p_mem = &ddata->rmems[i];
>> +
>> +		if (da < p_mem->dev_addr ||
>> +		    da >= p_mem->dev_addr + p_mem->size)
>> +			continue;
>> +		*pa = da - p_mem->dev_addr + p_mem->bus_addr;
>> +		dev_dbg(rproc->dev.parent, "da %llx to pa %#x\n", da, *pa);
> 
> I think it would look better to move this and below prints to the
> caller (you print in the other cases there).

Ok

> 
>> +		return 0;
>> +	}
>> +
>> +	dev_err(rproc->dev.parent, "can't translate da %llx\n", da);
>> +
>> +	return -EINVAL;
>> +}
>> +
>>  static int stm32_rproc_mem_alloc(struct rproc *rproc,
>>  				 struct rproc_mem_entry *mem)
>>  {
>> @@ -127,6 +160,15 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
>>  	return 0;
>>  }
>>  
>> +static int stm32_rproc_elf_load_segments(struct rproc *rproc,
>> +					 const struct firmware *fw)
>> +{
>> +	if (!rproc->skip_fw_load)
> 
> This indicates that the core's support for skip_fw_load isn't
> sufficient, let's ensure that the necessary core support is in place to
> make the drivers pretty.

I did not find in patch history the reason of this call, but yes seems that this ops should not be called
i will crosscheck this point.

> 
>> +		return rproc_elf_load_segments(rproc, fw);
>> +
>> +	return 0;
>> +}
>> +
>>  static int stm32_rproc_of_memory_translations(struct rproc *rproc)
>>  {
>>  	struct device *parent, *dev = rproc->dev.parent;
>> @@ -197,9 +239,34 @@ static int stm32_rproc_mbox_idx(struct rproc *rproc, const unsigned char *name)
>>  static int stm32_rproc_elf_load_rsc_table(struct rproc *rproc,
>>  					  const struct firmware *fw)
>>  {
>> -	if (rproc_elf_load_rsc_table(rproc, fw))
>> -		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
>> +	struct resource_table *table = NULL;
>> +	struct stm32_rproc *ddata = rproc->priv;
>> +
>> +	if (!rproc->skip_fw_load) {
>> +		if (rproc_elf_load_rsc_table(rproc, fw))
>> +			goto no_rsc_table;
>> +
>> +		return 0;
>> +	}
>> +
>> +	if (ddata->rsc_va) {
>> +		table = (struct resource_table *)ddata->rsc_va;
>> +		/* Assuming that the resource table fits in 1kB is fair */
>> +		rproc->cached_table = kmemdup(table, RSC_TBL_SIZE, GFP_KERNEL);
> 
> If we properly support skipping the booting/setup phase of a remoteproc
> driver in the core, then I don't see a reason why you can't do this
> directly in your probe function.

The hypothesis is that the resource table can be decorrelated from the firmware, that why this ops has to be called for preloaded and none-preloded FWs. In this case does it usefull to move it in probe function?

> 
>> +		if (!rproc->cached_table)
>> +			return -ENOMEM;
>> +
>> +		rproc->table_ptr = rproc->cached_table;
>> +		rproc->table_sz = RSC_TBL_SIZE;
>> +		return 0;
>> +	}
>>  
>> +	rproc->cached_table = NULL;
>> +	rproc->table_ptr = NULL;
>> +	rproc->table_sz = 0;
>> +
>> +no_rsc_table:
>> +	dev_warn(&rproc->dev, "no resource table found for this firmware\n");
>>  	return 0;
>>  }
>>  
>> @@ -259,6 +326,36 @@ static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>>  	return stm32_rproc_elf_load_rsc_table(rproc, fw);
>>  }
>>  
>> +static struct resource_table *
>> +stm32_rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
>> +				      const struct firmware *fw)
>> +{
>> +	struct stm32_rproc *ddata = rproc->priv;
>> +
>> +	if (!rproc->skip_fw_load)
>> +		return rproc_elf_find_loaded_rsc_table(rproc, fw);
>> +
>> +	return (struct resource_table *)ddata->rsc_va;
>> +}
>> +
>> +static int stm32_rproc_elf_sanity_check(struct rproc *rproc,
>> +					const struct firmware *fw)
>> +{
>> +	if (!rproc->skip_fw_load)
>> +		return rproc_elf_sanity_check(rproc, fw);
>> +
>> +	return 0;
>> +}
>> +
>> +static u32 stm32_rproc_elf_get_boot_addr(struct rproc *rproc,
>> +					 const struct firmware *fw)
>> +{
>> +	if (!rproc->skip_fw_load)
>> +		return rproc_elf_get_boot_addr(rproc, fw);
>> +
>> +	return 0;
>> +}
>> +
>>  static irqreturn_t stm32_rproc_wdg(int irq, void *data)
>>  {
>>  	struct rproc *rproc = data;
>> @@ -420,7 +517,7 @@ static int stm32_rproc_start(struct rproc *rproc)
>>  	stm32_rproc_add_coredump_trace(rproc);
>>  
>>  	/* clear remote proc Deep Sleep */
>> -	if (ddata->pdds.map) {
>> +	if (ddata->pdds.map && !rproc->skip_fw_load) {
>>  		err = regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
>>  					 ddata->pdds.mask, 0);
>>  		if (err) {
>> @@ -429,9 +526,15 @@ static int stm32_rproc_start(struct rproc *rproc)
>>  		}
>>  	}
>>  
>> -	err = stm32_rproc_set_hold_boot(rproc, false);
>> -	if (err)
>> -		return err;
>> +	/*
>> +	 * If M4 previously started by bootloader, just guarantee holdboot
>> +	 * is set to catch any crash.
>> +	 */
> 
> If the bootloader started the M4, why do we call start()?

The bootloader starts the firmware with "hold boot" disabled.
In case of crash the firmware automatically reboots, during the Linux kernel boot.
Then when Linux "attaches" to the remote firmware, and reconfigures the hold boot to freeze the remote processor on crash, 

> 
>> +	if (!rproc->skip_fw_load) {
>> +		err = stm32_rproc_set_hold_boot(rproc, false);
>> +		if (err)
>> +			return err;
>> +	}
>>  
>>  	return stm32_rproc_set_hold_boot(rproc, true);
>>  }
>> @@ -473,6 +576,21 @@ static int stm32_rproc_stop(struct rproc *rproc)
>>  		}
>>  	}
>>  
>> +	/* update copro state to OFF */
> 
> Please spell out "coprocessor"

ok

> 
>> +	if (ddata->copro_state.map) {
>> +		err = regmap_update_bits(ddata->copro_state.map,
>> +					 ddata->copro_state.reg,
>> +					 ddata->copro_state.mask,
>> +					 COPRO_STATE_OFF);
>> +		if (err) {
>> +			dev_err(&rproc->dev, "failed to set copro state\n");
>> +			return err;
>> +		}
>> +	}
>> +
>> +	/* Reset skip_fw_load state as we stop the co-processor */
>> +	rproc->skip_fw_load = false;
> 
> Now that's a hack...

This allows to support 2 use cases:
- crash recovery ( not able to ensure the integrity of the code in RAM)
- allows application to change the preloaded firmware.
As these use cases depend on the platform hw, how do you suggest to manage it?
 
> 
>> +
>>  	return 0;
>>  }
>>  
>> @@ -502,11 +620,11 @@ static struct rproc_ops st_rproc_ops = {
>>  	.start		= stm32_rproc_start,
>>  	.stop		= stm32_rproc_stop,
>>  	.kick		= stm32_rproc_kick,
>> -	.load		= rproc_elf_load_segments,
>> +	.load		= stm32_rproc_elf_load_segments,
>>  	.parse_fw	= stm32_rproc_parse_fw,
>> -	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>> -	.sanity_check	= rproc_elf_sanity_check,
>> -	.get_boot_addr	= rproc_elf_get_boot_addr,
>> +	.find_loaded_rsc_table = stm32_rproc_elf_find_loaded_rsc_table,
>> +	.sanity_check	= stm32_rproc_elf_sanity_check,
>> +	.get_boot_addr	= stm32_rproc_elf_get_boot_addr,
>>  };
>>  
>>  static const struct of_device_id stm32_rproc_match[] = {
>> @@ -543,8 +661,10 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
>>  	struct device_node *np = dev->of_node;
>>  	struct rproc *rproc = platform_get_drvdata(pdev);
>>  	struct stm32_rproc *ddata = rproc->priv;
>> -	struct stm32_syscon tz;
>> -	unsigned int tzen;
>> +	struct stm32_syscon tz, rsctbl;
>> +	phys_addr_t rsc_pa;
>> +	u32 rsc_da;
>> +	unsigned int tzen, state;
>>  	int err, irq;
>>  
>>  	irq = platform_get_irq(pdev, 0);
>> @@ -602,11 +722,62 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
>>  
>>  	err = stm32_rproc_get_syscon(np, "st,syscfg-pdds", &ddata->pdds);
>>  	if (err)
>> -		dev_warn(dev, "failed to get pdds\n");
>> +		dev_warn(dev, "pdds not supported\n");
> 
> Unrelated change?

yes to clean up in this patchset

> 
>>  
>>  	rproc->auto_boot = of_property_read_bool(np, "st,auto-boot");
>>  
>> -	return stm32_rproc_of_memory_translations(rproc);
>> +	err = stm32_rproc_of_memory_translations(rproc);
>> +	if (err)
>> +		return err;
>> +
>> +	/* check if the coprocessor has been started from the bootloader */
>> +	err = stm32_rproc_get_syscon(np, "st,syscfg-copro-state",
>> +				     &ddata->copro_state);
>> +	if (err) {
>> +		/* no copro_state syscon (optional) */
>> +		dev_warn(dev, "copro_state not supported\n");
>> +		goto bail;
> 
> return 0;

ok

> 
>> +	}
>> +
>> +	err = regmap_read(ddata->copro_state.map, ddata->copro_state.reg,
>> +			  &state);
> 
> Per the name of this function I think it should parse the dt, not figure
> out if the processor is booted already. Please parse things here and
> then read out the state and handle the absence of the "optional"
> properties depending on the state.

I will reorder the sequence.

> 
>> +	if (err) {
>> +		dev_err(&rproc->dev, "failed to read copro state\n");
>> +		return err;
>> +	}
>> +
>> +	if (state == COPRO_STATE_CRUN) {
>> +		rproc->skip_fw_load = true;
>> +
>> +		if (stm32_rproc_get_syscon(np, "st,syscfg-rsc-tbl", &rsctbl)) {
>> +			/* no rsc table syscon (optional) */
>> +			dev_warn(dev, "rsc tbl syscon not supported\n");
>> +			goto bail;
> 
> But you're still going to skip_fw_load?

Yes the DT property is optional, as the resource table is optional. So if not present, we consider that it is a preloaded firmware without resource table.

> 
>> +		}
>> +
>> +		err = regmap_read(rsctbl.map, rsctbl.reg, &rsc_da);
>> +		if (err) {
>> +			dev_err(&rproc->dev, "failed to read rsc tbl addr\n");
>> +			return err;
>> +		}
>> +		if (!rsc_da)
>> +			/* no rsc table */
>> +			goto bail;
>> +
>> +		err = stm32_rproc_da_to_pa(rproc, rsc_da, &rsc_pa);
>> +		if (err)
>> +			return err;
>> +
>> +		ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
>> +		if (IS_ERR_OR_NULL(ddata->rsc_va)) {
> 
> Shouldn't this be just !ddata->rsc_va?

Right, i will fix it.

> 
>> +			dev_err(dev, "Unable to map memory region: %pa+%zx\n",
>> +				&rsc_pa, RSC_TBL_SIZE);
>> +			ddata->rsc_va = NULL;
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +bail:
>> +	return 0;
>>  }
>>  
>>  static int stm32_rproc_probe(struct platform_device *pdev)
>> @@ -640,6 +811,12 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto free_wkq;
>>  
>> +	if (!rproc->skip_fw_load) {
> 
> So you read from the state map that the processor is not booted, why do
> you need to stop it?

This is done as values of the M4 are not at expected state on reset. For instance 
the PDDS value is not set to 1. As consequence the platform can not
go in standby mode. 

> 
>> +		ret = stm32_rproc_stop(rproc);
>> +		if (ret)
>> +			goto free_rproc;
>> +	}
>> +
>>  	ret = stm32_rproc_request_mbox(rproc);
>>  	if (ret)
>>  		goto free_rproc;
> 
> Thanks for including this patch in the series. After reading this patch
> I no longer think that patch 1 implements the proper support for what
> you need.

Please could you explain what exactly does not fit from your point of view?

> 
> The one piece I'm uncertain of is how are you dealing with the firmware
> during a restart or do you simply not support restarts without user
> space selecting new firmware?

Yes we do not support the restart without user space action.
If code is in ROM you can ensure the integrity of the code, but our code is in
RAM. And as RAM can be isolated we potentially don't have access to the code space.
Reseting rproc->skip_fw_load to 0 allows this choice.
So from our point of view delegate the behavior to the user space makes sense as 
depending on hardware but also on project itself.

Thanks,
Arnaud
> 
> Regards,
> Bjorn
> 
