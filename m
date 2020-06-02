Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA52C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B11220679
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RnmLLWR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFBKr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:47:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59106 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgFBKr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:47:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591094847; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: To:
 Subject: Sender; bh=KmJ3nT5wP6W5LJoeHmFVqVcNCLtBatXw/8h8arB12JM=; b=RnmLLWR0s4SgPma/1nqjh2aWiVXrE4Y1CqHHLas1qjLdyS3kt13W7yS7By+p/GWUtTrclpd5
 pIm5RJf0S+pPBGErWq59/rMP4I6ughdPs4ljKyDbpKvT/3XA8H11KgWHpO0nbPNZEaFW3QgE
 9HrMbwOCS4cNfgYKq0M/uCcoC+0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5ed62e3f8e09c0ae0922b757 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 10:47:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DEB3EC43387; Tue,  2 Jun 2020 10:47:26 +0000 (UTC)
Received: from [192.168.0.100] (unknown [49.207.141.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sivaprak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67E8FC433C9;
        Tue,  2 Jun 2020 10:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67E8FC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sivaprak@codeaurora.org
Subject: Re: [PATCH V6 4/5] clk: qcom: Add ipq6018 apss clock controller
To:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org
References: <1590582292-13314-1-git-send-email-sivaprak@codeaurora.org>
 <1590582292-13314-5-git-send-email-sivaprak@codeaurora.org>
 <159063116486.69627.5280506237179820811@swboyd.mtv.corp.google.com>
 <824cd7bb-0971-d387-4b78-75c36ddf2f66@codeaurora.org>
 <159104019638.69627.9161269856470136421@swboyd.mtv.corp.google.com>
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
Message-ID: <4266555a-5e4f-4340-1b3c-487a70805751@codeaurora.org>
Date:   Tue, 2 Jun 2020 16:17:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <159104019638.69627.9161269856470136421@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/2020 1:06 AM, Stephen Boyd wrote:
> Quoting Sivaprakash Murugesan (2020-06-01 05:41:15)
>> On 5/28/2020 7:29 AM, Stephen Boyd wrote:
>>> Quoting Sivaprakash Murugesan (2020-05-27 05:24:51)
>>>> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
>>>> new file mode 100644
>>>> index 0000000..004f7e1
>>>> --- /dev/null
>>>> +++ b/drivers/clk/qcom/apss-ipq6018.c
>>>> @@ -0,0 +1,106 @@
>>>> +       P_XO,
>>>> +       P_APSS_PLL_EARLY,
>>>> +};
>>>> +
>>>> +static const struct clk_parent_data parents_apcs_alias0_clk_src[] = {
>>>> +       { .fw_name = "xo" },
>>>> +       { .fw_name = "pll" },
>>> This pll clk is not described in the binding. Please add it there.
>> Sorry I did not get this, this PLL is not directly defined in this
>> driver and it comes
>>
>> from dts. do you still want to describe it in binding?
>>
> Yes, there should be a clock-names property for "pll" and a clocks
> property in the binding document. I didn't see that.

These are defined in

https://lkml.org/lkml/2020/5/27/658and

https://lkml.org/lkml/2020/5/27/659

it has been defined as part of mailbox binding, since this driver does

not have a dts node and it is child of apcs mailbox driver.

