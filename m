Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7FFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B76207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIBBoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:44:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbgIBBna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:43:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 54D2D8F0A8BC2F0A7D01;
        Wed,  2 Sep 2020 09:43:28 +0800 (CST)
Received: from [10.74.191.121] (10.74.191.121) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Sep 2020 09:43:22 +0800
Subject: Re: [PATCH net-next] net: sch_generic: aviod concurrent reset and
 enqueue op for lockless qdisc
To:     David Miller <davem@davemloft.net>
CC:     <eric.dumazet@gmail.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <john.fastabend@gmail.com>
References: <1598921718-79505-1-git-send-email-linyunsheng@huawei.com>
 <2d93706f-3ba6-128b-738a-b063216eba6d@gmail.com>
 <2b60e7fd-a86a-89ab-2759-e7a83e0e28cd@huawei.com>
 <20200901.113445.1511774749622784918.davem@davemloft.net>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <70ac88f4-1c35-380d-591e-a5c81eaa2dab@huawei.com>
Date:   Wed, 2 Sep 2020 09:43:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20200901.113445.1511774749622784918.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/2 2:34, David Miller wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Tue, 1 Sep 2020 15:27:44 +0800
> 
>> On 2020/9/1 14:48, Eric Dumazet wrote:
>>> We request Fixes: tag for fixes in networking land.
>>
>> ok.
>>
>> Fixes: 6b3ba9146fe6 ("net: sched: allow qdiscs to handle locking")
> 
> You should repost the patch with the Fixes: tag in order to add it, you
> can't just mention it in this thread.
> 
> And the patch has to change anyways as you were also given other
> feedback from Eric to address as well.

Yes, thanks for the feedback:)

> 
> Thank you.
> .
> 
