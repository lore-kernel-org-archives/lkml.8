Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB9DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250802072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="EXDkkNsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgFJRIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:08:05 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:13113 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728302AbgFJRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:08:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591808883; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=MhG4R5Vs80hCvljeBG9B5Ken60GZ0ZhM2+DRcSqYPJ8=; b=EXDkkNsNPc4QxwmTBLmeastnb4ikZtlIMR6fe+Luv40GY/G7fBpvbcW87rrR2C8jonNMU4pL
 klyki2L+EwXyFs/WvbR9cVAaNChKScPZDOLYJQOBJn1VJ3giVfVJC+xOhI23A1HgS/55uTo3
 Pq8mDkH4KFxw9r8k9zAdWxR49mk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5ee113735866879c764a71e8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Jun 2020 17:08:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 710E3C433CA; Wed, 10 Jun 2020 17:08:02 +0000 (UTC)
Received: from [192.168.0.104] (unknown [183.82.139.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE64CC433C6;
        Wed, 10 Jun 2020 17:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE64CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 2/4] dt-bindings: clock: Add YAML schemas for LPASS
 clocks on SC7180
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org
References: <1589707344-8871-1-git-send-email-tdas@codeaurora.org>
 <1589707344-8871-3-git-send-email-tdas@codeaurora.org>
 <159054910485.88029.14861222587907627358@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <b12652b6-3c82-c5fd-42cc-89bba4a15a01@codeaurora.org>
Date:   Wed, 10 Jun 2020 22:37:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <159054910485.88029.14861222587907627358@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On 5/27/2020 8:41 AM, Stephen Boyd wrote:

>> +  clocks:
>> +    items:
>> +      - description: gcc_lpass_sway clock from GCC
>> +
>> +  clock-names:
>> +    items:
>> +      - const: gcc_lpass_sway
> 
> As said on patch #4, maybe "iface" instead?
> 

Will take care in the next patch.

>> +
>> +  power-domains:
>> +    items:
>> +      - description: LPASS CORE HM GSDCR
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
