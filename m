Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9F8C38A29
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7F0214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDTBFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:05:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49350 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbgDTBFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:05:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 131943B4B51D164DD656;
        Mon, 20 Apr 2020 09:04:58 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 09:04:48 +0800
Subject: Re: [PATCH net-next 01/10] net: hns3: split out
 hclge_fd_check_ether_tuple()
To:     David Miller <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>, <shenjian15@huawei.com>
References: <1587192429-11463-1-git-send-email-tanhuazhong@huawei.com>
 <1587192429-11463-2-git-send-email-tanhuazhong@huawei.com>
 <20200418.201746.783676213458110248.davem@davemloft.net>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <d6cdcc43-94a9-318c-fec1-b26b0eb70015@huawei.com>
Date:   Mon, 20 Apr 2020 09:04:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200418.201746.783676213458110248.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/19 11:17, David Miller wrote:
> From: Huazhong Tan <tanhuazhong@huawei.com>
> Date: Sat, 18 Apr 2020 14:47:00 +0800
> 
>> +static int hclge_fd_check_spec(struct hclge_dev *hdev,
>> +			       struct ethtool_rx_flow_spec *fs,
>> +			       u32 *unused_tuple)
>> +{
>> +	int ret = 0;
> 
> There is no code path that uses 'ret' without it first being
> assigned.  If I let this code in, then someone is going to
> submit a fixup patch removing the initialization.
> 

Yes, will modify it.
Thanks.

> .
> 

