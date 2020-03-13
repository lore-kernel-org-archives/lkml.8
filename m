Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EBBC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EDD2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCMI0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:26:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbgCMI0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:26:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 31DAA4712341C184D5EE;
        Fri, 13 Mar 2020 16:25:53 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 13 Mar 2020
 16:25:46 +0800
Subject: Re: [PATCH net-next 0/2] net: hns3: add two optimizations for mailbox
 handling
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>
References: <1584087823-61800-1-git-send-email-tanhuazhong@huawei.com>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <bb37412b-c4a1-bc19-d784-a7693e4d5b0e@huawei.com>
Date:   Fri, 13 Mar 2020 16:25:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1584087823-61800-1-git-send-email-tanhuazhong@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this patchset, will resend it later :)

On 2020/3/13 16:23, Huazhong Tan wrote:
> This patchset includes two code optimizations for mailbox handling.
> 
> Jian Shen (1):
>    net: hns3: add a conversion for mailbox's response code
> 
> Yufeng Mo (1):
>    net: hns3: optimize the message response between pf and vf
> 
>   drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  54 ++-
>   .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 386 ++++++++++-----------
>   .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 306 ++++++++--------
>   .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   4 +-
>   .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  50 +--
>   5 files changed, 414 insertions(+), 386 deletions(-)
> 

