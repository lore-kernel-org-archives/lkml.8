Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1285DC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 06:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65962075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 06:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579845663;
	bh=QVU0YtZFq9qwpNjnhfbaDo1XXyShtxPdOS3MfNHNDsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eWDMi40IxAMBe0+ur4buesdwla7ggbmkgtYUnoiJKMCfdgycwp6jUjTFEj8kRYLWO
	 sdB2udhRxnL0//E/7IY/k/G90meI46KkEjVJNB9vnbwsKkD5khSmwsa9XHq+qlGQzY
	 Tth/bwP4HXS1+rOBx8BA/drGUUZZD4vaYEcoQ/uI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgAXGBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 01:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgAXGBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 01:01:02 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A5E2071A;
        Fri, 24 Jan 2020 06:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579845662;
        bh=QVU0YtZFq9qwpNjnhfbaDo1XXyShtxPdOS3MfNHNDsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlzbyQ3/qidsFG6tI1v/fn5URquGb39S/MLInSanwpkBI+RgRuCd6PH78uwEjEJnm
         sJpv92J5W8Yznrv5GR0gi07LCvbs8y3RRecRdzTdlR5buUuaWWcwgzbu7aLSGjURlL
         zdGCja9BdDOMaNUk5hAApLl7bma52fmBLqSnip/o=
Date:   Fri, 24 Jan 2020 11:30:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Gary R Hook <gary.hook@amd.com>
Subject: Re: [PATCH v3 1/3] dmaengine: ptdma: Initial driver for the AMD
 PassThru DMA engine
Message-ID: <20200124060058.GC2841@vkoul-mobl>
References: <1579597494-60348-1-git-send-email-Sanju.Mehta@amd.com>
 <1579597494-60348-2-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579597494-60348-2-git-send-email-Sanju.Mehta@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-20, 03:04, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> This device performs high-bandwidth memory-to-memory
> transfer operations.

Why is it called PassThru DMA engine?

>  obj-y += mediatek/
>  obj-y += qcom/
> diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
> new file mode 100644
> index 0000000..4ec259e
> --- /dev/null
> +++ b/drivers/dma/ptdma/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config AMD_PTDMA
> +	tristate  "AMD PassThru DMA Engine"
> +	depends on X86_64 && PCI

not using DMA_VIRTUAL_CHANNELS?

> +	help
> +	  Provides the support for AMD PassThru DMA Engine.

more help text please

> +++ b/drivers/dma/ptdma/ptdma-dev.c
> @@ -0,0 +1,387 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD Passthru DMA device driver
> + * -- Based on the CCP driver

What is ccp driver?

> + *
> + * Copyright (C) 2016,2019 Advanced Micro Devices, Inc.

2020..

> +#ifdef CONFIG_PM
> +static int pt_pci_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	return -ENOSYS;
> +}
> +
> +static int pt_pci_resume(struct pci_dev *pdev)
> +{
> +	return -ENOSYS;
> +}
> +#endif

please remove the dummy code, you can add these when you have support
for it

> +/* Bit masks */
> +#define	CMD_DESC_DW0_VAL		0x500012
> +#define	CMD_CONFIG_REQID		0x0
> +#define	CMD_CONFIG_VHB_EN		0x00000001
> +#define	CMD_QUEUE_PRIO			0x00000006
> +#define	CMD_TIMEOUT_DISABLE		0x00000000
> +#define	CMD_CLK_DYN_GATING_EN	0x1
> +#define	CMD_CLK_DYN_GATING_DIS	0x0
> +#define	CMD_CLK_HW_GATE_MODE	0x1
> +#define	CMD_CLK_SW_GATE_MODE	0x0
> +#define	CMD_CLK_GATE_ON_DELAY	0x1000
> +#define	CMD_CLK_GATE_CTL	0x0
> +#define	CMD_CLK_GATE_OFF_DELAY	0x1000

BIT and GENMASK for these...

All this adds handling of pt controller, I am not seeing dmaengine bits,
so please word the changelog accordingly and mention this adds based
bits and not dmaengine support (yet)

-- 
~Vinod
