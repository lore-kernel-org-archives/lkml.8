Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E37C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A333521532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2Bjm85v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgIGRNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbgIGRNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:13:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29784C061573;
        Mon,  7 Sep 2020 10:13:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so19075511eja.3;
        Mon, 07 Sep 2020 10:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7TGKe3H6jMAYGiTs6kFoy9n4vW2P17ChzLhdJQLwaF4=;
        b=m2Bjm85vz8tiN6hI7Hfp3pSDKj0cdm6zU0bwT214EeCHu9+pc4Fb/MNreDSFscptkJ
         sDS9CMbp/xdxHRgC0OgUaT8WCYnlmRpBfXTS5POVSyubs2PEoNCmReAwxVbI6vUoiZXk
         YyXlSAIPapLAKC0cQzHmQjEiMdkcJiru18Izcvi4jC6VYngk1/s3r1k7/zMIF8eBXYpT
         pynzzS5oA0OqmdIN0SSe9qzZ8Lms8tSuQoENXPr1KQLyP8Kpe3QotqR23YkOPYYCgk2B
         tuaKnqI8GSUvX3zTmnJVlR3nEgfbNG2nHrPv+dVrrvF0tTyXwQOrplVyCJA0+EXyQCa1
         dPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7TGKe3H6jMAYGiTs6kFoy9n4vW2P17ChzLhdJQLwaF4=;
        b=Wu1HKw/XH4+iVvIKJCrteULyzpDKTadON2doyuiMlP8Nmainpx7gUyJ23QaInJmE29
         4zFg3VTQNlfwKHrDFr0T8XxEkTiCX0k4wNeDDTGA1zHzkS/r16rKwjnk4eqvBcSnNQPj
         P76iKnCd7vsXFdetRwcwU5Pfvyb9gSJltmTzmhWgzlSb46LkZIRXGwgsFgxYjGX/dHq9
         DiEu7/BASzJZd7f6dIKhVGYur/m/6ce5Xh4bD2h6J4AXMPVY59cM5x03s1vYUDQ1lHxZ
         SHaA0mk4hnJFGooTZmHNs/Pol/uHdpnI6mTkLJpAor/15Wtx8QICADFWNDgpcoLdWuDm
         dMLw==
X-Gm-Message-State: AOAM5317/uG+hOBxiw4w4yTRzHn+61lqGYZpMNX9mP0rwaWW//0GfvZ/
        E1rTt+cXVOl06mson9ObHgTxcAJkucQT/w==
X-Google-Smtp-Source: ABdhPJzLAwg9pbpp4n8CSNlxU/iw7Vf1bDjKydx21x5FKZjyYqA2Nh5jCk0ow+T7Ne2LPThNafKkvg==
X-Received: by 2002:a17:906:5902:: with SMTP id h2mr22973494ejq.423.1599498822819;
        Mon, 07 Sep 2020 10:13:42 -0700 (PDT)
Received: from mamamia.internal (a89-183-24-75.net-htp.de. [89.183.24.75])
        by smtp.gmail.com with ESMTPSA id s19sm2290592eja.54.2020.09.07.10.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 10:13:42 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200907112718.5994-1-pali@kernel.org>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
Date:   Mon, 7 Sep 2020 19:13:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200907112718.5994-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

On 07/09/2020 13:27, Pali Rohár wrote:
> Espressobin boards have 3 ethernet ports and some of them got assigned more
> then one MAC address. MAC addresses are stored in U-Boot environment.
> 
> Since commit a2c7023f7075c ("net: dsa: read mac address from DT for slave
> device") kernel can use MAC addresses from DT for particular DSA port.
> 
> Currently Espressobin DTS file contains alias just for ethernet0.
> 
> This patch defines additional ethernet aliases in Espressobin DTS files, so
> bootloader can fill correct MAC address for DSA switch ports if more MAC
> addresses were specified.
> 
> DT alias ethernet1 is used for wan port, DT aliases ethernet2 and ethernet3
> are used for lan ports for both Espressobin revisions (V5 and V7).
> 
> Fixes: 5253cb8c00a6f ("arm64: dts: marvell: espressobin: add ethernet alias")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>   .../dts/marvell/armada-3720-espressobin-v7-emmc.dts  | 10 ++++++++--
>   .../boot/dts/marvell/armada-3720-espressobin-v7.dts  | 10 ++++++++--
>   .../boot/dts/marvell/armada-3720-espressobin.dtsi    | 12 ++++++++----
>   3 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index 03733fd92732..215d2f702623 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -20,17 +20,23 @@
>   	compatible = "globalscale,espressobin-v7-emmc", "globalscale,espressobin-v7",
>   		     "globalscale,espressobin", "marvell,armada3720",
>   		     "marvell,armada3710";
> +
> +	aliases {
> +		/* ethernet1 is wan port */
> +		ethernet1 = &switch0port3;
> +		ethernet3 = &switch0port1;
> +	};
>   };
>   
>   &switch0 {
>   	ports {
> -		port@1 {
> +		switch0port1: port@1 {
>   			reg = <1>;
>   			label = "lan1";
>   			phy-handle = <&switch0phy0>;
>   		};
>   
> -		port@3 {
> +		switch0port3: port@3 {
>   			reg = <3>;
>   			label = "wan";
>   			phy-handle = <&switch0phy2>;

My dts-foo is a little rusty, but now that you labeled the ports in the 
.dtsi, can this whole "switch0" block reduced to something like:

&switch0port1 {
	label = "lan1";
};

&switch0port3 {
	label = "wan";
};

?

> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> index 8570c5f47d7d..b6f4af8ebafb 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -19,17 +19,23 @@
>   	model = "Globalscale Marvell ESPRESSOBin Board V7";
>   	compatible = "globalscale,espressobin-v7", "globalscale,espressobin",
>   		     "marvell,armada3720", "marvell,armada3710";
> +
> +	aliases {
> +		/* ethernet1 is wan port */
> +		ethernet1 = &switch0port3;
> +		ethernet3 = &switch0port1;
> +	};
>   };
>   
>   &switch0 {
>   	ports {
> -		port@1 {
> +		switch0port1: port@1 {
>   			reg = <1>;
>   			label = "lan1";
>   			phy-handle = <&switch0phy0>;
>   		};
>   
> -		port@3 {
> +		switch0port3: port@3 {
>   			reg = <3>;
>   			label = "wan";
>   			phy-handle = <&switch0phy2>;
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index b97218c72727..0775c16e0ec8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -13,6 +13,10 @@
>   / {
>   	aliases {
>   		ethernet0 = &eth0;
> +		/* for dsa slave device */
> +		ethernet1 = &switch0port1;
> +		ethernet2 = &switch0port2;
> +		ethernet3 = &switch0port3;
>   		serial0 = &uart0;
>   		serial1 = &uart1;
>   	};
> @@ -120,7 +124,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   
> -			port@0 {
> +			switch0port0: port@0 {

This label is unused it seems.

Regards,
Andre

>   				reg = <0>;
>   				label = "cpu";
>   				ethernet = <&eth0>;
> @@ -131,19 +135,19 @@
>   				};
>   			};
>   
> -			port@1 {
> +			switch0port1: port@1 {
>   				reg = <1>;
>   				label = "wan";
>   				phy-handle = <&switch0phy0>;
>   			};
>   
> -			port@2 {
> +			switch0port2: port@2 {
>   				reg = <2>;
>   				label = "lan0";
>   				phy-handle = <&switch0phy1>;
>   			};
>   
> -			port@3 {
> +			switch0port3: port@3 {
>   				reg = <3>;
>   				label = "lan1";
>   				phy-handle = <&switch0phy2>;
> 

