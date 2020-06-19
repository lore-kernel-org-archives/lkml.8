Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F9C2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="o9mNFXZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgFSDQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:16:49 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:50932 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbgFSDQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:16:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592536607; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: To:
 Subject: Sender; bh=q2tuf/Vk4dsmpg1GKBEIvHV/O+3tneizdL+4RR6BTFI=; b=o9mNFXZ7u+CaLaeDC9ahK8c6TuCk/waG72bN0rYPngvljgW3wF3HpJWZnPO3gQIADu05pu4x
 Jk2QgWTwRBQMW1pI1rWaQhrbmwTfVrNkO9lDrb1cPrs/G3WDX2x6jGICLC30RIsCHuWqlRmU
 9o1dN2zZNxia4HX8Adpzo4BxXYc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5eec2e1b6bebe35deb142c85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Jun 2020 03:16:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2EE19C433CA; Fri, 19 Jun 2020 03:16:43 +0000 (UTC)
Received: from [192.168.1.6] (unknown [171.78.159.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EDF1C433C9;
        Fri, 19 Jun 2020 03:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EDF1C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH V3 0/5] Enable USB support in IPQ8074
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1591625479-4483-1-git-send-email-sivaprak@codeaurora.org>
From:   Sricharan Ramabadhran <sricharan@codeaurora.org>
Message-ID: <66cea2c1-5638-78c1-991e-89983883214a@codeaurora.org>
Date:   Fri, 19 Jun 2020 08:46:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1591625479-4483-1-git-send-email-sivaprak@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siva,

On 6/8/2020 7:41 PM, Sivaprakash Murugesan wrote:
> IPQ8074 has two super speed USB ports, with QMP and QUSB2 PHYs.
> This patch set enables the USB PHYs and USB dwc3 in IPQ8074.
>
> [V3]
>   * Rebased patch 3 on 5.7 and linux-next tag next-20200608
> [V2]
>   * Added new device compatible qcom,ipq8074-qusb2-phy for qusb2
>   * Addressed Bjorn's review comments on dts and binding
>
> Sivaprakash Murugesan (5):
>    dt-bindings: phy: qcom,qmp: Add ipq8074 usb dt bindings
>    dt-bindings: phy: qcom,qusb2: Add ipq8074 device compatible
>    phy: qcom-qmp: Add USB QMP PHY support for IPQ8074
>    phy: qcom-qusb2: Add ipq8074 device compatible
>    arm64: dts: ipq8074: enable USB support
>
>   .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   2 +
>   .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   1 +
>   arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |  24 +++
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 167 +++++++++++++++++++++
>   drivers/phy/qualcomm/phy-qcom-qmp.c                | 102 +++++++++++++
>   drivers/phy/qualcomm/phy-qcom-qusb2.c              |   3 +
>   6 files changed, 299 insertions(+)

  Tested this series on hk01.c1 for USB mass storage.

  Tested-by: Sricharan R <sricharan@codeaurora.org>

Regards,

  Sricharan



