Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FD2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A86206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Enb7s1ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgETTHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:07:16 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38242 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726688AbgETTHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:07:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590001635; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=QXlLEUKSHL/0UjZpVA1wNzA6wRLVED9Vpod9975E1rc=; b=Enb7s1ty908bUHK9DlRFlHpEDcb17XY3g5YQAnnnO71NzECPq/k+7fewqPdRPQMqz1QZHXaU
 2b+wsiyhdFpKkbx951zE2j3o3THqSxehSZF+L6AyAxVFkDhsRoCMOU20dhQMmnsLAwUHYwfg
 eDmMqO+xWkcK18NAYvJI9qpy3Ao=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec57fcd62ee3a3497b55603 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 May 2020 19:06:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E5A5C433C9; Wed, 20 May 2020 19:06:53 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A298C433C8;
        Wed, 20 May 2020 19:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A298C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 2/7] bus: mhi: core: Introduce independent voting
 mechanism
To:     bbhatt@codeaurora.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, linux-kernel@vger.kernel.org
References: <1589832241-13867-1-git-send-email-bbhatt@codeaurora.org>
 <1589832241-13867-3-git-send-email-bbhatt@codeaurora.org>
 <a12e693d-a8bb-3ecf-e799-c46de7429b5d@codeaurora.org>
 <574a4fe915f86608b59f10577eb960e9@codeaurora.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <a51d366e-5466-cbd0-b19c-61e76e8671b5@codeaurora.org>
Date:   Wed, 20 May 2020 13:06:50 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <574a4fe915f86608b59f10577eb960e9@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/2020 12:43 PM, bbhatt@codeaurora.org wrote:
> On 2020-05-20 09:54, Jeffrey Hugo wrote:
>> On 5/18/2020 2:03 PM, Bhaumik Bhatt wrote:
>>> Allow independent votes from clients such that they can choose to vote
>>> for either the device or the bus or both. This helps in cases where the
>>> device supports autonomous low power mode wherein it can move to M2
>>> state without the need to notify the host. Clients can also vote only to
>>> keep the underlying bus active without having the device in M0 state to
>>> support offload use cases.
>>>
>>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>> ---
>>
>> I wonder, why doesn't this fit with runtimePM?
> Hi Jeff,
> 
> Can you elaborate?
> 
> In short, with this patch, MHI just wants to give controller the option to
> choose the vote type so we can implement autonomous low power mode entries
> on both host and device.

So, you are attempting to manage the power mode of the device.  The 
standard mechanism to do so in Linux is runtime pm.

https://elixir.bootlin.com/linux/latest/source/Documentation/driver-api/pm/devices.rst

I'm no runtime pm expert, but it feels like your whole voting mechanism, 
etc is just reimplemeting that.  Reimplementing the wheel, when its been 
a standard thing that the majority of the kernel uses is not usually 
acceptable.

IMO, you need some sort of justification why runtime pm is not 
applicable for you, because I'm willing to bet Mani/Greg are going to 
ask the same.

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
