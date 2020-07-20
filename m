Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E3BC4345F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8753F2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L3T/Iusz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgGTPmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbgGTPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:42:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF85C061794;
        Mon, 20 Jul 2020 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uW55VeHLVejAEsOOwgk58cdmqasy1mJu39UYVDzDOtA=; b=L3T/Iusz7O9DXHHnLq9Ab4GK7b
        e0tKSup3EHUcx8aIUxq80LzKMoZQfssWvqOq1CGIgcX1o34SBug0S30t3ft49tobIC8llTeJzauRM
        uiIrQmmexuFchoXq9lqubYT9VhbyW+aQRFSUhktu+bzKgWMShZmGKnbkm4lUgQqm0vp5kpaZuSEOF
        h5sT4CHDg7+rvGDHcOv1SQniCt6nCNen/1uguff73ZXpWt4OaHsk7BZ+PQZBzpGUhsAOK/CKnMQCt
        gB90pST/N08SqxSPOtrA3paUoK2ux77xvN6YDjlN9q0nWOn/AtxMEs+F8EdNxHb9nvu7s3/Fdwhjj
        CJZK2H8g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxXve-0002sl-Sm; Mon, 20 Jul 2020 15:42:11 +0000
Subject: Re: [Patch v1 2/4] dma: tegra: Adding Tegra GPC DMA controller driver
To:     Rajesh Gumasta <rgumasta@nvidia.com>, ldewangan@nvidia.com,
        jonathanh@nvidia.com, vkoul@kernel.org, dan.j.williams@intel.com,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kyarlagadda@nvidia.com, Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
 <1595226856-19241-3-git-send-email-rgumasta@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a0e8fca8-da72-bafa-9980-6d5ffd1af6e3@infradead.org>
Date:   Mon, 20 Jul 2020 08:42:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595226856-19241-3-git-send-email-rgumasta@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/20 11:34 PM, Rajesh Gumasta wrote:
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index e9ed916..be4c395 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -639,6 +639,18 @@ config TEGRA210_ADMA
>  	  peripheral and vice versa. It does not support memory to
>  	  memory data transfer.
>  
> +config TEGRA_GPC_DMA
> +	tristate "NVIDIA Tegra GPC DMA support"
> +	depends on ARCH_TEGRA_186_SOC || ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	select DMA_ENGINE
> +	help
> +	  Support for the NVIDIA Tegra186 and Tegra194 GPC DMA controller
> +	  driver. The DMA controller is having multiple DMA channel which

	          The DMA controller has multiple DMA channels which

> +	  can be configured for different peripherals like UART, SPI, etc
> +	  which are on APB bus.
> +	  This DMA controller transfers data from memory to peripheral fifo

	                                                               FIFO

> +	  or vice versa. It also supports memory to memory data transfer.
> +
>  config TIMB_DMA
>  	tristate "Timberdale FPGA DMA support"
>  	depends on MFD_TIMBERDALE || COMPILE_TEST


thanks.
-- 
~Randy

