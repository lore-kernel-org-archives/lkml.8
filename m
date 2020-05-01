Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34721C47259
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD212173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339873;
	bh=eq9VzjTggIjZwyzJnYSvtCpci3J6H7Qooauqn2L2Q+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uk5NSln1aCOHO6KCSmLoDbWJu7RO/mBUBELDVbObTAGUUEmaHiS3dpoIBM2CX4pZU
	 9IUpjbvZtNP7CRRxTXk6LmUlxJOsNOIBhofVBPCa4AOlBX31gb3tQDn3s2yPm1aTSG
	 7PPy/Ewu98PXo60yxs6sXuSd2Mu8FudVUZASq53c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgEANbL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:31:11 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38934 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbgEANbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:31:07 -0400
Received: by mail-ej1-f65.google.com with SMTP id s3so7483120eji.6;
        Fri, 01 May 2020 06:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OvExKVABn65NYbhAsLzBIznCBsp6S8fN5fVcOGh1uUs=;
        b=K2NA6sZ/RcTB+yqUhPhaqpL4nkmTl8T0fAV0/4EeetYfNGkW0lBxRmQ3Lc7GXN8Oy6
         LCi1QIm6gXs1ombVdE8RyIYDssMotNK+pLMShOkXBJZwLFiYO7MGDJQm0c5H3M1dbxXW
         N/hLCmyBmvCXry8TTJNrOifvmpalXsN619wLCdSXM1O+t31jtD5sgnMLfopQQqlUfa9Q
         5e/hij9hKiITu9VZBp9aVvSsNHzTyNxZIKouDSJb7Wh7LcIG2sRAM+hWgP8LkioB1lyB
         1zMpfhCQF+gl+wnVtoRGr45VjnVBvsLKRl0eXF8X1XkV3C5CTo4E0ffWy34Nj8XSLaQZ
         EhBA==
X-Gm-Message-State: AGi0Puac48fzC0NOiwdnhB3R2yA+v6GMjhFvLShPGBnyGFmom41SAWBD
        h/uQX1pL0PecYsJivcEAsjWOaexb
X-Google-Smtp-Source: APiQypKISGOX7qOFt8o4ShYMxr/Bdy48MbYE+T4EfJCwSM93IitpN69Eij32vrIU58PdDpQhnaRZ/Q==
X-Received: by 2002:a17:906:f0d9:: with SMTP id dk25mr3113128ejb.266.1588339864014;
        Fri, 01 May 2020 06:31:04 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id u13sm304929edi.82.2020.05.01.06.31.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 06:31:03 -0700 (PDT)
Date:   Fri, 1 May 2020 15:31:00 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 06/13] arm: dts: s5pv210: aries: Add support for more
 devices
Message-ID: <20200501133100.GB5154@kozik-lap>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB0660563639D091548BFCCFF2A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200428102026.GB23963@kozik-lap>
 <BN6PR04MB0660776A38353DBDF0E2E3F9A3AC0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <BN6PR04MB0660776A38353DBDF0E2E3F9A3AC0@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 04:32:56PM -0700, Jonathan Bakker wrote:
> Hi Krzysztof,
> 
> On 2020-04-28 3:20 a.m., Krzysztof Kozlowski wrote:
> > On Sun, Apr 26, 2020 at 11:35:57AM -0700, Jonathan Bakker wrote:
> >> Add support for following devices:
> >>   - touchkeys connected over i2c-gpio
> >>   - s6e63m0 panel connected over spi-gpio
> >>   - fsa9480 microusb switch over i2c-gpio
> >>   - wm8994 over i2c-gpio (no machine driver yet)
> >>   - all common i2c-gpio devices
> > 
> > Please split it per functionality, e.g.:
> > 1. Add sound,
> > 2. Add panel,
> > 3. Add touchkeys (unless part of panel),
> > 4. The remaining i2c-gpio devices without bindings could go as one.
> 
> Ok, will do.
> 
> > 
> >>
> >> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> >> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> >> ---
> >>  arch/arm/boot/dts/s5pv210-aries.dtsi      | 282 ++++++++++++++++++++--
> >>  arch/arm/boot/dts/s5pv210-fascinate4g.dts |   6 +
> >>  2 files changed, 270 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
> >> index f83df426f2b6..ef966d13d83d 100644
> >> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> >> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> >> @@ -12,8 +12,14 @@
> >>  	compatible = "samsung,aries", "samsung,s5pv210";
> >>  
> >>  	aliases {
> >> +		i2c4 = &i2c_sound;
> >> +		i2c5 = &i2c_accel;
> >>  		i2c6 = &i2c_pmic;
> >> +		i2c7 = &i2c_musb;
> >>  		i2c9 = &i2c_fuel;
> >> +		i2c10 = &i2c_touchkey;
> >> +		i2c11 = &i2c_prox;
> >> +		i2c12 = &i2c_magnetometer;
> >>  	};
> >>  
> >>  	memory@30000000 {
> >> @@ -48,6 +54,18 @@
> >>  		gpio = <&gpj1 1 GPIO_ACTIVE_HIGH>;
> >>  	};
> >>  
> >> +	touchkey_vdd: regulator-fixed-1 {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "VTOUCH_3.3V";
> >> +		regulator-min-microvolt = <3300000>;
> >> +		regulator-max-microvolt = <3300000>;
> >> +		enable-active-high;
> >> +		gpio = <&gpj3 2 GPIO_ACTIVE_HIGH>;
> >> +
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&touchkey_vdd_ena>;
> >> +	};
> >> +
> >>  	wifi_pwrseq: wifi-pwrseq {
> >>  		compatible = "mmc-pwrseq-simple";
> >>  		reset-gpios = <&gpg1 2 GPIO_ACTIVE_LOW>;
> >> @@ -57,7 +75,69 @@
> >>  		power-off-delay-us = <500>;
> >>  	};
> >>  
> >> -	i2c_pmic: i2c-gpio-0 {
> >> +	i2c_sound: i2c-gpio-0 {
> >> +		compatible = "i2c-gpio";
> >> +		sda-gpios = <&mp05 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> >> +		scl-gpios = <&mp05 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> >> +		i2c-gpio,delay-us = <2>;
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&sound_i2c_pins>;
> >> +
> >> +		wm8994: wm8994@1a {
> >> +			compatible = "wlf,wm8994";
> >> +			reg = <0x1a>;
> >> +
> >> +			#sound-dai-cells = <0>;
> >> +
> >> +			gpio-controller;
> >> +			#gpio-cells = <2>;
> >> +
> >> +			clocks = <&clocks MOUT_CLKOUT>;
> >> +			clock-names = "MCLK1";
> >> +
> >> +			AVDD2-supply = <&buck3_reg>;
> >> +			DBVDD-supply = <&buck3_reg>;
> > 
> > No such supply, check the bindings.
> > 
> 
> Well, it may not be in the bindings, but the driver definitely requires it :) See drivers/mfd/wm8994-core.c
> 
> What's the best way of dealing with this situation?

I'll send a patch fixing the bindings. However don't you miss the
AVDD1-supply in such case? Driver should report error.

> 
> >> +			CPVDD-supply = <&buck3_reg>;
> >> +			SPKVDD1-supply = <&buck3_reg>;
> >> +			SPKVDD2-supply = <&buck3_reg>;
> >> +
> >> +			wlf,gpio-cfg = <0xa101 0x8100 0x0100 0x0100 0x8100
> >> +					0xa101 0x0100 0x8100 0x0100 0x0100
> >> +					0x0100>;
> >> +
> >> +			wlf,ldo1ena = <&gpf3 4 GPIO_ACTIVE_HIGH>;
> >> +			wlf,ldo2ena = <&gpf3 4 GPIO_ACTIVE_HIGH>;
> >> +
> >> +			wlf,lineout1-se;
> >> +			wlf,lineout2-se;
> >> +
> >> +			assigned-clocks = <&clocks MOUT_CLKOUT>;
> >> +			assigned-clock-rates = <0>;
> >> +			assigned-clock-parents = <&xusbxti>;
> >> +
> >> +			pinctrl-names = "default";
> >> +			pinctrl-0 = <&codec_ldo>;
> >> +		};
> >> +	};
> >> +
> >> +	i2c_accel: i2c-gpio-1 {
> >> +		compatible = "i2c-gpio";
> >> +		sda-gpios = <&gpj3 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> >> +		scl-gpios = <&gpj3 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> >> +		i2c-gpio,delay-us = <2>;
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&accel_i2c_pins>;
> >> +
> >> +		/* bma023 accelerometer, no mainline binding */
> > 
> > status disabled ... unless you need it for user-space I2C tools?
> > 
> 
> Nope, but wanted to add them all in due to adding the si4709 in galaxys.  I was having
> issues with accidentally overwriting previously named nodes (ie having i2c-gpio-0 in
> both the common dtsi and the device specific dts) so I wanted to get the numbers
> nailed down.

So add them with status disabled. This will document the HW without
enabling empty I2C GPIO bus.

Best regards,
Krzysztof

