Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BDFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D3822B4B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WFOJCR5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbgFTBGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:06:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51643 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731080AbgFTBGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:06:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592615196; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: To:
 Subject: Sender; bh=i+lpbCGwWh2tXc7P76pKSktyAwDvOkm0JAA1VAMKIWs=; b=WFOJCR5sPb8ImYhd40Nrd51wtPMgvHwM58BlrSPw07BuRHmq9ikeDcVXHJYIrFuBB1BIwTgQ
 +qQE0HOHKK7DURMSMp0sFcYMO24v5tns3Ij1hzRtr73wKLk3hOQwemnRmOz5wN8wKnyuxJ2d
 0dgPP0NpHMDzrgzhNF84zik3ODA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5eed6108bfb34e631c865cf6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 20 Jun 2020 01:06:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D393C43387; Sat, 20 Jun 2020 01:06:15 +0000 (UTC)
Received: from [192.168.0.101] (unknown [49.207.137.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sivaprak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6371EC433C8;
        Sat, 20 Jun 2020 01:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6371EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sivaprak@codeaurora.org
Subject: Re: [PATCH V7 1/4] dt-bindings: clock: add ipq6018 a53 pll compatible
To:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org
References: <1591440907-20021-1-git-send-email-sivaprak@codeaurora.org>
 <1591440907-20021-2-git-send-email-sivaprak@codeaurora.org>
 <159261339539.62212.17722723971033735363@swboyd.mtv.corp.google.com>
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
Message-ID: <efef8d40-1c89-76b5-261e-8801e4dbdf51@codeaurora.org>
Date:   Sat, 20 Jun 2020 06:36:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159261339539.62212.17722723971033735363@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/20/2020 6:06 AM, Stephen Boyd wrote:
> Quoting Sivaprakash Murugesan (2020-06-06 03:55:04)
>> cpus on ipq6018 are clocked by a53 pll, add device compatible for a53
>> pll found on ipq6018 devices.
>>
>> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
>> ---
>> [V7]
>>   * Addressed minor review comment from Rob
>>   .../devicetree/bindings/clock/qcom,a53pll.yaml         | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
>> index 20d2638..3161fab 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
>> @@ -15,6 +15,7 @@ description:
>>   
>>   properties:
>>     compatible:
>> +    const: qcom,ipq6018-a53pll
>>       const: qcom,msm8916-a53pll
>>   
>>     reg:
> I'm getting this error when running dt binding check:
>
> ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>    in "<unicode string>", line 18, column 5
> found duplicate key "const" with value "qcom,msm8916-a53pll" (original value: "qcom,ipq6018-a53pll")
>    in "<unicode string>", line 19, column 5

This error started coming after updating the dt-schema version.

Guess I need to replace const with enum to get rid of this error.

will address this.

