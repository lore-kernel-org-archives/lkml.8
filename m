Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F374C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162492081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dYNPjK0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgAMJ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:56:22 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:12168 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgAMJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:56:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578909380; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Q/2ImYuKYZGan94DZJlYZatYbdTBLNMNXpcAS+vGAww=; b=dYNPjK0csn1Nk1nvIwljabkz6Ndk/wne6Uxj6REQpr1BjSw7gbiMadge9AbvvWKda1W5hSsk
 /DfAZh+0K2Gb801lsOx/9Z7qXGmPkiBIzo5htWDnQp1ehrS9vGdFgcv529LFnL1rwiOHS83v
 lSmA4R7MHotkRLLRqwj+LsboWJc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1c3ec3.7f2ac18796c0-smtp-out-n01;
 Mon, 13 Jan 2020 09:56:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70B34C433CB; Mon, 13 Jan 2020 09:56:19 +0000 (UTC)
Received: from [10.206.28.9] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CB59C4479C;
        Mon, 13 Jan 2020 09:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CB59C4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: Add YAML schemas for the QCOM
 MSS clock bindings
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1577421760-1174-1-git-send-email-tdas@codeaurora.org>
 <1577421760-1174-2-git-send-email-tdas@codeaurora.org>
 <5b16d051146224c1efad40c4548dd0c4@codeaurora.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <d4793817-d6bd-b0ab-2b59-2c27c9edbdbe@codeaurora.org>
Date:   Mon, 13 Jan 2020 15:26:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <5b16d051146224c1efad40c4548dd0c4@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sibi, will take care of mapping the entire region.

+      reg = <0x041aa000 0x100>;
> 
> Bjorn/me had a discussion about the size
> a while back, we should use the entire
> reg space instead of fragmenting it.
> 
> reg = <0x041a8000 0x8000>;
> 
> We should just use ^^ instead.
> 
>> +      #clock-cells = <1>;
>> +    };
>> +...
>> -- 
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
