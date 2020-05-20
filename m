Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF54BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC451207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="I4xNE42d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgETSnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:43:20 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:55440 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbgETSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:43:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590000199; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0P2VQJRaXtfQ2Tc7Ubm5P15zd9+AUrdFPbZkwYBI0Lc=;
 b=I4xNE42dprydcqPMSYAVMSmEE1b1x4yGptEqBIXLRmBEEimuy1/5O72d8sM5jmmrrzMGhvQ2
 QL91CC5y+LPXkf1HbbtMBdcSYpSGRmOKzF7eRi5SRWhS1HEr2j/QPlED+LpdVxw128WlcjPW
 x6EnKZ3dq7SIIj78umsTORzGG54=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec57a38.7f21c8d76068-smtp-out-n02;
 Wed, 20 May 2020 18:43:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4FD1C433C8; Wed, 20 May 2020 18:43:03 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2846FC433C9;
        Wed, 20 May 2020 18:43:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 May 2020 11:43:03 -0700
From:   bbhatt@codeaurora.org
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] bus: mhi: core: Introduce independent voting
 mechanism
In-Reply-To: <a12e693d-a8bb-3ecf-e799-c46de7429b5d@codeaurora.org>
References: <1589832241-13867-1-git-send-email-bbhatt@codeaurora.org>
 <1589832241-13867-3-git-send-email-bbhatt@codeaurora.org>
 <a12e693d-a8bb-3ecf-e799-c46de7429b5d@codeaurora.org>
Message-ID: <574a4fe915f86608b59f10577eb960e9@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-20 09:54, Jeffrey Hugo wrote:
> On 5/18/2020 2:03 PM, Bhaumik Bhatt wrote:
>> Allow independent votes from clients such that they can choose to vote
>> for either the device or the bus or both. This helps in cases where 
>> the
>> device supports autonomous low power mode wherein it can move to M2
>> state without the need to notify the host. Clients can also vote only 
>> to
>> keep the underlying bus active without having the device in M0 state 
>> to
>> support offload use cases.
>> 
>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> ---
> 
> I wonder, why doesn't this fit with runtimePM?
Hi Jeff,

Can you elaborate?

In short, with this patch, MHI just wants to give controller the option 
to
choose the vote type so we can implement autonomous low power mode 
entries
on both host and device.

Let us know if you need some more information.

Thanks,
Bhaumik
