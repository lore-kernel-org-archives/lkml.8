Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20042C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001D92074B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NWXrMGMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgDVOi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgDVOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:38:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343AFC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:38:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so2648821wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=VPAi1jzLz5ivFSLbrGPumH1oKGnefQqrzmeoEGE1ITQ=;
        b=NWXrMGMWMxCuyyrkVI4ygim/zyyRBFfu0ln1870AObF6kViSLCgRrduj5VNqiYJjZh
         CLQih+MuUGO0UE3mMHcEzIjYzavQdqHD9OfkQkHtVC+aY5tVgwfKjfTiG/Xtj5xS7BAy
         cYxQx3eHrTRhYlvHHGcz5OK1E77s4vw09iHqF6KL1V8nwEQUw3XQ3t3TSa/16CyKnqHy
         PxhiVLdTCArUK3uDtGofQ42UEPpAen1euxQDweVl0dOEawd77txkTo781ZdpAbzyUURu
         CwlctttVX4b4OKRqBGzsBiCmy0E1puIEHLmqDbyHo6t0WVx+utyl6UkxGlIvXAj1bqR7
         xEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=VPAi1jzLz5ivFSLbrGPumH1oKGnefQqrzmeoEGE1ITQ=;
        b=CYEITUBj359DhPME2vcVI6JoOQJ9vGIbrC8ChO4f2lIlonGkq2ff+VbKAIn+CACnIo
         P9mldh6nSI8uJihQ/O7lLopszE06cxsKp9K9Flx0eUo37n9vl4+4ac80zjvpBOSJdVrY
         wnRXTakRtM84WJMgzvPDN1k6oaPO4ZULUqMIu9E12GiLZErR+bT9nbpmuvN7j+wCMyqf
         y0LEuQpK1+0u2FnZ0oBUbvyweaq8HwfgEm035yu7SBUh/qX2SfzDaNSzvyJzgNMdCgVe
         Zu76bG8PzSUDEyvPn66lEKGp1RQU3oI6Kt5pPD/dfYYrVqdKTDacIsz/82+gupX/w1l6
         +sIQ==
X-Gm-Message-State: AGi0Puble26w0hPAR0wU2QjDYlPqbFwTRlRCB04AjcQm3aKavTmmvOd1
        hLAA2q5VL87WmBoRxrX6ozli7g==
X-Google-Smtp-Source: APiQypKaHUpWnwclQRW8xfFhyadtn5bDQCs+tzS8XlFHPn49wjgX/3RyvXk4ThzLcKVkkCZU4zhaCQ==
X-Received: by 2002:a1c:2506:: with SMTP id l6mr10538294wml.44.1587566334432;
        Wed, 22 Apr 2020 07:38:54 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id y40sm9394800wrd.20.2020.04.22.07.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 07:38:53 -0700 (PDT)
References: <20200421163935.775935-1-jbrunet@baylibre.com> <20200421163935.775935-3-jbrunet@baylibre.com> <63b05930-4814-f8f9-d1eb-2bd487ed3406@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64: dts: meson-gx: add aiu support
In-reply-to: <63b05930-4814-f8f9-d1eb-2bd487ed3406@baylibre.com>
Date:   Wed, 22 Apr 2020 16:38:52 +0200
Message-ID: <1jimhrzitf.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 22 Apr 2020 at 15:12, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 21/04/2020 18:39, Jerome Brunet wrote:
>> Add the AIU audio device to the Amlogic GX SoC family DT.
>> ATM, this device provides the i2s and spdif output stages and also
>> the hdmi and internal codec glues.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 13 ++++++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 23 +++++++++++++++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 23 +++++++++++++++++++++
>>  3 files changed, 59 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index 03f79fe045b7..a8dc8f810253 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -278,6 +278,17 @@ reset: reset-controller@4404 {
>>  				#reset-cells = <1>;
>>  			};
>>  
>> +			aiu: audio-controller@5400 {
>> +				compatible = "amlogic,aiu";
>> +				#sound-dai-cells = <2>;
>> +				sound-name-prefix = "AIU";
>> +				reg = <0x0 0x5400 0x0 0x2ac>;
>> +				interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
>> +					     <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
>> +				interrupt-names = "i2s", "spdif";
>> +				status = "disabled";
>> +			};
>> +
>>  			uart_A: serial@84c0 {
>>  				compatible = "amlogic,meson-gx-uart";
>>  				reg = <0x0 0x84c0 0x0 0x18>;
>> @@ -626,6 +637,8 @@ hdmi_tx: hdmi-tx@c883a000 {
>>  			interrupts = <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>> +			#sound-dai-cells = <0>;
>> +			sound-name-prefix = "HDMITX";
>
> sound-name-prefix is not a valid property in Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
>
> It should be added.

Not sure it should be explicitly added. It should be valid for any
device providing a sound-dai (sound-dai-cell)

>
> AFAIK sound-name-prefix is not present on g12-common, is it missing ?

It might not be strictly required, as long as there is no name colision
in the ASoC widget and Control, it is OK. IMHO, it is a good practice to
set one to avoid those colision.

>
> Neil
>
>>  			status = "disabled";
>>  
>>  			/* VPU VENC Input */
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> index 0cb40326b0d3..234490d3ee68 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> @@ -60,6 +60,29 @@ usb1: usb@c9100000 {
>>  	};
>>  };
>>  
>> +&aiu {
>> +	compatible = "amlogic,aiu-gxbb", "amlogic,aiu";
>> +	clocks = <&clkc CLKID_AIU_GLUE>,
>> +		 <&clkc CLKID_I2S_OUT>,
>> +		 <&clkc CLKID_AOCLK_GATE>,
>> +		 <&clkc CLKID_CTS_AMCLK>,
>> +		 <&clkc CLKID_MIXER_IFACE>,
>> +		 <&clkc CLKID_IEC958>,
>> +		 <&clkc CLKID_IEC958_GATE>,
>> +		 <&clkc CLKID_CTS_MCLK_I958>,
>> +		 <&clkc CLKID_CTS_I958>;
>> +	clock-names = "pclk",
>> +		      "i2s_pclk",
>> +		      "i2s_aoclk",
>> +		      "i2s_mclk",
>> +		      "i2s_mixer",
>> +		      "spdif_pclk",
>> +		      "spdif_aoclk",
>> +		      "spdif_mclk",
>> +		      "spdif_mclk_sel";
>> +	resets = <&reset RESET_AIU>;
>> +};
>> +
>>  &aobus {
>>  	pinctrl_aobus: pinctrl@14 {
>>  		compatible = "amlogic,meson-gxbb-aobus-pinctrl";
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> index 259d86399390..d9f00c5a9a5c 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> @@ -49,6 +49,29 @@ crypto: crypto@c883e000 {
>>  	};
>>  };
>>  
>> +&aiu {
>> +	compatible = "amlogic,aiu-gxl", "amlogic,aiu";
>> +	clocks = <&clkc CLKID_AIU_GLUE>,
>> +		 <&clkc CLKID_I2S_OUT>,
>> +		 <&clkc CLKID_AOCLK_GATE>,
>> +		 <&clkc CLKID_CTS_AMCLK>,
>> +		 <&clkc CLKID_MIXER_IFACE>,
>> +		 <&clkc CLKID_IEC958>,
>> +		 <&clkc CLKID_IEC958_GATE>,
>> +		 <&clkc CLKID_CTS_MCLK_I958>,
>> +		 <&clkc CLKID_CTS_I958>;
>> +	clock-names = "pclk",
>> +		      "i2s_pclk",
>> +		      "i2s_aoclk",
>> +		      "i2s_mclk",
>> +		      "i2s_mixer",
>> +		      "spdif_pclk",
>> +		      "spdif_aoclk",
>> +		      "spdif_mclk",
>> +		      "spdif_mclk_sel";
>> +	resets = <&reset RESET_AIU>;
>> +};
>> +
>>  &apb {
>>  	usb2_phy0: phy@78000 {
>>  		compatible = "amlogic,meson-gxl-usb2-phy";
>> 

