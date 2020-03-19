Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D6C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A5B2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgCSQRx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:17:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46300 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgCSQRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:17:53 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jExrc-0001rp-J9; Thu, 19 Mar 2020 17:17:44 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: move uart2 pinctrl settings to each dts for rk3288
Date:   Thu, 19 Mar 2020 17:17:41 +0100
Message-ID: <3546891.GlR2YxYlMe@diego>
In-Reply-To: <8eed33d8-142c-28cf-7fa4-faf9bebb13cf@katsuster.net>
References: <20200319151339.17909-1-katsuhiro@katsuster.net> <4307911.4IBKxFWOMT@diego> <8eed33d8-142c-28cf-7fa4-faf9bebb13cf@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 19. März 2020, 16:58:00 CET schrieb Katsuhiro Suzuki:
> On 2020/03/20 0:25, Heiko Stübner wrote:
> > Am Donnerstag, 19. März 2020, 16:13:39 CET schrieb Katsuhiro Suzuki:
> >> This patch removes conflicted pinctrl settings uart2 and pwm 2/3
> >> from common rk3288.dtsi and moves exist uart2 pinctrl settings
> >> into each rk3288*.dts files.
> >>
> >>    - pwm2_pin  : use GPIO7_C6
> >>    - pwm3_pin  : use GPIO7_C7
> >>    - uart2_xfer: use GPIO7_C6, GPIO7_C7
> > 
> > Board files only ever get to enable either pwm2/3 or uart2,
> > not both at once - so I'm not sure where you see conflicts.
> > 
> 
> At first, I think so too. But I've saw this message when booting.
> 
> ----------
> [    2.435504] rockchip-pinctrl pinctrl: pin gpio7-22 already requested by ff680020.pwm; cannot claim for ff690000.serial
> [    2.447506] rockchip-pinctrl pinctrl: pin-238 (ff690000.serial) status -22
> [    2.455198] rockchip-pinctrl pinctrl: could not request pin 238 (gpio7-22) from group uart2-xfer  on device rockchip-pinctrl
> ----------
> 
> And it seems that uart2(ttyS2) is not working correctly.
> 
> ----------
> # cat /dev/ttyS2
> cat: /dev/ttyS2: Input/output error
> ----------
> 
> I'm using newest linux-next, make defconfig and CONFIG_MODULES = n setting
> with TinkerBoard. Can I resolve this issue in other ways?

On the tinker-board pwm2 is unused and has a status=disabled in the
devicetree [at least when checking my current branches], so the kernel
shouldn't even create a plaform-device for it.

I.e. see [0] - the of_device_is_available() call should already drop the
disabled devices, so there should not even exist a ff680020.pwm .

So I guess the solution would be to find out why it creates ff680020.pwm
in the first place and fix that.

Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/of/platform.c#n174



> > And of course there are alternative pins to use, if you need uart2
> > you need both pins in uart-pinmux and if you need either as pwm, then
> > the board by design just can't use them as uart2.
> > 
> > So pin setting should stay where they are, as there really is no conflict.
> > 
> > 
> > Heiko
> > 
> > 
> > 
> >> Currently uart2 rk3288 user is the following:
> >>
> >>    - rk3288-evb.dtsi:&uart2 {
> >>    - rk3288-firefly-reload.dts:&uart2 {
> >>    - rk3288-firefly.dtsi:&uart2 {
> >>    - rk3288-miqi.dts:&uart2 {
> >>    - rk3288-phycore-rdk.dts:&uart2 {
> >>    - rk3288-popmetal.dts:&uart2 {
> >>    - rk3288-r89.dts:&uart2 {
> >>    - rk3288-rock2-square.dts:&uart2 {
> >>    - rk3288-tinker.dtsi:&uart2 {
> >>    - rk3288-veyron.dtsi:&uart2 {
> >>    - rk3288-vyasa.dts:&uart2 {
> >>
> >> And no one is using pwm2 nor pwm3.
> >>
> >> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> >> ---
> >>   arch/arm/boot/dts/rk3288-evb.dtsi           | 2 ++
> >>   arch/arm/boot/dts/rk3288-firefly-reload.dts | 2 ++
> >>   arch/arm/boot/dts/rk3288-firefly.dtsi       | 2 ++
> >>   arch/arm/boot/dts/rk3288-miqi.dts           | 2 ++
> >>   arch/arm/boot/dts/rk3288-phycore-rdk.dts    | 2 ++
> >>   arch/arm/boot/dts/rk3288-popmetal.dts       | 2 ++
> >>   arch/arm/boot/dts/rk3288-r89.dts            | 2 ++
> >>   arch/arm/boot/dts/rk3288-rock2-square.dts   | 2 ++
> >>   arch/arm/boot/dts/rk3288-tinker.dtsi        | 2 ++
> >>   arch/arm/boot/dts/rk3288-veyron.dtsi        | 2 ++
> >>   arch/arm/boot/dts/rk3288-vyasa.dts          | 2 ++
> >>   arch/arm/boot/dts/rk3288.dtsi               | 6 ------
> >>   12 files changed, 22 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
> >> index 018802df4c0e..74091f831ecf 100644
> >> --- a/arch/arm/boot/dts/rk3288-evb.dtsi
> >> +++ b/arch/arm/boot/dts/rk3288-evb.dtsi
> >> @@ -285,6 +285,8 @@ &uart1 {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
> >> index 8c38bda21a7c..b0c976c8e35b 100644
> >> --- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
> >> +++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
> >> @@ -283,6 +283,8 @@ &uart1 {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
> >> index 5e0a19004e46..1632cc083c12 100644
> >> --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
> >> +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
> >> @@ -532,6 +532,8 @@ &uart1 {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
> >> index c41d012c8850..2c0ed37fde80 100644
> >> --- a/arch/arm/boot/dts/rk3288-miqi.dts
> >> +++ b/arch/arm/boot/dts/rk3288-miqi.dts
> >> @@ -379,6 +379,8 @@ &tsadc {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288-phycore-rdk.dts b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
> >> index 1e33859de484..6532c1ac43cd 100644
> >> --- a/arch/arm/boot/dts/rk3288-phycore-rdk.dts
> >> +++ b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
> >> @@ -244,6 +244,8 @@ &uart0 {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
> >> index 6a51940398b5..f18306bd9e6e 100644
> >> --- a/arch/arm/boot/dts/rk3288-popmetal.dts
> >> +++ b/arch/arm/boot/dts/rk3288-popmetal.dts
> >> @@ -481,6 +481,8 @@ &uart1 {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
> >> index a258c7ae5329..02d2f5cfe201 100644
> >> --- a/arch/arm/boot/dts/rk3288-r89.dts
> >> +++ b/arch/arm/boot/dts/rk3288-r89.dts
> >> @@ -340,6 +340,8 @@ &uart1 {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
> >> index cdcdc921ee09..a44290e882be 100644
> >> --- a/arch/arm/boot/dts/rk3288-rock2-square.dts
> >> +++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
> >> @@ -264,6 +264,8 @@ &spdif {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> >> index acfaa12ec239..0327119f71b4 100644
> >> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> >> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> >> @@ -500,6 +500,8 @@ &uart1 {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> >> index 54a6838d73f5..baa44d00e49a 100644
> >> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> >> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> >> @@ -412,6 +412,8 @@ &uart1 {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
> >> index 385dd59393e1..aa50cdc7f839 100644
> >> --- a/arch/arm/boot/dts/rk3288-vyasa.dts
> >> +++ b/arch/arm/boot/dts/rk3288-vyasa.dts
> >> @@ -398,6 +398,8 @@ &tsadc {
> >>   };
> >>   
> >>   &uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_xfer>;
> >>   	status = "okay";
> >>   };
> >>   
> >> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> >> index 0cd88774db95..4c1f8cabb5eb 100644
> >> --- a/arch/arm/boot/dts/rk3288.dtsi
> >> +++ b/arch/arm/boot/dts/rk3288.dtsi
> >> @@ -450,8 +450,6 @@ uart2: serial@ff690000 {
> >>   		reg-io-width = <4>;
> >>   		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> >>   		clock-names = "baudclk", "apb_pclk";
> >> -		pinctrl-names = "default";
> >> -		pinctrl-0 = <&uart2_xfer>;
> >>   		status = "disabled";
> >>   	};
> >>   
> >> @@ -706,8 +704,6 @@ pwm2: pwm@ff680020 {
> >>   		compatible = "rockchip,rk3288-pwm";
> >>   		reg = <0x0 0xff680020 0x0 0x10>;
> >>   		#pwm-cells = <3>;
> >> -		pinctrl-names = "default";
> >> -		pinctrl-0 = <&pwm2_pin>;
> >>   		clocks = <&cru PCLK_RKPWM>;
> >>   		clock-names = "pwm";
> >>   		status = "disabled";
> >> @@ -717,8 +713,6 @@ pwm3: pwm@ff680030 {
> >>   		compatible = "rockchip,rk3288-pwm";
> >>   		reg = <0x0 0xff680030 0x0 0x10>;
> >>   		#pwm-cells = <3>;
> >> -		pinctrl-names = "default";
> >> -		pinctrl-0 = <&pwm3_pin>;
> >>   		clocks = <&cru PCLK_RKPWM>;
> >>   		clock-names = "pwm";
> >>   		status = "disabled";
> >>
> > 
> > 
> > 
> > 
> > 
> 
> 




