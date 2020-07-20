Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534AEC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2414C2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dqyRVB5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGTJCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:02:10 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53658 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgGTJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:02:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595235729; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=zHN3yyOoB+/6mEYmNshsBTczmFu7lRzATlYwvFIc5ko=; b=dqyRVB5nQuTZdeaXUQvKBfdiKX6k2YTfyljXWNQgsXZTOzDoIievLIuO8MLm/TvipimlQNxk
 2o+rAY12NdpuolkNTRamfk5HyBTr/hI6+OCdpcwamrhb5q18EGyq1+2ukGK7qIumZ7h8guN6
 02jyxloz4fUvqQG6EGBaXUs2zZE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5f155d70e3bee125101807a5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 09:01:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2308EC4339C; Mon, 20 Jul 2020 09:01:35 +0000 (UTC)
Received: from [192.168.0.12] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDC02C433C6;
        Mon, 20 Jul 2020 09:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDC02C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH] soc: qcom: geni: Fix NULL pointer dereference
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        saipraka@codeaurora.org, msavaliy@codeaurora.org
References: <1594996342-26964-1-git-send-email-akashast@codeaurora.org>
 <20200717144840.GT3191083@google.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <238543d2-60fc-8c76-e345-a9de04a7562c@codeaurora.org>
Date:   Mon, 20 Jul 2020 14:31:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717144840.GT3191083@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 7/17/2020 8:18 PM, Matthias Kaehlcke wrote:
> Please make sure to cc the linux-arm-msm@vger list for patches of
> Qualcomm code.
Sure.
> On Fri, Jul 17, 2020 at 08:02:22PM +0530, Akash Asthana wrote:
>> pdev struct doesn't exits for the devices whose status are disabled
> s/exits/exist/
ok
>
>> from DT node, in such cases NULL is returned from 'of_find_device_by_node'
>> Later when we try to get drvdata from pdev struct NULL pointer dereference
>> is triggered.
>>
>> Add a NULL check for return values to fix the issue.
>>
>> We were hitting this issue when one of QUP is disabled.
>>
>> Fixes: 048eb908a1f2 ("soc: qcom-geni-se: Add interconnect support to fix earlycon crash")
>> Reported-by: Sai Prakash Ranjan <saipraka@codeaurora.org>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
>> ---
>>   drivers/soc/qcom/qcom-geni-se.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
>> index 355d503..6e5fe65 100644
>> --- a/drivers/soc/qcom/qcom-geni-se.c
>> +++ b/drivers/soc/qcom/qcom-geni-se.c
>> @@ -820,6 +820,7 @@ void geni_remove_earlycon_icc_vote(void)
>>   	struct geni_wrapper *wrapper;
>>   	struct device_node *parent;
>>   	struct device_node *child;
>> +	struct platform_device *wrapper_pdev;
> nit: since there is no other 'pdev' in this function you could just name
> it 'pdev', which is less clunky. The variable is only used immediately
> after it is assigned, so it's clear from the context that it refers to
> the 'wrapper'.

ok

Thankyou for review!.


regards,

Akash

>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

