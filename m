Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AF3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 03:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EDC22D00
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 03:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHHDgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 23:36:46 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:48584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbgHHDgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 23:36:46 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 01C9FE04D439560D1802;
        Sat,  8 Aug 2020 11:36:44 +0800 (CST)
Received: from [10.174.61.242] (10.174.61.242) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 8 Aug 2020 11:36:43 +0800
Subject: Re: [PATCH net-next v1] hinic: fix strncpy output truncated compile
 warnings
To:     David Laight <David.Laight@ACULAB.COM>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "luoxianjun@huawei.com" <luoxianjun@huawei.com>,
        "yin.yinshi@huawei.com" <yin.yinshi@huawei.com>,
        "cloud.wangxiaoyun@huawei.com" <cloud.wangxiaoyun@huawei.com>,
        "chiqijun@huawei.com" <chiqijun@huawei.com>
References: <20200807020914.3123-1-luobin9@huawei.com>
 <e7a4fcf12a4e4d179e2fae8ffb44f992@AcuMS.aculab.com>
From:   "luobin (L)" <luobin9@huawei.com>
Message-ID: <b886a6ff-8ed8-c857-f190-e99f8f735e02@huawei.com>
Date:   Sat, 8 Aug 2020 11:36:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e7a4fcf12a4e4d179e2fae8ffb44f992@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.61.242]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/7 17:32, David Laight wrote:
> From: Luo bin
>> Sent: 07 August 2020 03:09
>>
>> fix the compile warnings of 'strncpy' output truncated before
>> terminating nul copying N bytes from a string of the same length
>>
>> Signed-off-by: Luo bin <luobin9@huawei.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>> V0~V1:
>> - use the strlen()+1 pattern consistently
>>
>>  drivers/net/ethernet/huawei/hinic/hinic_devlink.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
>> b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
>> index c6adc776f3c8..1ec88ebf81d6 100644
>> --- a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
>> +++ b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
>> @@ -342,9 +342,9 @@ static int chip_fault_show(struct devlink_fmsg *fmsg,
>>
>>  	level = event->event.chip.err_level;
>>  	if (level < FAULT_LEVEL_MAX)
>> -		strncpy(level_str, fault_level[level], strlen(fault_level[level]));
>> +		strncpy(level_str, fault_level[level], strlen(fault_level[level]) + 1);
> 
> Have you even considered what that code is actually doing?
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> .
> 
I'm sorry that I haven't got what you mean and I haven't found any defects in that code. Can you explain more to me?
