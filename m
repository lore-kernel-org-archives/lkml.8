Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C0DC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9A72064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PLJc2t2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgF2TFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:05:25 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11897 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729374AbgF2TFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:05:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593457523; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=bTRel+jIaUhGrzbH1i1gBp7pLF2BMvSOKMtXNQCwcs4=; b=PLJc2t2uNW9uJWHvGk5xPmHYKBgkT106snZexwvXA51oiEzjpeAJPjq8+hPHYUw4IhuwAWt2
 JrdBV0+9oqEHphpu8up6MzVy73L+p7nF1DzDSHncchecR7Zzuc54HYJe928SWdGwaZ04C/z2
 9rcpZd9IdXoqTxPId8/OkIL1/Xc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ef9cf8a567385e8e7665deb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 11:24:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69CA3C43391; Mon, 29 Jun 2020 11:24:57 +0000 (UTC)
Received: from [10.50.61.98] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D81E5C433C8;
        Mon, 29 Jun 2020 11:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D81E5C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 04/17] arm64: dts: sc7180: Add OPP table for all qup
 devices
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-5-git-send-email-rnayak@codeaurora.org>
 <20200625151713.GF39073@google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <97dc03e1-48b1-ca69-1fa9-893f147361ad@codeaurora.org>
Date:   Mon, 29 Jun 2020 16:54:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625151713.GF39073@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/2020 8:47 PM, Matthias Kaehlcke wrote:
> Hi Rajendra,
> 
> On Tue, Apr 28, 2020 at 07:02:52PM +0530, Rajendra Nayak wrote:
>> qup has a requirement to vote on the performance state of the CX domain
>> in sc7180 devices. Add OPP tables for these and also add power-domains
>> property for all qup instances.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 79 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 79 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index 998f101..efba600 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -417,6 +417,25 @@
>>   			status = "disabled";
>>   		};
>>   
>> +		qup_opp_table: qup-opp-table {
>> +			compatible = "operating-points-v2";
>> +
>> +			opp-75000000 {
>> +				opp-hz = /bits/ 64 <75000000>;
>> +				required-opps = <&rpmhpd_opp_low_svs>;
>> +			};
>> +
>> +			opp-100000000 {
>> +				opp-hz = /bits/ 64 <100000000>;
>> +				required-opps = <&rpmhpd_opp_svs>;
>> +			};
>> +
>> +			opp-128000000 {
>> +				opp-hz = /bits/ 64 <128000000>;
>> +				required-opps = <&rpmhpd_opp_nom>;
>> +			};
>> +		};
>> +
>>   		qupv3_id_0: geniqup@8c0000 {
>>   			compatible = "qcom,geni-se-qup";
>>   			reg = <0 0x008c0000 0 0x6000>;
> 
> 
> no entries for i2c0?

I have actually wrongly added them for some i2c instances, I need to drop all of them.
geni i2c does not support dvfs, it just uses a fixed clock.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
