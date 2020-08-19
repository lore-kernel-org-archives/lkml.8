Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C86C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0E020639
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgHSClf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 22:41:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbgHSClf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:41:35 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BC91DAA52303CB9EAE82;
        Wed, 19 Aug 2020 10:41:31 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.81) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 10:41:30 +0800
Subject: Re: [PATCH net] net: gemini: Fix missing free_netdev() in error path
 of gemini_ethernet_port_probe()
To:     David Miller <davem@davemloft.net>
CC:     <ulli.kroll@googlemail.com>, <linus.walleij@linaro.org>,
        <kuba@kernel.org>, <mirq-linux@rere.qmqm.pl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20200818134404.63828-1-wanghai38@huawei.com>
 <20200818.125401.958204660420531471.davem@davemloft.net>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <210d463e-e444-66a6-62f3-e39e0940d5f9@huawei.com>
Date:   Wed, 19 Aug 2020 10:41:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200818.125401.958204660420531471.davem@davemloft.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.81]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2020/8/19 3:54, David Miller Ð´µÀ:
> From: Wang Hai <wanghai38@huawei.com>
> Date: Tue, 18 Aug 2020 21:44:04 +0800
>
>> Fix the missing free_netdev() before return from
>> gemini_ethernet_port_probe() in the error handling case.
>>
>> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> You can just convert this function to use 'devm_alloc_etherdev_mqs', which
> is a one line fix.
>
> .
Thanks for your advice, I just sent a v2 patch.
"[PATCH net v2] net: gemini: Fix missing free_netdev() in error path of 
gemini_ethernet_port_probe()"

