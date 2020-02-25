Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817EFC35DEA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C54421927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgBYCGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 21:06:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58960 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728011AbgBYCGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:06:50 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8828C5E565293787A2F6;
        Tue, 25 Feb 2020 10:06:48 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Feb 2020
 10:06:27 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Clear Valid before writing any bits
 else in VPENDBASER
To:     Marc Zyngier <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Yanlei Jia <jiayanlei@huawei.com>
References: <20200224025029.92-1-yuzenghui@huawei.com>
 <bb7cdb29eda9cf160bcf85a58a9fc63d@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <6ce5c751-6d17-b9ee-4054-edad7de075bf@huawei.com>
Date:   Tue, 25 Feb 2020 10:06:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <bb7cdb29eda9cf160bcf85a58a9fc63d@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/2/25 7:47, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2020-02-24 02:50, Zenghui Yu wrote:
>> The Valid bit must be cleared before changing anything else when writing
>> GICR_VPENDBASER to avoid the UNPREDICTABLE behavior. This is exactly what
>> we've done on 32bit arm, but not on arm64.
> 
> I'm not quite sure how you decide that Valid must be cleared before 
> changing
> anything else. The reason why we do it on 32bit is that we cannot update
> the full 64bit register at once, so we start by clearing Valid so that
> we can update the rest. arm64 doesn't require that.

The problem came out from discussions with our GIC engineers and what we
talked about at that time was IHI 0069E 9.11.36 - the description of the
Valid field:

"Writing a new value to any bit of GICR_VPENDBASER, other than
GICR_VPENDBASER.Valid, when GICR_VPENDBASER.Valid==1 is UNPREDICTABLE."

It looks like we should first clear the Valid and then write something
else. We might have some mis-understanding about this statement..

> 
> For the rest of discussion, let's ignore GICv4.1 32bit support (I'm
> pretty sure nobody cares about that).
> 
>> This works fine on GICv4 where we only clear Valid for a vPE deschedule.
>> With the introduction of GICv4.1, we might also need to talk something 
>> else
>> (e.g., PendingLast, Doorbell) to the redistributor when clearing the 
>> Valid.
>> Let's port the 32bit gicr_write_vpendbaser() to arm64 so that hardware 
>> can
>> do the right thing after descheduling the vPE.
> 
> The spec says that:
> 
> "For a write that writes GICR_VPENDBASER.Valid from 1 to 0, if
> GICR_VPENDBASER.PendingLast is written as 1 then 
> GICR_VPENDBASER.PendingLast
> takes an UNKNOWN value and GICR_VPENDBASER.Doorbell is treated as being 0."
> 
> and
> 
> "When GICR_VPENDBASER.Valid is written from 1 to 0, if there are 
> outstanding
> enabled pending interrupts GICR_VPENDBASER.Doorbell is treated as 0."
> 
> which indicate that PendingLast/Doorbell have to be written at the same 
> time
> as we clear Valid.

Yes. I obviously missed these two points when writing this patch.

> Can you point me to the bit of the v4.1 spec that makes
> this "clear Valid before doing anything else" requirement explicit?

No, nothing in v4.1 spec supports me :-(  The above has been forwarded
to Hisilicon and I will confirm these with them. It would be easy for
hardware to handle the PendingLast/DB when clearing Valid, I think.


Thank you,
Zenghui

