Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7859C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C2F206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgHJDBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 23:01:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgHJDBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 23:01:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BB7E56A952D883030327;
        Mon, 10 Aug 2020 11:01:13 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.81) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 10 Aug 2020
 11:01:08 +0800
Subject: Re: [PATCH net] net: qcom/emac: Fix missing clk_disable_unprepare()
 in error path of emac_probe
To:     Timur Tabi <timur@kernel.org>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20200806140647.43099-1-wanghai38@huawei.com>
 <87f41175-689e-f198-aaf6-9b9f04449ed8@kernel.org>
 <df1bad2e-2a6a-ff70-9b91-f18df20aaec8@huawei.com>
 <9ec9b9ab-48d9-9d38-8f58-27e2556c141a@kernel.org>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <8e2e50eb-d747-8c11-7067-9042a0b59aaf@huawei.com>
Date:   Mon, 10 Aug 2020 11:01:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9ec9b9ab-48d9-9d38-8f58-27e2556c141a@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.81]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/8/7 21:38, Timur Tabi 写道:
> On 8/6/20 8:54 PM, wanghai (M) wrote:
>> Thanks for your suggestion. May I fix it like this?
>>
> Yes, this is what I had in mind.  Thanks.
>
> Acked-by: Timur Tabi <timur@kernel.org>
>
> .

Thanks for your ack. I just sent a new patch.

"[PATCH net] net: qcom/emac: add missed clk_disable_unprepare in error 
path of emac_clks_phase1_init"


