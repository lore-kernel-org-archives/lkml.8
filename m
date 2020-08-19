Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8919C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2022078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgHSOTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:19:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbgHSOTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:19:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33BCF64983AB2B898E66;
        Wed, 19 Aug 2020 22:19:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 22:19:36 +0800
Subject: Re: [PATCH v2 1/4] libnvdimm: fix memmory leaks in of_pmem.c
To:     Oliver O'Halloran <oohall@gmail.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-2-thunder.leizhen@huawei.com>
 <CAOSf1CGvtX6FjYXy-mGxoEx4B6ZQ-LUZDMi-503JtECLu93faw@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d22e87df-0602-91fa-2ecd-6f641b734fbb@huawei.com>
Date:   Wed, 19 Aug 2020 22:19:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOSf1CGvtX6FjYXy-mGxoEx4B6ZQ-LUZDMi-503JtECLu93faw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2020 9:37 PM, Oliver O'Halloran wrote:
> On Wed, Aug 19, 2020 at 12:05 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> The memory priv->bus_desc.provider_name allocated by kstrdup() is not
>> freed correctly.
>>
>> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Yep, that's a bug.
> 
> Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

Thanks for your review.

> 
>> ---
>>  drivers/nvdimm/of_pmem.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
>> index 10dbdcdfb9ce913..1292ffca7b2ecc0 100644
>> --- a/drivers/nvdimm/of_pmem.c
>> +++ b/drivers/nvdimm/of_pmem.c
>> @@ -36,6 +36,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>>
>>         priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
>>         if (!bus) {
>> +               kfree(priv->bus_desc.provider_name);
>>                 kfree(priv);
>>                 return -ENODEV;
>>         }
>> @@ -83,6 +84,7 @@ static int of_pmem_region_remove(struct platform_device *pdev)
>>         struct of_pmem_private *priv = platform_get_drvdata(pdev);
>>
>>         nvdimm_bus_unregister(priv->bus);
>> +       kfree(priv->bus_desc.provider_name);
>>         kfree(priv);
>>
>>         return 0;
>> --
>> 1.8.3
>>
>>
> 
> .
> 

