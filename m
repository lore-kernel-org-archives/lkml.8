Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81197C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5005222CAF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596658312;
	bh=UmJlgXnRIbkpWEb4+GJWusTxQMcaZd+VjLiPMxf0RoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rGxDesclSlgSNmpJiF9DMv/idWdcbzz7rFNyvLHFNrEOm8/zHMu/4JDa/GxnQesds
	 nGbmVLR/mWhitkD9U72rLfVfL1j8WsAbxdqfJDJlTtayEDGY5r3NvI8ygCpSawo1B8
	 y7t9IHQ0cUYCnYVGk8/2WrPYQdUKT1y5VcuE1BoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgHEULu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgHEQ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:27:42 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1699E22D06;
        Wed,  5 Aug 2020 11:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596627161;
        bh=UmJlgXnRIbkpWEb4+GJWusTxQMcaZd+VjLiPMxf0RoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKfYLGeL4sk3PaNTyYcFVHFQJ1R5LtEjDS+g5xCfn8oIH1gcjpsfcxSdctodlhZVV
         SLRSKAGz2ZtLWVabntzLUhnn0sjLlBfo+0MQlBqq+ITL/t48N86l3vymtRCPsUSAMC
         msElrEF7e9enPeNSNKvrmqKdS3g0NSNrW9SNYw7o=
Date:   Wed, 5 Aug 2020 17:02:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     ssantosh@kernel.org, santosh.shilimkar@oracle.com,
        linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Fix parameters for rx ring
 pair request
Message-ID: <20200805113237.GX12965@vkoul-mobl>
References: <20200805112746.15475-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805112746.15475-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-08-20, 14:27, Peter Ujfalusi wrote:
> The original commit mixed up the forward and completion ring IDs for the
> rx flow configuration.

Acked-By: Vinod Koul <vkoul@kernel.org>

> 
> Fixes: 4927b1ab2047 ("dmaengine: ti: k3-udma: Switch to k3_ringacc_request_rings_pair")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Santosh, Vinod,
> 
> the offending patch was queued via ti SoC tree.
> Santosh, can you pick up this fix also?
> 
> Regards,
> Peter
> 
>  drivers/dma/ti/k3-udma-glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index 3a5d33ea5ebe..12da38a92218 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -579,8 +579,8 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  
>  	/* request and cfg rings */
>  	ret =  k3_ringacc_request_rings_pair(rx_chn->common.ringacc,
> -					     flow_cfg->ring_rxq_id,
>  					     flow_cfg->ring_rxfdq0_id,
> +					     flow_cfg->ring_rxq_id,
>  					     &flow->ringrxfdq,
>  					     &flow->ringrx);
>  	if (ret) {
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
