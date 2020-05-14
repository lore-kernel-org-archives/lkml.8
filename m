Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C8DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BD9206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QTldCfKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgENFEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:04:09 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53214 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgENFEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:04:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589432645; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+R980JJRad4Bc8DEDwszR3WVoC0lPCn30fDwTzM+pbE=; b=QTldCfKkomrdL5cCtSEJmgVOhf1z77aFTs4J5KGz9ibDOEJ4VrdqIJ0MPlPCM8XMaDepdEws
 10FEyOBwpRnTcz8nW9vWh65R94s1OGFC1fFV72PhJ97+6w80a+KgHBFEwvw4dfKF3ZPg/UfA
 lSCP7m/cbhQDiPw8CCiUzHgfQ0U=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebcd139.7f698f6076f8-smtp-out-n03;
 Thu, 14 May 2020 05:03:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CAFEEC4478C; Thu, 14 May 2020 05:03:52 +0000 (UTC)
Received: from [10.79.166.230] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D756C44791;
        Thu, 14 May 2020 05:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D756C44791
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v5 2/6] spi: spi-geni-qcom: Use OPP API to set clk/perf
 state
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
References: <1589368382-19607-1-git-send-email-rnayak@codeaurora.org>
 <1589368382-19607-3-git-send-email-rnayak@codeaurora.org>
 <20200513190752.GS2165@builder.lan>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <97288c37-66cf-305d-1e62-a0d12b7cba17@codeaurora.org>
Date:   Thu, 14 May 2020 10:33:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513190752.GS2165@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[]..

>>   
>>   	spi->bus_num = -1;
>>   	spi->dev.of_node = dev->of_node;
>> @@ -596,6 +607,9 @@ static int spi_geni_probe(struct platform_device *pdev)
>>   spi_geni_probe_runtime_disable:
>>   	pm_runtime_disable(dev);
>>   	spi_master_put(spi);
>> +	if (mas->se.has_opp_table)
> 
> Why do you need has_opp_table?
> 
> Afaict if dev_pm_opp_of_add_table() returns -ENODEV there's no attached
> opp-table and dev_pm_opp_of_remove_table() is a nop.

Apparently its not. Calling dev_pm_opp_of_remove_table() when dev_pm_opp_of_add_table()
failed causes use-count mismatch.
You can see https://lkml.org/lkml/2020/4/15/18 for more details.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
