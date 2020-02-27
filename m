Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043BFC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF682467B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgB0Ijg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:39:36 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3027 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728440AbgB0Ijf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:39:35 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id E19E8D2589D9E7932342;
        Thu, 27 Feb 2020 16:39:29 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 16:39:15 +0800
Received: from [10.173.219.71] (10.173.219.71) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 27 Feb 2020 16:39:15 +0800
Subject: Re: [PATCH net-next 1/2] hinic: Fix a irq affinity bug
To:     David Miller <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <aviad.krawczyk@huawei.com>, <luoxianjun@huawei.com>
References: <20200218194013.23837-1-luobin9@huawei.com>
 <20200219.104754.1226041715847841139.davem@davemloft.net>
From:   "luobin (L)" <luobin9@huawei.com>
Message-ID: <5797dc75-4f93-77db-9a72-e138cb15a7df@huawei.com>
Date:   Thu, 27 Feb 2020 16:39:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200219.104754.1226041715847841139.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.173.219.71]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David:

Thanks for your reply, we'll fix and resubmit.

On 2020/2/20 2:47, David Miller wrote:
> From: Luo bin <luobin9@huawei.com>
> Date: Tue, 18 Feb 2020 19:40:12 +0000
>
>> do not use a local variable as an input parameter of irq_set_affinity_hint
>>
>> Signed-off-by: Luo bin <luobin9@huawei.com>
> Bug fixes should target 'net' instead of 'net-next'.
>
> Every patch series containing more than one patch should have an appropriate
> header posting.
> .
