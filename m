Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8951C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94612075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404515AbgE2B4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:56:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390018AbgE2B4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:56:13 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B273461E77528AE2947B;
        Fri, 29 May 2020 09:56:10 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 29 May 2020
 09:56:01 +0800
Subject: Re: [PATCH 02/12] net: hns3: Destroy a mutex after initialisation
 failure in hclge_init_ad_dev()
To:     Markus Elfring <Markus.Elfring@web.de>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>
References: <913bb77c-6190-9ce7-a46d-906998866073@web.de>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <9c50ab14-c5c7-129f-0e51-d40a4c552fd8@huawei.com>
Date:   Fri, 29 May 2020 09:56:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <913bb77c-6190-9ce7-a46d-906998866073@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/29 2:42, Markus Elfring wrote:
>> Add a mutex destroy call in hclge_init_ae_dev() when fails.
> 
> How do you think about a wording variant like the following?
> 
>     Change description:
>     The function “mutex_init” was called before a call of
>     the function “hclge_pci_init”.
>     But the function “mutex_destroy” was not called after initialisation
>     steps failed.
>     Thus add the missed function call for the completion of
>     the exception handling.
> 

It looks better. I will try to improve the skill of patch description
and make as many as people can understand the patch.

Thanks for help.

> 
> Would you like to add the tag “Fixes” to the commit message?
> 

Since it seems not a very urgent issue, so i send it to the -next
and make it as a code optimization.

Thanks:)

> 
> …
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> @@ -10108,6 +10108,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
>>   	pci_release_regions(pdev);
>>   	pci_disable_device(pdev);
>>   out:
>> +	mutex_destroy(&hdev->vport_lock);
>>   	return ret;
>>   }
> 
> How do you think about to use the label “destroy_mutex” instead?

Will use label 'destroy_mutex‘ instead if there is another patch need to 
modify this code, which is more readable.

Thanks for your comments.

> 
> Regards,
> Markus
> 
> 

