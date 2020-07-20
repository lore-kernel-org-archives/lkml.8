Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA62C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24842250E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgGTC1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 22:27:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8329 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbgGTC1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:27:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0AC2B61B87CB122F880B;
        Mon, 20 Jul 2020 10:27:20 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 10:27:10 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1: Ensure accessing the correct RD when
 writing INVALLR
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>
References: <20200709134959.1039-1-yuzenghui@huawei.com>
 <87h7u6xuur.wl-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4d79c6f0-cb38-70fc-93e7-0172417ecbfd@huawei.com>
Date:   Mon, 20 Jul 2020 10:27:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87h7u6xuur.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/7/17 19:07, Marc Zyngier wrote:
> On Thu, 09 Jul 2020 14:49:59 +0100,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> The GICv4.1 spec tells us that it's CONSTRAINED UNPREDICTABLE to issue a
>> register-based invalidation operation for a vPEID not mapped to that RD,
>> or another RD within the same CommonLPIAff group.
>>
>> To follow this rule, commit f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual
>> exclusion between vPE affinity change and RD access") tried to address the
>> race between the RD accesses and the vPE affinity change, but somehow
>> forgot to take GICR_INVALLR into account. Let's take the vpe_lock before
>> evaluating vpe->col_idx to fix it.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> 
> Shouldn't this deserve a Fixes: tag?

Yes, I think a

Fixes: f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual exclusion between 
vPE affinity change and RD access")

should be enough. Should I resend a version with the tag added?


Thanks,
Zenghui
