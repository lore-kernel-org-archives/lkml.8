Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E9C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A9820730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNT4E41c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgDGQXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:23:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43096 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgDGQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:23:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id k28so2844417lfe.10;
        Tue, 07 Apr 2020 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lIqJzw68A7L2ZWYO7kXO32fbdvxsPUYFK3LDegQyWKc=;
        b=fNT4E41c9Kf5/+9c195ZItbCQYbPiNgNCDcP9aouFle0LBy5SPGYfimut47m7vkxDt
         V8rWGYHyO3WCWn7RKiG1E5fVA6VARNQi89QMCxZxi+keGbxOj+wsb+5t9bTw1cpaDT5S
         tLkhbhsDUgF5pkKMcFXKIW6Hjt8/wlDR7AmX4JgfaMBatBdeCmwUqpBMScq9w2Z4wnhQ
         LE/XyHSX+8XSEjAsKWhzIZKW8lVFDoWSeWAhaMw4OeaX2po85cwrdSKcABQVs76CBHd/
         Z3L0C2TCUrYBwYvoxONzkrevi7QXnLschZG3zPWvQmLmQKeJSGkt762Z29yt1x4ZJdoZ
         vpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lIqJzw68A7L2ZWYO7kXO32fbdvxsPUYFK3LDegQyWKc=;
        b=oStFr7lEKKHjvmrrsDnomr0QVEe+nz5AHLTgTErUGrOutvLBJc0c0ne2i2mSC+xsGc
         yeLQrKYgi+/S/8FTnLJRLsvN9VNbzpbiZC0DmN5ZNEMTs4FsGeRaB8lJeQjObSfkSgdz
         Id7E3ogg00ppZ4dnWflQD9N0WwceBRaAhovT4M18vG2ePOiq7otgeue3NV5OeY/Touip
         0Ovm5MR8f3dG8GCU8/5JadghZtZ1w3eewx71GWipIfOzLYefdbVX9zauv/SWFWkot6e/
         OsZqfNbZDdNnQ8LK/BkCTcJfgsiWxlRRMB9rJOwilM7MkjrmWHtp0VEJMFV3+lsAZSNp
         gvtg==
X-Gm-Message-State: AGi0PuZTopLeoG7kGRelxnXn2GO8Yco/a1tOpQNaKr3iAKDDyQXJdTNw
        ZWN0DIjDRbADpxOmQOIILHVZWg6W
X-Google-Smtp-Source: APiQypIQxCrMVBGXPJJ/pWY6ipOmji7dpEZtCwu9qdrifxSSlfjvJAGzOR28WynMaQVcGQpcjA0aAA==
X-Received: by 2002:ac2:4291:: with SMTP id m17mr1948274lfh.201.1586276617360;
        Tue, 07 Apr 2020 09:23:37 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id z9sm11818302lfd.9.2020.04.07.09.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 09:23:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] ARM: tegra: Add device-tree for Acer Iconia Tab
 A500
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?Q?Pedro_=c3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200406194110.21283-1-digetx@gmail.com>
 <20200406194110.21283-2-digetx@gmail.com> <20200407104109.GC1720957@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dcacb220-580f-d9fc-a82d-4c7941f5ed2c@gmail.com>
Date:   Tue, 7 Apr 2020 19:23:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407104109.GC1720957@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.04.2020 13:41, Thierry Reding пишет:
> On Mon, Apr 06, 2020 at 10:41:05PM +0300, Dmitry Osipenko wrote:
> [...]
>> diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
> [...]
>> +	host1x@50000000 {
>> +		dc@54200000 {
>> +			rgb {
>> +				status = "okay";
>> +				nvidia,panel = <&panel>;
>> +
>> +				port@0 {
>> +					lvds_output: endpoint {
>> +						remote-endpoint = <&lvds_encoder_input>;
>> +						bus-width = <18>;
>> +					};
>> +				};
>> +			};
>> +		};
> 
> This seems a little strange to me, though, admittedly, I've never worked
> with these types of bridges before, so I may be misunderstanding this. I
> was under the impression that we could obtain the panel by traversing an
> OF graph, so that we didn't have to have that extra nvidia,panel
> property. As it is, you seem to describe two different paths, one that
> goes from the RGB output to the panel directly, and another that goes
> from the RGB output to the LVDS encoder and then to the panel.
> 
> It doesn't seem to me like a direct link from RGB output to panel does
> actually exist in this setup.

AFAIK, the direct link doesn't exist on any of Tegra boards, they all
have an LVDS bridge. The older device-trees just didn't model it properly.

The LVDS bridge and panel-lvds are relatively new things in DRM, which
allow to model hardware more correctly, like for example the bridge's
powerdown control is now modeled properly.

The nvidia,panel is a mandatory property for the Tegra's DRM output,
panel won't light up without it. I guess it should be possible to get
the panel's phandle from the graph, but this is not supported by the
Tegra's DRM driver + nvidia,panel is also useful to have for older
kernels that do not support panel-lvds. The panel falls back to a
simple-panel in the case of older kernel version, which results in a not
entirely appropriate panel timing (wrong framerate), but this is okay'ish.

> [...]
>> +	pwm: pwm@7000a000 {
>> +		status = "okay";
>> +		power-supply = <&vdd_3v3_sys>;
>> +	};
> 
> I don't see power-supply defined as a property for the PWM controller.
> Why do you need this?

Yes, looks like it's not needed. I'll remove it in v3, thanks.

> [...]
>> +	sdhci@c8000000 {
>> +		status = "okay";
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		max-frequency = <25000000>;
>> +		keep-power-in-suspend;
>> +		bus-width = <4>;
>> +		non-removable;
>> +
>> +		mmc-pwrseq = <&brcm_wifi_pwrseq>;
>> +		vmmc-supply = <&vdd_3v3_sys>;
>> +		vqmmc-supply = <&vdd_3v3_sys>;
>> +
>> +		/* Azurewave AW-NH611 BCM4329 */
>> +		WiFi@1 {
> 
> I think these names are supposed to be lowercase.

The dtbs_check doesn't complain, should be fine :)

But I don't mind, although the camel-case should be a correct way of
spelling WiFi. I'll change it in v3.

>> +			reg = <1>;
>> +			compatible = "brcm,bcm4329-fmac";
>> +			interrupt-parent = <&gpio>;
>> +			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "host-wake";
>> +		};
>> +	};
> [...]
>> +	clocks {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		clk32k_in: clock@0 {
>> +			compatible = "fixed-clock";
>> +			reg = <0>;
>> +			#clock-cells = <0>;
>> +			clock-frequency = <32768>;
>> +			clock-output-names = "tps658621-out32k";
>> +		};
>> +
>> +		rtc_32k_wifi: clock@1 {
>> +			compatible = "fixed-clock";
>> +			reg = <1>;
>> +			#clock-cells = <0>;
>> +			clock-frequency = <32768>;
>> +			clock-output-names = "kk3270032";
>> +		};
>> +	};
> 
> Are these clocks going to the PMIC and RTC, or are they generated by the
> chips? If they are generated by the chips, which sounds like they might
> be, wouldn't it be better to represent them as children of the
> corresponding chips?

They are generated by the chips.

The PMIC has a built-in 32K oscillator.

The kk3270032 is a dedicated onboard 32K oscillator. This one is not
mandatory to model in the device-tree, but I wanted to model as much as
possible.

> There's probably no infrastructure to do this, so maybe that would be
> overkill.

Yes, PMIC doesn't model the clock. All Tegra boards model the PMIC's
clock this way, although those boards don't set the clock-output-names
property, which makes the DT model more obscure than it could be.

The kk3270032 is a standalone oscillator, so it's fine as-is already.

> But for clarity it might be worth documenting here where
> exactly these clocks come from.

I guess the output clock-output-names are already self-explanatory,
don't you think so? For more details you could always consult the
board's schematics.

> [...]
>> +	memory-controller@7000f400 {
>> +		nvidia,use-ram-code;
>> +
>> +		emc-tables@elpida-8gb {
> 
> I don't think unit-addresses are supposed to be freeform text like
> above. These should always reflect the value of the "reg" property,
> though in this case we don't have one...
> 
>> +			nvidia,ram-code = <0>;
> 
> In retrospect it might have been better to just reuse the reg property
> for this.
> 
> I think in this case it might be best to reflect the RAM code in the
> unit-address. At least that way we conceptually get things right since
> it's the RAM code that selects which of these tables is used, much like
> a register, I2C slave address, or SPI chip select would select which of
> the subdevices are targetted.

This could be done, although we already have a precedent in a form of
the paz00 board that got memory timings not so long time ago.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=834f1d6cf3647e804e7a80569e42ee7fbee50eb1

I'll change it in v3.

Thank you for the review.
