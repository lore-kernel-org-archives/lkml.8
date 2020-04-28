Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E279AC83003
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F82206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgD1BmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:42:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbgD1BmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 21:42:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 86376842198694EC7F6D;
        Tue, 28 Apr 2020 09:42:12 +0800 (CST)
Received: from [10.166.212.221] (10.166.212.221) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 28 Apr
 2020 09:42:07 +0800
Subject: Re: [PATCH] net: phy: bcm54140: Make a bunch of functions static
To:     David Miller <davem@davemloft.net>
CC:     <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>
References: <20200425084944.152130-1-chentao107@huawei.com>
 <20200427.111459.2101842326845678002.davem@davemloft.net>
From:   "chentao (AS)" <chentao107@huawei.com>
Message-ID: <2ce96c08-c238-62e4-334e-11797bc74725@huawei.com>
Date:   Tue, 28 Apr 2020 09:42:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200427.111459.2101842326845678002.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.166.212.221]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot, i will resubmit the patch.

On 2020/4/28 2:14, David Miller wrote:
> From: ChenTao <chentao107@huawei.com>
> Date: Sat, 25 Apr 2020 16:49:44 +0800
>
>> Fix the following warning:
>>
>> drivers/net/phy/bcm54140.c:663:5: warning:
>> symbol 'bcm54140_did_interrupt' was not declared. Should it be static?
>> drivers/net/phy/bcm54140.c:672:5: warning:
>> symbol 'bcm54140_ack_intr' was not declared. Should it be static?
>> drivers/net/phy/bcm54140.c:684:5: warning:
>> symbol 'bcm54140_config_intr' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: ChenTao <chentao107@huawei.com>
> The appropriate mailing list for networking changes is netdev@vger.kernel.org
> so please resubmit this there.
>
> Thank you.
> .
