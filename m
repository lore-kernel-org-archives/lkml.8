Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D313C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D572467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgB0IkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:40:13 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:39212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728440AbgB0IkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:40:13 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 6220AB7C8164880F9630;
        Thu, 27 Feb 2020 16:39:51 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 16:39:51 +0800
Received: from [10.173.219.71] (10.173.219.71) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 27 Feb 2020 16:39:50 +0800
Subject: Re: [PATCH net-next 2/2] hinic: Fix a bug of setting hw_ioctxt
To:     David Miller <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <aviad.krawczyk@huawei.com>, <luoxianjun@huawei.com>
References: <20200218194013.23837-1-luobin9@huawei.com>
 <20200218194013.23837-2-luobin9@huawei.com>
 <20200219.104816.1415899664142388967.davem@davemloft.net>
From:   "luobin (L)" <luobin9@huawei.com>
Message-ID: <09622539-88c1-3731-937c-937f8acaa123@huawei.com>
Date:   Thu, 27 Feb 2020 16:39:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200219.104816.1415899664142388967.davem@davemloft.net>
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

On 2020/2/20 2:48, David Miller wrote:
> From: Luo bin <luobin9@huawei.com>
> Date: Tue, 18 Feb 2020 19:40:13 +0000
>
>> This patch fix the bug of setting hw_ioctxt failed randomly
>>
>> Signed-off-by: Luo bin <luobin9@huawei.com>
> This does not explain what the bug is, how you decided to fix it,
> and why you decided to fix it that way.
> .
