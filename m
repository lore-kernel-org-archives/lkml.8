Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C69C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D729D2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="E5fTkIrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGAS5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:57:44 -0400
Received: from vps.xff.cz ([195.181.215.36]:55362 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgGAS5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593629862; bh=6Z4SBIMcF6Jx3VXG/1PL+4vEJ0Qm28Mfr5ilIHdjHfw=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=E5fTkIrR8oXuyozxosnFCsaP3zz8CaqTTmyfOX7Qq/Tk1+H7X2JPzVkAmx/hn4E1N
         E9MS+7jieub7R3oXm9FLKUWyQ6aaFFHZhZvJ1zUkhYtTjLtfyZyqb+LQ+fQ8SO9+LR
         6KtgZTk1FZE7J7E43U5231hKWXwLus06UJbm15vw=
Date:   Wed, 1 Jul 2020 20:57:41 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: Re: [PATCH v6 13/13] arm64: dts: sun50i-a64-pinephone: Add
 touchscreen support
Message-ID: <20200701185741.z5cga3b7z4gmba6u@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
References: <20200701103126.1512615-1-megous@megous.com>
 <20200701103126.1512615-14-megous@megous.com>
 <78C72279-99DB-4FDE-81B3-1CF6BEF80BBF@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78C72279-99DB-4FDE-81B3-1CF6BEF80BBF@aosc.io>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On Wed, Jul 01, 2020 at 08:01:14PM +0800, Icenowy Zheng wrote:
> 
> 
> 于 2020年7月1日 GMT+08:00 下午6:31:26, Ondrej Jirman <megous@megous.com> 写到:
> >Pinephone has a Goodix GT917S capacitive touchscreen controller on
> >I2C0 bus. Add support for it.
> >
> >Signed-off-by: Ondrej Jirman <megous@megous.com>
> >Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >---
> > .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 19 +++++++++++++++++++
> > 1 file changed, 19 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >index 85a7aa5efd32..2d5694446d17 100644
> >--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >@@ -123,6 +123,25 @@ &ehci1 {
> > 	status = "okay";
> > };
> > 
> >+&i2c0 {
> >+	pinctrl-names = "default";
> >+	pinctrl-0 = <&i2c0_pins>;
> >+	status = "okay";
> >+
> >+	touchscreen@5d {
> >+		compatible = "goodix,gt917s", "goodix,gt911";
> 
> Please drop gt911 here. GT917S belong to the GT1x product line, not the same line with GT911.
> 
> You will see this in the driver.

Right. I'll do so in v8.

thnk you and regards,
	o.

> >+		reg = <0x5d>;
> >+		interrupt-parent = <&pio>;
> >+		interrupts = <7 4 IRQ_TYPE_LEVEL_HIGH>; /* PH4 */
> >+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> >+		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
> >+		AVDD28-supply = <&reg_ldo_io0>;
> >+		VDDIO-supply = <&reg_ldo_io0>;
> >+		touchscreen-size-x = <720>;
> >+		touchscreen-size-y = <1440>;
> >+	};
> >+};
> >+
> > &i2c1 {
> > 	status = "okay";
> > 
