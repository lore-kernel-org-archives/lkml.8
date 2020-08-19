Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9404C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F7E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="EWwJdb63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgHSNu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:50:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45266 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbgHSNte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:49:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597844973; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0mtotj0y7f/ujlPF/3BquuIrAPK++4mXpR4ueE77w5Y=;
 b=EWwJdb63BXCa66o/fuatQ3Vf5U28Lga1lSaHzp4fksPhNSpVmPpCCDADoYaQ3tnd0+/8WRak
 lCES+8vdpMNj9ZFHcuCAAswMNjrxB4jP4qc1jPikpGbY8ORcJynu5JWA4x+Vql5a4MIqhERH
 7nKCVfMqZ90yo7AYY3wiVdFD5jY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3d2de6d90407f0b972b868 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 13:49:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1D36C433CB; Wed, 19 Aug 2020 13:49:25 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15974C433C6;
        Wed, 19 Aug 2020 13:49:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Aug 2020 19:19:25 +0530
From:   skakit@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V2 2/3] arm64: dts: qcom: sc7180: Add sleep pin ctrl for
 BT uart
In-Reply-To: <20200817180158.GD2995789@google.com>
References: <1595563082-2353-1-git-send-email-skakit@codeaurora.org>
 <1595563082-2353-3-git-send-email-skakit@codeaurora.org>
 <20200817180158.GD2995789@google.com>
Message-ID: <1cbbc8cf5c918c6a9eee5ef349707fc6@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-17 23:31, Matthias Kaehlcke wrote:
> On Fri, Jul 24, 2020 at 09:28:01AM +0530, satya priya wrote:
>> Add sleep pin ctrl for BT uart, and also change the bias
>> configuration to match Bluetooth module.
>> 
>> Signed-off-by: satya priya <skakit@codeaurora.org>
>> ---
>> Changes in V2:
>>  - This patch adds sleep state for BT UART. Newly added in V2.
>> 
>>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 42 
>> ++++++++++++++++++++++++++++-----
>>  1 file changed, 36 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts 
>> b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> index 26cc491..bc919f2 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> @@ -469,20 +469,50 @@
>> 
>>  &qup_uart3_default {
>>  	pinconf-cts {
>> -		/*
>> -		 * Configure a pull-down on 38 (CTS) to match the pull of
>> -		 * the Bluetooth module.
>> -		 */
>> +		/* Configure no pull on 38 (CTS) to match Bluetooth module */
> 
> Has the pull from the Bluetooth module been removed or did the previous 
> config
> incorrectly claim that the Bluetooth module has a pull-down?
> 

The previous config was incorrect, so we corrected it to match the pull 
of BT.

>>  		pins = "gpio38";
>> +		bias-disable;
>> +	};
>> +
>> +	pinconf-rts {
>> +		/* We'll drive 39 (RTS), so configure pull-down */
>> +		pins = "gpio39";
>> +		drive-strength = <2>;
>>  		bias-pull-down;
>> +	};
>> +
>> +	pinconf-tx {
>> +		/* We'll drive 40 (TX), so no pull */
> 
> The rationales for RTS and TX contradict each other. According to the 
> comment
> the reason to configure a pull-down on RTS is that it is driven by the 
> host.
> Then for TX the reason to configure no pull is that it is driven by the 
> host.
> 
> Please make sure the comments *really* describe the rationale, 
> otherwise they
> are just confusing.

The rationale for RTS is that we don't want it to be floating and want 
to make sure that it is pulled down, to receive bytes. Will modify the 
comment mentioning the same.
