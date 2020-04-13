Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C67C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B97220767
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="R3fv68Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgDMOCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:02:49 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:20709 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730228AbgDMOCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:02:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586786565; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=N0n8kdCEFen4uzBPsMM4YzWOmJWKxXpHF1vXpG7UtR0=; b=R3fv68QrFiazsjg+ojzDv34lNU/ceojWWzO8Ptz+fIknjKRz5VD7MzbuvTK+PXie4NeNLy1E
 lQ+pWaKDREnPJArDfdeZRayMu2IWnvHBSHZIyT0VV5F44F7lkeXNmDERDywm+PgtK4aFiCh3
 7pZYxLJzIR0dRwlpQTFlSzKE3zU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9470c2.7fc7948a5d50-smtp-out-n04;
 Mon, 13 Apr 2020 14:01:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E20D4C432C2; Mon, 13 Apr 2020 14:01:37 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15E67C433F2;
        Mon, 13 Apr 2020 14:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15E67C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 1/5] bus: mhi: core: Handle syserr during power_up
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bhaumik Vasav Bhatt <bbhatt@codeaurora.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1586278230-29565-1-git-send-email-jhugo@codeaurora.org>
 <1586278230-29565-2-git-send-email-jhugo@codeaurora.org>
 <1768ba6e-12c2-7b4f-0f17-44fecc6473b9@codeaurora.org>
 <11d9f35b-b911-7985-8846-0a45904ceed1@codeaurora.org>
 <5c4efe13-42a4-e802-4070-5d9d30b8cac2@codeaurora.org>
 <79feeb0b-0837-c5b6-087d-856c3e238c67@codeaurora.org>
 <20200413133447.GA19124@Mani-XPS-13-9360>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <ee51ae8f-5826-5402-9178-3f2fba1358f8@codeaurora.org>
Date:   Mon, 13 Apr 2020 08:01:36 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200413133447.GA19124@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/2020 7:34 AM, Manivannan Sadhasivam wrote:
> On Fri, Apr 10, 2020 at 03:39:57PM -0600, Jeffrey Hugo wrote:
>> On 4/10/2020 2:37 PM, Bhaumik Vasav Bhatt wrote:
>>> Hi Jeff,
>>>
>>> We will always have the mhi_intvec_handler registered and trigger your
>>> wake_up state event when you write MHI RESET. BHI INTVEC IRQ using
>>> mhi_cntrl->irq[0] is _not_ unregistered once you enter AMSS EE.
>>
>> I understand it is not unregistered.  However mhi_cntrl->irq[0] may be
>> reserved for BHI, and thus only exercised by PBL EE.  Where as,
>> mhi_cntrl->irq[1..N] may be only exercised by AMSS EE. mhi_intvec_handler is
>> not called in response to mhi_cntrl->irq[1..N].
>>
>> Additionally, I re-reviewed the MHI spec, and I don't see where the spec
>> requires the device to issue an interrupt upon completion of the RESET
>> request.
>>
>> Under section 3.5, step 11 states -
>>
>> "The host must poll for the value of the RESET bit to detect the completion
>> of the reset procedure by the device (RESET is set to 0)."
>>
> 
> If this is the scenario then we need to change all of the wait_event_timeout()
> implementation for MHI RESET in current stack to polling.
> 
> Or the interrupt generation is not defined in spec (sheet) but part of the
> existing implementation?

It probably could be considered part of the existing implementation, but 
I'd like to hear from Hemant/Bhaumik.  Wherever we end up, I'd like to 
have the spec match.

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
