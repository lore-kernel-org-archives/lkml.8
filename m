Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDEBC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B404D208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XZBZHAde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEHLG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:06:59 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:61466 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbgEHLG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:06:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588936018; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=uh/ZNr9Sq0hE0WrYUJOHIGzp5iAZ7MwJ5z89NMlyi3Y=; b=XZBZHAden3OaS0TRQoyKSe/cGwKf2+uxcS98BQxYcse9UCaNcBPFpwKigNGOKjlk/8LzKacQ
 N9lT6WVDNyHcEwtC7AkjkRq+tDm8qF+avg2skQX86v1IRmuDKKclFo8W518QXn2wq2Co7b45
 eQqL+uLVxb5ZnKRX8+XNILBUwAM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb53d47.7f1cb68aeb20-smtp-out-n01;
 Fri, 08 May 2020 11:06:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D90D1C433D2; Fri,  8 May 2020 11:06:46 +0000 (UTC)
Received: from [192.168.0.103] (unknown [49.204.184.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9790FC433F2;
        Fri,  8 May 2020 11:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9790FC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: Query regarding pseudo nmi support on GIC V3 and request_nmi()
To:     Marc Zyngier <maz@kernel.org>
Cc:     julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org
References: <2a0d5719-b2c7-1287-e0b5-2dd8b1072e49@codeaurora.org>
 <87ftca1z9k.wl-maz@kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <2f41b2e8-925e-3869-da39-fd4ab28ca1b1@codeaurora.org>
Date:   Fri, 8 May 2020 16:36:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ftca1z9k.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 5/8/2020 4:15 PM, Marc Zyngier wrote:
> On Thu, 07 May 2020 17:06:19 +0100,
> Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
>>
>> Hi,
>>
>> I have one query regarding pseudo NMI support on GIC v3; from what I
>> could understand, GIC v3 supports pseudo NMI setup for SPIs and PPIs.
>> However the request_nmi() in irq framework requires NMI to be per cpu
>> interrupt source (it checks for IRQF_PERCPU). Can you please help
>> understand this part, how SPIs can be configured as NMIs, if there is
>> a per cpu interrupt source restriction?
> 
> Let me answer your question by another question: what is the semantic
> of a NMI if you can't associate it with a particular CPU?
>

I was actually thinking of a use case, where, we have a watchdog 
interrupt (which is a SPI), which is used for detecting software hangs
and cause device reset; If that interrupt's current cpu affinity is on a 
core, where interrupts are disabled, we won't be able to serve it; so, 
we need to group that interrupt as an fiq; I was thinking, if its 
feasible to mark that interrupt as pseudo NMI and route it to EL1 as 
irq. However, looks like that is not the semantic of a NMI and we would
need something like pseudo NMI ipi for this.

> We use pseudo-NMI to be able to profile (or detect lockups) within
> sections where normal interrupts cannot fire. If the interrupt can
> end-up on a random CPU (with an unrelated PMU or one that hasn't
> locked up), what have we achieved? Only confusion.
> 
> The whole point is that NMIs have to be tied to a given CPU. For
> SGI/PPI, this is guaranteed by construction. For SPIs, this means that
> the affinity cannot be changed from userspace. IRQF_PERCPU doesn't
> mean much in this context as we don't "broadcast" interrupts, but is
> an indication to the core kernel that the same interrupt cannot be
> taken on another CPU.
> 
> The short of it is that NMIs are only for per-CPU sources. For SPIs,
> that's for PMUs that use SPIs instead of PPIs. Don't use it for
> anything else.
> 

Thank you for the explanation!

> Thanks,
> 
> 	M.
> 

Thanks
Neeraj

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
