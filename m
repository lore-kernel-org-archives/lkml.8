Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B74C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 00:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C20820787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 00:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="B5hC0GXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgDKAqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 20:46:00 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37213 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgDKAqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 20:46:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586565960; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=baG7AxsdPksik3jIsNvIYu8dRq4/IoOL7ZLETdz7QWM=; b=B5hC0GXGPy7JhFvH1W5AdSIglJkQRahJ1us3ON/0xV5uDT+gdzwWrAEtBu7luKxM6JaIbffK
 2EjDO1YrHDMIlcGzxF9aTwM9oks9Sjc9u/6Aq2KzN6Ljsd5ci7x3ZHynRtotmRvjQ3E5cPT0
 VoVysjJUZoZ2Lpjc3sTZhridBEg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e911343.7f2eaf90ed50-smtp-out-n05;
 Sat, 11 Apr 2020 00:45:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 225CAC43636; Sat, 11 Apr 2020 00:45:54 +0000 (UTC)
Received: from [192.168.0.100] (unknown [49.206.125.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sivaprak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48833C433CB;
        Sat, 11 Apr 2020 00:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48833C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sivaprak@codeaurora.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,qmp: Add ipq8074 usb dt
 bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, kishon@ti.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1586543372-13969-1-git-send-email-sivaprak@codeaurora.org>
 <1586543372-13969-2-git-send-email-sivaprak@codeaurora.org>
 <20200410220540.GC20625@builder.lan>
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
Message-ID: <c22e2ccd-3f9d-e0ce-45e5-01cb603c8555@codeaurora.org>
Date:   Sat, 11 Apr 2020 06:15:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200410220540.GC20625@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 4/11/2020 3:35 AM, Bjorn Andersson wrote:
> On Fri 10 Apr 11:29 PDT 2020, Sivaprakash Murugesan wrote:
>
>> Add ipq8074 qmp phy device compatible for usb super speed usb support.
>>
>> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>> index 18a8985..d60c845 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>> @@ -18,6 +18,7 @@ properties:
>>     compatible:
>>       enum:
>>         - qcom,ipq8074-qmp-pcie-phy
>> +      - qcom,ipq8074-qmp-usb-phy
> I believe you're missing a "3" here.
Yes. Will correct it in next patch set.
> Regards,
> Bjorn
>
