Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F032C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DF92084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lAB7tEmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgBDOEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:04:54 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:59729 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727210AbgBDOEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:04:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580825093; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=AYVm5lWqfJDQUHSM0JeCo9evaNtbla9UOu0fjh+4k6g=; b=lAB7tEmToMs4BgyqQ5uw8k/6/tpuThXyfuV6voA2TltbkQdY3FBycTEiAcsbckcubvI9agmx
 ZxRq0RQ7u5p46hj1SP56NzdZSQhwISh7Ne3WMd5/ag5a/tfc69lyVNBnWnKHM/ls1Npac66N
 hIEbG67wg9IcMgpuA+JPv+STKc8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3979f9.7f4c1731c340-smtp-out-n02;
 Tue, 04 Feb 2020 14:04:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9CFD0C447A2; Tue,  4 Feb 2020 14:04:40 +0000 (UTC)
Received: from [192.168.1.5] (unknown [122.164.174.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1AD5AC433CB;
        Tue,  4 Feb 2020 14:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AD5AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH V6 1/5] dt-bindings: pinctrl: qcom: Add ipq6018 pinctrl
 bindings
From:   Sricharan R <sricharan@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Rajkumar Ayyasamy <arajkuma@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        sivaprak@codeaurora.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1579439601-14810-1-git-send-email-sricharan@codeaurora.org>
 <1579439601-14810-2-git-send-email-sricharan@codeaurora.org>
 <20200127154113.GA6904@bogus>
 <422e31d0-f67f-3b10-5d8f-ccc9d6f7dc70@codeaurora.org>
Message-ID: <9acb9b69-fd44-57db-e974-9fee5a1d871f@codeaurora.org>
Date:   Tue, 4 Feb 2020 19:34:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <422e31d0-f67f-3b10-5d8f-ccc9d6f7dc70@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 1/28/2020 10:07 AM, Sricharan R wrote:
> Hi,
> 
> On 1/27/2020 9:11 PM, Rob Herring wrote:
>> On Sun, 19 Jan 2020 18:43:17 +0530, Sricharan R wrote:
>>> Add device tree binding Documentation details for ipq6018
>>> pinctrl driver.
>>>
>>> Co-developed-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
>>> Signed-off-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
>>> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
>>> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
>>> Co-developed-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
>>> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
>>> ---
>>> [V6] 
>>>   * Addressed review comments form Rob.
>>>  .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     | 153 +++++++++++++++++++++
>>>  1 file changed, 153 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
>>>
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> Thanks Rob.
> 
> Hi Linus,
>    The pinctrl driver can now be pulled in.

Any chance this can be taken for 5.6 ?

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
