Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504A6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBAB20936
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DEGRN5ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGBVBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:01:32 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:42923 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbgGBVBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:01:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593723690; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=MrJDxWrf2N4TbGJfco8+HjKPzeQQULCNLSgOC4TTleI=; b=DEGRN5ijpm4O8TXrT5slKoP7ITFvxB6dhzuwB6nUMo4XPAEXAcT85NGg+kTX5dbFwxUM/86G
 F11LxYsi9w5SBB1WcI3aNG8LgO9MxAo6KGlERAYZGdCf6ZUE+eqUIZZGBI3MV/5Tpko0PvwF
 9Bf4DFG2ImnMhCdqHlSTpu5mxZs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5efe4b13bfb34e631cf7c2de (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 21:01:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54286C433C6; Thu,  2 Jul 2020 21:01:06 +0000 (UTC)
Received: from [192.168.1.117] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C29E8C433C8;
        Thu,  2 Jul 2020 21:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C29E8C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH 1/4] interconnect: qcom: Support bcm-voter-specific TCS
 wait behavior
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200623040814.23791-1-mdtipton@codeaurora.org>
 <20200623040814.23791-2-mdtipton@codeaurora.org>
 <fee03dda-4c17-701b-bb1a-bf9482cc476d@linaro.org>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <9833fdac-2790-d488-e998-93fd077dfb03@codeaurora.org>
Date:   Thu, 2 Jul 2020 14:01:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fee03dda-4c17-701b-bb1a-bf9482cc476d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/2020 2:02 AM, Georgi Djakov wrote:
> Hi Mike,
> 
> On 6/23/20 07:08, Mike Tipton wrote:
>> Currently, all bcm-voters set tcs_cmd::wait=true for the last VCD
>> command in each TCS (AMC, WAKE, and SLEEP). However, some bcm-voters
>> don't need the completion and instead need to optimize for latency. For
>> instance, disabling wait-for-completion in the WAKE set can decrease
>> resume latency and allow for certain operations to occur in parallel
>> with the WAKE TCS triggering. This is only safe in very specific
>> situations. Keep the default behavior of always waiting, but allow it to
>> be overridden in devicetree.
>>
>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>> ---
>>   drivers/interconnect/qcom/bcm-voter.c | 32 ++++++++++++++++++---------
>>   1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> [..]
>> @@ -336,7 +342,11 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   
>>   	voter->dev = &pdev->dev;
>> -	voter->np = pdev->dev.of_node;
>> +	voter->np = np;
>> +
>> +	if (of_property_read_u32(np, "qcom,tcs-wait", &voter->tcs_wait))
> 
> This DT property needs to be documented.
Whoops, will do.

> 
> Thanks,
> Georgi
> 
