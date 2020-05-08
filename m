Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40307C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155F721775
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="taHZmK6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEHRUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:20:22 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53008 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbgEHRUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:20:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588958421; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=g5t40zAHZN8q4M/OlN3ypjCaSJjppYPdopPDXTJaPxs=; b=taHZmK6x6UptB9hIzjtPy++8H7kEFMcSyQURYDzlU41pG0vMnDi1Irv7cWOfqaGrUo0kOelH
 cVCRyY0jzTNP89JqKkmpVbOcTBYRV8l8d8tU0z006R6GadNVoZO5c8hd72TA4AnkFppzDjsb
 qZIMs0bF+dPaSIiSMkFF3T2n7fw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb594d3.7fb2ee7d5960-smtp-out-n04;
 Fri, 08 May 2020 17:20:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5FC09C433BA; Fri,  8 May 2020 17:20:19 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A4EFC433F2;
        Fri,  8 May 2020 17:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A4EFC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Replace zero-length array with
 flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20200507185016.GA13883@embeddedor>
 <1b3cda25-5f3a-5359-4bf7-d16a8364f545@codeaurora.org>
 <20200508170233.GB23375@embeddedor>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <c4f4fc47-6add-1ba1-9f06-978003e47c4f@codeaurora.org>
Date:   Fri, 8 May 2020 11:20:16 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508170233.GB23375@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/2020 11:02 AM, Gustavo A. R. Silva wrote:
> On Thu, May 07, 2020 at 01:24:57PM -0600, Jeffrey Hugo wrote:
>>>    drivers/dma/qcom/bam_dma.c         |    2 +-
>>>    drivers/firmware/qcom_scm-legacy.c |    2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>
>> Shouldn't these two files be two different patches?
>>
> 
> I believe so... I'll split this patch up into two patches.
> 
> Thanks
> --
> Gustavo
> 

Sounds good to me.  When you do, you can add the following if you like

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
