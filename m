Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1160CC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEAF24680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QQ29GRLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgANPPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:15:06 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3904 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:15:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ddae50001>; Tue, 14 Jan 2020 07:14:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 07:15:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jan 2020 07:15:05 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 15:15:03 +0000
Subject: Re: [PATCH v4 02/14] dmaengine: tegra-apb: Implement synchronization
 callback
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-3-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c225399c-f032-8001-e67b-b807dcda748c@nvidia.com>
Date:   Tue, 14 Jan 2020 15:15:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-3-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579014886; bh=JePrDOAkjzv0EzYr8BYmr8mKs2tVGED6HLIuxX62xjg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QQ29GRLZ1Fxi8VQCLPj1z1303NuVayIcuiSPhf7J4o36AJhk5rTzcXcjVkWHvwBFr
         CtF42OumyEEV+IxkvLx3KYrMeQ4qtnLUeBduReKyG3aqQirL/o1OlINvVSfn7iLzZJ
         b8PuUYbo1LquBMcogfmHTHDD9Xzsplkmm6/YkV5Y8Pw1eWIccUFPoPOJ1YmudWFFdV
         4gr3KZc1W9EZUxPbrrfSZsarz/dZF05hN4orxlqx5rvQ8dMuDwHvljYdyv3zmce2mx
         slgi6QdACkoRq83MUhLAOKrIIA41EzqYDmKuBcx09SawllLYglC/ojX5q03b49MYev
         bCQ4ByIdQnleQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/01/2020 17:29, Dmitry Osipenko wrote:
> The ISR tasklet could be kept scheduled after DMA transfer termination,
> let's add synchronization callback which blocks until tasklet is finished.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 319f31d27014..664e9c5df3ba 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -798,6 +798,13 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>  	return 0;
>  }
>  
> +static void tegra_dma_synchronize(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +
> +	tasklet_kill(&tdc->tasklet);
> +}
> +

Wouldn't there need to be some clean-up here? If the tasklet is
scheduled, seems that there would be some other house-keeping that needs
to be done after killing it.

Jon

-- 
nvpublic
