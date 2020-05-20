Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C846C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144D420578
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgETDGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:06:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55408 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbgETDGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:06:48 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 94CA74A8013FC1636D76;
        Wed, 20 May 2020 11:06:45 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 20 May 2020
 11:06:40 +0800
Subject: Re: [PATCH] firmware: arm_sdei: remove unused interfaces
To:     James Morse <james.morse@arm.com>, Christoph Hellwig <hch@lst.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200504164224.2842960-1-hch@lst.de>
 <7c127e49-b1c6-c7ac-69bf-9fc0a6dba4c4@arm.com>
 <6d0adc02-bcd8-2217-c145-d609528fbe77@huawei.com>
 <0ac1444b-bbdf-1efb-54e6-db90fe6ac707@arm.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <f3944635-39d3-f68c-9adb-9471e51ee3be@huawei.com>
Date:   Wed, 20 May 2020 11:06:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0ac1444b-bbdf-1efb-54e6-db90fe6ac707@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2020/5/19 23:47, James Morse wrote:
> Hi Xiongfeng,
> 
> On 05/05/2020 03:08, Xiongfeng Wang wrote:
>> On 2020/5/5 1:14, James Morse wrote:
>>> Hi Christoph,
>>>
>>> (CC: +Xiongfeng)
>>>
>>> Thanks for the reminder - I was just searching for who was using this.
>>
>> Thanks for CC me. We do have a driver that are using it.
> 
>>> On 04/05/2020 17:42, Christoph Hellwig wrote:
>>>> The export symbols to register/unregister and enable/disable events
>>>> aren't ever used outside of arm_sdei.c, so mark them static.
>>>
>>> Xiongfeng, you have drivers using this, could they be posted upstream. Or can we stop
>>> exporting these?
>>
>> It's the SDEI Wathchdog which is used for hardlockup detection. But I wasn't
>> able to push it upstream because we have Pseudo-NMI in mainline.
> 
> Hmm, that shouldn't be directly relevant, unless your SDEI watchdog is using the
> bindable-irq thing?

Yes, we are using the bindable-irq thing. It's easier for the UEFI team.
Firmware doesn't need to too much modification.

> 
> 
> If your firmware offers an event-id for the watchdog, please upstream the driver. Half of
> the event-id space is reserved for vendor stuff like this.

My origin thought is using a new event-id. But the firmware guys are new to SDEI
and don't know how to add a new event-id.

> 
> If firmware needs to be told to re-configure the watchdog irq to make this work, then pNMI
> is a much better fit. Having firmware and linux modifying the irqchip hardware is a
> nightmare best avoided.
> 

Yes, we are using the secure timer irq as the watchdog irq. So the firmware
needs to disable and enable the irq when we disable and enable the event. But
linux don't need to modify the irqchip hardware about the secure timer irq.

All works well except the kdump situation. Because in sdei_handler the secure
timer irq, which is routed to EL3, remains active. We clear the EOI when we
complete the event. So when we panic and start kdump in sdei_handler, the EL2
interrupt of the second kernel can not be taken. We add a hack to clear the EOI
before start kdump.

Yes, the pNMI is a much better fit. We don't need such a hack. But the product
department seems to have get used to the SDEI watchdog method. It works well and
they don't want much change.

Thanks,
Xiongfeng

> 
>>> (they were originally added for the GHES RAS thing, but by the time it was all merged
>>> upstream, it wasn't possible to build it as a module)
>>
>> The SDEI Watchdog driver also can't be built as a module. We still need to
>> modify the origin kernel. So I think this patch doesn't affect me. Thanks for CC me.
> 
> Okay, I'll pick this up to drop the module exports.
> 
> I'd prefer not to make all this static as these register/unregister calls are the
> interface that is supposed to be used. If we are going to gut it, we should do it completely.
> 
> 
> Thanks,
> 
> James
> 
> .
> 

