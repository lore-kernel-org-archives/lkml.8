Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452B3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DE7221F0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGNGr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:47:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgGNGrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:47:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D3538EC20E012F4A524F;
        Tue, 14 Jul 2020 14:47:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.219) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Jul 2020
 14:47:13 +0800
Subject: Re: [PATCH net-next] rtnetlink: Fix memory(net_device) leak when
 ->newlink fails
To:     David Miller <davem@davemloft.net>
CC:     <kuba@kernel.org>, <jiri@mellanox.com>, <edumazet@google.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200713075528.141235-1-chenweilong@huawei.com>
 <20200713.120206.428449983947812863.davem@davemloft.net>
From:   Weilong Chen <chenweilong@huawei.com>
Message-ID: <e2f6d2c4-26e2-7bef-e0b4-1dcb29300d74@huawei.com>
Date:   Tue, 14 Jul 2020 14:47:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713.120206.428449983947812863.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/14 3:02, David Miller wrote:
> From: Weilong Chen <chenweilong@huawei.com>
> Date: Mon, 13 Jul 2020 15:55:28 +0800
> 
>> When vlan_newlink call register_vlan_dev fails, it might return error
>> with dev->reg_state = NETREG_UNREGISTERED. The rtnl_newlink should
>> free the memory. But currently rtnl_newlink only free the memory which
>> state is NETREG_UNINITIALIZED.
>  ...
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> 
> This needs a Fixes: tag.
> 
> Also, can't this bug happen in mainline too?  It's a bug fix and therefore
> should target 'net' instead of 'net-next'.
>> .
> 
Yes, it can happend in mainline, I'll send a v2 PATCH.

