Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C207C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7525B21744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgBZBfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:35:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43918 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729346AbgBZBfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:35:39 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9BD9497D363A8F050052;
        Wed, 26 Feb 2020 09:35:37 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 09:35:28 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Clear Valid before writing any bits
 else in VPENDBASER
To:     Marc Zyngier <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Yanlei Jia <jiayanlei@huawei.com>
References: <20200224025029.92-1-yuzenghui@huawei.com>
 <bb7cdb29eda9cf160bcf85a58a9fc63d@kernel.org>
 <6ce5c751-6d17-b9ee-4054-edad7de075bf@huawei.com>
 <d8d9fbeddfe59574c457b2f803d0af6c@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <22aa4f88-6a32-1204-e428-de1ffc52b600@huawei.com>
Date:   Wed, 26 Feb 2020 09:35:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <d8d9fbeddfe59574c457b2f803d0af6c@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/26 3:45, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2020-02-25 02:06, Zenghui Yu wrote:
>> Hi Marc,
>>
>> On 2020/2/25 7:47, Marc Zyngier wrote:
>>> Hi Zenghui,
>>>
>>> On 2020-02-24 02:50, Zenghui Yu wrote:
>>>> The Valid bit must be cleared before changing anything else when 
>>>> writing
>>>> GICR_VPENDBASER to avoid the UNPREDICTABLE behavior. This is exactly 
>>>> what
>>>> we've done on 32bit arm, but not on arm64.
>>>
>>> I'm not quite sure how you decide that Valid must be cleared before 
>>> changing
>>> anything else. The reason why we do it on 32bit is that we cannot update
>>> the full 64bit register at once, so we start by clearing Valid so that
>>> we can update the rest. arm64 doesn't require that.
>>
>> The problem came out from discussions with our GIC engineers and what we
>> talked about at that time was IHI 0069E 9.11.36 - the description of the
>> Valid field:
>>
>> "Writing a new value to any bit of GICR_VPENDBASER, other than
>> GICR_VPENDBASER.Valid, when GICR_VPENDBASER.Valid==1 is UNPREDICTABLE."
>>
>> It looks like we should first clear the Valid and then write something
>> else. We might have some mis-understanding about this statement..
> 
> So that's the v4.0 version of VPENDBASER. On v4.0, you start by clearing
> Valid, not changing any other bit. Subsequent polling of the leads to
> the PendingLast bit once Dirty clears. The current code follows this
> principle.
> 
>>> For the rest of discussion, let's ignore GICv4.1 32bit support (I'm
>>> pretty sure nobody cares about that).
>>>
>>>> This works fine on GICv4 where we only clear Valid for a vPE 
>>>> deschedule.
>>>> With the introduction of GICv4.1, we might also need to talk 
>>>> something else
>>>> (e.g., PendingLast, Doorbell) to the redistributor when clearing the 
>>>> Valid.
>>>> Let's port the 32bit gicr_write_vpendbaser() to arm64 so that 
>>>> hardware can
>>>> do the right thing after descheduling the vPE.
>>>
>>> The spec says that:
>>>
>>> "For a write that writes GICR_VPENDBASER.Valid from 1 to 0, if
>>> GICR_VPENDBASER.PendingLast is written as 1 then 
>>> GICR_VPENDBASER.PendingLast
>>> takes an UNKNOWN value and GICR_VPENDBASER.Doorbell is treated as 
>>> being 0."
>>>
>>> and
>>>
>>> "When GICR_VPENDBASER.Valid is written from 1 to 0, if there are 
>>> outstanding
>>> enabled pending interrupts GICR_VPENDBASER.Doorbell is treated as 0."
>>>
>>> which indicate that PendingLast/Doorbell have to be written at the 
>>> same time
>>> as we clear Valid.
>>
>> Yes. I obviously missed these two points when writing this patch.
>>
>>> Can you point me to the bit of the v4.1 spec that makes
>>> this "clear Valid before doing anything else" requirement explicit?
>>
>> No, nothing in v4.1 spec supports me :-(  The above has been forwarded
>> to Hisilicon and I will confirm these with them. It would be easy for
>> hardware to handle the PendingLast/DB when clearing Valid, I think.
> 
> v4.1 changes the way VPENDBASER works in a number of way. Clearing Valid 
> allows
> a "handshake": At the point of making the vPE non-resident, to specify the
> expected behaviour of the redistributor once the residency has been 
> completed.
> This includes requesting the doorbell or telling the GIC that we don't 
> care to
> know about PendingLast.
> 
> This is effectively a relaxation of the v4.0 behaviour. I believe the 
> current
> state of the driver matches both specs (not using common code though).

Yes, I agree with all of the above. Thanks for your confirmation and
please ignore this patch.


Thanks,
Zenghui

