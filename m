Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B5FC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB1B2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ancSJtsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgHaM6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:58:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38848 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgHaM6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:58:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07VCwMkH039669;
        Mon, 31 Aug 2020 07:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598878702;
        bh=fIeoGr9RayYl9FESFymBJwM5lWdwC5rfBgndUYtOWIc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ancSJtsCMkFd61yu8JK0ure5Lba2+7UnJlEMHCoL8n+LqpbS6ZdjDZC9Ue6dTq780
         7aqmCUPZTe+GW0k6E1h61TK3iruR1jwI+Fp7fKo32grGWAIPZgQs073gqCoL9Ke3v+
         ypOi788gS91JwhL73EPpdbK8U6ZAk2SyZKLw0Sq8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07VCwMax104973
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 07:58:22 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 31
 Aug 2020 07:58:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 31 Aug 2020 07:58:22 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07VCwJXR101432;
        Mon, 31 Aug 2020 07:58:20 -0500
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA
 reads
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Brown <broonie@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200828074726.24546-1-vigneshr@ti.com>
 <8828e301-a7b7-d837-dc60-6c5101cdac90@siemens.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <d011f755-421a-292f-25f6-a88568f09798@ti.com>
Date:   Mon, 31 Aug 2020 18:28:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8828e301-a7b7-d837-dc60-6c5101cdac90@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/20 1:56 PM, Jan Kiszka wrote:
> On 28.08.20 09:47, Vignesh Raghavendra wrote:
>> Buffers need to mapped to DMA channel's device pointer instead of SPI
>> controller's device pointer as its system DMA that actually does data
>> transfer.
>> Data inconsistencies have been reported when reading from flash
>> without this fix.
>>
>> Fixes: 31fb632b5d43c ("spi: Move cadence-quadspi driver to drivers/spi/")
> 
> This looks wrong, ...
> 
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>
>> This issue was present in the original driver under SPI NOR framework as well.
>> But only got exposed as driver started handling probe deferral for DMA channel
>> request and thus uses DMA almost always unlike before.
> 
> ...you rather want 935da5e5100f57d843cac4781b21f1c235059aa0 then.
> 

Actually, the offending code is actually from 
commit ffa639e069fb ("mtd: spi-nor: cadence-quadspi: Add DMA support for direct mode reads)
which adds dma_{un}map_single() calls.

Will send v2 with Fixes tag updated to point to above commit 


> Other than that:
> 
> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks!

Regards
Vignesh

> 
> Thanks!
> Jan
> 
>>
>>  drivers/spi/spi-cadence-quadspi.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index 508b219eabf8..c6795c684b16 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -907,14 +907,16 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>>  	struct dma_async_tx_descriptor *tx;
>>  	dma_cookie_t cookie;
>>  	dma_addr_t dma_dst;
>> +	struct device *ddev;
>>  
>>  	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
>>  		memcpy_fromio(buf, cqspi->ahb_base + from, len);
>>  		return 0;
>>  	}
>>  
>> -	dma_dst = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
>> -	if (dma_mapping_error(dev, dma_dst)) {
>> +	ddev = cqspi->rx_chan->device->dev;
>> +	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
>> +	if (dma_mapping_error(ddev, dma_dst)) {
>>  		dev_err(dev, "dma mapping failed\n");
>>  		return -ENOMEM;
>>  	}
>> @@ -948,7 +950,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>>  	}
>>  
>>  err_unmap:
>> -	dma_unmap_single(dev, dma_dst, len, DMA_FROM_DEVICE);
>> +	dma_unmap_single(ddev, dma_dst, len, DMA_FROM_DEVICE);
>>  
>>  	return ret;
>>  }
>>
> 
