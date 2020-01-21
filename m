Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B243C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AC624654
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAUD2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:28:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbgAUD2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:28:48 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 265DDF03C5BA81701639;
        Tue, 21 Jan 2020 11:28:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 21 Jan 2020
 11:28:43 +0800
Subject: Re: [PATCH -next] dmaengine: fsl-qdma: fix duplicated argument to &&
To:     Peng Ma <peng.ma@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
References: <20200120125843.34398-1-chenzhou10@huawei.com>
 <VI1PR04MB44314C51FA4C397F352C14C8ED0D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <96b96dda-0fdc-bbc1-cdb8-b7d0f20940e7@huawei.com>
Date:   Tue, 21 Jan 2020 11:28:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB44314C51FA4C397F352C14C8ED0D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 2020/1/21 10:54, Peng Ma wrote:
> 
> 
>> -----Original Message-----
>> From: Chen Zhou <chenzhou10@huawei.com>
>> Sent: 2020Äê1ÔÂ20ÈÕ 20:59
>> To: dan.j.williams@intel.com; vkoul@kernel.org
>> Cc: Peng Ma <peng.ma@nxp.com>; Wen He <wen.he_1@nxp.com>;
>> jiaheng.fan@nxp.com; dmaengine@vger.kernel.org;
>> linux-kernel@vger.kernel.org; chenzhou10@huawei.com
>> Subject: [PATCH -next] dmaengine: fsl-qdma: fix duplicated argument to &&
>>
>> There is duplicated argument to && in function fsl_qdma_free_chan_resources,
>> which looks like a typo, pointer fsl_queue->desc_pool also needs NULL check,
>> fix it.
>> Detected with coccinelle.
>>
> What does the " coccinelle " mean here?

The scripts in kernel dir, that is coccicheck.

Thanks,
Chen Zhou

> 
>> Fixes: b092529e0aa0 ("dmaengine: fsl-qdma: Add qDMA controller driver for
>> Layerscape SoCs")
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>> drivers/dma/fsl-qdma.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c index
>> 8979208..95cc025 100644
>> --- a/drivers/dma/fsl-qdma.c
>> +++ b/drivers/dma/fsl-qdma.c
>> @@ -304,7 +304,7 @@ static void fsl_qdma_free_chan_resources(struct
>> dma_chan *chan)
>>
>> 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
>>
>> -	if (!fsl_queue->comp_pool && !fsl_queue->comp_pool)
>> +	if (!fsl_queue->comp_pool && !fsl_queue->desc_pool)
>> 		return;
>>
> Hi Chen,
> 
> Thanks very much for your patch, It is really need to check comp_pool and desc_pool here.
> Reviewed-by: Peng Ma <peng.ma@nxp.com>
> Tested-by: Peng Ma <peng.ma@nxp.com>
> 
> BR,
> Peng
>> 	list_for_each_entry_safe(comp_temp, _comp_temp,
>> --
>> 2.7.4
> 

