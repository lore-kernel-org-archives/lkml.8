Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2116C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C682074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HjmRgKoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgG1LnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:43:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51442 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbgG1LnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:43:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595936596; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: To: From:
 Subject: Sender; bh=C2g3qCsM1rQjNC6Re9u3OWUPrxkKyricosFKiC3IGhw=; b=HjmRgKoVrPlW+CJAcnT3ZGXJq/h99U0JpbtyAZroojGZICK3QK2mHUEpjmpEzmzLx16UsvQM
 CGWd/yqm1Z+/1efKTfxgB6Vnqi05YVkIy6VUqb4IH9KlSMLGxTAsuhy6/vOjZEzZiGW/9QdN
 Zekn+NhrgTm49rOjwDRJ4kijrVA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5f200f54a61bb9e3f5cf3e94 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Jul 2020 11:43:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 175F4C433AD; Tue, 28 Jul 2020 11:43:15 +0000 (UTC)
Received: from [192.168.0.129] (unknown [183.83.142.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A0FBC433C6;
        Tue, 28 Jul 2020 11:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A0FBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v4 00/12] ASoC: qcom: Add support for SC7180 lpass variant
From:   Rohit Kumar <rohitkr@codeaurora.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
 <d1e6d60b-9f00-266d-74ad-8c18bbf8d142@linaro.org>
 <cb02a3d7-a947-852d-739f-a5f4b823f06a@codeaurora.org>
Message-ID: <b5cb020c-4fc8-376f-3308-71bf3a244d26@codeaurora.org>
Date:   Tue, 28 Jul 2020 17:13:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cb02a3d7-a947-852d-739f-a5f4b823f06a@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/2020 3:20 PM, Rohit Kumar wrote:
>
> On 7/24/2020 4:52 PM, Srinivas Kandagatla wrote:
>>
>>
>> On 22/07/2020 11:31, Rohit kumar wrote:
>>> This patch chain add audio support for SC7180 soc by doing the required
>>> modification in existing common lpass-cpu/lpass-platform driver.
>>> This also fixes some concurrency issue.
>>>
>>> Changes since v3:
>>>     - Fixed yaml documentation comments and make dt_binding_check 
>>> issues.
>>>     - Moved general fixes out of sc7180 specific patches as 
>>> suggested by Srinivas.
>>>     - Update clock-names to make it same as existing platforms.
>>>
>>> Ajit Pandey (4):
>>>    ASoC: qcom: Add common array to initialize soc based core clocks
>>>    ASoC: qcom: lpass-platform: Replace card->dev with component->dev
>>>    include: dt-bindings: sound: Add sc7180-lpass bindings header
>>>    ASoC: qcom: lpass-sc7180: Add platform driver for lpass audio
>>>
>>> Rohit kumar (8):
>>>    ASoC: qcom: lpass-cpu: Move ahbix clk to platform specific function
>>>    ASoC: qcom: lpass-platform: fix memory leak
>>>    ASoC: qcom: lpass: Use regmap_field for i2sctl and dmactl registers
>>>    ASoC: qcom: lpass-cpu: fix concurrency issue
>>>    dt-bindings: sound: lpass-cpu: Add sc7180 lpass cpu node
>>>    ASoC: qcom: lpass-cpu: Use platform_get_resource
>>>    ASoC: qcom: lpass-platform: Use platform_get_irq
>>>    dt-bindings: sound: lpass-cpu: Move to yaml format
>>
>>
> Thanks Srini for review and testing.
>
> Mark, I am planning to repost patch07 onwards to address comments by 
> Rob as
>
> there are no comments till patch06 and they are just fixes.

Hello Mark,

Are you planning to review/merge the changes till patch06. If not, I 
will resend those

patches along with comments addressed on patch07 onwards.

Thanks,

Rohit


>
>> Tested this on Dragon Board 410c!
>>
>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> --srini
>>>
>>>   .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |  79 --------
>>>   .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 185 
>>> ++++++++++++++++++
>>>   include/dt-bindings/sound/sc7180-lpass.h           |  10 +
>>>   sound/soc/qcom/Kconfig                             |   5 +
>>>   sound/soc/qcom/Makefile                            |   2 +
>>>   sound/soc/qcom/lpass-apq8016.c                     |  86 ++++++--
>>>   sound/soc/qcom/lpass-cpu.c                         | 204 
>>> ++++++++++---------
>>>   sound/soc/qcom/lpass-ipq806x.c                     |  67 +++++++
>>>   sound/soc/qcom/lpass-lpaif-reg.h                   | 157 
>>> ++++++++-------
>>>   sound/soc/qcom/lpass-platform.c                    | 155 
>>> +++++++++++----
>>>   sound/soc/qcom/lpass-sc7180.c                      | 216 
>>> +++++++++++++++++++++
>>>   sound/soc/qcom/lpass.h                             |  63 +++++-
>>>   12 files changed, 930 insertions(+), 299 deletions(-)
>>>   delete mode 100644 
>>> Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
>>>   create mode 100644 include/dt-bindings/sound/sc7180-lpass.h
>>>   create mode 100644 sound/soc/qcom/lpass-sc7180.c
>>>
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

