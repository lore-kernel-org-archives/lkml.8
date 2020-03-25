Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607C8C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1B520719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Odq4E63u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCYFTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:19:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33329 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYFTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:19:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id g18so376928plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 22:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J29crWytQAisaCp0H628HohCtdrpBvOM1Zs9NCer/jw=;
        b=Odq4E63ulVsiXjbm7OEotwAvFIrGAqbeq4oI0SFfqI4POWn+iyou27zqLA+SbBg9p8
         JrBL8L7y0ayxFj9xcMoHxOU5qC1hdCAEb3Xft2AlANKAM0EyQkd3KUCaSf61LQvZ6qzX
         hewHBLiChnGuRHYAlmmWP0YVsQRz8Y5l8q+ipY+/IDk6BIw1ExmYXXKJRlx1ErD6Nkzy
         wxgKD7soLkQuogTJSqr+V86khF8mi8dk+/Tm6mTrL4sRePj7Qxj247fa2u6XFVaUY/c0
         zj3wAD0y7X6zW2G8xfraAIDoqIgD3Zwusba3yNNYcx2iWNxSuKciqo8Ht5L+H65edYkE
         D+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J29crWytQAisaCp0H628HohCtdrpBvOM1Zs9NCer/jw=;
        b=irTUTiBewf6KX9DPNkbV2+PU+XHicSvzyAuctEjm5icnpmRXlv3RitXJ0hgDXjMAl4
         E2s0SmUhoAzl/THkumzvywZ5oEIukYwO5TqG6+TDFdBn4pnkvIWJ9uM6QFQJjAAZvAvQ
         lkCNuuT1zWck3RAVqGKfdzkYiVDIvluy2hyPIlaYjmWx1WH2yck9rITEgxAe0LNL2TjQ
         d2f/2ap+ex87P5TrjouGoclJEGFUpqXGnvnnm+RhxtaZ+vp0i9j4zeEGJLfZmfBOj6WS
         RtD++ib79+7D+Lst77dP5hj+G4pO56Cr6pOuoK3z+KFvkSxtXaKdP4YGblzyORWr05rr
         Zbcg==
X-Gm-Message-State: ANhLgQ2JDgNnCA5tVk9F9GoLmeCOoIPAPbqMwjEbM1emV+7Ox6QEwnOP
        Mg+GlLEmC4KM5sT8gMxSxUXbCw==
X-Google-Smtp-Source: ADFU+vuthqwecOtp0+4ed+RE3r+KNsZuvSR0QhTyCSiZ0TG6AgVxvr7G2e9wdw1IfrHu31WiKeBIBQ==
X-Received: by 2002:a17:90a:a511:: with SMTP id a17mr1703243pjq.178.1585113576796;
        Tue, 24 Mar 2020 22:19:36 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g12sm65965pfo.200.2020.03.24.22.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:19:36 -0700 (PDT)
Date:   Tue, 24 Mar 2020 22:19:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v1 1/2] remoteproc: qcom: Add PAS based SPSS PIL driver
Message-ID: <20200325051933.GG522435@yoga>
References: <1584754330-445-1-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584754330-445-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Mar 18:32 PDT 2020, Rishabh Bhatnagar wrote:

> This adds Peripheral Authentication System (PAS) based SPSS PIL
> driver for loading SPSS firmware and booting. The firmware is
> verified and booted with the help of the PAS in TrustZone.
> This driver also adds functionality to handle late
> attach feature for a remote processor. The driver queries
> the initial state of remote processor and is capable of handling
> successful bootup and crash scenarios.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/Kconfig     |  17 ++
>  drivers/remoteproc/Makefile    |   1 +
>  drivers/remoteproc/qcom_spss.c | 500 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 518 insertions(+)
>  create mode 100644 drivers/remoteproc/qcom_spss.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index de3862c..ab3e89a 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -151,6 +151,23 @@ config QCOM_Q6V5_PAS
>  	  for the Qualcomm Hexagon v5 based remote processors. This is commonly
>  	  used to control subsystems such as ADSP, Compute and Sensor.
>  
> +config QCOM_SPSS
> +	tristate "Qualcomm secure subsystem Peripheral loading support"
> +	depends on OF && ARCH_QCOM
> +	depends on QCOM_SMEM
> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
> +	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> +	depends on QCOM_SYSMON || QCOM_SYSMON=n
> +	select MFD_SYSCON
> +	select QCOM_MDT_LOADER
> +	select QCOM_Q6V5_COMMON
> +	select QCOM_RPROC_COMMON
> +	select QCOM_SCM
> +	help
> +	  Say y here to support the TrustZone based Peripheral Image Loader
> +	  for the Qualcomm secure subsystem remote processor. This also supports
> +	  remote processors that are booted before kernel comes up.
> +
>  config QCOM_Q6V5_WCSS
>  	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
>  	depends on OF && ARCH_QCOM
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index e30a1b1..e781552 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>  obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>  obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
>  obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
> +obj-$(CONFIG_QCOM_SPSS)			+= qcom_spss.o
>  obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
>  obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
>  obj-$(CONFIG_QCOM_Q6V5_ADSP)		+= qcom_q6v5_adsp.o
> diff --git a/drivers/remoteproc/qcom_spss.c b/drivers/remoteproc/qcom_spss.c
> new file mode 100644
> index 0000000..7be7b2b
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_spss.c
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + * Qualcomm SPSS Peripheral Image Loader for SM8250
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/firmware.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/qcom_scm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/remoteproc.h>
> +#include <linux/soc/qcom/mdt_loader.h>
> +
> +#include "qcom_common.h"
> +#include "remoteproc_internal.h"
> +
> +#define ERR_READY	0
> +#define PBL_DONE	1
> +
> +struct spss_data {
> +	const char *firmware_name;
> +	int pas_id;
> +	const char *ssr_name;
> +	bool skip_fw_load;
> +};
> +
> +struct qcom_spss {
> +	struct device *dev;
> +	struct rproc *rproc;
> +
> +	struct clk *xo;
> +
> +	struct regulator *cx_supply;
> +	struct regulator *px_supply;
> +
> +	int pas_id;
> +
> +	struct completion start_done;
> +
> +	phys_addr_t mem_phys;
> +	phys_addr_t mem_reloc;
> +	void *mem_region;
> +	size_t mem_size;
> +	int generic_irq;
> +
> +	struct qcom_rproc_glink glink_subdev;
> +	struct qcom_rproc_ssr ssr_subdev;
> +	void __iomem *irq_status;
> +	void __iomem *irq_clr;
> +	void __iomem *irq_mask;
> +	void __iomem *err_status;
> +	void __iomem *err_status_spare;
> +	u32 bits_arr[2];

Rather than having this lookup table, just define PBL_DONE and ERR_READY
as BIT(24) and BIT(25), respectively. Once we add support for a platform
where these differs we can add it to the data associated with the
compatible.

> +};
> +
> +static void clear_pbl_done(struct qcom_spss *spss)
> +{
> +	uint32_t err_value, rmb_err_spare0, rmb_err_spare1, rmb_err_spare2;
> +
> +	err_value =  __raw_readl(spss->err_status);
> +	rmb_err_spare2 =  __raw_readl(spss->err_status_spare);
> +	rmb_err_spare1 =  __raw_readl(spss->err_status_spare-4);

err_status_spare is the returned value of a ioremap, so -4 here is
invalid.

> +	rmb_err_spare0 =  __raw_readl(spss->err_status_spare-8);

Why bypass the endian handling here? Can we use readl() and writel()
throughout instead?

> +
> +	if (err_value) {
> +		dev_err(spss->dev, "PBL error status register: 0x%08x,\
> +			spare0 register: 0x%08x, spare1 register: 0x%08x,\
> +			spare2 register: 0x%08x\n", err_value, rmb_err_spare0,
> +					rmb_err_spare1, rmb_err_spare2);
> +	} else
> +		dev_info(spss->dev, "PBL_DONE - 1st phase loading [%s] \
> +					completed ok\n", spss->rproc->name);

Please omit any "noisy" prints in the logs. You may dev_dbg() this if
you really want it.

> +
> +	__raw_writel(BIT(spss->bits_arr[PBL_DONE]), spss->irq_clr);
> +}
> +
> +static void clear_err_ready(struct qcom_spss *spss)
> +{
> +	dev_info(spss->dev, "SW_INIT_DONE - 2nd phase loading [%s] \
> +					completed ok\n", spss->rproc->name);
> +
> +	__raw_writel(BIT(spss->bits_arr[ERR_READY]), spss->irq_clr);
> +	complete(&spss->start_done);
> +}
> +
> +static void clear_sw_init_done_error(struct qcom_spss *spss, int err)
> +{
> +	uint32_t rmb_err_spare0;
> +	uint32_t rmb_err_spare1;
> +	uint32_t rmb_err_spare2;
> +
> +	dev_info(spss->dev, "SW_INIT_DONE - ERROR [%s] [0x%x].\n",
> +						spss->rproc->name, err);
> +
> +	rmb_err_spare2 =  __raw_readl(spss->err_status_spare);
> +	rmb_err_spare1 =  __raw_readl(spss->err_status_spare-4);
> +	rmb_err_spare0 =  __raw_readl(spss->err_status_spare-8);
> +
> +	dev_err(spss->dev, "spare0 register: 0x%08x, spare1 register: 0x%08x,\
> +		spare2 register: 0x%08x\n", rmb_err_spare0, rmb_err_spare1,
> +							rmb_err_spare2);
> +
> +	/* Clear the interrupt source */
> +	__raw_writel(BIT(spss->bits_arr[ERR_READY]), spss->irq_clr);
> +}
> +
> +
> +
> +static void clear_wdog(struct qcom_spss *spss)
> +{
> +	/* Check crash status to know if device is restarting*/
> +	if (spss->rproc->state == RPROC_RUNNING) {
> +		dev_err(spss->dev, "wdog bite received from %s!\n",
> +							spss->rproc->name);
> +		__raw_writel(BIT(spss->bits_arr[ERR_READY]), spss->irq_clr);
> +		rproc_report_crash(spss->rproc, RPROC_WATCHDOG);
> +	}
> +}
> +
> +static irqreturn_t spss_generic_handler(int irq, void *dev_id)
> +{
> +	struct qcom_spss *spss = dev_id;
> +	uint32_t status_val, err_value;
> +
> +	err_value =  __raw_readl(spss->err_status_spare);
> +	status_val = __raw_readl(spss->irq_status);
> +
> +	if (status_val & BIT(spss->bits_arr[ERR_READY])) {
> +		if (!err_value)
> +			clear_err_ready(spss);
> +		else if (err_value == 0x44554d50)
> +			clear_wdog(spss);
> +		else
> +			clear_sw_init_done_error(spss, err_value);
> +	}
> +
> +	if (status_val & BIT(spss->bits_arr[PBL_DONE]))
> +		clear_pbl_done(spss);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void mask_scsr_irqs(struct qcom_spss *spss)
> +{
> +	uint32_t mask_val;
> +
> +	/* Masking all interrupts */
> +	mask_val = ~0;
> +	__raw_writel(mask_val,  spss->irq_mask);
> +}
> +
> +static void unmask_scsr_irqs(struct qcom_spss *spss)
> +{
> +	uint32_t mask_val;
> +
> +	/* unmasking interrupts handled by HLOS */
> +	mask_val = ~0;
> +	__raw_writel(mask_val & ~BIT(spss->bits_arr[ERR_READY]) &
> +			~BIT(spss->bits_arr[PBL_DONE]), spss->irq_mask);

This looks undefined, do you mean to write ~(ERR_READY | PBL_DONE)?

> +}
> +
> +static bool check_status(struct qcom_spss *spss)

s/check_status/check_if_crashed/

> +{
> +	uint32_t status_val, err_value;
> +
> +	err_value =  __raw_readl(spss->err_status_spare);
> +	status_val = __raw_readl(spss->irq_status);
> +
> +	if ((status_val & BIT(spss->bits_arr[ERR_READY])) && err_value) {
> +		dev_err(spss->dev, "SPSS crashed before booting\n");
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static int spss_load(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct qcom_spss *spss = (struct qcom_spss *)rproc->priv;
> +
> +	if (rproc->skip_fw_load)
> +		return 0;
> +
> +	return qcom_mdt_load(spss->dev, fw, rproc->firmware, spss->pas_id,
> +			     spss->mem_region, spss->mem_phys, spss->mem_size,
> +			     &spss->mem_reloc);
> +
> +}
> +
> +static int spss_stop(struct rproc *rproc)
> +{
> +	struct qcom_spss *spss = (struct qcom_spss *)rproc->priv;
> +	int ret;
> +
> +	ret = qcom_scm_pas_shutdown(spss->pas_id);
> +	if (ret)
> +		dev_err(spss->dev, "failed to shutdown: %d\n", ret);
> +
> +	mask_scsr_irqs(spss);
> +	/* Negate skip fw load if already set */
> +	if (rproc->skip_fw_load)
> +		rproc->skip_fw_load = false;
> +
> +	return ret;
> +}
> +
> +static int spss_start(struct rproc *rproc)
> +{
> +	struct qcom_spss *spss = (struct qcom_spss *)rproc->priv;
> +	int ret = 0;
> +
> +	if (rproc->skip_fw_load) {
> +		/* If rproc already crashed stop it and retry boot*/
> +		if (check_status(spss)) {
> +			spss_stop(rproc);
> +			return -EAGAIN;

Who will attempt to start the remoteproc again? I presume you do this
because if you get this far you don't have a way to load the firmware
again?

Seems like something we need to consider in when adding the support for
synchronizing the MCUs - as Mathieu is working on.

> +		}
> +		/* If booted successfully then wait for init_done*/
> +		else
> +			goto wait_for_init;
> +	}
> +
> +	ret = clk_prepare_enable(spss->xo);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_enable(spss->cx_supply);

Would be nicer with a regulator_bulk_enable(), but these are power
domains upstream, so this needs to be changed.

> +	if (ret)
> +		goto disable_xo_clk;
> +
> +	ret = regulator_enable(spss->px_supply);
> +	if (ret)
> +		goto disable_cx_supply;
> +

You want to reinit start_done here.

> +	ret = qcom_scm_pas_auth_and_reset(spss->pas_id);
> +	if (ret) {
> +		dev_err(spss->dev,
> +			"failed to authenticate image and release reset\n");
> +		goto disable_px_supply;
> +	}
> +
> +wait_for_init:
> +	unmask_scsr_irqs(spss);
> +
> +	ret = wait_for_completion_timeout(&spss->start_done,
> +						msecs_to_jiffies(5000));
> +	if (!ret) {
> +		dev_err(spss->dev, "start timed out\n");
> +		spss_stop(rproc);
> +	}
> +	ret = ret ? 0 : -ETIMEDOUT;
> +
> +disable_px_supply:
> +	regulator_disable(spss->px_supply);
> +disable_cx_supply:
> +	regulator_disable(spss->cx_supply);
> +disable_xo_clk:
> +	clk_disable_unprepare(spss->xo);
> +	return ret;
> +}
> +
> +static void *spss_da_to_va(struct rproc *rproc, u64 da, int len)
> +{
> +	struct qcom_spss *spss = (struct qcom_spss *)rproc->priv;
> +	int offset;
> +
> +	offset = da - spss->mem_reloc;
> +	if (offset < 0 || offset + len > spss->mem_size)
> +		return NULL;
> +
> +	return spss->mem_region + offset;
> +}
> +
> +static const struct rproc_ops spss_ops = {
> +	.start = spss_start,
> +	.stop = spss_stop,
> +	.da_to_va = spss_da_to_va,
> +	.load = spss_load,
> +};
> +
> +static int spss_init_clock(struct qcom_spss *spss)
> +{
> +	int ret;
> +
> +	spss->xo = devm_clk_get(spss->dev, "xo");
> +	if (IS_ERR(spss->xo)) {
> +		ret = PTR_ERR(spss->xo);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(spss->dev, "failed to get xo clock");
> +		return ret;
> +	}

	if (IS_ERR(spss->xo) && PTR_ERR(spss->xo) != -EPROBE_DEFER)
		dev_err(...);

	return PTR_ERR_OR_ZERO(spss->xo);

> +
> +	return 0;
> +}
> +
> +static int spss_init_regulator(struct qcom_spss *spss)

These are power domains upstream.

> +{
> +	spss->cx_supply = devm_regulator_get(spss->dev, "cx");
> +	if (IS_ERR(spss->cx_supply))
> +		return PTR_ERR(spss->cx_supply);
> +	regulator_set_load(spss->cx_supply, 100000);
> +
> +	spss->px_supply = devm_regulator_get(spss->dev, "px");
> +	if (IS_ERR(spss->px_supply))
> +		return PTR_ERR(spss->px_supply);
> +	regulator_set_load(spss->px_supply, 100000);
> +
> +	return 0;
> +}
> +
> +static int spss_alloc_memory_region(struct qcom_spss *spss)
> +{
> +	struct device_node *node;
> +	struct resource r;
> +	int ret;
> +
> +	node = of_parse_phandle(spss->dev->of_node, "memory-region", 0);
> +	if (!node) {
> +		dev_err(spss->dev, "no memory-region specified\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_address_to_resource(node, 0, &r);
> +	if (ret)
> +		return ret;
> +
> +	spss->mem_phys = spss->mem_reloc = r.start;
> +	spss->mem_size = resource_size(&r);
> +	spss->mem_region = devm_ioremap_wc(spss->dev, spss->mem_phys,
> +								spss->mem_size);
> +	if (!spss->mem_region) {
> +		dev_err(spss->dev, "unable to map memory region: %pa+%zx\n",
> +			&r.start, spss->mem_size);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_spss_init_mmio(struct platform_device *pdev, struct qcom_spss *spss)
> +{
> +	struct resource *res;
> +	int ret;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						"sp2soc_irq_status");

These are all individual registers in the same memory region, please
just map it once.

And yes, this driver then becomes the natural place to implement what
lives in qsee_ipc_irq.c as well.

> +	spss->irq_status = devm_ioremap_resource(&pdev->dev, res);

Use devm_platform_ioremap_resource_byname() - or now that you only have
a single region use devm_platform_ioremap_resource(pdev, 0);

> +	if (IS_ERR(spss->irq_status))
> +		return PTR_ERR(spss->irq_status);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						"sp2soc_irq_clr");
> +	spss->irq_clr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spss->irq_clr))
> +		return PTR_ERR(spss->irq_clr);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						"sp2soc_irq_mask");
> +	spss->irq_mask = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spss->irq_mask))
> +		return PTR_ERR(spss->irq_mask);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						"rmb_err");
> +	spss->err_status = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spss->err_status))
> +		return PTR_ERR(spss->err_status);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						"rmb_err_spare2");
> +	spss->err_status_spare = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spss->err_status_spare))
> +		return PTR_ERR(spss->err_status_spare);
> +
> +	ret = of_property_read_u32_array(pdev->dev.of_node,
> +			       "qcom,spss-scsr-bits", spss->bits_arr,
> +				ARRAY_SIZE(spss->bits_arr));

As requested above, please just hard code these in the driver for now.

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +
> +}
> +
> +static int qcom_spss_probe(struct platform_device *pdev)
> +{
> +	const struct spss_data *desc;
> +	struct qcom_spss *spss;
> +	struct rproc *rproc;
> +	const char *fw_name;
> +
> +	int ret;
> +
> +	desc = of_device_get_match_data(&pdev->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +

Please query firmware-name from DT, before falling back to "spss.mdt" as
default file name - as in the other drivers.

> +	rproc = rproc_alloc(&pdev->dev, pdev->name, &spss_ops,
> +			    fw_name, sizeof(*spss));
> +	if (!rproc) {
> +		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
> +		return -ENOMEM;
> +	}
> +
> +	rproc->skip_fw_load = desc->skip_fw_load;

Rather than inherting this from desc you should be able to just read it
back from the hardware here (and this will still be pending conclusion
on the core support for "skip_fw_load").

> +
> +	spss = (struct qcom_spss *)rproc->priv;

No need to explicitly typecast a void *.

> +	spss->dev = &pdev->dev;
> +	spss->rproc = rproc;
> +	spss->pas_id = desc->pas_id;
> +	init_completion(&spss->start_done);
> +	platform_set_drvdata(pdev, spss);
> +
> +	ret = qcom_spss_init_mmio(pdev, spss);
> +	if (ret)
> +		goto free_rproc;
> +
> +	ret = spss_alloc_memory_region(spss);
> +	if (ret)
> +		goto free_rproc;
> +
> +	ret = spss_init_clock(spss);
> +	if (ret)
> +		goto free_rproc;
> +
> +	ret = spss_init_regulator(spss);
> +	if (ret)
> +		goto free_rproc;
> +
> +	qcom_add_glink_subdev(rproc, &spss->glink_subdev);
> +	qcom_add_ssr_subdev(rproc, &spss->ssr_subdev, desc->ssr_name);
> +
> +	ret = rproc_add(rproc);
> +	if (ret)
> +		goto free_rproc;
> +
> +	mask_scsr_irqs(spss);
> +	spss->generic_irq = platform_get_irq(pdev, 0);
> +	ret = devm_request_threaded_irq(&pdev->dev, spss->generic_irq, NULL,
> +		spss_generic_handler, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +							"generic-irq", spss);

Please skip IRQF_TRIGGER_RISING and let this come from DT, give the irq
a better name (spss-generic-irq?) and please indent broken lines to
line up with the open parenthesis.

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to acquire generic IRQ\n");
> +		goto free_rproc;

This is past rproc_add(), so you need to rproc_del() as well, unless you
do this before adding the remoteproc - which would make sense, in case
the core finds the firmware and "boots" the remoteproc before returning
from rproc_add().

> +	}
> +
> +	return 0;
> +
> +free_rproc:
> +	rproc_free(rproc);
> +
> +	return ret;
> +}
> +
> +static int qcom_spss_remove(struct platform_device *pdev)
> +{
> +	struct qcom_spss *spss = platform_get_drvdata(pdev);
> +
> +	rproc_del(spss->rproc);
> +	qcom_remove_glink_subdev(spss->rproc, &spss->glink_subdev);
> +	qcom_remove_ssr_subdev(spss->rproc, &spss->ssr_subdev);
> +	rproc_free(spss->rproc);
> +
> +	return 0;
> +}
> +
> +static const struct spss_data spss_resource_init = {
> +		.firmware_name = "spss.mdt",
> +		.pas_id = 14,
> +		.ssr_name = "spss",

I don't see that these are going to differ between different platforms,
so just hard code them where needed.

> +		.skip_fw_load = true,

Can we not derive this from the hardware state during initialization?

Regards,
Bjorn

> +};
> +
> +static const struct of_device_id spss_of_match[] = {
> +	{ .compatible = "qcom,sm8250-spss-pas", .data = &spss_resource_init},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, spss_of_match);
> +
> +static struct platform_driver spss_driver = {
> +	.probe = qcom_spss_probe,
> +	.remove = qcom_spss_remove,
> +	.driver = {
> +		.name = "qcom_spss",
> +		.of_match_table = spss_of_match,
> +	},
> +};
> +
> +module_platform_driver(spss_driver);
> +MODULE_DESCRIPTION("Qualcomm Peripheral Image Loader for secure subsystem");
> +MODULE_LICENSE("GPL v2");
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
