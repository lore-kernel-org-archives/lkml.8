Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC787C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BC921582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WZKR3cRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgBDFsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:48:30 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:55110 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgBDFsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:48:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580795309; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=EiJMFgPyy3YCvZepEl1JHjLk0/TYtHhRCO/RQKlEbqc=; b=WZKR3cRPStFiBDXr5RqkgukmHOKY0BEt6LqwSy0QH+Pw1OTsbdOJS4rvO6rAAmi7zbnRF+f7
 xPfITXmSyr3H4+0BNy1ihfZpydNbzhDo6FNFs3qnnXR+LymVOfT2STYpU7aDlCOdQrUYELIz
 0BTJXo5Vtd2uuZz2gMtf1Wp7xh0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3905a7.7f7b07398490-smtp-out-n02;
 Tue, 04 Feb 2020 05:48:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 22BACC4479C; Tue,  4 Feb 2020 05:48:23 +0000 (UTC)
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAFADC433CB;
        Tue,  4 Feb 2020 05:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAFADC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add cpuidle low power states
From:   Maulik Shah <mkshah@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        swboyd@chromium.org, evgreen@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org
References: <1572408318-28681-1-git-send-email-mkshah@codeaurora.org>
 <1572408318-28681-2-git-send-email-mkshah@codeaurora.org>
 <20200121234452.GW89495@google.com>
 <948c046a-5e95-104c-0bc0-f3615edddeca@codeaurora.org>
Message-ID: <f844cc35-8310-75e6-0151-a44be4bb657b@codeaurora.org>
Date:   Tue, 4 Feb 2020 11:18:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <948c046a-5e95-104c-0bc0-f3615edddeca@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

this change is part of series @ 
https://patchwork.kernel.org/cover/11362717/

Thanks,

Maulik


On 1/25/2020 9:09 PM, Maulik Shah wrote:
> Hi Matthias,
>
> Yes, i will post new version very soon.
>
> Thanks,
>
> Maulik
>
>
>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
