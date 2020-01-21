Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD43FC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A1424655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A8+hE7I8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAUXo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:44:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39770 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgAUXo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:44:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id 4so2387576pgd.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HjUpoeX4YdaRqbuTABV6ngWl1iP5khVVeq5ucr6BmI4=;
        b=A8+hE7I8Bs79HcypjskxtoOMrmYsHUnGQYYKjvbT05uwioIjpjROOii8SdChwAwTRo
         n5FPoC5p9ffecmhCYCk7bac7FfCDg7KNxvC8f5tu1euT0ibfyKWgHJNsrDGrwkENbDTV
         iMxG8gErHP/g5bEM2WuA6rKRB2/y+t3rMK7lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HjUpoeX4YdaRqbuTABV6ngWl1iP5khVVeq5ucr6BmI4=;
        b=NMSkv9a3O206znJ/JHano4NlQsQ4s97Bf3H7OVWZFy/oQ0gYyjm+bDyyWPuMjn5sY3
         1udZTrg0wzvpe5jqHcMRF6BDXPYpOLgOqCTdi8Md4SqK7zT27YoF2PijP5acKtZdGiLD
         WiOePGgEsr2JhHzgTa4SdVfdmDaAVOiwusgh1C7v0xySBx9e0mGRFVtrfDzMbN9T/EGd
         HrfHoo3PT9VWPaiOLAIAxifd9rSqqs4/alXZZPD0cH66T19epu6+auofOfR23Iaq3B9+
         RL/mB4cnQLNIvBcBnWrWQPwvjW06pThZLN/hUVceC2aG5YuHQpPFqLIOjUtVmfJKBp8M
         XDyg==
X-Gm-Message-State: APjAAAVW76oc4qGUWrAnjQyTB+oab9Am90uDz6XCd2EkLg2TIo9ROnrM
        pjEPNbm5Ro0vez8YHs36PWG/gg==
X-Google-Smtp-Source: APXvYqxd6VR1UOpjrwuDNyi5uF08oFLWZkyGgiNDxxRwi7fsupmCk5D3rfPHM9YUeLW+SwAJAVODVw==
X-Received: by 2002:a62:788a:: with SMTP id t132mr14342pfc.134.1579650294897;
        Tue, 21 Jan 2020 15:44:54 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id p28sm42695027pgb.93.2020.01.21.15.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 15:44:54 -0800 (PST)
Date:   Tue, 21 Jan 2020 15:44:52 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        swboyd@chromium.org, evgreen@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add cpuidle low power states
Message-ID: <20200121234452.GW89495@google.com>
References: <1572408318-28681-1-git-send-email-mkshah@codeaurora.org>
 <1572408318-28681-2-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1572408318-28681-2-git-send-email-mkshah@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maulik,

what is the state of this patch? Sudeep and Stephen had comments requesting
minor changes, do you plan to send a v2 soon?

Thanks

Matthias

On Wed, Oct 30, 2019 at 09:35:18AM +0530, Maulik Shah wrote:
> Add device bindings for cpuidle states for cpu devices.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 78 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index fceac50..69d5e2c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -70,6 +70,9 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> @@ -85,6 +88,9 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_100>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> @@ -97,6 +103,9 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x200>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_200>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> @@ -109,6 +118,9 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x300>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_300>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> @@ -121,6 +133,9 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x400>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_400>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
> @@ -133,6 +148,9 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x500>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +					   &LITTLE_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_500>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
> @@ -145,6 +163,9 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x600>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&BIG_CPU_SLEEP_0
> +					   &BIG_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_600>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
> @@ -157,12 +178,69 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x700>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&BIG_CPU_SLEEP_0
> +					   &BIG_CPU_SLEEP_1
> +					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_700>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "little-power-down";
> +				arm,psci-suspend-param = <0x40000003>;
> +				entry-latency-us = <350>;
> +				exit-latency-us = <461>;
> +				min-residency-us = <1890>;
> +				local-timer-stop;
> +			};
> +
> +			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "little-rail-power-down";
> +				arm,psci-suspend-param = <0x40000004>;
> +				entry-latency-us = <360>;
> +				exit-latency-us = <531>;
> +				min-residency-us = <3934>;
> +				local-timer-stop;
> +			};
> +
> +			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "big-power-down";
> +				arm,psci-suspend-param = <0x40000003>;
> +				entry-latency-us = <264>;
> +				exit-latency-us = <621>;
> +				min-residency-us = <952>;
> +				local-timer-stop;
> +			};
> +
> +			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "big-rail-power-down";
> +				arm,psci-suspend-param = <0x40000004>;
> +				entry-latency-us = <702>;
> +				exit-latency-us = <1061>;
> +				min-residency-us = <4488>;
> +				local-timer-stop;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "cluster-power-down";
> +				arm,psci-suspend-param = <0x400000F4>;
> +				entry-latency-us = <3263>;
> +				exit-latency-us = <6562>;
> +				min-residency-us = <9987>;
> +				local-timer-stop;
> +			};
> +		};
>  	};
>  
>  	memory@80000000 {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
