Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B39C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62C020731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Q8bW54E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgEHMjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:39:53 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:48918 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727892AbgEHMj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:39:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588941565; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=u9iyFqCAnEb5sRsmgCcPsnxpILU9p4HopBIb8TR6T9U=; b=Q8bW54E6vQvwRAlG1bSTW/aRIjiK7lJIiK99LxBerZE2GUAR3uwgzpjBTWi4seBd/kv9hAd1
 a63RnGB2iwJLdaFfoqXBEweqQD4d9QidWSlPYcYp2xkH6g01cLrE2/bcer1LZYeX4Tu4CUyS
 jTL8RYpBT8JpjsE02BQbN8apyaI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb552ea.7fbc5ef3b8f0-smtp-out-n05;
 Fri, 08 May 2020 12:39:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 964EEC44795; Fri,  8 May 2020 12:39:05 +0000 (UTC)
Received: from [192.168.0.103] (unknown [49.204.184.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CBD6C433BA;
        Fri,  8 May 2020 12:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CBD6C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: Query regarding pseudo nmi support on GIC V3 and request_nmi()
To:     Marc Zyngier <maz@kernel.org>
Cc:     julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org
References: <2a0d5719-b2c7-1287-e0b5-2dd8b1072e49@codeaurora.org>
 <87ftca1z9k.wl-maz@kernel.org>
 <2f41b2e8-925e-3869-da39-fd4ab28ca1b1@codeaurora.org>
 <20200508132740.2d645ea2@why>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <27ecf3b0-4bb4-e89d-2ca9-3828cdcb2834@codeaurora.org>
Date:   Fri, 8 May 2020 18:09:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508132740.2d645ea2@why>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 5/8/2020 5:57 PM, Marc Zyngier wrote:
> On Fri, 8 May 2020 16:36:42 +0530
> Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
> 
>> Hi Marc,
>>
>> On 5/8/2020 4:15 PM, Marc Zyngier wrote:
>>> On Thu, 07 May 2020 17:06:19 +0100,
>>> Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I have one query regarding pseudo NMI support on GIC v3; from what I
>>>> could understand, GIC v3 supports pseudo NMI setup for SPIs and PPIs.
>>>> However the request_nmi() in irq framework requires NMI to be per cpu
>>>> interrupt source (it checks for IRQF_PERCPU). Can you please help
>>>> understand this part, how SPIs can be configured as NMIs, if there is
>>>> a per cpu interrupt source restriction?
>>>
>>> Let me answer your question by another question: what is the semantic
>>> of a NMI if you can't associate it with a particular CPU?
>>>   
>>
>> I was actually thinking of a use case, where, we have a watchdog
>> interrupt (which is a SPI), which is used for detecting software
>> hangs and cause device reset; If that interrupt's current cpu
>> affinity is on a core, where interrupts are disabled, we won't be
>> able to serve it; so, we need to group that interrupt as an fiq;
> 
> Linux doesn't use Group-0 interrupts, as they are strictly secure
> (unless your SoC doesn't have EL3, which I doubt).

Yes, we handle that watchdog interrupt as a Group-0 interrupt, which is 
handled as fiq in EL3.

> 
>> I was thinking, if its feasible to mark that interrupt as pseudo NMI
>> and route it to EL1 as irq. However, looks like that is not the
>> semantic of a NMI and we would need something like pseudo NMI ipi for
>> this.
> 
> Sending a NMI IPI from another NMI handler? Even once I've added these,
> there is no way this will work for that particular scenario. Just look
> at the restrictions we impose on NMIs.
> 

Sending a pseudo NMI IPI (to EL1) from fiq handler (which runs in EL3); 
I will check, but do you think, that might not work?

> Frankly, if all you need to do is to reset the SoC, use EL3 firmware.
> That is what it is for.
> 

Before triggering SoC reset, we want to collect certain  EL1 debug 
information like stack trace for CPUs and other debug information.

> Thanks,
> 
> 	M.
> 

Thanks
Neeraj

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
