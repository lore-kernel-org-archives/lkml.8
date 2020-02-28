Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37808C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19A3246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgB1O4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:56:34 -0500
Received: from mail.manjaro.org ([176.9.38.148]:47146 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgB1O4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:56:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id D085F3941E12;
        Fri, 28 Feb 2020 15:56:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1dWdwfYRA7sh; Fri, 28 Feb 2020 15:56:29 +0100 (CET)
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add initial support for
 Pinebook Pro
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Alexis Ballier <aballier@gentoo.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Xie <nick@khadas.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        anarsoul@gmail.com, enric.balletbo@collabora.com
References: <20200227180630.166982-1-t.schramm@manjaro.org>
 <20200227180630.166982-3-t.schramm@manjaro.org> <12370413.gKdrHkWbHd@diego>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <37190f26-48aa-dcad-d4b1-8a534ba1360e@manjaro.org>
Date:   Fri, 28 Feb 2020 15:57:10 +0100
MIME-Version: 1.0
In-Reply-To: <12370413.gKdrHkWbHd@diego>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

thanks for the review. I'll implement the changes and send a v2.

>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pwrled_gpio &slpled_gpio>;
>> +
>> +		green-led {
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			default-state = "off";
>> +			function = LED_FUNCTION_POWER;
>> +			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
>> +			label = "green:disk-activity";
>> +			linux,default-trigger = "mmc2";
> hmm, LED_FUNCTION_POWER but trigger for mmc2 ?
> So if there is no activity on the LED it looks to be off?

I see why this is looking weird. It does not make a whole lot of sense
at the moment and I'll change that for v2. 

However I have a patch in the making that adds "-inverted" variants for
all triggers so the power LED can be turned of briefly to indicate mmc
activity.

Not sure wether people will like it or not but I'll try it as a RFC.

>> +	 * of wakeup sources without disabling the whole key
> Also can you explain the problem a bit? If there is a deficit in the input
> subsystem regarding wakeup events, dt is normally not the place to work
> around things [we're supposed to be OS independent]

The issue is that some users wanted to be able to control the wakeup
functionality of the keys separately via sysfs. That does not seem to be
possible when combining both keys into one gpio-keys node. A more
detailed explanation of the issue can be found at [1].

>> +&i2c0 {
>> +	clock-frequency = <400000>;
>> +	i2c-scl-rising-time-ns = <168>;
>> +	i2c-scl-falling-time-ns = <4>;
>> +	status = "okay";
>> +
>> +	rk808: pmic@1b {
>> +		compatible = "rockchip,rk808";
>> +		reg = <0x1b>;
>> +		#clock-cells = <1>;
>> +		clock-output-names = "xin32k", "rk808-clkout2";
>> +		interrupt-parent = <&gpio3>;
>> +		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pmic_int_l_gpio>;
>> +		rockchip,system-power-controller;
>> +		wakeup-source;
>> +
>> +		vddio-supply = <&vcc_3v0>;
> where does this come from? Aka it's not specified in the dt-binding
> (though the example falsely uses it) and also not referenced in the driver.

This does likely come from the BSP dts. Seems I missed it while checking
bindings.


Thanks again for the review,

Tobias


[1] https://gitlab.manjaro.org/tsys/linux-pinebook-pro/issues/5

