Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BFEC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675DC20674
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zqtk37f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgCRHDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:03:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34948 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCRHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:03:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02I73g2E110851;
        Wed, 18 Mar 2020 02:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584515022;
        bh=s84pMpvP+sKCmwJIMIK+lqik+PaKJfBiqAnv1uQ88rw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Zqtk37f78UahoZXtiMgZ7ZR6ETIw5vD4dzmToFok0WrjihjOqvNkgts171bFBN1n3
         NYdl1S66HCvGdLsM/nA6N5vrYLfnbpbeqk5hkituX+db2LyKV9os2DO3DAdiD6ydYU
         Jn0TMnFe/AHNpwjmAYxep/nsOFR8T/fN7yLxJBxM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02I73fbQ113946
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Mar 2020 02:03:41 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 18
 Mar 2020 02:03:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 18 Mar 2020 02:03:42 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02I73dp3080708;
        Wed, 18 Mar 2020 02:03:40 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix an error handling path in
 'k3_udma_glue_cfg_rx_flow()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20200315155015.27303-1-christophe.jaillet@wanadoo.fr>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <5d714664-d8c3-a710-8e14-65492b4cd99e@ti.com>
Date:   Wed, 18 Mar 2020 09:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200315155015.27303-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 15/03/2020 17.50, Christophe JAILLET wrote:
> All but one error handling paths in the 'k3_udma_glue_cfg_rx_flow()'
> function 'goto err' and call 'k3_udma_glue_release_rx_flow()'.
> 
> This not correct because this function has a 'channel->flows_ready--;' at
> the end, but 'flows_ready' has not been incremented here, when we branch to
> the error handling path.
> 
> In order to keep a correct value in 'flows_ready', un-roll
> 'k3_udma_glue_release_rx_flow()', simplify it, add some labels and branch
> at the correct places when an error is detected.
> 
> Doing so, we also NULLify 'flow->udma_rflow' in a path that was lacking it.
> 
> Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine user")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Can you change the subject to:
dmaengine: ti: k3-udma-glue: ...

> ---
> Not sure that the last point of the description is correct. Maybe, the
> 'xudma_rflow_put / return -ENODEV;' should be kept in order not to
> override 'flow->udma_rflow'.
> ---
>  drivers/dma/ti/k3-udma-glue.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index dbccdc7c0ed5..890573eb1625 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -578,12 +578,12 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  	if (IS_ERR(flow->udma_rflow)) {
>  		ret = PTR_ERR(flow->udma_rflow);
>  		dev_err(dev, "UDMAX rflow get err %d\n", ret);
> -		goto err;
> +		goto err_return;

return ret;

>  	}
>  
>  	if (flow->udma_rflow_id != xudma_rflow_get_id(flow->udma_rflow)) {
> -		xudma_rflow_put(rx_chn->common.udmax, flow->udma_rflow);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_rflow_put;
>  	}
>  
>  	/* request and cfg rings */
> @@ -592,7 +592,7 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  	if (!flow->ringrx) {
>  		ret = -ENODEV;
>  		dev_err(dev, "Failed to get RX ring\n");
> -		goto err;
> +		goto err_rflow_put;
>  	}
>  
>  	flow->ringrxfdq = k3_ringacc_request_ring(rx_chn->common.ringacc,
> @@ -600,19 +600,19 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  	if (!flow->ringrxfdq) {
>  		ret = -ENODEV;
>  		dev_err(dev, "Failed to get RXFDQ ring\n");
> -		goto err;
> +		goto err_ringrx_free;
>  	}
>  
>  	ret = k3_ringacc_ring_cfg(flow->ringrx, &flow_cfg->rx_cfg);
>  	if (ret) {
>  		dev_err(dev, "Failed to cfg ringrx %d\n", ret);
> -		goto err;
> +		goto err_ringrxfdq_free;
>  	}
>  
>  	ret = k3_ringacc_ring_cfg(flow->ringrxfdq, &flow_cfg->rxfdq_cfg);
>  	if (ret) {
>  		dev_err(dev, "Failed to cfg ringrxfdq %d\n", ret);
> -		goto err;
> +		goto err_ringrxfdq_free;
>  	}
>  
>  	if (rx_chn->remote) {
> @@ -662,7 +662,7 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  	if (ret) {
>  		dev_err(dev, "flow%d config failed: %d\n", flow->udma_rflow_id,
>  			ret);
> -		goto err;
> +		goto err_ringrxfdq_free;
>  	}
>  
>  	rx_chn->flows_ready++;
> @@ -670,8 +670,18 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  		flow->udma_rflow_id, rx_chn->flows_ready);
>  
>  	return 0;
> -err:
> -	k3_udma_glue_release_rx_flow(rx_chn, flow_idx);
> +
> +err_ringrxfdq_free:
> +	k3_ringacc_ring_free(flow->ringrxfdq);
> +
> +err_ringrx_free:
> +	k3_ringacc_ring_free(flow->ringrx);
> +
> +err_rflow_put:
> +	xudma_rflow_put(rx_chn->common.udmax, flow->udma_rflow);
> +	flow->udma_rflow = NULL;
> +
> +err_return:

and you don't need this label.

>  	return ret;
>  }
>  
> 

With these changes:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
