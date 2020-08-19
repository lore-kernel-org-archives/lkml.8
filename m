Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D0CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E1C20897
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DkaTRXXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgHSP1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbgHSP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:27:40 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB91C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:27:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so11831051pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GbZAIltrnM0W892A2YesXVvpE1k1bqYDVw/4ubYRqGc=;
        b=DkaTRXXgWwG3uZd9a0IRe/RV2vXYNROwGHlVvK8AdBBwvOrA1vM+RIPv/TpRoRcTUt
         4+7BQOnVsmOx0zh/VLyPG47qosUjBEO+BQA38o7pPz2t0hYEt0jRDekjmfYbwI2S9CGi
         WIeJu+ZOOazK+x/CC/RK67ZznBcECU98bRv7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GbZAIltrnM0W892A2YesXVvpE1k1bqYDVw/4ubYRqGc=;
        b=nRg6Q2L3I/7Fnm09kucMFJb/GKRb6ukE/G7ct7DHhcZNgV7hVYh23qL68YKGVtOqPZ
         z1Fp3+wDOIpnelJ8C0qfNYubbmxoGcwV6V/LEKBmhcYTHxdFuem4s+PNKtX/OlNzJjnN
         bVR274EEx1Y8SMU2pnpAkkwjSnmE3pn2QQQESDYWJQTvD2C6O1la4hp8Lhq4WqdK6DCt
         L7wDf/wbM6X5ErMHhVSUQz1/AmPwCNoWO52MPQzzeV1tn0vpDPBqI0l2AbgH/iexPCK6
         NYV+7gexFDR9VCgQOqCPGBxAhfOlIbt458ZujTZImZzRwQ/tSEN+1D9Iu6yatqWJiPFp
         R1NQ==
X-Gm-Message-State: AOAM531e7vOXyg2WLTnkAn32zeEYcznCHJrEKSo6DP4YZySebU3z14ty
        dc+TxpxKmJqPYX3GAv1RxpwrhSmoWoTa0xGwwQTO6Vf5HVOU+tdLo/eNntNoyXKx+XaxBvyOiPA
        o/kIFLEkeGZD8edHY30qna6fZ1DGzSgL5gTVDFNrVKYRPOMbuKgS2rg4ufX1lhuDfrphCtk3GgP
        Uq5iE=
X-Google-Smtp-Source: ABdhPJyl+ktBglnyLwWowddUPxmmPk6qJLOP97Bs6pa01a9/8ygvmLy0Ulsn7uhbiOR2Xy/Rl943ig==
X-Received: by 2002:a63:af47:: with SMTP id s7mr17692321pgo.335.1597850859651;
        Wed, 19 Aug 2020 08:27:39 -0700 (PDT)
Received: from [10.136.8.253] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id s6sm3377091pjn.48.2020.08.19.08.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 08:27:39 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: BCM5301X: Fix pin controller node
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200819042308.19043-1-f.fainelli@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <fd39660a-4797-9db4-acc9-85c2fa98beff@broadcom.com>
Date:   Wed, 19 Aug 2020 08:27:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819042308.19043-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2020 9:23 PM, Florian Fainelli wrote:
> The pin controller resources start at 0xc0 from the CRU base which is at
> 0x100 from th DMU base, for a final address of 0x1800_c1c0, whereas we
> are currently off by 0x100. The resource size of the CRU is also
> incorrect and should end at 0x248 bytes from 0x100 which is the start
> address. Finally, the compatibility strings defined for the
> pin-controller node should reflect the SoC being used.
> 
> Fixes: 9994241ac97c ("ARM: dts: BCM5301X: Describe Northstar pins mux controller")
> Reported-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Christian, can you test this as a preliminary patch for your Cisco
> Meraki MR32 series? Thanks!
> 
>  arch/arm/boot/dts/bcm4708.dtsi  | 4 ++++
>  arch/arm/boot/dts/bcm4709.dtsi  | 4 ++++
>  arch/arm/boot/dts/bcm5301x.dtsi | 8 ++++----
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
> index 1a19e97a987d..5064fe51e402 100644
> --- a/arch/arm/boot/dts/bcm4708.dtsi
> +++ b/arch/arm/boot/dts/bcm4708.dtsi
> @@ -43,6 +43,10 @@ cpu@1 {
>  
>  };
>  
> +&pinctrl {
> +	compatible = "brcm,bcm4708-pinmux";
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/bcm4709.dtsi b/arch/arm/boot/dts/bcm4709.dtsi
> index e1bb8661955f..7417c275ea9d 100644
> --- a/arch/arm/boot/dts/bcm4709.dtsi
> +++ b/arch/arm/boot/dts/bcm4709.dtsi
> @@ -5,6 +5,10 @@
>  
>  #include "bcm4708.dtsi"
>  
> +&pinctrl {
> +	compatible = "brcm,bcm4709-pinmux";
> +};
> +
>  &uart0 {
>  	clock-frequency = <125000000>;
>  	status = "okay";
> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> index 2d9b4dd05830..bf49943f504a 100644
> --- a/arch/arm/boot/dts/bcm5301x.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> @@ -402,14 +402,14 @@ dmu@1800c000 {
>  
>  		cru@100 {
>  			compatible = "simple-bus";
> -			reg = <0x100 0x1a4>;
> +			reg = <0x100 0x248>;
>  			ranges;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  
> -			pin-controller@1c0 {
> -				compatible = "brcm,bcm4708-pinmux";
> -				reg = <0x1c0 0x24>;
> +			pinctrl: pin-controller@c0 {
> +				compatible = "brcm,bcm53012-pinmux";
> +				reg = <0xc0 0x24>;
>  				reg-names = "cru_gpio_control";
>  
>  				spi-pins {
> 

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
