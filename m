Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F8AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1C822B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGTHIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:08:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgGTHIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:08:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7A2A7BC094A04463BD6D;
        Mon, 20 Jul 2020 15:08:50 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.81) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Jul 2020
 15:08:44 +0800
Subject: Re: [PATCH net-next v2] net: ena: Fix using plain integer as NULL
 pointer in ena_init_napi_in_range
To:     Joe Perches <joe@perches.com>, <gtzalik@amazon.com>,
        <saeedb@amazon.com>, <zorik@amazon.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <sameehj@amazon.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200720025309.18597-1-wanghai38@huawei.com>
 <f31ec3e646c9ba73c09f821a173c20110346deab.camel@perches.com>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <073489da-6ffb-4f1c-fe35-d663f86dd1a6@huawei.com>
Date:   Mon, 20 Jul 2020 15:08:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f31ec3e646c9ba73c09f821a173c20110346deab.camel@perches.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.81]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2020/7/20 11:15, Joe Perches Ð´µÀ:
> On Mon, 2020-07-20 at 10:53 +0800, Wang Hai wrote:
>> Fix sparse build warning:
>>
>> drivers/net/ethernet/amazon/ena/ena_netdev.c:2193:34: warning:
>>   Using plain integer as NULL pointer
> []
>> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> []
>> @@ -2190,11 +2190,10 @@ static void ena_del_napi_in_range(struct ena_adapter *adapter,
>>   static void ena_init_napi_in_range(struct ena_adapter *adapter,
>>   				   int first_index, int count)
>>   {
>> -	struct ena_napi *napi = {0};
>>   	int i;
>>   
>>   	for (i = first_index; i < first_index + count; i++) {
>> -		napi = &adapter->ena_napi[i];
>> +		struct ena_napi *napi = &adapter->ena_napi[i];
>>   
>>   		netif_napi_add(adapter->netdev,
>>   			       &adapter->ena_napi[i].napi,
> Another possible change is to this statement:
>
>   		netif_napi_add(adapter->netdev,
> 			       &napi->napi,
> 			       etc...);
>
Good catch. I'll add this change, Thanks.
>
>
> .
>

