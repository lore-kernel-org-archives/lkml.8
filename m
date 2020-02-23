Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA54C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B349C206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="ASvUC3zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBWKhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 05:37:39 -0500
Received: from vps.xff.cz ([195.181.215.36]:41764 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgBWKhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 05:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582454257; bh=F25Sml78iMjr19VTKxWNGaFjBxZ6Zvw7TPMvdEJ0DF4=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=ASvUC3zf8QJbFhXlpMHCkWZXJ4yNj/Er35jQ9uYfRm12wUeXCv+IZsFmYNnteKbk5
         +JyoBmlQhB6r4G2ZFAEg+OgaJAjsX0O9Kbcoyl+J1bbDbkJQc7oojR/f0lhdJLaVEu
         OodwRFVhGKOfUkl3hMi7Ghobo7toW5CF5vA4nB08=
Date:   Sun, 23 Feb 2020 11:37:36 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-sunxi@googlegroups.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH] arm64: dts: sun50i-h5-orange-pi-pc2: Add
 CPUX voltage regulator
Message-ID: <20200223103736.5uigz2nvvee3w5yr@core.my.home>
Mail-Followup-To: Samuel Holland <samuel@sholland.org>,
        linux-sunxi@googlegroups.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200222214541.210318-1-megous@megous.com>
 <92a2b808-8280-7ad4-cfb4-8ff9488c02c8@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a2b808-8280-7ad4-cfb4-8ff9488c02c8@sholland.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Sat, Feb 22, 2020 at 09:26:30PM -0600, Samuel Holland wrote:
> Hi Ondrej,
> 
> On 2/22/20 3:45 PM, Ondrej Jirman wrote:
> > Orange Pi PC2 features sy8106a regulator just like Orange Pi PC.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> > index 70b5f09984218..5feedde95b5fc 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> > @@ -85,6 +85,10 @@ reg_usb0_vbus: usb0-vbus {
> >  	};
> >  };
> >  
> > +&cpu0 {
> > +	cpu-supply = <&reg_vdd_cpux>;
> > +};
> > +
> 
> This should go alphabetically after "codec".
> 
> >  &codec {
> >  	allwinner,audio-routing =
> >  		"Line Out", "LINEOUT",
> > @@ -180,6 +184,31 @@ flash@0 {
> >  	};
> >  };
> >  
> > +&r_i2c {
> 
> This should go alphabetically before "spi0".
> 
> > +	status = "okay";
> > +
> > +	reg_vdd_cpux: regulator@65 {
> > +		compatible = "silergy,sy8106a";
> > +		reg = <0x65>;
> > +		regulator-name = "vdd-cpux";
> > +		silergy,fixed-microvolt = <1200000>;
> 
> The resistors in the datasheet (10k/11.8k) make this 1.1V.

Ah, you're right. I didn't notice the fine print bellow:

  https://megous.com/dl/tmp/e696b6042b80bf2e.png

only the big number above. Hehe.

> > +		/*
> > +		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
> > +		 * however both the Armbian DVFS table and the official one
> > +		 * have operating points with voltage under 1.1V, and both
> > +		 * DVFS table are known to work properly at the lowest
> > +		 * operating point.
> > +		 *
> > +		 * Use 1.0V as the minimum voltage instead.
> > +		 */
> 
> The datasheet I have for H5 has "TBD" for the VDD-CPUX volatage range. I think
> this comment only applies to H3 and is not necessary here.

Ok.

> > +		regulator-min-microvolt = <1000000>;
> > +		regulator-max-microvolt = <1400000>;
> > +		regulator-ramp-delay = <200>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +};
> > +
> >  &uart0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&uart0_pa_pins>;
> > 
> 
> Otherwise,
> Reviewed-by: Samuel Holland <samuel@sholland.org>

Thanks for the feedback.

regards,
	o.

> Regards,
> Samuel
