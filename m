Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBDAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D080207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="APP+6E7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgETToc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:44:32 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31677 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgETToc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:44:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590003871; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=CAOGbNRPH8PavTHVA+eqY2zfyumPm9H6vlGj6V/xRYU=;
 b=APP+6E7jpRbDh4Tx7daMmpU34xMultipu5vTb8y4wuJfEeXsjQxL282jqW6JirJY6y1FskDv
 xJotdgOkpZWiX6c3WjNxSSyJbKGKVNosPwINc7dWmSQGAF+V4qN7eQ0mt1oIPImglTFvgnKs
 4NmREjKSkFbjw0V+gqHOWP4fr0E=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec5889245598550e697656b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 May 2020 19:44:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3A5DC433CB; Wed, 20 May 2020 19:44:17 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DADFC433C9;
        Wed, 20 May 2020 19:44:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 May 2020 12:44:16 -0700
From:   bbhatt@codeaurora.org
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/7] bus: mhi: core: Introduce independent voting
 mechanism
In-Reply-To: <a51d366e-5466-cbd0-b19c-61e76e8671b5@codeaurora.org>
References: <1589832241-13867-1-git-send-email-bbhatt@codeaurora.org>
 <1589832241-13867-3-git-send-email-bbhatt@codeaurora.org>
 <a12e693d-a8bb-3ecf-e799-c46de7429b5d@codeaurora.org>
 <574a4fe915f86608b59f10577eb960e9@codeaurora.org>
 <a51d366e-5466-cbd0-b19c-61e76e8671b5@codeaurora.org>
Message-ID: <70f32d3dfc9dd81163897a57ebe35d02@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-20 12:06, Jeffrey Hugo wrote:
> On 5/20/2020 12:43 PM, bbhatt@codeaurora.org wrote:
>> On 2020-05-20 09:54, Jeffrey Hugo wrote:
>>> On 5/18/2020 2:03 PM, Bhaumik Bhatt wrote:
>>>> Allow independent votes from clients such that they can choose to 
>>>> vote
>>>> for either the device or the bus or both. This helps in cases where 
>>>> the
>>>> device supports autonomous low power mode wherein it can move to M2
>>>> state without the need to notify the host. Clients can also vote 
>>>> only to
>>>> keep the underlying bus active without having the device in M0 state 
>>>> to
>>>> support offload use cases.
>>>> 
>>>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>>> ---
>>> 
>>> I wonder, why doesn't this fit with runtimePM?
>> Hi Jeff,
>> 
>> Can you elaborate?
>> 
>> In short, with this patch, MHI just wants to give controller the 
>> option to
>> choose the vote type so we can implement autonomous low power mode 
>> entries
>> on both host and device.
> 
> So, you are attempting to manage the power mode of the device.  The
> standard mechanism to do so in Linux is runtime pm.
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/driver-api/pm/devices.rst
> 
> I'm no runtime pm expert, but it feels like your whole voting
> mechanism, etc is just reimplemeting that.  Reimplementing the wheel,
> when its been a standard thing that the majority of the kernel uses is
> not usually acceptable.
> 
> IMO, you need some sort of justification why runtime pm is not
> applicable for you, because I'm willing to bet Mani/Greg are going to
> ask the same.
I think we can look at the patch as simply expanding the scope of what 
already exists.

The client here has been calling mhi_device_get/put/sync APIs to gain 
device vote and with
new features yet to come in, this introductory change is only 
re-purposing what voting
means going forward. i.e. allowing individual bus and device votes.

If you're suggesting using runtimePM APIs to replace the newly 
introduced bus vote, it
would be kind of overkill here IMO. Is that what you were getting at? 
Because currently,
we just have controllers use runtimePM and provide callbacks to them.

If you have ideas, we can discuss them.
