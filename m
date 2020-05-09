Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE06C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9AA218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgEICND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 22:13:03 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2497 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728158AbgEICND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 22:13:03 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 844D6A4F7C6D3D8EC00B;
        Sat,  9 May 2020 10:13:01 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 9 May 2020 10:13:01 +0800
Received: from [10.173.219.71] (10.173.219.71) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 9 May 2020 10:13:00 +0800
Subject: Re: [PATCH net v1] hinic: fix a bug of ndo_stop
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
References: <20200507182227.20553-1-luobin9@huawei.com>
 <20200508142434.0c437e43@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   "luobin (L)" <luobin9@huawei.com>
Message-ID: <39a37452-c743-d1b5-d9dd-83d3058ee217@huawei.com>
Date:   Sat, 9 May 2020 10:13:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200508142434.0c437e43@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.173.219.71]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two modified points are relevant. We bump the timeout for SET_FUNC_STATE

to ensure that cmd won't return failure when hw is busy. Otherwise hw 
may stomp

host memory if we free memory regardless of the return value of 
SET_FUNC_STATE.

I will mention the timeout changes in the commit message. And the bug 
exists since

the first commit, not introduced. Thanks for your review.

On 2020/5/9 5:24, Jakub Kicinski wrote:
> On Thu, 7 May 2020 18:22:27 +0000 Luo bin wrote:
>> if some function in ndo_stop interface returns failure because of
>> hardware fault, must go on excuting rest steps rather than return
>> failure directly, otherwise will cause memory leak
>>
>> Signed-off-by: Luo bin <luobin9@huawei.com>
> The code looks good, but would it make sense to split this patch into
> two? First one that ignores the return values on close path with these
> fixes tags:
>
> Fixes: e2585ea77538 ("net-next/hinic: Add Rx handler")
> Fixes: c4d06d2d208a ("net-next/hinic: Add Rx mode and link event handler")
>
> And a separate patch which bumps the timeout for SET_FUNC_STATE? Right
> now you don't even mention the timeout changes in the commit message.
> .
