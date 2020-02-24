Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D427C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45FF20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="tfQ1X2cS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBXPLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:11:33 -0500
Received: from vps.xff.cz ([195.181.215.36]:58468 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgBXPLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582557091; bh=9aE+a8E4LVEOkt4HFGQF11TSms2VZ1eBDyNQaeKqK74=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=tfQ1X2cSGvWyWkk8cfn533l5XKTK8qIsCqHpeifhVET6YwxrfV/c4HQ7kAgDyZtg1
         EemSNHRmabcJvOtTSMSP1I33wJwaxrfobg/YeZItZIRq2JW7elPmz3bbDuCsibqTVH
         aM1WXmMSCOmobj2LdNFrUK8MQqCd/7ErnT0+zGIU=
Date:   Mon, 24 Feb 2020 16:11:31 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: sun50i-h5-orange-pi-pc2: Add CPUX voltage
 regulator
Message-ID: <20200224151131.fw7to7pmegj5ylqy@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200223104019.527587-1-megous@megous.com>
 <20200224092704.gnnjwds3zmmravrw@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224092704.gnnjwds3zmmravrw@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:27:04AM +0100, Maxime Ripard wrote:
> On Sun, Feb 23, 2020 at 11:40:19AM +0100, Ondrej Jirman wrote:
> > Orange Pi PC2 features sy8106a regulator just like Orange Pi PC.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > Reviewed-by: Samuel Holland <samuel@sholland.org>
> > ---
> >  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> 
> Having a changelog would be great
> 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> > index 70b5f09984218..7b2572dc84857 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> > @@ -93,6 +93,10 @@ &codec {
> >  	status = "okay";
> >  };
> >
> > +&cpu0 {
> > +	cpu-supply = <&reg_vdd_cpux>;
> > +};
> > +
> >  &de {
> >  	status = "okay";
> >  };
> > @@ -168,6 +172,22 @@ &ohci3 {
> >  	status = "okay";
> >  };
> >
> > +&r_i2c {
> > +	status = "okay";
> > +
> > +	reg_vdd_cpux: regulator@65 {
> > +		compatible = "silergy,sy8106a";
> > +		reg = <0x65>;
> > +		regulator-name = "vdd-cpux";
> > +		silergy,fixed-microvolt = <1100000>;
> > +		regulator-min-microvolt = <1000000>;
> > +		regulator-max-microvolt = <1400000>;
> > +		regulator-ramp-delay = <200>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +};
> > +
> 
> Looks like you fixed the issues reported by Samuel though. I've
> applied it.

Sorry, yes, I just did that. Re-ordering + removing a comment and changing the
fixed voltage.

Thank you,
	o.

> Maxime


