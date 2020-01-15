Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD2BC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A517B206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rrdWLgEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgAOKKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:10:49 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3087 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbgAOKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:10:49 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ee5140000>; Wed, 15 Jan 2020 02:10:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Jan 2020 02:10:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Jan 2020 02:10:48 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 10:10:46 +0000
Subject: Re: [PATCH v4 13/14] dmaengine: tegra-apb: Allow to compile as a
 loadable kernel module
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-14-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <620aa569-b880-d226-8dee-382ea5143fa3@nvidia.com>
Date:   Wed, 15 Jan 2020 10:10:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-14-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579083028; bh=29XVyQvFxwTUd3BflXV70WyEzCR4mVvEevxIzIM4rGc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rrdWLgEv0c2hG4IFCZE+m98k6ihvT5VI4kXgWG8C5j0lqmpKJhcAoyrYN8P5B4A7I
         nifm8nnWN77+iGs/7ED5TPw3QOmEzR/Usx8rm9Hh2akjqj65DgJUC3yEI5OgguE1Ex
         YPg074juckePkwsg+1exkFTUfAwQzqqSAWvYrp97ODIf6o/jfz/mgVeJhFc+lrqKHS
         aC3U79XR04aC/wgoTDCf5e0rzfiQVk5trcY+W8ownvpGg+cG6/o8WGyjxdfKtk37RS
         CXCuUSTXf2T6572utEC/1aUYF4voZ1ZfQM76/lT2nkRRmrNw6VoKm5xaXjO+LHQ9xX
         6RVXHve3UY5Gg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/01/2020 17:30, Dmitry Osipenko wrote:
> The driver's removal was fixed by a recent commit and module load/unload
> is working well now, tested on Tegra30.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 6fa1eba9d477..9f43e2cae8b4 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -586,7 +586,7 @@ config TXX9_DMAC
>  	  integrated in chips such as the Toshiba TX4927/38/39.
>  
>  config TEGRA20_APB_DMA
> -	bool "NVIDIA Tegra20 APB DMA support"
> +	tristate "NVIDIA Tegra20 APB DMA support"
>  	depends on ARCH_TEGRA
>  	select DMA_ENGINE
>  	help

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon


-- 
nvpublic
