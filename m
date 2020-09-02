Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCCC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073B520767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MWQsoGHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIBNQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:16:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58275 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgIBNKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:10:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599052207; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=wBdcPQ/YNiU+WDkJLplCJsZAXQvmVTWpdtx6qvH+ZwA=; b=MWQsoGHWHhFRclmdDj6qIWS2PfvKzai1FcI0B0ZTbrTDh0lKSL/RxPe9lGNJDbVMRyOgYc7V
 8WmsLA0yB54D/51GFsc+jVHK4HJ/UjXSmDxAgJdmOUbXjuXfklPcIaMuQvxZRRWUr8nwxUlS
 Vpn4r78JQOxsAI/Sp5rNBkSY848=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f4f99964f13e63f04e63665 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 13:09:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9C55C43395; Wed,  2 Sep 2020 13:09:41 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10DB5C433C9;
        Wed,  2 Sep 2020 13:09:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Sep 2020 18:39:41 +0530
From:   skakit@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V3 1/3] arm64: dts: sc7180: Add wakeup support over UART
 RX
Message-ID: <e073ccd4fe47ab7e1a61fb201c9f5d84@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2020-08-21 21:56, Matthias Kaehlcke wrote:
> On Thu, Aug 20, 2020 at 07:21:05PM +0530, satya priya wrote:
>> Add the necessary pinctrl and interrupts to make UART
>> wakeup capable.
>> 
>> Signed-off-by: satya priya <skakit@codeaurora.org>
>> Reviewed-by: Akash Asthana <akashast@codeaurora.org>
>> ---
>> Changes in V2:
>>  - As per Matthias's comment added wakeup support for all the UARTs
>>    of SC7180.
>> 
>> Changes in V3:
>>  - No change.
>> 
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 98 
>> ++++++++++++++++++++++++++++++------
>>  1 file changed, 84 insertions(+), 14 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index d46b383..855b13e 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> 
>> ...
>> 
>> +			qup_uart0_sleep: qup-uart0-sleep {
>> +				pinmux {
>> +					pins = "gpio34", "gpio35",
>> +					       "gpio36", "gpio37";
>> +					function = "gpio";
> 
> What is the reason that the GPIO function needs to be selected in sleep 
> mode
> to support wakeup?
> 
> This should be explained in the commit message unless it is evident.

When QUP function is selected in sleep state, RTS/RFR is pulled high as 
soon as we enter suspend and not receiving wakeup bytes from BT SoC to 
wakeup device. Whereas in GPIO mode it is staying low and receiving 
data.

Thanks,
Satya Priya
