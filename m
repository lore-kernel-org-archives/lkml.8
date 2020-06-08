Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF18C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06494204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9f1jrf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbgFHXt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731775AbgFHXtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:49:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA559C08C5C5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 16:49:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t7so9489574pgt.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SftEqeFHV4l9XAhAAJtrWaW0DUvH+fLmXD45zeoEieY=;
        b=K9f1jrf/eQtKL5v6PH6R1gfQ/aYZP3qZyVbixwgoPN5+V3INcZ/16/7ESs1IkTmQig
         RHhuWSrXYCErQVyrry9KFXWJaShNycJ2258Ho3bPHycXi3Lic5PW9/KGDFG43qCrbFk8
         4kw/J9AWNH7oEdRF5xyOLQAVhnAPgHzGpl5J/crP3WQ5JX2dlBAQ9Mo9oOceqebshiI3
         /PXPrCA3sNQC/baWRrVdXL6tDoIcMTPwOEoTwbMh7TDWM79oV617/RFXuYxw3pSusxXY
         N57Bg9h/sGPWEjTYbd6rKoEsrDu/bHhLDnrumE3ZmK+mpaKoXvbxU9972NGEdqtFg8fw
         5vsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SftEqeFHV4l9XAhAAJtrWaW0DUvH+fLmXD45zeoEieY=;
        b=VqG4lLFy6cWqH01/0Oa5Bjvr99B9kd/K83QmVpfXY5/4YTTLOj9P4qQ7WXm7nvvzRx
         LEgN7GfShUyzfsePZROmjWslVyBEI+FZPTbFyS2XdyOt4j6TmMB2502HP6izTr5qhrRH
         x17KhRHh07TBW95Zp8CS0xD4970Tgiq7+0qFUtuXJaZveHJCrWEPStYj/sL27qBtzKwB
         MNxokvUVO2b4eK6me/Z8r6uSp6r0vob3kmLtv6FCLFGroMLe77gEMjW6T/mYQ7WVP/1X
         wN2oVVJKfFDqGyhAAfJi3KwazE3dCsWBQun/fj3RVLuyRQ7XYygfQUVTSvFfQX9F+ONw
         2gtg==
X-Gm-Message-State: AOAM531e3wYMlnpGyAe9rfK3miWN0ZD+QSvpOXNUioQv3ZBteAtWWrcw
        0mtxFjhQUYc0syuw+EQHStPMdw==
X-Google-Smtp-Source: ABdhPJyje9sjObpg5xn7/A+YNNoOKqRbCzu++X7ThXLZgSNFwDDr4ab1NJXyTinrdbhbo2irs++3pg==
X-Received: by 2002:a63:9312:: with SMTP id b18mr22617989pge.128.1591660178745;
        Mon, 08 Jun 2020 16:49:38 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 9sm7985959pfu.181.2020.06.08.16.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 16:49:38 -0700 (PDT)
Date:   Mon, 8 Jun 2020 17:49:35 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        jollys@xilinx.com, rajanv@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wendy Liang <wendy.liang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ed Mooring <ed.mooring@xilinx.com>, Jason Wu <j.wu@xilinx.com>
Subject: Re: [PATCH v5 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
Message-ID: <20200608234935.GA4268@xps15>
References: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
 <1591195783-10290-6-git-send-email-ben.levinsky@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591195783-10290-6-git-send-email-ben.levinsky@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 07:49:43AM -0700, Ben Levinsky wrote:
> R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
> remotproc driver, we can boot the R5 sub-system in different
> configurations.
> 
> Acked-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Acked-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Ed Mooring <ed.mooring@xilinx.com>
> Signed-off-by: Jason Wu <j.wu@xilinx.com>
> Tested-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
> v2:
> - remove domain struct as per review from Mathieu
> v3:
> - add xilinx-related platform mgmt fn's instead of wrapping around
>   function pointer in xilinx eemi ops struct
> v4:
> - add default values for enums
> - fix formatting as per checkpatch.pl --strict. Note that 1 warning and 1 check
>   are still raised as each is due to fixing the warning results in that
> particular line going over 80 characters.
> v5:
> - parse_fw change from use of rproc_of_resm_mem_entry_init to rproc_mem_entry_init and use of alloc/release
> - var's of type zynqmp_r5_pdata all have same local variable name
> - use dev_dbg instead of dev_info
> 
> ---
>  drivers/remoteproc/Kconfig                |  10 +
>  drivers/remoteproc/Makefile               |   1 +
>  drivers/remoteproc/zynqmp_r5_remoteproc.c | 898 ++++++++++++++++++++++++++++++
>  3 files changed, 909 insertions(+)
>  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index fbaed07..735bd7f 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -240,6 +240,16 @@ config STM32_RPROC
>  
>  	  This can be either built-in or a loadable module.
>  
> +config ZYNQMP_R5_REMOTEPROC
> +	tristate "ZynqMP_R5 remoteproc support"
> +	depends on ARM64 && PM && ARCH_ZYNQMP
> +	select RPMSG_VIRTIO
> +	select MAILBOX
> +	select ZYNQMP_IPI_MBOX
> +	help
> +	  Say y here to support ZynqMP R5 remote processors via the remote
> +	  processor framework.
> +
>  endif # REMOTEPROC
>  
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 0effd38..806ac3f 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -27,5 +27,6 @@ obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss_pil.o
>  qcom_wcnss_pil-y			+= qcom_wcnss.o
>  qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
>  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
> +obj-$(CONFIG_ZYNQMP_R5_REMOTEPROC)	+= zynqmp_r5_remoteproc.o
>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
> diff --git a/drivers/remoteproc/zynqmp_r5_remoteproc.c b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> new file mode 100644
> index 0000000..0e4f3ad
> --- /dev/null
> +++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> @@ -0,0 +1,898 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Zynq R5 Remote Processor driver
> + *
> + * Copyright (C) 2019, 2020 Xilinx Inc. Ben Levinsky <ben.levinsky@xilinx.com>
> + * Copyright (C) 2015 - 2018 Xilinx Inc.
> + * Copyright (C) 2015 Jason Wu <j.wu@xilinx.com>
> + *
> + * Based on origin OMAP and Zynq Remote Processor driver
> + *
> + * Copyright (C) 2012 Michal Simek <monstr@monstr.eu>
> + * Copyright (C) 2012 PetaLogix
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + * Copyright (C) 2011 Google, Inc.
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/cpu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/genalloc.h>
> +#include <linux/idr.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox/zynqmp-ipi-message.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/pfn.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/skbuff.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +#include "remoteproc_internal.h"
> +
> +#define MAX_RPROCS	2 /* Support up to 2 RPU */
> +#define MAX_MEM_PNODES	4 /* Max power nodes for one RPU memory instance */
> +
> +#define DEFAULT_FIRMWARE_NAME	"rproc-rpu-fw"
> +
> +/* PM proc states */
> +#define PM_PROC_STATE_ACTIVE 1U
> +
> +/* IPI buffer MAX length */
> +#define IPI_BUF_LEN_MAX	32U
> +/* RX mailbox client buffer max length */
> +#define RX_MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
> +				 sizeof(struct zynqmp_ipi_message))
> +
> +static bool autoboot __read_mostly;
> +
> +/**
> + * struct zynqmp_r5_mem - zynqmp rpu memory data
> + * @pnode_id: TCM power domain ids
> + * @res: memory resource
> + * @node: list node
> + */
> +struct zynqmp_r5_mem {
> +	u32 pnode_id[MAX_MEM_PNODES];
> +	struct resource res;
> +	struct list_head node;
> +};
> +
> +/**
> + * struct zynqmp_r5_pdata - zynqmp rpu remote processor private data
> + * @dev: device of RPU instance
> + * @rproc: rproc handle
> + * @pnode_id: RPU CPU power domain id
> + * @mems: memory resources
> + * @is_r5_mode_set: indicate if r5 operation mode is set
> + * @tx_mc: tx mailbox client
> + * @rx_mc: rx mailbox client
> + * @tx_chan: tx mailbox channel
> + * @rx_chan: rx mailbox channel
> + * @mbox_work: mbox_work for the RPU remoteproc
> + * @tx_mc_skbs: socket buffers for tx mailbox client
> + * @rx_mc_buf: rx mailbox client buffer to save the rx message
> + */
> +struct zynqmp_r5_pdata {
> +	struct device dev;
> +	struct rproc *rproc;
> +	u32 pnode_id;
> +	struct list_head mems;
> +	bool is_r5_mode_set;
> +	struct mbox_client tx_mc;
> +	struct mbox_client rx_mc;
> +	struct mbox_chan *tx_chan;
> +	struct mbox_chan *rx_chan;
> +	struct work_struct mbox_work;
> +	struct sk_buff_head tx_mc_skbs;
> +	unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
> +};
> +
> +/**
> + * table of RPUs
> + */
> +struct zynqmp_r5_pdata rpus[MAX_RPROCS];
> +/**
> + *  RPU core configuration
> + */
> +enum rpu_oper_mode rpu_mode;
> +
> +/*
> + * r5_set_mode - set RPU operation mode
> + * @pdata: Remote processor private data
> + *
> + * set RPU oepration mode
> + *
> + * Return: 0 for success, negative value for failure
> + */
> +static int r5_set_mode(struct zynqmp_r5_pdata *pdata)
> +{
> +	u32 val[PAYLOAD_ARG_CNT] = {0}, expect, tcm_mode;
> +	struct device *dev = &pdata->dev;
> +	int ret;
> +
> +	expect = (u32)rpu_mode;
> +	ret = zynqmp_pm_get_rpu_mode(pdata->pnode_id, 0, 0, val);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get RPU oper mode.\n");
> +		return ret;
> +	}
> +	if (val[0] == expect) {
> +		dev_dbg(dev, "RPU mode matches: %x\n", val[0]);
> +	} else {
> +		ret = zynqmp_pm_set_rpu_mode(pdata->pnode_id,
> +					     expect, 0, val);
> +		if (ret < 0) {
> +			dev_err(dev,
> +				"failed to set RPU oper mode.\n");
> +			return ret;
> +		}
> +	}
> +
> +	tcm_mode = (expect == (u32)PM_RPU_MODE_LOCKSTEP) ?
> +		    PM_RPU_TCM_COMB : PM_RPU_TCM_SPLIT;
> +	ret = zynqmp_pm_set_tcm_config(pdata->pnode_id, tcm_mode, 0, val);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to config TCM to %x.\n",
> +			expect);
> +		return ret;
> +	}
> +	pdata->is_r5_mode_set = true;
> +	return 0;
> +}
> +
> +/**
> + * r5_is_running - check if r5 is running
> + * @pdata: Remote processor private data
> + *
> + * check if R5 is running
> + *
> + * Return: true if r5 is running, false otherwise
> + */
> +static bool r5_is_running(struct zynqmp_r5_pdata *pdata)
> +{
> +	u32 status, requirements, usage;
> +	struct device *dev = &pdata->dev;
> +
> +	if (zynqmp_pm_get_node_status(pdata->pnode_id,
> +				      &status, &requirements, &usage)) {
> +		dev_err(dev, "Failed to get RPU node %d status.\n",
> +			pdata->pnode_id);
> +		return false;
> +	} else if (status != PM_PROC_STATE_ACTIVE) {
> +		dev_dbg(dev, "RPU is not running.\n");
> +		return false;
> +	}
> +
> +	dev_dbg(dev, "RPU is running.\n");
> +	return true;
> +}
> +
> +/*
> + * ZynqMP R5 remoteproc memory release function
> + */
> +static int zynqmp_r5_mem_release(struct rproc *rproc,
> +				 struct rproc_mem_entry *mem)
> +{
> +	struct zynqmp_r5_mem *priv;
> +	int i, ret;
> +	struct device *dev = &rproc->dev;
> +
> +	priv = mem->priv;
> +	if (!priv)
> +		return 0;
> +	for (i = 0; i < MAX_MEM_PNODES; i++) {
> +		if (priv->pnode_id[i]) {
> +			dev_dbg(dev, "%s, pnode %d\n",
> +				__func__, priv->pnode_id[i]);
> +			ret = zynqmp_pm_release_node(priv->pnode_id[i]);
> +			if (ret < 0) {
> +				dev_err(dev,
> +					"failed to release power node: %u\n",
> +					priv->pnode_id[i]);
> +				return ret;
> +			}
> +		} else {
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + * ZynqMP R5 remoteproc operations
> + */
> +static int zynqmp_r5_rproc_start(struct rproc *rproc)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> +	enum rpu_boot_mem bootmem;
> +	int ret;
> +	/* Set up R5 if not already setup */
> +	ret = pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);

Is there any reason why r5_set_mode() has to be done as part of the start()
function rather than at probe() time?

> +	if (ret) {
> +		dev_err(dev, "failed to set R5 operation mode.\n");
> +		return ret;
> +	}
> +	if ((rproc->bootaddr & 0xF0000000) == 0xF0000000)
> +		bootmem = PM_RPU_BOOTMEM_HIVEC;
> +	else
> +		bootmem = PM_RPU_BOOTMEM_LOVEC;
> +	dev_dbg(dev, "RPU boot from %s.",
> +		bootmem == PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
> +	ret = zynqmp_pm_request_wakeup(pdata->pnode_id, 1,
> +				       bootmem, ZYNQMP_PM_REQUEST_ACK_NO);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to boot R5.\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int zynqmp_r5_rproc_stop(struct rproc *rproc)
> +{
> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> +	int ret;
> +
> +	ret = zynqmp_pm_force_powerdown(pdata->pnode_id,
> +					ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +	if (ret < 0) {
> +		dev_err(&pdata->dev, "failed to shutdown R5.\n");
> +		return ret;
> +	}
> +	pdata->is_r5_mode_set = false;

Why resetting this to false?  If r5_set_mode() needs to be called every time the
remote processor is booted, why carrying an extra variable (pdata->is_r5_mode_set)?

> +	return 0;
> +}
> +
> +static int zynqmp_r5_rproc_mem_alloc(struct rproc *rproc,
> +				      struct rproc_mem_entry *mem)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	void *va;
> +
> +	dev_dbg(rproc->dev.parent, "map memory: %pa\n", &mem->dma);
> +	va = ioremap_wc(mem->dma, mem->len);
> +	if (IS_ERR_OR_NULL(va)) {
> +		dev_err(dev, "Unable to map memory region: %pa+%x\n",
> +			&mem->dma, mem->len);
> +		return -ENOMEM;
> +	}
> +
> +	/* Update memory entry va */
> +	mem->va = va;
> +
> +	return 0;
> +}
> +static int zynqmp_r5_rproc_mem_release(struct rproc *rproc,
> +				       struct rproc_mem_entry *mem)
> +{
> +	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
> +	iounmap(mem->va);
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	int num_mems, i, ret;
> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> +	struct device *dev = &pdata->dev;
> +	struct device_node *np = dev->of_node;
> +	struct rproc_mem_entry *mem;
> +	struct device_node *child;
> +	struct resource rsc;
> +
> +	num_mems = of_count_phandle_with_args(np, "memory-region", NULL);
> +	if (num_mems <= 0)
> +		return 0;
> +	for (i = 0; i < num_mems; i++) {
> +		struct device_node *node;
> +		struct zynqmp_r5_mem *zynqmp_mem;
> +		struct reserved_mem *rmem;
> +		char rproc_name[20];
> +
> +		node = of_parse_phandle(np, "memory-region", i);
> +		rmem = of_reserved_mem_lookup(node);
> +		if (!rmem) {
> +			dev_err(dev, "unable to acquire memory-region\n");
> +			return -EINVAL;
> +		}
> +
> +		if (strstr(node->name, "vdev0buffer")) {
> +			/* Register DMA region */
> +			mem = rproc_mem_entry_init(dev, NULL,
> +						   (dma_addr_t)rmem->base,
> +						   rmem->size, rmem->base,
> +						   NULL, NULL,
> +						   "vdev0buffer");

Out of sheer curiosity, why did you choose to use rproc_mem_entry_init() rather
than rproc_of_resm_mem_entry_init()?  After all the vdev0buffer is part of a
reserved memory...

There is more comments further below.  I'm out of time for today, I'll continue
with the rest of zynmp_r5_parse_fw() tomorrow.

Thanks,
Mathieu 

> +			if (!mem) {
> +				dev_err(dev, "unable to initialize memory-region %s\n",
> +					node->name);
> +				return -ENOMEM;
> +			}
> +			dev_dbg(dev, "parsed %s at  %llx\r\n", mem->name,
> +				mem->dma);
> +			rproc_add_carveout(rproc, mem);
> +			continue;
> +		} else if (strstr(node->name, "vdev") &&
> +				    strstr(node->name, "vring")) {
> +			int id, vring_id;
> +			char name[16];
> +
> +			id = node->name[8] - '0';
> +			vring_id = node->name[14] - '0';
> +			snprintf(name, sizeof(name), "vdev%dvring%d", id,
> +				 vring_id);
> +			/* Register vring */
> +			mem = rproc_mem_entry_init(dev, NULL,
> +						   (dma_addr_t)rmem->base,
> +						   rmem->size, rmem->base,
> +						   zynqmp_r5_rproc_mem_alloc,
> +						   zynqmp_r5_rproc_mem_release,
> +						   name);
> +			dev_dbg(dev, "parsed %s at %llx\r\n", mem->name,
> +				mem->dma);
> +			rproc_add_carveout(rproc, mem);
> +			continue;
> +		} else {
> +			mem = rproc_mem_entry_init(dev, NULL,
> +						   (dma_addr_t)rmem->base,
> +						   rmem->size, rmem->base,
> +						   zynqmp_r5_rproc_mem_alloc,
> +						   zynqmp_r5_rproc_mem_release,
> +						   node->name);
> +
> +			if (!mem) {
> +				dev_err(dev,
> +					"unable to init memory-region %s\n",
> +					node->name);
> +				return -ENOMEM;
> +			}
> +			mem->of_resm_idx = i;
> +
> +			rproc_add_carveout(rproc, mem);
> +		}
> +	}
> +
> +	/* map TCM */
> +	for_each_available_child_of_node(np, child) {
> +		struct property *prop;
> +		const __be32 *cur;
> +		u32 pnode_id;
> +		void *va;
> +		dma_addr_t dma;
> +		resource_size_t size;
> +
> +		ret = of_address_to_resource(child, 0, &rsc);
> +
> +		i = 0;
> +		of_property_for_each_u32(child, "pnode-id", prop, cur,
> +					 pnode_id) {
> +			ret = zynqmp_pm_request_node(pnode_id,
> +				ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +				ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +			if (ret < 0) {
> +				dev_err(dev, "failed to request power node: %u\n",
> +					pnode_id);
> +				return ret;
> +			}
> +		}
> +		size = resource_size(&rsc);
> +		va = devm_ioremap_wc(dev, rsc.start, size);
> +		if (!va)
> +			return -ENOMEM;
> +
> +		/* zero out tcm base address */
> +		if (rsc.start & 0xffe00000) {
> +			rsc.start &= 0x000fffff;
> +			/* handle tcm banks 1 a and b
> +			 * (0xffe9000 and oxffeb0000)
> +			 */
> +				if (rsc.start & 0x80000)
> +					rsc.start -= 0x90000;
> +		}
> +
> +		dma = (dma_addr_t)rsc.start;
> +		mem = rproc_mem_entry_init(dev, va, dma, (int)size, rsc.start,
> +					   NULL, zynqmp_r5_mem_release,
> +					   rsc.name);
> +		if (!mem)
> +			return -ENOMEM;
> +
> +		rproc_add_carveout(rproc, mem);
> +	}
> +
> +	ret = rproc_elf_load_rsc_table(rproc, fw);
> +	if (ret == -EINVAL)
> +		ret = 0;
> +	return ret;
> +}
> +
> +/* kick a firmware */
> +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> +
> +	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n", vqid);
> +
> +	if (vqid < 0) {
> +		/* If vqid is negative, does not pass the vqid to
> +		 * mailbox. As vqid is supposed to be 0 or possive.
> +		 * It also gives a way to just kick instead but
> +		 * not use the IPI buffer. It is better to provide
> +		 * a proper way to pass the short message, which will
> +		 * need to sync to upstream first, for now,
> +		 * use negative vqid to assume no message will be
> +		 * passed with IPI buffer, but just raise interrupt.
> +		 * This will be faster as it doesn't need to copy the
> +		 * message to the IPI buffer.
> +		 *
> +		 * It will ignore the return, as failure is due to
> +		 * there already kicks in the mailbox queue.
> +		 */
> +		(void)mbox_send_message(pdata->tx_chan, NULL);
> +	} else {
> +		struct sk_buff *skb;
> +		unsigned int skb_len;
> +		struct zynqmp_ipi_message *mb_msg;
> +		int ret;
> +
> +		skb_len = (unsigned int)(sizeof(vqid) + sizeof(mb_msg));
> +		skb = alloc_skb(skb_len, GFP_ATOMIC);
> +		if (!skb) {
> +			dev_err(dev,
> +				"Failed to allocate skb to kick remote.\n");
> +			return;
> +		}
> +		mb_msg = (struct zynqmp_ipi_message *)skb_put(skb, skb_len);
> +		mb_msg->len = sizeof(vqid);
> +		memcpy(mb_msg->data, &vqid, sizeof(vqid));
> +		skb_queue_tail(&pdata->tx_mc_skbs, skb);
> +		ret = mbox_send_message(pdata->tx_chan, mb_msg);
> +		if (ret < 0) {
> +			dev_warn(dev, "Failed to kick remote.\n");
> +			skb_dequeue_tail(&pdata->tx_mc_skbs);
> +			kfree_skb(skb);
> +		}
> +	}
> +}
> +
> +static struct rproc_ops zynqmp_r5_rproc_ops = {
> +	.start		= zynqmp_r5_rproc_start,
> +	.stop		= zynqmp_r5_rproc_stop,
> +	.load		= rproc_elf_load_segments,
> +	.parse_fw	= zynqmp_r5_parse_fw,
> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> +	.sanity_check	= rproc_elf_sanity_check,
> +	.get_boot_addr	= rproc_elf_get_boot_addr,
> +	.kick		= zynqmp_r5_rproc_kick,
> +};
> +
> +/* zynqmp_r5_mem_probe() - probes RPU TCM memory device
> + * @pdata: pointer to the RPU remoteproc private data
> + * @node: pointer to the memory node
> + *
> + * Function to retrieve resources for RPU TCM memory device.
> + */
> +static int zynqmp_r5_mem_probe(struct zynqmp_r5_pdata *pdata,
> +			       struct device_node *node)
> +{
> +	struct device *dev;
> +	struct zynqmp_r5_mem *mem;
> +	int ret;
> +	struct property *prop;
> +	const __be32 *cur;
> +	u32 val;
> +	int i = 0;
> +
> +	dev = &pdata->dev;
> +	mem = devm_kzalloc(dev, sizeof(*mem), GFP_KERNEL);
> +	if (!mem)
> +		return -ENOMEM;
> +	ret = of_address_to_resource(node, 0, &mem->res);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get resource of memory %s",
> +			of_node_full_name(node));
> +		return -EINVAL;
> +	}
> +
> +	/* Get the power domain id */
> +	if (of_find_property(node, "pnode-id", NULL)) {
> +		of_property_for_each_u32(node, "pnode-id", prop, cur, val)
> +			mem->pnode_id[i++] = val;
> +	}
> +	list_add_tail(&mem->node, &pdata->mems);
> +	return 0;
> +}
> +
> +/**
> + * zynqmp_r5_release() - ZynqMP R5 device release function
> + * @dev: pointer to the device struct of ZynqMP R5
> + *
> + * Function to release ZynqMP R5 device.
> + */
> +static void zynqmp_r5_release(struct device *dev)
> +{
> +	struct zynqmp_r5_pdata *pdata;
> +	struct rproc *rproc;
> +	struct sk_buff *skb;
> +
> +	pdata = dev_get_drvdata(dev);
> +	rproc = pdata->rproc;
> +	if (rproc) {
> +		rproc_del(rproc);
> +		rproc_free(rproc);
> +	}
> +	if (pdata->tx_chan)
> +		mbox_free_channel(pdata->tx_chan);
> +	if (pdata->rx_chan)
> +		mbox_free_channel(pdata->rx_chan);
> +	/* Discard all SKBs */
> +	while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
> +		skb = skb_dequeue(&pdata->tx_mc_skbs);
> +		kfree_skb(skb);
> +	}
> +
> +	put_device(dev->parent);
> +}
> +
> +/**
> + * event_notified_idr_cb() - event notified idr callback
> + * @id: idr id
> + * @ptr: pointer to idr private data
> + * @data: data passed to idr_for_each callback
> + *
> + * Pass notification to remoteproc virtio
> + *
> + * Return: 0. having return is to satisfy the idr_for_each() function
> + *          pointer input argument requirement.
> + **/
> +static int event_notified_idr_cb(int id, void *ptr, void *data)
> +{
> +	struct rproc *rproc = data;
> +
> +	(void)rproc_vq_interrupt(rproc, id);
> +	return 0;
> +}
> +
> +/**
> + * handle_event_notified() - remoteproc notification work funciton
> + * @work: pointer to the work structure
> + *
> + * It checks each registered remoteproc notify IDs.
> + */
> +static void handle_event_notified(struct work_struct *work)
> +{
> +	struct rproc *rproc;
> +	struct zynqmp_r5_pdata *pdata;
> +
> +	pdata = container_of(work, struct zynqmp_r5_pdata, mbox_work);
> +
> +	(void)mbox_send_message(pdata->rx_chan, NULL);
> +	rproc = pdata->rproc;
> +	/*
> +	 * We only use IPI for interrupt. The firmware side may or may
> +	 * not write the notifyid when it trigger IPI.
> +	 * And thus, we scan through all the registered notifyids.
> +	 */
> +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
> +}
> +
> +/**
> + * zynqmp_r5_mb_rx_cb() - Receive channel mailbox callback
> + * @cl: mailbox client
> + * @mssg: message pointer
> + *
> + * It will schedule the R5 notification work.
> + */
> +static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *mssg)
> +{
> +	struct zynqmp_r5_pdata *pdata;
> +
> +	pdata = container_of(cl, struct zynqmp_r5_pdata, rx_mc);
> +	if (mssg) {
> +		struct zynqmp_ipi_message *ipi_msg, *buf_msg;
> +		size_t len;
> +
> +		ipi_msg = (struct zynqmp_ipi_message *)mssg;
> +		buf_msg = (struct zynqmp_ipi_message *)pdata->rx_mc_buf;
> +		len = (ipi_msg->len >= IPI_BUF_LEN_MAX) ?
> +		      IPI_BUF_LEN_MAX : ipi_msg->len;
> +		buf_msg->len = len;
> +		memcpy(buf_msg->data, ipi_msg->data, len);
> +	}
> +	schedule_work(&pdata->mbox_work);
> +}
> +
> +/**
> + * zynqmp_r5_mb_tx_done() - Request has been sent to the remote
> + * @cl: mailbox client
> + * @mssg: pointer to the message which has been sent
> + * @r: status of last TX - OK or error
> + *
> + * It will be called by the mailbox framework when the last TX has done.
> + */
> +static void zynqmp_r5_mb_tx_done(struct mbox_client *cl, void *mssg, int r)
> +{
> +	struct zynqmp_r5_pdata *pdata;
> +	struct sk_buff *skb;
> +
> +	if (!mssg)
> +		return;
> +	pdata = container_of(cl, struct zynqmp_r5_pdata, tx_mc);
> +	skb = skb_dequeue(&pdata->tx_mc_skbs);
> +	kfree_skb(skb);
> +}
> +
> +/**
> + * zynqmp_r5_setup_mbox() - Setup mailboxes
> + *
> + * @pdata: pointer to the ZynqMP R5 processor platform data
> + * @node: pointer of the device node
> + *
> + * Function to setup mailboxes to talk to RPU.
> + *
> + * Return: 0 for success, negative value for failure.
> + */
> +static int zynqmp_r5_setup_mbox(struct zynqmp_r5_pdata *pdata,
> +				struct device_node *node)
> +{
> +	struct device *dev = &pdata->dev;
> +	struct mbox_client *mclient;
> +
> +	/* Setup TX mailbox channel client */
> +	mclient = &pdata->tx_mc;
> +	mclient->dev = dev;
> +	mclient->rx_callback = NULL;
> +	mclient->tx_block = false;
> +	mclient->knows_txdone = false;
> +	mclient->tx_done = zynqmp_r5_mb_tx_done;
> +
> +	/* Setup TX mailbox channel client */
> +	mclient = &pdata->rx_mc;
> +	mclient->dev = dev;
> +	mclient->rx_callback = zynqmp_r5_mb_rx_cb;
> +	mclient->tx_block = false;
> +	mclient->knows_txdone = false;
> +
> +	INIT_WORK(&pdata->mbox_work, handle_event_notified);
> +
> +	/* Request TX and RX channels */
> +	pdata->tx_chan = mbox_request_channel_byname(&pdata->tx_mc, "tx");
> +	if (IS_ERR(pdata->tx_chan)) {
> +		dev_err(dev, "failed to request mbox tx channel.\n");
> +		pdata->tx_chan = NULL;
> +		return -EINVAL;
> +	}
> +	pdata->rx_chan = mbox_request_channel_byname(&pdata->rx_mc, "rx");
> +	if (IS_ERR(pdata->rx_chan)) {
> +		dev_err(dev, "failed to request mbox rx channel.\n");
> +		pdata->rx_chan = NULL;
> +		return -EINVAL;
> +	}
> +	skb_queue_head_init(&pdata->tx_mc_skbs);
> +	return 0;
> +}
> +
> +/**
> + * zynqmp_r5_probe() - Probes ZynqMP R5 processor device node
> + * @pdata: pointer to the ZynqMP R5 processor platform data
> + * @pdev: parent RPU domain platform device
> + * @node: pointer of the device node
> + *
> + * Function to retrieve the information of the ZynqMP R5 device node.
> + *
> + * Return: 0 for success, negative value for failure.
> + */
> +static int zynqmp_r5_probe(struct zynqmp_r5_pdata *pdata,
> +			   struct platform_device *pdev,
> +			   struct device_node *node)
> +{
> +	struct device *dev = &pdata->dev;
> +	struct rproc *rproc;
> +	struct device_node *nc;
> +	int ret;
> +
> +	/* Create device for ZynqMP R5 device */
> +	dev->parent = &pdev->dev;
> +	dev->release = zynqmp_r5_release;
> +	dev->of_node = node;
> +	dev_set_name(dev, "%s", of_node_full_name(node));
> +	dev_set_drvdata(dev, pdata);
> +	ret = device_register(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register device.\n");
> +		return ret;
> +	}
> +	get_device(&pdev->dev);
> +
> +	/* Allocate remoteproc instance */
> +	rproc = rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops, NULL, 0);
> +	if (!rproc) {
> +		dev_err(dev, "rproc allocation failed.\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +	rproc->auto_boot = autoboot;
> +	pdata->rproc = rproc;
> +	rproc->priv = pdata;
> +
> +	/*
> +	 * The device has not been spawned from a device tree, so
> +	 * arch_setup_dma_ops has not been called, thus leaving
> +	 * the device with dummy DMA ops.
> +	 * Fix this by inheriting the parent's DMA ops and mask.
> +	 */
> +	rproc->dev.dma_mask = pdev->dev.dma_mask;
> +	set_dma_ops(&rproc->dev, get_dma_ops(&pdev->dev));
> +
> +	/* Probe R5 memory devices */
> +	INIT_LIST_HEAD(&pdata->mems);
> +	for_each_available_child_of_node(node, nc) {
> +		ret = zynqmp_r5_mem_probe(pdata, nc);
> +		if (ret) {
> +			dev_err(dev, "failed to probe memory %s.\n",
> +				of_node_full_name(nc));
> +			goto error;
> +		}
> +	}
> +
> +	/* Set up DMA mask */
> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_warn(dev, "dma_set_coherent_mask failed: %d\n", ret);
> +		/* If DMA is not configured yet, try to configure it. */
> +		ret = of_dma_configure(dev, node, true);
> +		if (ret) {
> +			dev_err(dev, "failed to configure DMA.\n");
> +			goto error;
> +		}
> +	}
> +
> +	/* Get R5 power domain node */
> +	ret = of_property_read_u32(node, "pnode-id", &pdata->pnode_id);
> +	if (ret) {
> +		dev_err(dev, "failed to get power node id.\n");
> +		goto error;
> +	}
> +
> +	/* Check if R5 is running */
> +	if (r5_is_running(pdata)) {
> +		atomic_inc(&rproc->power);
> +		rproc->state = RPROC_RUNNING;
> +	}

How does this work when state_store() returns an error if rproc->state ==
RPROC_RUNNING?  As such the remote processor is running but there is no
way to attach to it.  As I requested during my previous review, please hold off
on supporting scenarios where the remote processor is already running when the 
driver is probe.  We are working on introducing that in the remoteproc core. 

> +
> +	if (!of_get_property(dev->of_node, "mboxes", NULL)) {
> +		dev_dbg(dev, "no mailboxes.\n");
> +		goto error;
> +	} else {
> +		ret = zynqmp_r5_setup_mbox(pdata, node);
> +		if (ret < 0)
> +			goto error;
> +	}
> +
> +	/* Add R5 remoteproc */
> +	ret = rproc_add(rproc);
> +	if (ret) {
> +		dev_err(dev, "rproc registration failed\n");
> +		goto error;
> +	}
> +	return 0;
> +error:
> +	if (pdata->rproc)
> +		rproc_free(pdata->rproc);
> +	pdata->rproc = NULL;
> +	device_unregister(dev);
> +	put_device(&pdev->dev);
> +	return ret;
> +}
> +
> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> +{
> +	const unsigned char *prop;
> +	int ret, i;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *nc;
> +	struct zynqmp_r5_pdata *pdata;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, pdata);
> +
> +	prop = of_get_property(dev->of_node, "core_conf", NULL);
> +	if (!prop) {
> +		dev_err(&pdev->dev, "core_conf is not used.\n");
> +		return -EINVAL;
> +	}

This should be the same as what Texas Instrument is doing, i.e:
        lockstep-mode = <1>

That way:

1) The wheel is not re-invented.
2) An 'enum rpu_oper_mode' can be used directly.
3) No need for string comparison.

> +
> +	dev_dbg(dev, "RPU core_conf: %s\n", prop);
> +	if (!strcmp(prop, "split")) {
> +		rpu_mode = PM_RPU_MODE_SPLIT;
> +	} else if (!strcmp(prop, "lockstep")) {
> +		rpu_mode = PM_RPU_MODE_LOCKSTEP;
> +	} else {
> +		dev_err(dev,
> +			"Invalid core_conf mode provided - %s , %d\n",
> +			prop, (int)rpu_mode);
> +		return -EINVAL;
> +	}
> +
> +	i = 0;

This can be done when the variable is declared above.

> +	for_each_available_child_of_node(dev->of_node, nc) {
> +		ret = zynqmp_r5_probe(&rpus[i], pdev, nc);
> +		if (ret) {
> +			dev_err(dev, "failed to probe rpu %s.\n",
> +				of_node_full_name(nc));
> +			return ret;
> +		}
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_remoteproc_remove(struct platform_device *pdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_RPROCS; i++) {
> +		struct zynqmp_r5_pdata *pdata = &rpus[i];
> +		struct rproc *rproc;
> +
> +		rproc = pdata->rproc;
> +		if (rproc) {
> +			rproc_del(rproc);
> +			rproc_free(rproc);
> +			pdata->rproc = NULL;
> +		}
> +		if (pdata->tx_chan) {
> +			mbox_free_channel(pdata->tx_chan);
> +			pdata->tx_chan = NULL;
> +		}
> +		if (pdata->rx_chan) {
> +			mbox_free_channel(pdata->rx_chan);
> +			pdata->rx_chan = NULL;
> +		}
> +
> +		device_unregister(&pdata->dev);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Match table for OF platform binding */
> +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> +	{ .compatible = "xlnx,zynqmp-r5-remoteproc-1.0", },
> +	{ /* end of list */ },
> +};
> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> +
> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> +	.probe = zynqmp_r5_remoteproc_probe,
> +	.remove = zynqmp_r5_remoteproc_remove,
> +	.driver = {
> +		.name = "zynqmp_r5_remoteproc",
> +		.of_match_table = zynqmp_r5_remoteproc_match,
> +	},
> +};
> +module_platform_driver(zynqmp_r5_remoteproc_driver);
> +
> +module_param_named(autoboot,  autoboot, bool, 0444);
> +MODULE_PARM_DESC(autoboot,
> +		 "enable | disable autoboot. (default: true)");
> +
> +MODULE_AUTHOR("Ben Levinsky <ben.levinsky@xilinx.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ZynqMP R5 remote processor control driver");
> -- 
> 2.7.4
> 
