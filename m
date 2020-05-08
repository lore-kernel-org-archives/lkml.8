Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D86FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522CD206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WMTPq2HS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgEHQQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:16:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21162 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbgEHQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:16:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588954590; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=5CBAgNlB8RMy1a95Pf8iASRN33KBORYnzqPlOCoMdFg=; b=WMTPq2HSNuYZpc/fMb8AzoMstQVllUX/t/+NThYQe4kTLQVCigEwMnwTgSZ9PKGkkxDRLNE/
 4IW4LKcOydee9nHtFzwbLdW65mIXrN9764EnaG9MaNY3LXqZx5YlrSYqBktwL/X0jJkPaHG5
 KP3f4xVoFS1lT5LhngQotRnuCjk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb585c8.7f979756f570-smtp-out-n01;
 Fri, 08 May 2020 16:16:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73E96C44792; Fri,  8 May 2020 16:16:07 +0000 (UTC)
Received: from [192.168.0.103] (unknown [49.204.184.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89227C43636;
        Fri,  8 May 2020 16:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89227C43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: Query regarding pseudo nmi support on GIC V3 and request_nmi()
To:     Marc Zyngier <maz@kernel.org>
Cc:     julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org
References: <2a0d5719-b2c7-1287-e0b5-2dd8b1072e49@codeaurora.org>
 <87ftca1z9k.wl-maz@kernel.org>
 <2f41b2e8-925e-3869-da39-fd4ab28ca1b1@codeaurora.org>
 <20200508132740.2d645ea2@why>
 <27ecf3b0-4bb4-e89d-2ca9-3828cdcb2834@codeaurora.org>
 <20200508135306.1936b09b@why>
 <2f98a5e2-ac5a-1b22-18b8-d8a2261fc42e@codeaurora.org>
 <87eeru1k6d.wl-maz@kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <bc177e2d-5839-3bda-a35b-783ad5e1b3df@codeaurora.org>
Date:   Fri, 8 May 2020 21:46:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87eeru1k6d.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thanks a lot for your comments. I will work on exploring how SDEI can be 
used for it.



Thanks
Neeraj

On 5/8/2020 9:41 PM, Marc Zyngier wrote:
> On Fri, 08 May 2020 14:34:10 +0100,
> Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
>>
>> Hi Marc,
>>
>> On 5/8/2020 6:23 PM, Marc Zyngier wrote:
>>> On Fri, 8 May 2020 18:09:00 +0530
>>> Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
>>>
>>>> Hi Marc,
>>>>
>>>> On 5/8/2020 5:57 PM, Marc Zyngier wrote:
>>>>> On Fri, 8 May 2020 16:36:42 +0530
>>>>> Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
>>>>>     
>>>>>> Hi Marc,
>>>>>>
>>>>>> On 5/8/2020 4:15 PM, Marc Zyngier wrote:
>>>>>>> On Thu, 07 May 2020 17:06:19 +0100,
>>>>>>> Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I have one query regarding pseudo NMI support on GIC v3; from what I
>>>>>>>> could understand, GIC v3 supports pseudo NMI setup for SPIs and PPIs.
>>>>>>>> However the request_nmi() in irq framework requires NMI to be per cpu
>>>>>>>> interrupt source (it checks for IRQF_PERCPU). Can you please help
>>>>>>>> understand this part, how SPIs can be configured as NMIs, if there is
>>>>>>>> a per cpu interrupt source restriction?
>>>>>>>
>>>>>>> Let me answer your question by another question: what is the semantic
>>>>>>> of a NMI if you can't associate it with a particular CPU?
>>>>>>>     >>
>>>>>> I was actually thinking of a use case, where, we have a watchdog
>>>>>> interrupt (which is a SPI), which is used for detecting software
>>>>>> hangs and cause device reset; If that interrupt's current cpu
>>>>>> affinity is on a core, where interrupts are disabled, we won't be
>>>>>> able to serve it; so, we need to group that interrupt as an fiq;
>>>>>
>>>>> Linux doesn't use Group-0 interrupts, as they are strictly secure
>>>>> (unless your SoC doesn't have EL3, which I doubt).
>>>>
>>>> Yes, we handle that watchdog interrupt as a Group-0 interrupt, which
>>>> is handled as fiq in EL3.
>>>>
>>>>>     
>>>>>> I was thinking, if its feasible to mark that interrupt as pseudo
>>>>>> NMI and route it to EL1 as irq. However, looks like that is not the
>>>>>> semantic of a NMI and we would need something like pseudo NMI ipi
>>>>>> for this.
>>>>>
>>>>> Sending a NMI IPI from another NMI handler? Even once I've added
>>>>> these, there is no way this will work for that particular scenario.
>>>>> Just look at the restrictions we impose on NMIs.
>>>>>     
>>>>
>>>> Sending a pseudo NMI IPI (to EL1) from fiq handler (which runs in
>>>> EL3); I will check, but do you think, that might not work?
>>>
>>> How do you know, from EL3, what to write in memory so that the NMI
>>> handler knows what you want to do? Are you going to parse the S1 page
>>> tables? Hard-code the behaviour of some random Linux version in your
>>> legendary non-updatable firmware? This isn't an acceptable behaviour.
>>>
>>
>> Ok, I understand;
>>
>> Initial thought was to use watchdog SPI as pseudo NMI; however, as
>> pseudo NMIs are only per CPU sources, we were exploring the
>> possibility of using an unused ipi (using the work which is done in
>> [1] and [2]  for SGIs) as pseudo NMI, which EL3 sends to EL1, on
>> receiving watchdog fiq. The pseudo NMI handler would collect required
>> debug information, to help indentify the lockup cause. We weren't
>> thinking of communicating any information from EL3 fiq handler to
>> EL1.
> 
> What if the operating system running at EL1/EL2 is *not* Linux?
> 
>>
>> However, from this discussion, I realize that calling irq handler from
>> fiq handler, would not be possible. So, the approach looks flawed.
>>
>> I believe, allowing a non-percpu pseudo NMI is not acceptable to community?
> 
> No, I really don't want to entertain this idea, because the semantics
> are way too loosely defined and you'd end up with everyone wanting
> something mildly different.
> 
>>> An IPI is between two CPUs used by the same SW entitiy. What runs at
>>> EL3 is completely alien to Linux, and so is Linux to EL3. If you want
>>> to IPI, send Group-0 IPIs that are private to the firmware.
>>>
>>
>> Ok got it; however, I wonder what's the use case of sending
>> SGI to EL1, from secure world, using ICC_ASGI1R. I thought it
>> allowed communication between EL1 and EL3; but, looks like I
>> understood in wrong.
> 
> There is what the GIC architecture can do, and there is what is
> sensible for Linux. The GIC allows IPIs from S-to-NS as well as the
> opposite. This doesn't make it a good idea (it actually is a terrible
> idea, and I really hope that future versions of the architecture will
> simply kill the feature).
> 
> The idea was that you'd make SGIs an first class ABI between S and
> NS. Given that the two are developed separately and that nobody ever
> standardised what the SGI numbers mean, this idea is completely dead.
> 
>>
>>> If you want to inject NMI-type exceptions into EL1, you can always try
>>> SDEI (did I actually write this? Help!). But given your use case below,
>>> that wouldn't work either.
>>>
>>
>> Ok.
>>
>>>>> Frankly, if all you need to do is to reset the SoC, use EL3
>>>>> firmware. That is what it is for.
>>>>>     
>>>>
>>>> Before triggering SoC reset, we want to collect certain  EL1 debug
>>>> information like stack trace for CPUs and other debug information.
>>>
>>> Frankly, if you are going to reset the SoC because EL1/EL2 has gone
>>> bust, how can you trust it to do anything sensible when injecting an
>>> interrupt?. Once you take a SPI at EL3, gather whatever state you want
>>> from EL3. Do not involve EL1 at all.
>>>
>>> 	M.
>>>
>>
>> Agree that it might not work for all cases. But, for the cases like,
>> some kernel code is stuck after disabling local irqs; pseudo NMI might
>> still be able to run and capture stack and other debug info, to help
>> detect the cause of lockups.
> 
> And for that we'll have pseudo-NMI IPIs, initiated from the kernel
> itself as part of the normal debugging infrastructure. It is the EL3
> initiated IPI to EL1 that I strongly oppose against. Not to mention
> that if the kernel locks up with PSTATE.I set (which still happens on
> exception entry), the pseudo-NMI won't work either.
> 
> As I said, you only have two options: either implement everything in
> EL3 (and the NS OS doesn't need to know anything at all), or use SDEI
> as the architected way to inject an exception into the NS world (and
> Linux already supports it).
> 
> 	M.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
