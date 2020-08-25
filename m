Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A03C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E544720715
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598354707;
	bh=M3p0x9HTexyXG3y5wtcZskuuZYZ2oidM4aabQAVz3xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BjzD7kjpX7uZKoQL5omtCUUgwCRg+SfLqBcyCfZkKRMR37iIL11wKLc9BDFD4QiMU
	 98xaDYolNzZp00e/1zthdxLHJwvgv5yPg5R0RfL1X8ZRE/BQ7Pk1nX7jjP8nEJ98Et
	 EGkTx7nlNspuAvxiMR2trHO9Ht/ZaPcn2hbulou0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgHYLY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgHYLYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:24:40 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D2E20715;
        Tue, 25 Aug 2020 11:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598354679;
        bh=M3p0x9HTexyXG3y5wtcZskuuZYZ2oidM4aabQAVz3xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZh0xC0b8X09A8dT0ltfBidxeXkJkRe/uji2Tj8v/s2tkDe8qNiV9RLZQSAKx3yU1
         yzhQMZXTO+VJFReo++Wt1I/UsaWuGgF0FHj00yNwRdYf5uA0pzmxmbUL7FP1fgQKeu
         KjEQsComLcl8dmfQABg2xxd5W9quYrDzm07wD7+Y=
Date:   Tue, 25 Aug 2020 16:54:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, dan.j.williams@intel.com, ardeleanalex@gmail.com
Subject: Re: [PATCH 2/5] dmaengine: axi-dmac: move clock enable earlier
Message-ID: <20200825112435.GO2639@vkoul-mobl>
References: <20200819071633.76494-1-alexandru.ardelean@analog.com>
 <20200819071633.76494-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819071633.76494-2-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-20, 10:16, Alexandru Ardelean wrote:
> The clock may also be required to read registers from the IP core (if it is
> provided and the driver needs to control it).
> So, move it earlier in the probe.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 088c79137398..07665c60c21b 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -850,6 +850,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	if (IS_ERR(dmac->clk))
>  		return PTR_ERR(dmac->clk);
>  
> +	ret = clk_prepare_enable(dmac->clk);
> +	if (ret < 0)
> +		return ret;
> +
>  	INIT_LIST_HEAD(&dmac->chan.active_descs);

Change is fine, but then you need to jump to err_clk_disable in few
place below this and not return error

>  
>  	of_channels = of_get_child_by_name(pdev->dev.of_node, "adi,channels");
> @@ -892,10 +896,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	dmac->chan.vchan.desc_free = axi_dmac_desc_free;
>  	vchan_init(&dmac->chan.vchan, dma_dev);
>  
> -	ret = clk_prepare_enable(dmac->clk);
> -	if (ret < 0)
> -		return ret;
> -
>  	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
>  
>  	ret = axi_dmac_detect_caps(dmac, version);
> -- 
> 2.17.1

-- 
~Vinod
