Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE29C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9742065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nC71oJVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgENQMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:12:23 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:42915 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727935AbgENQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:12:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589472742; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=9xdp9FEZWYqs/Uq972oFma2+9rV0qjU40H3MxXCHi+A=; b=nC71oJVOB6ruU1y0AYl7fPAbb4BD8ULIvdGB70DngRGEHEStkZmaQcoOcE/IlkhjOukHDWu2
 N503p9uvKnbTWYKyAA32iuKfkBkTxPzPKqVYHCQe36NCb63k7ykmbYAGNoLRGEecgVhTEGLj
 5Oov4WuSqDzydvmVQHmRTfKBDhc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ebd6dd6aefa5a01cc1b8293 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 May 2020 16:12:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C210BC44791; Thu, 14 May 2020 16:12:05 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89494C44792;
        Thu, 14 May 2020 16:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89494C44792
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [RFC PATCH 5/8] qaic: Implement data path
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, manivannan.sadhasivam@linaro.org,
        bjorn.andersson@linaro.org, wufan@codeaurora.org,
        pratanan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1589465266-20056-1-git-send-email-jhugo@codeaurora.org>
 <1589465266-20056-6-git-send-email-jhugo@codeaurora.org>
 <20200514141403.GB2643665@kroah.com>
 <2e569e9e-2e5f-a99e-384c-1aaf34d9999e@codeaurora.org>
 <20200514155645.GB2963499@kroah.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <d34d726d-7911-824d-82ac-34358874b103@codeaurora.org>
Date:   Thu, 14 May 2020 10:12:03 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514155645.GB2963499@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2020 9:56 AM, Greg KH wrote:
> On Thu, May 14, 2020 at 09:06:53AM -0600, Jeffrey Hugo wrote:
>> On 5/14/2020 8:14 AM, Greg KH wrote:
>>> On Thu, May 14, 2020 at 08:07:43AM -0600, Jeffrey Hugo wrote:
>>>> +struct qaic_execute {
>>>> +	__u16		ver;    /* struct version, must be 1 */
>>>
>>> No need for structures to be versioned.  If you change something, then
>>> add a new ioctl if you really needed it.
>>
>> Huh.  We had thought the botching ioctls document advised having a version,
>> but as I double check that document, it infact does not.
>>
>> Will remove.
> 
> Thanks, you can also remove the "reserved" variables as well as those
> will not be needed either.

Are you sure?

Documentation/process/botching-up-ioctls.rst
Starting at Line 38:

"Pad the entire struct to a multiple of 64-bits if the structure 
contains 64-bit types - the structure size will otherwise differ on 
32-bit versus 64-bit. Having a different structure size hurts when 
passing arrays of structures to the kernel, or if the kernel checks the 
structure size, which e.g. the drm core does."

The "reserved" variables seem to be in line with that.

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
