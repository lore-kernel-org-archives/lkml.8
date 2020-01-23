Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A52C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157C520704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gx7tlueO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAWOoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:44:22 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:29595 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbgAWOoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:44:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579790661; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=HcX2Aw1GwJmH4+E7kYExxM1bSry4/2ZTDPoiiydnMe8=; b=gx7tlueOv0dBKjKqD+jeArrBqXavWie2cB/sbrndOmpYADlAswLD6HdX4PwYo6oPP77xoIg5
 aFjyOfu4UrTMbfBm9/55593i/d1/S8VmGv3SUus1XyOHcDd5dy/S+GHCPxXQmsLMe5nx1LHT
 sBlK8Mf1GiUH52ihtvVqp5vk+yk=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e29b141.7f18538746c0-smtp-out-n03;
 Thu, 23 Jan 2020 14:44:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6827FC447A1; Thu, 23 Jan 2020 14:44:17 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F378CC43383;
        Thu, 23 Jan 2020 14:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F378CC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 05/16] bus: mhi: core: Add support for ringing
 channel/event ring doorbells
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>, smohanad@codeaurora.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        hemantk@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
 <20200123111836.7414-6-manivannan.sadhasivam@linaro.org>
 <CAK8P3a2pZEdsAi6YQ5z3YD=zD1iZLu+WPirhwmxeZ33k7sjkeg@mail.gmail.com>
 <20200123120050.GB8937@mani>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <e56387b3-6588-1153-48bd-ba92b5609769@codeaurora.org>
Date:   Thu, 23 Jan 2020 07:44:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200123120050.GB8937@mani>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/2020 5:00 AM, Manivannan Sadhasivam wrote:
> Hi Arnd,
> 
> On Thu, Jan 23, 2020 at 12:39:06PM +0100, Arnd Bergmann wrote:
>> On Thu, Jan 23, 2020 at 12:19 PM Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:
>>
>>> +int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
>>> +                             void __iomem *base, u32 offset, u32 *out)
>>> +{
>>> +       u32 tmp = readl_relaxed(base + offset);
>> ....
>>> +void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
>>> +                  u32 offset, u32 val)
>>> +{
>>> +       writel_relaxed(val, base + offset);
>>
>> Please avoid using _relaxed accessors by default, and use the regular
>> ones instead. There are a number of things that can go wrong with
>> the relaxed version, so ideally each caller should have a comment
>> explaining why this instance is safe without the barriers and why it
>> matters to not have it.
>>
>> If there are performance critical callers of mhi_read_reg/mhi_write_reg,
>> you could add mhi_read_reg_relaxed/mhi_write_reg_relaxed for those
>> and apply the same rules there.
>>
>> Usually most mmio accesses are only needed for reconfiguration or
>> other slow paths.
>>
> 
> Fair point. I'll defer to readl/writel APIs and I also need to add
> le32_to_cpu/cpu_to_le32 to them.

I would expect we would be using these in the "hot" path.

I'm a bit confused, I thought the convention was to put a comment why a 
barrier was necessary, now we should be putting a comment why a barrier 
is not necessary?


-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
