Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1326EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 00:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB182072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 00:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbgEWA4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 20:56:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4891 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387413AbgEWA4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 20:56:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B8093A4BB66DDF1A4655;
        Sat, 23 May 2020 08:56:18 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 23 May 2020
 08:56:08 +0800
Subject: Re: [PATCH net-next 1/5] net: hns3: add support for VF to query ring
 and vector mapping
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>
References: <1590115786-9940-1-git-send-email-tanhuazhong@huawei.com>
 <1590115786-9940-2-git-send-email-tanhuazhong@huawei.com>
 <20200522103907.2eec2b6e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <443b7ad5-b437-f22c-78ca-52fbec0d092a@huawei.com>
Date:   Sat, 23 May 2020 08:56:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200522103907.2eec2b6e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/23 1:39, Jakub Kicinski wrote:
> On Fri, 22 May 2020 10:49:42 +0800 Huazhong Tan wrote:
>> From: Guangbin Huang <huangguangbin2@huawei.com>
>>
>> This patch adds support for VF to query the mapping of ring and
>> vector.
>>
>> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
>> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
>

Hi, Jakub.


> Could you explain a little more what this is doing?

This patch just adds a new type of mailbox for VF to the mapping of ring 
and vector through PF. not a complicated feature;).

> 
> Also what's using this? In the series nothing is making this request.
> 

As mentioned in the cover, "this is needed by the hns3 DPDK VF PMD
driver", current the VF driver of linux kernel does need this info.
Should this also mention in this commit log?

Thanks.

> .
> 

