Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91376C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B897206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Jctgtgx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgD2OSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:18:52 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:14722 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgD2OSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:18:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588169930; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=h0jvRC7HGXaYimqyTJRzfmOTezRJJ7zDAntXQ60QslU=; b=Jctgtgx5P8dCA309UVhffLrxwRylztnskGdbOqA2e+pL1iOOKt7JVusY76c1xv5N8BQsb4U6
 +XA3Hn1rTi6T9C0Ma8cuPJhVbiGLufWmq2eb04zm+iLb6y31LECOMpHFxuwKP/f0Ryl9OqeC
 f245VLK8T+SXuLguWqJ39ucac9I=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea98cb5.7f2e1fdd23e8-smtp-out-n05;
 Wed, 29 Apr 2020 14:18:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5679CC44791; Wed, 29 Apr 2020 14:18:29 +0000 (UTC)
Received: from [10.131.182.194] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 932EDC44792;
        Wed, 29 Apr 2020 14:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 932EDC44792
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 07/17] arm64: dts: sdm845: Add DSI and MDP OPP tables
 and power-domains
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-8-git-send-email-rnayak@codeaurora.org>
 <20200429002705.GM4525@google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <39ccd066-1691-b53d-029b-f6533f18d2e9@codeaurora.org>
Date:   Wed, 29 Apr 2020 19:48:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429002705.GM4525@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/2020 5:57 AM, Matthias Kaehlcke wrote:
> On Tue, Apr 28, 2020 at 07:02:55PM +0530, Rajendra Nayak wrote:
>> Add the OPP tables for DSI and MDP based on the perf state/clk
>> requirements, and add the power-domains property to specify the
>> scalable power domain.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 59 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 36b9fb1..7a625ad 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -3309,6 +3309,59 @@
>>   			#reset-cells = <1>;
>>   		};
>>   
>> +		mdp_opp_table: mdp-opp-table {
>> +			compatible = "operating-points-v2";
>> +
>> +			opp-19200000 {
>> +				opp-hz = /bits/ 64 <19200000>;
>> +				required-opps = <&rpmhpd_opp_min_svs>;
>> +			};
>> +
>> +			opp-171428571 {
>> +				opp-hz = /bits/ 64 <171428571>;
>> +				required-opps = <&rpmhpd_opp_low_svs>;
>> +			};
>> +
>> +			opp-344000000 {
>> +				opp-hz = /bits/ 64 <344000000>;
>> +				required-opps = <&rpmhpd_opp_svs_l1>;
>> +			};
>> +
>> +			opp-430000000 {
>> +				opp-hz = /bits/ 64 <430000000>;
>> +				required-opps = <&rpmhpd_opp_nom>;
>> +			};
>> +		};
> 
> as commented on "[v3,03/17] arm64: dts: sdm845: Add OPP table for all qup
> devices" (https://patchwork.kernel.org/patch/11514693/) this table should
> probably be inside the 'mdp' node.

right, I will move this and the below table inside the device nodes.

> 
>> +
>> +		dsi_opp_table: dsi-opp-table {
>> +			compatible = "operating-points-v2";
>> +
>> +			opp-19200000 {
>> +				opp-hz = /bits/ 64 <19200000>;
>> +				required-opps = <&rpmhpd_opp_min_svs>;
>> +			};
>> +
>> +			opp-180000000 {
>> +				opp-hz = /bits/ 64 <180000000>;
>> +				required-opps = <&rpmhpd_opp_low_svs>;
>> +			};
>> +
>> +			opp-275000000 {
>> +				opp-hz = /bits/ 64 <275000000>;
>> +				required-opps = <&rpmhpd_opp_svs>;
>> +			};
>> +
>> +			opp-328580000 {
>> +				opp-hz = /bits/ 64 <328580000>;
>> +				required-opps = <&rpmhpd_opp_svs_l1>;
>> +			};
>> +
>> +			opp-358000000 {
>> +				opp-hz = /bits/ 64 <358000000>;
>> +				required-opps = <&rpmhpd_opp_nom>;
>> +			};
>> +		};
>> +
> 
> depending on the outcome of the discussion mentioned above this might have
> to move into the 'dsi0' node.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
