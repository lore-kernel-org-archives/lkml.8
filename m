Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0EC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FFEA206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgEKCJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 22:09:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2069 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729085AbgEKCJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:09:19 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 981CAC1B783130818844;
        Mon, 11 May 2020 10:09:15 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 11 May 2020 10:09:15 +0800
Received: from [10.173.219.71] (10.173.219.71) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 11 May 2020 10:09:14 +0800
Subject: Re: [PATCH net v2] hinic: fix a bug of ndo_stop
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
References: <20200508201933.5054-1-luobin9@huawei.com>
 <20200509153758.06f6947f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   "luobin (L)" <luobin9@huawei.com>
Message-ID: <c94de313-5b54-8f39-b036-22e7aa026c23@huawei.com>
Date:   Mon, 11 May 2020 10:09:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200509153758.06f6947f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.173.219.71]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will fix. Thanks.

On 2020/5/10 6:37, Jakub Kicinski wrote:
> On Fri, 8 May 2020 20:19:33 +0000 Luo bin wrote:
>> if some function in ndo_stop interface returns failure because of
>> hardware fault, must go on excuting rest steps rather than return
>> failure directly, otherwise will cause memory leak.And bump the
>> timeout for SET_FUNC_STATE to ensure that cmd won't return failure
>> when hw is busy. Otherwise hw may stomp host memory if we free
>> memory regardless of the return value of SET_FUNC_STATE.
>>
>> Signed-off-by: Luo bin <luobin9@huawei.com>
> Doesn't apply to the net tree:
>
> error: patch failed: drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c:353
> error: drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c: patch does not apply
> error: patch failed: drivers/net/ethernet/huawei/hinic/hinic_main.c:504
> error: drivers/net/ethernet/huawei/hinic/hinic_main.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
> Applying: hinic: fix a bug of ndo_stop
>
> Please also include a Fixes tag when you repost.
> .
