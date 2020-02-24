Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F1C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9203520661
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="EFR8Y73l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBXGmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:42:02 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:46897 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbgBXGmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:42:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582526520; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ZfQGMbPq3WH0A2TQD2P6hS1/SkCmFAZG5KtLl2FUbIE=; b=EFR8Y73lbdecf7HylDU0wXtkiHV/n9R5RKyWKVLtWze+2PJ7nXI87mdA2hlHwTBymMBGDovY
 FVlgdaEeYXzmESL7nCCsX44+8eKL7BK/VAAYjvPvKRqqZHNxXwXWXesOaeA+PeUS2n5b3op9
 5s+qAAea9Zv6rR9p9sQJvc8cHzY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e53702f.7f0c08e9a8b8-smtp-out-n01;
 Mon, 24 Feb 2020 06:41:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D800FC4479C; Mon, 24 Feb 2020 06:41:49 +0000 (UTC)
Received: from [10.206.12.145] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lsrao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E356C43383;
        Mon, 24 Feb 2020 06:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E356C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=lsrao@codeaurora.org
Subject: Re: [PATCH v6 1/3] arm64: dts: qcom: sc7180: Add cpuidle low power
 states
To:     Maulik Shah <mkshah@codeaurora.org>, swboyd@chromium.org,
        mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, devicetree@vger.kernel.org
References: <1582277527-19638-1-git-send-email-mkshah@codeaurora.org>
 <1582277527-19638-2-git-send-email-mkshah@codeaurora.org>
From:   Srinivas Rao L <lsrao@codeaurora.org>
Message-ID: <bc99547e-4f9a-a959-fb59-fe0b19216eb0@codeaurora.org>
Date:   Mon, 24 Feb 2020 12:11:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582277527-19638-2-git-send-email-mkshah@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>

Regards,

Srinivas.

On 2/21/2020 3:02 PM, Maulik Shah wrote:
> Add device bindings for cpuidle states for cpu devices.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 78 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 78 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index cc5a94f..2941a7e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -86,6 +86,9 @@
>   			compatible = "arm,armv8";
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_0>;
>   			#cooling-cells = <2>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -103,6 +106,9 @@
>   			compatible = "arm,armv8";
>   			reg = <0x0 0x100>;
>   			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_100>;
>   			#cooling-cells = <2>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -117,6 +123,9 @@
>   			compatible = "arm,armv8";
>   			reg = <0x0 0x200>;
>   			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_200>;
>   			#cooling-cells = <2>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -131,6 +140,9 @@
>   			compatible = "arm,armv8";
>   			reg = <0x0 0x300>;
>   			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_300>;
>   			#cooling-cells = <2>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -145,6 +157,9 @@
>   			compatible = "arm,armv8";
>   			reg = <0x0 0x400>;
>   			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_400>;
>   			#cooling-cells = <2>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -159,6 +174,9 @@
>   			compatible = "arm,armv8";
>   			reg = <0x0 0x500>;
>   			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_500>;
>   			#cooling-cells = <2>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -173,6 +191,9 @@
>   			compatible = "arm,armv8";
>   			reg = <0x0 0x600>;
>   			enable-method = "psci";
> +			cpu-idle-states = <&BIG_CPU_SLEEP_0
> +					   &BIG_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_600>;
>   			#cooling-cells = <2>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
> @@ -187,6 +208,9 @@
>   			compatible = "arm,armv8";
>   			reg = <0x0 0x700>;
>   			enable-method = "psci";
> +			cpu-idle-states = <&BIG_CPU_SLEEP_0
> +					   &BIG_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_700>;
>   			#cooling-cells = <2>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
> @@ -195,6 +219,60 @@
>   				next-level-cache = <&L3_0>;
>   			};
>   		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "little-power-down";
> +				arm,psci-suspend-param = <0x40000003>;
> +				entry-latency-us = <549>;
> +				exit-latency-us = <901>;
> +				min-residency-us = <1774>;
> +				local-timer-stop;
> +			};
> +
> +			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "little-rail-power-down";
> +				arm,psci-suspend-param = <0x40000004>;
> +				entry-latency-us = <702>;
> +				exit-latency-us = <915>;
> +				min-residency-us = <4001>;
> +				local-timer-stop;
> +			};
> +
> +			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "big-power-down";
> +				arm,psci-suspend-param = <0x40000003>;
> +				entry-latency-us = <523>;
> +				exit-latency-us = <1244>;
> +				min-residency-us = <2207>;
> +				local-timer-stop;
> +			};
> +
> +			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "big-rail-power-down";
> +				arm,psci-suspend-param = <0x40000004>;
> +				entry-latency-us = <526>;
> +				exit-latency-us = <1854>;
> +				min-residency-us = <5555>;
> +				local-timer-stop;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "cluster-power-down";
> +				arm,psci-suspend-param = <0x40003444>;
> +				entry-latency-us = <3263>;
> +				exit-latency-us = <6562>;
> +				min-residency-us = <9926>;
> +				local-timer-stop;
> +			};
> +		};
>   	};
>   
>   	memory@80000000 {

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
