Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59B6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F1720671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OAPdlR0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgENQYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:24:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15989 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbgENQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:24:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589473489; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=nVgMACd1zvIq4WhGfSju+6OvJNb61oG1e/CVzd4fVNc=; b=OAPdlR0aUGdRjmISPK65wTl8D4BQS8fHYbkX86UGFi3G+hOBTeEoLzS0z81GnY/vtGOtnQrJ
 +BroxJduzBXd6T1778xWMa8cbk+B5+aj50yOJYv68fWpRBroSyTo4dkAcjW9JlxTRpLN7Ksp
 yWWRwgVJuLEllIo7eLd4ooE8bxU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebd70cf.7f6d1a141ce0-smtp-out-n03;
 Thu, 14 May 2020 16:24:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D542FC432C2; Thu, 14 May 2020 16:24:46 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 982E6C433D2;
        Thu, 14 May 2020 16:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 982E6C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [RFC PATCH 3/8] qaic: Create char dev
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, manivannan.sadhasivam@linaro.org,
        bjorn.andersson@linaro.org, wufan@codeaurora.org,
        pratanan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1589465266-20056-1-git-send-email-jhugo@codeaurora.org>
 <1589465266-20056-4-git-send-email-jhugo@codeaurora.org>
 <20200514141211.GA2643665@kroah.com>
 <0421a64a-10f3-08df-9ef1-14fdb570db0d@codeaurora.org>
 <20200514155615.GA2963499@kroah.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <4be546d3-b571-0659-0140-f34ec88f95ff@codeaurora.org>
Date:   Thu, 14 May 2020 10:24:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514155615.GA2963499@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2020 9:56 AM, Greg KH wrote:
> On Thu, May 14, 2020 at 09:05:30AM -0600, Jeffrey Hugo wrote:
>> Wow, thank you for the near immediate response.  I'm am quite impressed.
>>
>> On 5/14/2020 8:12 AM, Greg KH wrote:
>>> On Thu, May 14, 2020 at 08:07:41AM -0600, Jeffrey Hugo wrote:
>>>>    /* Copyright (c) 2019-2020, The Linux Foundation. All rights reserved. */
>>>> +#include <linux/cdev.h>
>>>> +#include <linux/idr.h>
>>>> +#include <linux/list.h>
>>>> +#include <linux/kref.h>
>>>> +#include <linux/mhi.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/msi.h>
>>>> +#include <linux/mutex.h>
>>>>    #include <linux/pci.h>
>>>>    #include <linux/pci_ids.h>
>>>> @@ -13,9 +19,242 @@
>>>>    #define PCI_DEV_AIC100			0xa100
>>>>    #define QAIC_NAME			"Qualcomm Cloud AI 100"
>>>> +#define QAIC_MAX_MINORS			256
>>>
>>> Why have a max?
>>>
>>> Why not just use a misc device so you make the logic a lot simple, no
>>> class or chardev logic to mess with at all.
>>
>> It was our understanding that the preference is not to add new misc devices.
> 
> Huh, who said that?  Not the char/misc maintainer (i.e. me) :)
> 
>> As I go and try to find a supporting reference for that, I cannot find one,
>> so I'm not entirely sure where that idea came from.
>>
>> In addition, we see that the Habana Labs driver also uses chardev, and has
>> chosen the same max.  We assumed that since their driver is already
>> accepted, using the same mechanisms where applicable would be the preferred
>> approach.
> 
> They had good reasons why not to use a chardev and convinced me of it.
> If you can't come up with them, then stick with a misc for now please.

Interesting.  I didn't see any discussion on this.

>> Specific to the max, 256 was chosen as being a factor larger than the
>> largest system we have, therefore we figured it wouldn't be hit for a long
>> while even as we try to have a look at what might happen down the road.
>> Looking at the Habana code, it looks like they have the same value for much
>> of the same reasons, although their usecases may vary from ours somewhat.
> 
> Max numbers for no good reason are not a good thing to have.
> 
>> At this time, I don't think we have a strong requirement for a chardev, so
>> we could investigate a switch over to a misc dev if you would prefer that
>> over following the Habana Labs precedent.  All I ask is a confirmation that
>> is the approach you would like to see going forward after reviewing the
>> above.
> 
> Please use misc.

Ok, will investigate.

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
