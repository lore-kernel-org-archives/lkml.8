Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDACCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06E6204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgESPrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:47:32 -0400
Received: from foss.arm.com ([217.140.110.172]:35294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbgESPrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:47:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BC0731B;
        Tue, 19 May 2020 08:47:31 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CB2B3F305;
        Tue, 19 May 2020 08:47:30 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH] firmware: arm_sdei: remove unused interfaces
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200504164224.2842960-1-hch@lst.de>
 <7c127e49-b1c6-c7ac-69bf-9fc0a6dba4c4@arm.com>
 <6d0adc02-bcd8-2217-c145-d609528fbe77@huawei.com>
Message-ID: <0ac1444b-bbdf-1efb-54e6-db90fe6ac707@arm.com>
Date:   Tue, 19 May 2020 16:47:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6d0adc02-bcd8-2217-c145-d609528fbe77@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng,

On 05/05/2020 03:08, Xiongfeng Wang wrote:
> On 2020/5/5 1:14, James Morse wrote:
>> Hi Christoph,
>>
>> (CC: +Xiongfeng)
>>
>> Thanks for the reminder - I was just searching for who was using this.
> 
> Thanks for CC me. We do have a driver that are using it.

>> On 04/05/2020 17:42, Christoph Hellwig wrote:
>>> The export symbols to register/unregister and enable/disable events
>>> aren't ever used outside of arm_sdei.c, so mark them static.
>>
>> Xiongfeng, you have drivers using this, could they be posted upstream. Or can we stop
>> exporting these?
> 
> It's the SDEI Wathchdog which is used for hardlockup detection. But I wasn't
> able to push it upstream because we have Pseudo-NMI in mainline.

Hmm, that shouldn't be directly relevant, unless your SDEI watchdog is using the
bindable-irq thing?


If your firmware offers an event-id for the watchdog, please upstream the driver. Half of
the event-id space is reserved for vendor stuff like this.

If firmware needs to be told to re-configure the watchdog irq to make this work, then pNMI
is a much better fit. Having firmware and linux modifying the irqchip hardware is a
nightmare best avoided.


>> (they were originally added for the GHES RAS thing, but by the time it was all merged
>> upstream, it wasn't possible to build it as a module)
> 
> The SDEI Watchdog driver also can't be built as a module. We still need to
> modify the origin kernel. So I think this patch doesn't affect me. Thanks for CC me.

Okay, I'll pick this up to drop the module exports.

I'd prefer not to make all this static as these register/unregister calls are the
interface that is supposed to be used. If we are going to gut it, we should do it completely.


Thanks,

James
