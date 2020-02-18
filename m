Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23192C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 06:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018DC21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 06:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgBRGTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 01:19:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10633 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbgBRGTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:19:34 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE0479280B2678BB9764;
        Tue, 18 Feb 2020 14:19:30 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Feb 2020
 14:19:29 +0800
Subject: Re: [PATCH net-next] net: ena: remove set but not used variable
 'rx_ring'
To:     David Miller <davem@davemloft.net>
References: <20200218015951.7224-1-yuehaibing@huawei.com>
 <20200217.215308.783108603461354408.davem@davemloft.net>
CC:     <netanel@amazon.com>, <akiyano@amazon.com>, <gtzalik@amazon.com>,
        <saeedb@amazon.com>, <zorik@amazon.com>, <kuba@kernel.org>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <sameehj@amazon.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <3ac2812b-9e5e-286a-ea65-62d2ec2f6400@huawei.com>
Date:   Tue, 18 Feb 2020 14:19:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200217.215308.783108603461354408.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/18 13:53, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Tue, 18 Feb 2020 09:59:51 +0800
> 
>> drivers/net/ethernet/amazon/ena/ena_netdev.c: In function ena_xdp_xmit_buff:
>> drivers/net/ethernet/amazon/ena/ena_netdev.c:316:19: warning:
>>  variable rx_ring set but not used [-Wunused-but-set-variable]
>>
>> commit 548c4940b9f1 ("net: ena: Implement XDP_TX action")
>> left behind this unused variable.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> This does not apply cleanly to net-next, please respin.

Sorry, this is a duplicate, my bad.
> 
> .
> 

