Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FD9C83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFBD20787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgD3Bi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:38:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3343 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbgD3Bi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:38:27 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 993BD23B206319219236;
        Thu, 30 Apr 2020 09:38:25 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.180) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 09:38:21 +0800
Subject: Re: [PATCH -next v2] hinic: Use ARRAY_SIZE for nic_vf_cmd_msg_handler
To:     David Miller <davem@davemloft.net>
CC:     <aviad.krawczyk@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1588133860-55722-1-git-send-email-zou_wei@huawei.com>
 <20200429.114327.1585519928398105692.davem@davemloft.net>
From:   Samuel Zou <zou_wei@huawei.com>
Message-ID: <356fed7c-0983-4d33-df5b-e7b326a90833@huawei.com>
Date:   Thu, 30 Apr 2020 09:38:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429.114327.1585519928398105692.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.212.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/30 2:43, David Miller wrote:
> From: Zou Wei <zou_wei@huawei.com>
> Date: Wed, 29 Apr 2020 12:17:40 +0800
> 
>> fix coccinelle warning, use ARRAY_SIZE
>>
>> drivers/net/ethernet/huawei/hinic/hinic_sriov.c:713:43-44: WARNING: Use ARRAY_SIZE
>>
>> ----------
> 
> Please don't put this "-------" here.
> 
>> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
>> index b24788e..af70cca 100644
>> --- a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
>> +++ b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
>> @@ -704,17 +704,15 @@ int nic_pf_mbox_handler(void *hwdev, u16 vf_id, u8 cmd, void *buf_in,
>>   	struct hinic_hwdev *dev = hwdev;
>>   	struct hinic_func_to_io *nic_io;
>>   	struct hinic_pfhwdev *pfhwdev;
>> -	u32 i, cmd_number;
>> +	u32 i;
>>   	int err = 0;
> 
> Please preserve the reverse christmas tree ordering of local variables.
> 
> .
> 
Thanks，I will modify and send v3 patch

