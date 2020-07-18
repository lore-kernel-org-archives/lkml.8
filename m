Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB74C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD83220717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGRH51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 03:57:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8319 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728957AbgGRH51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 03:57:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B92516B03DFDC255EE0D;
        Sat, 18 Jul 2020 15:57:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.81) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Jul 2020
 15:57:14 +0800
Subject: Re: [PATCH] net: cxgb3: add missed destroy_workqueue in cxgb3 probe
 failure
To:     David Miller <davem@davemloft.net>
CC:     <vishal@chelsio.com>, <kuba@kernel.org>, <jeff@garzik.org>,
        <divy@chelsio.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200717062117.8941-1-wanghai38@huawei.com>
 <20200717.183913.1150846066923869608.davem@davemloft.net>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <23c0e185-5897-c6d0-1db7-b9ffa3df44ec@huawei.com>
Date:   Sat, 18 Jul 2020 15:57:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200717.183913.1150846066923869608.davem@davemloft.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.81]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2020/7/18 9:39, David Miller Ð´µÀ:
> From: Wang Hai <wanghai38@huawei.com>
> Date: Fri, 17 Jul 2020 14:21:17 +0800
>
>> The driver forgets to call destroy_workqueue when cxgb3 probe fails.
>> Add the missed calls to fix it.
>>
>> Fixes: 4d22de3e6cc4 ("Add support for the latest 1G/10G Chelsio adapter, T3.")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> You have to handle the case that the probing of one or more devices
> fails yet one or more others succeed.
>
> And you can't know in advance how this will play out.
>
> This is why the workqueue is unconditionally created, and only destroyed
> on module remove.
>
> .
Thanks for your explanation. I got it.

