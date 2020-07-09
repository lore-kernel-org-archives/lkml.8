Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0E1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E87820663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BHTdJH/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGIKMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:12:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31019 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgGIKMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:12:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594289569; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: To:
 Subject: Sender; bh=wWq91HAC/ZSJGdVzwMRWL+Q0WO0UCK3z/tPDOpaZ6gU=; b=BHTdJH/wFBRn7Jt5WrDIV170lSicBm9FCA+9GWr/KFGnK/d0vPBT+9IGy1Qw1EfCPl/j1BhO
 2NSwG8ccAulRiKhqJoFWlip9p9cGn6LNzEpYNNR4QPoTgwngZ1b6tjNMQ/tKcluESdtvLGsq
 uXnyeGzRcKQIPLidBsqEujkgkIA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-west-2.postgun.com with SMTP id
 5f06ed9ea33b1a3dd4559642 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Jul 2020 10:12:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BFC65C433C8; Thu,  9 Jul 2020 10:12:45 +0000 (UTC)
Received: from [192.168.0.129] (unknown [183.83.142.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 437E9C433C6;
        Thu,  9 Jul 2020 10:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 437E9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v3 6/8] dt-bindings: sound: lpass-cpu: Add sc7180 lpass
 cpu node
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1594184896-10629-1-git-send-email-rohitkr@codeaurora.org>
 <1594184896-10629-7-git-send-email-rohitkr@codeaurora.org>
 <6b6b0e38-9c04-e065-8a43-ccfec260d60c@linaro.org>
 <430e0d24-c5c2-84ec-fe7b-b6b27192666d@codeaurora.org>
 <de07f84b-40bc-d9ae-932d-623a5e8341e2@linaro.org>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <40ca93fe-5bf0-ace3-4f95-90624d29a409@codeaurora.org>
Date:   Thu, 9 Jul 2020 15:42:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <de07f84b-40bc-d9ae-932d-623a5e8341e2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/9/2020 3:38 PM, Srinivas Kandagatla wrote:
>
>
> On 09/07/2020 11:01, Rohit Kumar wrote:
>>
>> On 7/9/2020 2:57 PM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 08/07/2020 06:08, Rohit kumar wrote:
>>>> Add dt-bindings to support "qcom,lpass-cpu-sc7180" node.
>>>>
>>>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>>>> ---
>>>>   Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt 
>>>> b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>>>> index 32c2cdb..04e34cc 100644
>>>> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>>>> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>>>> @@ -4,7 +4,8 @@ This node models the Qualcomm Technologies 
>>>> Low-Power Audio SubSystem (LPASS).
>>>>     Required properties:
>>>>   -- compatible        : "qcom,lpass-cpu" or "qcom,apq8016-lpass-cpu"
>>>> +- compatible        : "qcom,lpass-cpu" or "qcom,apq8016-lpass-cpu" or
>>>> +              "qcom,lpass-cpu-sc7180"
>>>>   - clocks        : Must contain an entry for each entry in 
>>>> clock-names.
>>>>   - clock-names        : A list which must include the following 
>>>> entries:
>>>>                   * "ahbix-clk"
>>>
>>> Can you also list the clocks that are mandatory for this SoC.
>>>
>>> --srini
>>>
>> Will it be fine if I update it in patch 8 only where we have moved to 
>> yaml format?
>>
> May be reverse the order, Convert to Yaml first and then add sc7180!

Actually Mark suggested to keep yaml change at the end of patch series 
as there

are pending yaml patch reviews and it might take time. If we keep yaml 
change before sc7180

change, then it will get blocked until yaml review. For now, I can 
update in exisiting

documentation. Please suggest.

Thanks

>
> --srini
>> Thanks,
>>
>> Rohit
>>
>>>
>>>>
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

