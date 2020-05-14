Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07CFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FF520709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgENJJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:09:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4841 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbgENJJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:09:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 114C065729C54A7EB87F;
        Thu, 14 May 2020 17:09:21 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.180) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 14 May 2020
 17:09:18 +0800
Subject: Re: [PATCH -next] dmaengine: ti: k3-udma: Use PTR_ERR_OR_ZERO() to
 simplify code
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1588757146-38858-1-git-send-email-zou_wei@huawei.com>
 <f9ae33c9-5a8a-d10a-5bb3-ecf9ee5d81f5@ti.com>
From:   Samuel Zou <zou_wei@huawei.com>
Message-ID: <ee9877ba-b310-9e6e-12e3-4eb5b09c4e75@huawei.com>
Date:   Thu, 14 May 2020 17:09:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f9ae33c9-5a8a-d10a-5bb3-ecf9ee5d81f5@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.212.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I'm sorry for my mistake.
Thanks for your comments and suggestions.

On 2020/5/14 16:33, Peter Ujfalusi wrote:
> Hi Samuel,
> 
> On 06/05/2020 12.25, Samuel Zou wrote:
>> Fixes coccicheck warnings:
>>
>> drivers/dma/ti/k3-udma.c:1294:1-3: WARNING: PTR_ERR_OR_ZERO can be used
>> drivers/dma/ti/k3-udma.c:1311:1-3: WARNING: PTR_ERR_OR_ZERO can be used
>> drivers/dma/ti/k3-udma.c:1376:1-3: WARNING: PTR_ERR_OR_ZERO can be used
> 
> Thanks for the patch, I have missed it as I was not in CC for it.
> scripts/get_maintainer.pl would have tipped for a wider recipient list..
> 
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
>> ---
>>   drivers/dma/ti/k3-udma.c | 12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 0a04174..f5775ca 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -1291,10 +1291,8 @@ static int udma_get_tchan(struct udma_chan *uc)
>>   	}
>>   
>>   	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl, -1);
>> -	if (IS_ERR(uc->tchan))
>> -		return PTR_ERR(uc->tchan);
>>   
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(uc->tchan);
>>   }
>>   
>>   static int udma_get_rchan(struct udma_chan *uc)
>> @@ -1308,10 +1306,8 @@ static int udma_get_rchan(struct udma_chan *uc)
>>   	}
>>   
>>   	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl, -1);
>> -	if (IS_ERR(uc->rchan))
>> -		return PTR_ERR(uc->rchan);
>>   
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(uc->rchan);
>>   }
>>   
>>   static int udma_get_chan_pair(struct udma_chan *uc)
>> @@ -1373,10 +1369,8 @@ static int udma_get_rflow(struct udma_chan *uc, int flow_id)
>>   	}
>>   
>>   	uc->rflow = __udma_get_rflow(ud, flow_id);
>> -	if (IS_ERR(uc->rflow))
>> -		return PTR_ERR(uc->rflow);
>>   
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(uc->rflow);
>>   }
>>   
>>   static void udma_put_rchan(struct udma_chan *uc)
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

