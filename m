Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329A8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1037320888
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="izwm9jk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbgFSDVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:21:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48318 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730863AbgFSDVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:21:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592536867; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: To: From:
 Subject: Sender; bh=HoBIv8pNYmm6s5yZQ4hfjvjnNhMkJF2iNGsFnvBroqM=; b=izwm9jk3gy60Ahmpjo6vwYx7o0a1t6LAbkPIDMUOseg4JGNeTusUjWotH67yoYZBnVq5kSLb
 IuhNRn2L3554+TNhMdsldH+7m8Nz7+gyVA8VZ9IMA+BB89BeZ0QOyKSPdr+mpsUOMhi4zK0l
 cZS7HS5R3B3TSn7MV4TgFiysyoM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5eec2f1a3a8a8b20b854e1f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Jun 2020 03:20:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9FCC1C43391; Fri, 19 Jun 2020 03:20:58 +0000 (UTC)
Received: from [192.168.0.101] (unknown [49.207.137.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sivaprak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 199E0C433C8;
        Fri, 19 Jun 2020 03:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 199E0C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sivaprak@codeaurora.org
Subject: Re: [PATCH V3 0/5] Enable USB support in IPQ8074
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1591625479-4483-1-git-send-email-sivaprak@codeaurora.org>
 <5e392fe0-c8aa-4cef-d04b-0209b504c75d@codeaurora.org>
Message-ID: <20cbe93c-1c04-c214-9c25-77650f44dd5e@codeaurora.org>
Date:   Fri, 19 Jun 2020 08:50:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5e392fe0-c8aa-4cef-d04b-0209b504c75d@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod, Bjorn

This series is completely reviewed and acked now, can you

take this for merging?

On 6/16/2020 3:57 PM, Sivaprakash Murugesan wrote:
> Ping!
>
> Hi Vinod,
>
> can you please review this patch series?
>
> On 6/8/2020 7:41 PM, Sivaprakash Murugesan wrote:
>> IPQ8074 has two super speed USB ports, with QMP and QUSB2 PHYs.
>> This patch set enables the USB PHYs and USB dwc3 in IPQ8074.
>>
>> [V3]
>>   * Rebased patch 3 on 5.7 and linux-next tag next-20200608
>> [V2]
>>   * Added new device compatible qcom,ipq8074-qusb2-phy for qusb2
>>   * Addressed Bjorn's review comments on dts and binding
>>
>> Sivaprakash Murugesan (5):
>>    dt-bindings: phy: qcom,qmp: Add ipq8074 usb dt bindings
>>    dt-bindings: phy: qcom,qusb2: Add ipq8074 device compatible
>>    phy: qcom-qmp: Add USB QMP PHY support for IPQ8074
>>    phy: qcom-qusb2: Add ipq8074 device compatible
>>    arm64: dts: ipq8074: enable USB support
>>
>>   .../devicetree/bindings/phy/qcom,qmp-phy.yaml |   2 +
>>   .../devicetree/bindings/phy/qcom,qusb2-phy.yaml |   1 +
>>   arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          | 24 +++
>>   arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 167 
>> +++++++++++++++++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp.c                | 102 +++++++++++++
>>   drivers/phy/qualcomm/phy-qcom-qusb2.c |   3 +
>>   6 files changed, 299 insertions(+)
>>
