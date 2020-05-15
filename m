Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90EEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE49F206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Z/39Jpll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgEOVJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:09:12 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:39349 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbgEOVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:09:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589576949; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=tMa0XjTHFu9sNkikzcNxomTk26A/Z3fbNKIPFzqYgHI=; b=Z/39Jpll4mjCqh5OZqUX0Uak4PgDbdyrCFDxkziwR4VwOZV1MVACdBt8jzpMdID2RqF9prQg
 LPqSATHN3kptSrttoOTU1IMCaDcDTex3JWTPFBEq2bsH+Cuq5ObDHAyMlPkluW3kQ9bk/p7x
 K0y8gKo+cljKStnuk6QV/PWbF5c=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebf04ee.7f628e639538-smtp-out-n02;
 Fri, 15 May 2020 21:09:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2E1FC43636; Fri, 15 May 2020 21:09:01 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B082CC433F2;
        Fri, 15 May 2020 21:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B082CC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [RFC PATCH 3/8] qaic: Create char dev
From:   Jeffrey Hugo <jhugo@codeaurora.org>
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
 <4be546d3-b571-0659-0140-f34ec88f95ff@codeaurora.org>
Message-ID: <4683046a-c6b5-30a5-ef02-2f610523ae1c@codeaurora.org>
Date:   Fri, 15 May 2020 15:08:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4be546d3-b571-0659-0140-f34ec88f95ff@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2020 10:24 AM, Jeffrey Hugo wrote:
> On 5/14/2020 9:56 AM, Greg KH wrote:
>> Please use misc.
> 
> Ok, will investigate.
> 

Misc looks like it'll work, and I'm expecting to have that in the next 
revision.  However, a few of us looked at misc vs chardev, and didn't 
see much of a difference.

We were hoping you'd be kind enough to educate us on the considerations 
between the two, in-case we missed something that ends up being very 
relevant.  We attempted to find relevant documentation within the 
kernel, and in Linux Device Drivers 3rd edition, but did not find any 
besides just reading the misc dev code.  If we missed something, please 
point us to it.

By going with a misc device, we see two possible limitations -

1. You don't have your own major number, so userspace may have to do a 
bit more work to identify your device.  However, given that the driver 
assigns the device name, one would think that the device name would be 
pretty unique.  So, it seems like this would have a minor impact to udev 
rules.

2. There are a limited number of dynamic minor numbers for misc devs 
(64), so if you are expecting more devices than that, a misc dev is not 
appropiate.  Also, these minors are shared with other misc dev users, so 
depending on the system configuration, you might have significantly less 
than 64 minors available for use.

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
