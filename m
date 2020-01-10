Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF03EC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933F320661
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WqqWhJ00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgAJHFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:05:52 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51656 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgAJHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:05:52 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00A75cER115272;
        Fri, 10 Jan 2020 01:05:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578639938;
        bh=kpORGyTnFiUB2kyV4rh9SVQZSJpHZQmOr0++G25k5Oc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WqqWhJ008QHlSIDVi34sOqZuXoEJmGIeNFnfPWDFSCvpu1SlX7OMiEoPbYuK//T6Y
         oqiaD5ciDKWocqn9lJ8EJJEXDxHNCjhtc2JbLBbb7Y17fZ86Ek8WJceVPSc5pA5Zwp
         WIg1PC5VkRDWBFdqEJrl0uOG71YPeSNcjwcHhNjo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00A75cYD031065;
        Fri, 10 Jan 2020 01:05:38 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 10
 Jan 2020 01:05:38 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 10 Jan 2020 01:05:38 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00A75ZF7099102;
        Fri, 10 Jan 2020 01:05:36 -0600
Subject: Re: [PATCH] media: xilinx: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <mchehab@kernel.org>, <hyun.kwon@xilinx.com>, <vkoul@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
References: <20191217104235.23771-1-peter.ujfalusi@ti.com>
 <20200109164847.GF31792@pendragon.ideasonboard.com>
 <20200109165348.GG31792@pendragon.ideasonboard.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <1a58e0e2-b1c2-1b97-22a8-8c0f366882d3@ti.com>
Date:   Fri, 10 Jan 2020 09:06:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109165348.GG31792@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/01/2020 18.53, Laurent Pinchart wrote:
> Hello again,
> 
> On Thu, Jan 09, 2020 at 06:48:47PM +0200, Laurent Pinchart wrote:
>> On Tue, Dec 17, 2019 at 12:42:35PM +0200, Peter Ujfalusi wrote:
>>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>>> eating up the error code.
>>>
>>> By using dma_request_chan() directly the driver can support deferred
>>> probing against DMA.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> Vinod, could you please pick this up ?
> 
> I spoke too fast.
> 
>>> ---
>>>  drivers/media/platform/xilinx/xilinx-dma.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/xilinx/xilinx-dma.c b/drivers/media/platform/xilinx/xilinx-dma.c
>>> index b211380a11f2..9ce515ff9c0a 100644
>>> --- a/drivers/media/platform/xilinx/xilinx-dma.c
>>> +++ b/drivers/media/platform/xilinx/xilinx-dma.c
>>> @@ -725,10 +725,10 @@ int xvip_dma_init(struct xvip_composite_device *xdev, struct xvip_dma *dma,
>>>  
>>>  	/* ... and the DMA channel. */
>>>  	snprintf(name, sizeof(name), "port%u", port);
>>> -	dma->dma = dma_request_slave_channel(dma->xdev->dev, name);
>>> -	if (dma->dma == NULL) {
>>> +	dma->dma = dma_request_chan(dma->xdev->dev, name);
>>> +	if (IS_ERR(dma->dma)) {
>>>  		dev_err(dma->xdev->dev, "no VDMA channel found\n");

and print this only in case of !EPROBE_DEFER

>>> -		ret = -ENODEV;
>>> +		ret = PTR_ERR(dma->dma);
>>>  		goto error;
> 
> At the error label, we have
> 
> error:
> 	xvip_dma_cleanup(dma);
> 	return ret;
> 
> and xvip_dma_cleanup() contains
> 
> 	if (dma->dma)
> 		dma_release_channel(dma->dma);
> 
> You need to turn this into
> 
> 	if (!IS_ERR_OR_NULL(dma->dma))

I generally try to avoid IS_ERR_OR_NULL()

> 
> or add a
> 
> 		dma->dma = NULL;

But in this case I think it looks better that way.

> 
> in the error case in xvip_dma_init().
> 
>>>  	}
>>>  
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
