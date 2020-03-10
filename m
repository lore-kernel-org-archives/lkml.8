Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E13DC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130A524673
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TgjBmVfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCJIDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:03:15 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:40864 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgCJIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:03:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583827393; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=QBtq7GTfm1XtqD3LNG9Vf7w0jmrC6VQFpurGidPCtd8=; b=TgjBmVfywi1zJizSkrBIli+fREFwUjVvIeOY9WqGHpSLMg/N8LDVR6QcQGLvp32HOwhZgVaR
 XSk2FJnybHp8o7luNQQW6L+FDbQM0AHibggRCC/E40Zb2tMgV+X5vnql4p0RaK5ctrqvxSNg
 qa3GX/mqKgQg63PFqnv8CnF7ZUA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6749c0.7f0020ef89d0-smtp-out-n02;
 Tue, 10 Mar 2020 08:03:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C35CC432C2; Tue, 10 Mar 2020 08:03:12 +0000 (UTC)
Received: from [192.168.0.103] (unknown [183.83.137.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66FBDC433CB;
        Tue, 10 Mar 2020 08:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66FBDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v4 1/4] dt-bindings: Introduce SoC sleep stats bindings
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     evgreen@chromium.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        devicetree@vger.kernel.org
References: <1583752457-21159-1-git-send-email-mkshah@codeaurora.org>
 <1583752457-21159-2-git-send-email-mkshah@codeaurora.org>
 <158377818530.66766.4481786840843320343@swboyd.mtv.corp.google.com>
 <20200309185120.GC1098305@builder>
 <158378046147.66766.9861199454487445583@swboyd.mtv.corp.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <20fccc8f-f224-fed7-a0ca-ac39857027d7@codeaurora.org>
Date:   Tue, 10 Mar 2020 13:33:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158378046147.66766.9861199454487445583@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/10/2020 12:31 AM, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2020-03-09 11:51:20)
>> On Mon 09 Mar 11:23 PDT 2020, Stephen Boyd wrote:
>>
>>> Quoting Maulik Shah (2020-03-09 04:14:14)
>>>> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>>>>
>>>> Add device binding documentation for Qualcomm Technologies, Inc. (QTI)
>>>> SoC sleep stats driver. The driver is used for displaying SoC sleep
>>>> statistic maintained by Always On Processor or Resource Power Manager.
>>>>
>>>> Cc: devicetree@vger.kernel.org
>>>> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>>>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>> ---
>>>>  .../bindings/soc/qcom/soc-sleep-stats.yaml         | 46 ++++++++++++++++++++++
>>>>  1 file changed, 46 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
>>>> new file mode 100644
>>>> index 00000000..7c29c61
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
>>>> @@ -0,0 +1,46 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/soc/qcom/soc-sleep-stats.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm Technologies, Inc. (QTI) SoC sleep stats bindings
>>>> +
>>>> +maintainers:
>>>> +  - Maulik Shah <mkshah@codeaurora.org>
>>>> +  - Lina Iyer <ilina@codeaurora.org>
>>>> +
>>>> +description:
>>>> +  Always On Processor/Resource Power Manager maintains statistics of the SoC
>>>> +  sleep modes involving powering down of the rails and oscillator clock.
>>>> +
>>>> +  Statistics includes SoC sleep mode type, number of times low power mode were
>>>> +  entered, time of last entry, time of last exit and accumulated sleep duration.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - qcom,rpmh-sleep-stats
>>>> +      - qcom,rpm-sleep-stats
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +
>>>> +examples:
>>>> +  # Example of rpmh sleep stats
>>>> +  - |
>>>> +    rpmh_sleep_stats@c3f0000 {
>>>> +      compatible = "qcom,rpmh-sleep-stats";
>>>> +      reg = <0 0xc3f0000 0 0x400>;
>>>> +    };
>>>> +  # Example of rpm sleep stats
>>>> +  - |
>>>> +    rpm_sleep_stats@4690000 {
>>> Node names don't have underscores. It really feels like we should be able
>>> to get away with not having this device node at all. Why can't we have
>>> the rpm message ram be a node that covers the entire range and then have
>>> that either create a platform device for debugfs stats or just have it
>>> register the stat information from whatever driver attaches to that
>>> node?
>>>
>>> Carving this up into multiple nodes and making compatible strings
>>> doesn't seem very useful here because we're essentially making device
>>> nodes in DT for logical software components that exist in the rpm
>>> message ram.
>> It's been a while since I discussed this with Lina, but iirc I opted for
>> the model you suggest and we concluded that it wouldn't fit with the RPM
>> case.
>>
>> And given that, for reasons unknown to me, msgram isn't a single region,
>> but a set of adjacent memory regions, this does seem to represent
>> hardware better.
>>
> I guess there's message ram and code ram or something like that? Maybe
> that's the problem? Either way it sounds like the node name needs to be
> fixed to have dashes and then this is fine to keep. Describing memory
> like this in DT just makes me sad.
Hi,

I will spin v5 with fixing node name.

Thanks,
Maulik

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
