Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA87FC83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A76420737
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgD2Bui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 21:50:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3331 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbgD2Bui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:50:38 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 301E229E52E30D02CF9B;
        Wed, 29 Apr 2020 09:50:36 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 09:50:25 +0800
Subject: Re: [PATCH net-next] net: hns3: adds support for reading module
 eeprom info
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        Yonglong Liu <liuyonglong@huawei.com>
References: <1588075105-52158-1-git-send-email-tanhuazhong@huawei.com>
 <20200428114910.7cc5182e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <a43d4e21-d4e7-a439-946d-306db7f7a5d6@huawei.com>
Date:   Wed, 29 Apr 2020 09:50:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200428114910.7cc5182e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/29 2:49, Jakub Kicinski wrote:
> On Tue, 28 Apr 2020 19:58:25 +0800 Huazhong Tan wrote:
>> From: Yonglong Liu <liuyonglong@huawei.com>
>>
>> This patch adds support for reading the optical module eeprom
>> info via "ethtool -m".
>>
>> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
>> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> 
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> index 4d9c85f..8364e1b 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> @@ -12,6 +12,16 @@ struct hns3_stats {
>>   	int stats_offset;
>>   };
>>   
>> +#define HNS3_MODULE_TYPE_QSFP		0x0C
>> +#define HNS3_MODULE_TYPE_QSFP_P		0x0D
>> +#define HNS3_MODULE_TYPE_QSFP_28	0x11
>> +#define HNS3_MODULE_TYPE_SFP		0x03
> 
> Could you use the SFF8024_ID_* defines from sfp.h here as well?
>

Yes, will send V2 to do that.


> Otherwise looks good to me!
> 

Thanks:)

> .
> 

