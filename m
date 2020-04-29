Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABE4C83009
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6CD206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dwdHcP3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgD2OPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:15:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:13811 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbgD2OPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:15:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588169745; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=bIN4xF93iRJ+VRYE4AruY+YqNKP4UWPj3P+2URriqLk=; b=dwdHcP3p5JDWQ2CSVB+A9jznWY+bkXjCbov3bt0U8Es4b2am4jnteOiLixUuMehuqKRNYCZZ
 4SFH50IIEhEsYIM0UzimOiuKSetY35Zqk8ks/m/qYfI2pvbMmYusDIxGRi9riBDoxALNCgi4
 qx0j9Vw0yJmDhHSi+c8iIpjKHzA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea98c06.7f7375cb6688-smtp-out-n03;
 Wed, 29 Apr 2020 14:15:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 623D7C43636; Wed, 29 Apr 2020 14:15:33 +0000 (UTC)
Received: from [10.131.182.194] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB73FC432C2;
        Wed, 29 Apr 2020 14:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB73FC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 03/17] arm64: dts: sdm845: Add OPP table for all qup
 devices
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-4-git-send-email-rnayak@codeaurora.org>
 <20200429000234.GK4525@google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <fe4b60f9-8aa6-0173-a67f-2f0f8451ad85@codeaurora.org>
Date:   Wed, 29 Apr 2020 19:45:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429000234.GK4525@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/29/2020 5:32 AM, Matthias Kaehlcke wrote:
> Hi Rajendra,
> 
> On Tue, Apr 28, 2020 at 07:02:51PM +0530, Rajendra Nayak wrote:
>> qup has a requirement to vote on the performance state of the CX domain
>> in sdm845 devices. Add OPP tables for these and also add power-domains
>> property for all qup instances.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 115 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 115 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 8f926b5..36b9fb1 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -804,6 +804,25 @@
>>   			clock-names = "core";
>>   		};
>>   
>> +		qup_opp_table: qup-opp-table {
>> +			compatible = "operating-points-v2";
>> +
>> +			opp-19200000 {
>> +				opp-hz = /bits/ 64 <19200000>;
>> +				required-opps = <&rpmhpd_opp_min_svs>;
>> +			};
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
>> +		};
>> +
> 
> Judging from SDM845 (which has more OPP tables) the convention seems to be
> to add OPP tables to the nodes that use them, which seems reasonable and
> keeps them out of the device list.
> 
> Unfortunately this convention isn't completely suitable for cases like this
> (and the DSI OPPs later in this series), where the same OPP table is used by
> multiple devices. A possible compromise would be to add the table to the
> node of the first device that uses them.

Sounds fair, I will do that and respin. Thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
