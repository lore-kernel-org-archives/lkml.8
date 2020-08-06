Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78CBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 04:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B2522CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 04:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="G9OSkMpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgHFEAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 00:00:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36491 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgHFEAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 00:00:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596686431; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=385LRkURABpjFHvOhGppwgzxlDi5diqKefwwA9AZkPM=; b=G9OSkMpHa6aCV3kJCN3Z4shabNo3Sy9Prz+74Y/npTcdY1sJiWkayl9OijrKsOOAxez6JYv7
 sDnV0Xfkm6h4kxngmgp6npbHDEnYlV3L53zsJ1h0Fmt4FQ0eQRPzw/kQ1JH7SawHlP2JA1lp
 m861n4zV0OTQhLqqr9JqXAdee/4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5f2b804f56dc452789e2b7ef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 Aug 2020 04:00:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 754C9C433A0; Thu,  6 Aug 2020 04:00:14 +0000 (UTC)
Received: from [192.168.0.129] (unknown [183.83.142.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D254C433C6;
        Thu,  6 Aug 2020 03:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D254C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v4 01/12] ASoC: qcom: Add common array to initialize soc
 based core clocks
To:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, plai@codeaurora.org, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, tiwai@suse.com
Cc:     Ajit Pandey <ajitp@codeaurora.org>
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
 <1595413915-17867-2-git-send-email-rohitkr@codeaurora.org>
 <159667391634.1360974.15763918681460437981@swboyd.mtv.corp.google.com>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <989f1d99-3cd0-e725-3f6d-43facf1ec04d@codeaurora.org>
Date:   Thu, 6 Aug 2020 09:29:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159667391634.1360974.15763918681460437981@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen for reviewing.

On 8/6/2020 6:01 AM, Stephen Boyd wrote:
> Quoting Rohit kumar (2020-07-22 03:31:44)
>> From: Ajit Pandey <ajitp@codeaurora.org>
>>
>> LPASS variants have their own soc specific clocks that needs to be
>> enabled for MI2S audio support. Added a common variable in drvdata to
>> initialize such clocks using bulk clk api. Such clock names is
>> defined in variants specific data and needs to fetched during init.
> Why not just get all the clks and not even care about the names of them?
> Use devm_clk_bulk_get_all() for that, unless some clks need to change
> rates?

There is ahbix clk which needs clk rate to be set. Please check below 
patch in

the series for reference

[PATCH v5 02/12] ASoC: qcom: lpass-cpu: Move ahbix clk to platform 
specific function

Thanks,

Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

